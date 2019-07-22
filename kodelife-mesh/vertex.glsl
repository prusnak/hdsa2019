#version 150

uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;
uniform vec3 spectrum;
uniform mat4 mvp;

in vec4 a_position;
in vec3 a_normal;
in vec2 a_texcoord;

out VertexData
{
    vec4 v_position;
    vec3 v_normal;
    vec2 v_texcoord;
} outData;

mat4 rotationX(in float angle) {
    return mat4(        1.0,           0,           0, 0,
                          0,  cos(angle), -sin(angle), 0,
                          0,  sin(angle),  cos(angle), 0,
                          0,           0,           0, 1);
}

mat4 rotationY(in float angle) {
    return mat4( cos(angle),           0,  sin(angle), 0,
                          0,         1.0,           0, 0,
                -sin(angle),           0,  cos(angle), 0,
                          0,           0,           0, 1);
}

mat4 rotationZ(in float angle) {
    return mat4( cos(angle), -sin(angle),           0, 0,
                 sin(angle),  cos(angle),           0, 0,
                          0,           0,           1, 0,
                          0,           0,           0, 1);
}

float random (in vec2 _st, float seed) {
    return fract(sin(seed + dot(_st.xy,vec2(12.9898, 78.233))) * 43758.5453123);
}

void main(void)
{
    float rx = random(a_position.xy, 0) - 0.5;
    float ry = random(a_position.xy, 1) - 0.5;
    float rz = random(a_position.xy, 2) - 0.5;
    float scale = spectrum.y * 8;
    vec4 new_pos = a_position + vec4(rx * scale, ry * scale, rz * scale, 0);
    gl_Position = mvp * new_pos * rotationY(sin(time) / 4) * rotationX(cos(time) / 4);
    outData.v_position = new_pos;
    outData.v_normal = a_normal;
    outData.v_texcoord = a_texcoord;
}
