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
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-60;
                break;
            case 2:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-67;
                break;
            case 3:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-74;
                break;
            case 4:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-81;
                break;
            case 5:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-88;
                break;
            case 6:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-95;
                break;
            case 7:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-102;
                break;
            case 8:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-109;
                break;
            case 9:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-116;
                break;
            case 10:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-123;
                break;
            case 11:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-130;
                break;
            case 12:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-137;
                break;
            case 13:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-144;
                break;
            case 14:
                yOffset = int(guiSize.y * (0.0/100))+62;
                xOffset = int(guiSize.x * (-50.0/100))-55;
                break;
            case 15:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-60;
                break;
            case 16:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-67;
                break;
            case 17:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-74;
                break;
            case 18:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-81;
                break;
            case 19:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-88;
                break;
            case 20:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-95;
                break;
            case 21:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-102;
                break;
            case 22:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-109;
                break;
            case 23:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-116;
                break;
            case 24:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-123;
                break;
            case 25:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-130;
                break;
            case 26:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-137;
                break;
            case 27:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-144;
                break;
            case 28:
                yOffset = int(guiSize.y * (0.0/100))+52;
                xOffset = int(guiSize.x * (-50.0/100))-55;
                break;
            case 29:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))+60;
                break;
            case 30:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))+53;
                break;
            case 31:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))+46;
                break;
            case 32:
                yOffset = int(guiSize.y * (-500.0/100));
                xOffset = int(guiSize.x * (-0.0/100));
                break;
            case 33:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))+39;
                break;
            case 34:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))+32;
                break;
            case 35:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))+25;
                break;
            case 36:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))+18;
                break;
            case 37:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))+11;
                break;
            case 38:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))+4;
                break;
            case 39:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-3;
                break;
            case 40:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-10;
                break;
            case 41:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-17;
                break;
            case 42:
                yOffset = int(guiSize.y * (0.0/100))+60;
                xOffset = int(guiSize.x * (-50.0/100))-24;
                break;
            case 43:
                yOffset = int(guiSize.y * (0.0/100))+62;
                xOffset = int(guiSize.x * (-50.0/100))+65;
                break;
            case 44:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))+60;
                break;
            case 45:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))+53;
                break;
            case 46:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))+46;
                break;
            case 47:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))+39;
                break;
            case 48:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))+32;
                break;
            case 49:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))+25;
                break;
            case 50:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))+18;
                break;
            case 51:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))+11;
                break;
            case 52:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))+4;
                break;
            case 53:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-3;
                break;
            case 54:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-10;
                break;
            case 55:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-17;
                break;
            case 56:
                yOffset = int(guiSize.y * (0.0/100))+50;
                xOffset = int(guiSize.x * (-50.0/100))-24;
                break;
            case 57:
                yOffset = int(guiSize.y * (0.0/100))+52;
                xOffset = int(guiSize.x * (-50.0/100))+65;
                break;
            case 58:
                yOffset = int(guiSize.y * (0.0/100))+52;
                xOffset = int(guiSize.x * (-50.0/100))+50;
                break;
            case 59:
                yOffset = int(guiSize.y * (100.0/100))-14;
                xOffset = int(guiSize.x * (-50.0/100))+59;
                break;
            case 60:
                yOffset = int(guiSize.y * (100.0/100))-12;
                xOffset = int(guiSize.x * (-50.0/100))+60;
                break;
            case 61:
                yOffset = int(guiSize.y * (100.0/100))-12;
                xOffset = int(guiSize.x * (-50.0/100))-60;
                break;
            case 62:
                yOffset = int(guiSize.y * (0.0/100))+24;
                xOffset = int(guiSize.x * (-50.0/100))-100;
                break;
            case 63:
                yOffset = int(guiSize.y * (0.0/100))+10;
                xOffset = int(guiSize.x * (-50.0/100))-105;
                break;
            case 64:
                yOffset = int(guiSize.y * (0.0/100))+70;
                xOffset = int(guiSize.x * (-50.0/100));
                break;
        }

        pos -= vec3(xOffset, yOffset, 0.0);
    } 	

    gl_Position = ProjMat * ModelViewMat * vec4(pos, 1);
}
