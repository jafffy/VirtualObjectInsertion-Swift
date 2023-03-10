//
// Created by Jaewon Choi on 2023/03/09.
//

import simd

struct AreaLight {
    let vertices: simd_float3
    let radiance: simd_float3
}

struct PointLight {
    let intensity: simd_float3 = simd_float3(1.0, 1.0, 1.0)
    let position: simd_float3 = simd_float3(0.0, 0.0, 0.0)
    let isFlash: Bool = false
}

struct Envmap {
    let filename: String
    let scale: Float = 1.0
}

