#version 110

#moj_import <fog.glsl>
#moj_import <light.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler0;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform int FogShape;
uniform vec2 ScreenSize;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

#define HH_VERSION 2
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

            pos -= vec3(xOffset, yOffset, 0.0);
            pos.z += layer;
        }
    } 	

    gl_Position = ProjMat * ModelViewMat * vec4(pos, 1);
}
