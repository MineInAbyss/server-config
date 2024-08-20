#version 110

#moj_import <fog.glsl>
#moj_import <light.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler0, Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform float GameTime;
uniform mat3 IViewRotMat;
uniform int FogShape;
uniform vec2 ScreenSize;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

#define HH_VERSION 3
#define HH_OFFSET %BOSSBAR_OFFSET%

// Function to convert a vertical ascent into a ID.
float get_id(float offset) {
    if (offset <= 0.0)
        return 0.0;
    return trunc(offset/1000.0);
}

void main() {
    vec3 pos = Position;

    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    vertexColor = Color;
    texCoord0 = UV0;

    vec2 pixel = vec2(ProjMat[0][0], ProjMat[1][1]) / 2.0;
    int guiScale = int(round(pixel.x / (1 / ScreenSize.x)));
    vec2 guiSize = ScreenSize / guiScale;

    float id = get_id((round(HH_OFFSET - Position.y)) * -1);

    
    if ( Color.xyz == vec3( 254 ) / 255.0 ) {
        vec2 dimensions = textureSize( Sampler0, 0 );
        vec2 texShift = 1 / dimensions;

        // Just in case the texture is not its own image
        // Otherwise we could just fetch the pixel at 0, 0
        ivec2 quadrantUV = ivec2( UV0 * dimensions );
        vec4 quadrant = texelFetch( Sampler0, quadrantUV, 0 );
        vec2 newUV0 = UV0;
        if ( quadrant.a == ( 149.0 / 255.0 ) ) {
            vec4 infoPix1 = vec4( 0 );
            vec4 infoPix2 = vec4( 0 );
            vertexColor = vec4( 1 );
            if ( quadrant.r == 1.0 / 255.0 ) {
                infoPix1 = texelFetch( Sampler0, quadrantUV + ivec2( 1, 0 ), 0 );
                infoPix2 = texelFetch( Sampler0, quadrantUV + ivec2( 0, 1 ), 0 );
                newUV0 = newUV0 + ( quadrant.gb * 255 + 1 ) / dimensions;
            } else if ( quadrant.r == 0.0 / 255.0 ) {
                infoPix1 = texelFetch( Sampler0, quadrantUV - ivec2( 1, 0 ), 0 );
                infoPix2 = texelFetch( Sampler0, quadrantUV + ivec2( 0, 1 ), 0 );
                newUV0 = newUV0 + ( quadrant.gb * 255 + vec2( -1, 1 ) ) / dimensions;
            } else if ( quadrant.r == 3.0 / 255.0 ) {
                infoPix1 = texelFetch( Sampler0, quadrantUV - ivec2( 1, 0 ), 0 );
                infoPix2 = texelFetch( Sampler0, quadrantUV - ivec2( 0, 1 ), 0 );
                newUV0 = newUV0 + ( quadrant.gb * 255 - 1 ) / dimensions;
            } else if ( quadrant.r == 2.0 / 255.0 ) {
                infoPix1 = texelFetch( Sampler0, quadrantUV + ivec2( 1, 0 ), 0 );
                infoPix2 = texelFetch( Sampler0, quadrantUV - ivec2( 0, 1 ), 0 );
                newUV0 = newUV0 + ( quadrant.gb * 255 + vec2( 1, -1 ) ) / dimensions;
            } else {
                vertexColor = Color * texelFetch( Sampler2, UV2 / 16, 0 );
                return;
            }

            // Get timing info
            float totalTime = infoPix1.r * 256 + infoPix1.g;
            float startTime = infoPix1.b * 256 + infoPix1.a;
            float endTime = infoPix2.r * 256 + infoPix2.g;

            float lower = startTime / totalTime;
            float upper = endTime / totalTime;
            float total = totalTime / 4705.882352941176;
            float whole = 0;
            float time = modf( GameTime / total, whole );

            vertexColor = vec4( time >= lower && time < upper );

            texCoord0 = newUV0;
        } else {
            vertexColor = Color * texelFetch( Sampler2, UV2 / 16, 0 );
        }
    } else if ( Color.xyz == vec3( floor( 254 / 4. ) / 255. ) ) {
        // Get rid of shadows
        vertexColor = vec4( 0 );
    }

    // Detect if GUI text.
    if (id > 99 && Color.a != 0.0) {
        float yOffset = 0.0;
        float xOffset = 0.0;
        int layer = 0;
        vec2 scale = vec2(1, 1);
        bool outlined = false;

        switch (int(id)) {
%POSITIONS%
        }

        // -90.0 is required for forge comp
        if ((Position.z != 0.0 && Position.z != -90.0) || outlined) {
            pos.y -= (id*1000) + 500 + HH_OFFSET;
            pos.x -= (guiSize.x * 0.5);

            pos.x *= scale.x;
            pos.y *= scale.y;

            pos.y += guiSize.y;
            // force align guiScale 3
            if (guiScale == 3) {
                pos.x += 1.45;
            }

            pos -= vec3(xOffset, yOffset, 0.0);
            pos.z += layer;
        }
    } 	
    
    gl_Position = ProjMat * ModelViewMat * vec4(pos, 1);
}
