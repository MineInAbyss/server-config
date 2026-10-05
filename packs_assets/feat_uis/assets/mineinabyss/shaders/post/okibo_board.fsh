#version 330
#extension GL_ARB_separate_shader_objects : require

uniform sampler2D InSampler;
uniform sampler2D DepthSampler;
uniform sampler2D BlurSampler;

layout(std140) uniform SamplerInfo {
    vec2 OutSize;
    vec2 InSize;
    vec2 DepthSize;
    vec2 BlurSize;
};

layout(std140) uniform BoardConfig {
    float Near;
    float Cutoff;
    float Dim;
    float Desaturate;
    float Fade;
};

layout(location = 0) in vec2 texCoord;

layout(location = 0) out vec4 fragColor;

// A hard edge would cut across the floor right behind the board, so the world fades over Fade blocks
void main() {
    float depth = texture(DepthSampler, texCoord).r;
    vec4 sharp = texture(InSampler, texCoord);
    float dist = depth > 0.0 ? Near / depth : 1.0e6;
    if (dist < Cutoff) {
        fragColor = sharp;
        return;
    }
    vec3 color = texture(BlurSampler, texCoord).rgb;
    float grey = dot(color, vec3(0.299, 0.587, 0.114));
    vec3 background = mix(color, vec3(grey), Desaturate) * Dim;
    fragColor = vec4(mix(sharp.rgb, background, smoothstep(Cutoff, Cutoff + Fade, dist)), 1.0);
}
