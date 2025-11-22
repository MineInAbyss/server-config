#version 110

#moj_import <minecraft:fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler0, Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;
uniform vec2 ScreenSize;
uniform float GameTime;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

#define MH_VERSION 5
#define MH_OFFSET %BOSSBAR_OFFSET%
#define XP_COLOR vec3(0.501, 1.0, 0.125)
#define XP_COLOR_SHADOW vec3(0.0, 0.0, 0.0)

// Function to convert a vertical ascent into a ID.
float get_id(float offset) {
    if (offset <= 0.0)
    return 0.0;
    return trunc(offset/1000.0);
}

bool is_at(int offset, int vertex, int pos) { return (((vertex == 1 || vertex == 2) && offset == pos) || ((vertex == 0 || vertex == 3) && offset == (pos + 8))); }
bool is_at(int offset, int vertex, int pos0, int pos1) { return is_at(offset, vertex, pos0) || is_at(offset, vertex, pos1); }
bool is_at(int offset, int vertex, int pos0, int pos1, int pos2, int pos3) { return is_at(offset, vertex, pos0, pos1) || is_at(offset, vertex, pos2, pos3); }
bool within(vec3 a, vec3 b, float threshold) { return abs(length(a - b)) < threshold; }

void main() {
    vec3 pos = Position;
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);

    vec2 guiSize = ceil(2 / vec2(ProjMat[0][0], -ProjMat[1][1]));
    int guiScale = int(round(guiSize.x / (1 / ScreenSize.x)));

    float id = get_id((round(MH_OFFSET - pos.y)) * -1);

    //Emojy GIFs - start
    vec2 dimensions = textureSize(Sampler0, 0);
    ivec2 quadrantUV = ivec2(UV0 * dimensions);
    vec4 quadrant = texelFetch(Sampler0, quadrantUV, 0);

    bool isAnimatedGlyph = Color.xyz == vec3(254) / 255.0 && quadrant.a == 149.0 / 255.0;
    bool isAnimatedGlyphShadow = Color.xyz == vec3(floor(254.0 / 4.0) / 255.0) && quadrant.a == 149.0 / 255.0;

    if (isAnimatedGlyph || isAnimatedGlyphShadow) {
        vec2 newUV0 = UV0;
        vec4 infoPix1 = vec4(0);
        vec4 infoPix2 = vec4(0);
        vertexColor = vec4(1);

        // Determine texture fetch offsets based on quadrant color value
        if (quadrant.r == 1.0 / 255.0) {
            infoPix1 = texelFetch(Sampler0, quadrantUV + ivec2(1, 0), 0);
            infoPix2 = texelFetch(Sampler0, quadrantUV + ivec2(0, 1), 0);
            newUV0 += (quadrant.gb * 255.0 + 1.0) / dimensions;
        } else if (quadrant.r == 0.0 / 255.0) {
            infoPix1 = texelFetch(Sampler0, quadrantUV - ivec2(1, 0), 0);
            infoPix2 = texelFetch(Sampler0, quadrantUV + ivec2(0, 1), 0);
            newUV0 += (quadrant.gb * 255.0 - vec2(1.0, -1.0)) / dimensions;
        } else if (quadrant.r == 3.0 / 255.0) {
            infoPix1 = texelFetch(Sampler0, quadrantUV - ivec2(1, 0), 0);
            infoPix2 = texelFetch(Sampler0, quadrantUV - ivec2(0, 1), 0);
            newUV0 += (quadrant.gb * 255.0 - 1.0) / dimensions;
        } else if (quadrant.r == 2.0 / 255.0) {
            infoPix1 = texelFetch(Sampler0, quadrantUV + ivec2(1, 0), 0);
            infoPix2 = texelFetch(Sampler0, quadrantUV - ivec2(0, 1), 0);
            newUV0 += (quadrant.gb * 255.0 + vec2(1.0, -1.0)) / dimensions;
        } else {
            vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
            return;
        }

        float totalTime = infoPix1.r * 256.0 + infoPix1.g;
        float startTime = infoPix1.b * 256.0 + infoPix1.a;
        float endTime = infoPix2.r * 256.0 + infoPix2.g;

        float lower = startTime / totalTime;
        float upper = endTime / totalTime;
        float total = totalTime / 4705.882352941176;

        float time = mod(GameTime / total, 1.0);
        float visible = float(time >= lower && time < upper);

        vertexColor = vec4(Color.rgb, Color.a * visible) * texelFetch(Sampler2, UV2 / 16, 0);
        texCoord0 = newUV0;
    }
    //Emojy GIFs - end
    else if (id > 99 && Color.a != 0.0) {
        float yOffset = 0.0;
        float xOffset = 0.0;
        float layer = 0.0;
        vec2 scale = vec2(1, 1);
        bool outlined = false;

        %SWITCH_POSITIONS%

        // -2800.0 is required for forge comp
        if ((Position.z != 1000.0 && Position.z != -2800.0) || outlined) {
            pos.y -= (id*1000) + 500 + MH_OFFSET;
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
    } else {
        if (false) {
            int offset = int(round(guiSize.y - Position.y));
            int vID = gl_VertexID % 4;

            if ((within(Color.rgb, XP_COLOR, 0.002) && is_at(offset, vID, 26, 27)) || (within(Color.rgb, XP_COLOR_SHADOW, 0.002) && is_at(offset, vID, 25, 26, 27, 28))) {
                //pos += %EXPERIENCE_LEVEL_OFFSET%;
            }
        }
    }

    vertexDistance = fog_distance(Position, FogShape);
    texCoord0 = UV0;
    gl_Position = ProjMat * ModelViewMat * vec4(pos, 1.0);
}