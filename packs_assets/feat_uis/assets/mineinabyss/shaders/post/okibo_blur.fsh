#version 330
#extension GL_ARB_separate_shader_objects : require

uniform sampler2D InSampler;
uniform sampler2D DepthSampler;

layout(std140) uniform SamplerInfo {
    vec2 OutSize;
    vec2 InSize;
    vec2 DepthSize;
};

layout(std140) uniform BlurConfig {
    vec2 BlurDir;
    float Radius;
    float Near;
    float Cutoff;
};

layout(location = 0) in vec2 texCoord;

layout(location = 0) out vec4 fragColor;

void main() {
    vec2 step = BlurDir / InSize;
    vec4 sum = vec4(0.0);
    float count = 0.0;
    for (float a = -Radius; a <= Radius; a += 1.0) {
        vec2 uv = texCoord + step * a;
        float depth = texture(DepthSampler, uv).r;
        if (depth > 0.0 && Near / depth < Cutoff) continue;
        sum += texture(InSampler, uv);
        count += 1.0;
    }
    if (count == 0.0) {
        for (float a = -Radius * 6.0; a <= Radius * 6.0; a += 3.0) {
            vec2 uv = texCoord + step * a;
            float depth = texture(DepthSampler, uv).r;
            if (depth > 0.0 && Near / depth < Cutoff) continue;
            sum += texture(InSampler, uv);
            count += 1.0;
        }
    }
    fragColor = count > 0.0 ? sum / count : texture(InSampler, texCoord);
}
