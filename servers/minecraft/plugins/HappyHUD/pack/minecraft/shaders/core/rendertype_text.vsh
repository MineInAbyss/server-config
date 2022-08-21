#version 150

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

#define ACTIONBAR_OFFSET 64

int get_id(int offset) {
    if (offset <= 0)
        return 0;
    return int(offset/1000);
}


void main() {
    vec3 pos = Position;

    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    vertexColor = Color;
    texCoord0 = UV0;

    vec2 pixel = vec2(ProjMat[0][0], ProjMat[1][1]) / 2.0;
    int guiScale = int(round(pixel.x / (1 / ScreenSize.x)));
    vec2 guiSize = ScreenSize / guiScale;

    int id = get_id((int(round(guiSize.y - Position.y)) - ACTIONBAR_OFFSET) * -1);
    
    // Detect if GUI text.
    if (Position.z > 0.0 && Position.z < 0.1 && id != 0 && Color.a != 0.0) {
        pos.y -= int((id*1000) + 500 - ACTIONBAR_OFFSET);
        pos.x -= (guiSize.x * 0.5);

        float yOffset = 0;
        float xOffset = 0;

        switch (id) {
            case 1:
                yOffset = int(guiSize.y * (0.0/100))+24;
                xOffset = int(guiSize.x * (-50.0/100))-100;
                break;
            case 2:
                yOffset = int(guiSize.y * (0.0/100))+10;
                xOffset = int(guiSize.x * (-50.0/100))-105;
                break;
            case 3:
                yOffset = int(guiSize.y * (0.0/100));
                xOffset = int(guiSize.x * (-0.0/100));
                break;
        }

        pos -= vec3(xOffset, yOffset, 0.0);
    } 	

    gl_Position = ProjMat * ModelViewMat * vec4(pos, 1);
}
