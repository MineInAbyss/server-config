#version 330
#extension GL_ARB_separate_shader_objects : require

uniform sampler2D InSampler;

layout(location = 0) in vec2 texCoord;

// Share of the screen height each bar covers
layout(std140) uniform LetterboxConfig {
    float BarHeight;
};

layout(location = 0) out vec4 fragColor;

void main() {
    vec4 base = texture(InSampler, texCoord);
    bool covered = texCoord.y < BarHeight || texCoord.y > 1.0 - BarHeight;
    fragColor = covered ? vec4(0.0, 0.0, 0.0, base.a) : base;
}
