#version 330
#extension GL_ARB_separate_shader_objects : require

/**
 * Range: how far the beam reaches, in blocks. Worth keeping near the light block's own level
 * ConeRadius: half-width of the full-strength cone, in aspect-corrected screen units where 0.5 is the screen edge
 * ConeSoft: width of the falloff past ConeRadius
 * Dim: how much of the original light survives outside the beam, 1 leaves the periphery untouched
 * Lamp: rgb is the beam's colour and should sit near luminance 1, a is the gain inside the beam
 */

uniform sampler2D InSampler;
uniform sampler2D InDepthSampler;

layout(location = 0) in vec2 texCoord;

layout(std140) uniform SamplerInfo {
    vec2 OutSize;
    vec2 InSize;
};

layout(std140) uniform HeadlampConfig {
    float Range;
    float ConeRadius;
    float ConeSoft;
    float Dim;
    vec4 Lamp;
};

layout(location = 0) out vec4 fragColor;

// Depth is reversed with an infinite far plane, so depth = NEAR / distance and 0 where nothing was drawn
// Vanilla near plane
const float NEAR = 0.05;
// Fraction of Range the beam keeps full strength for before fading out
const float FALLOFF_START = 0.35;

void main() {
    vec4 base = texture(InSampler, texCoord);
    float depth = texture(InDepthSampler, texCoord).r;
    if (depth == 0.0) {
        fragColor = base;
        return;
    }

    float viewZ = NEAR / depth;
    float atten = 1.0 - smoothstep(Range * FALLOFF_START, Range, viewZ);

    // Screen space rather than view space keeps the beam FOV independent, and FOV is a client setting
    vec2 centered = texCoord - vec2(0.5);
    centered.x *= OutSize.x / OutSize.y;
    float cone = 1.0 - smoothstep(ConeRadius, ConeRadius + ConeSoft, length(centered));

    float g = cone * atten;

    vec3 shaped = base.rgb * mix(vec3(Dim), Lamp.rgb * Lamp.a, g);
    fragColor = vec4(min(shaped, vec3(1.0)), base.a);
}
