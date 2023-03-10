//
// Created by Jaewon Choi on 2023/03/09.
//

import simd

protocol BRDF {
}

struct Diffuse: BRDF {
    let reflectance: simd_float3
}

struct Phong: BRDF {
    let Kd: simd_float3
    let Ks: simd_float3
    let Ka: simd_float3
    let alpha: Float
}