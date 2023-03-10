//
// Created by Jaewon Choi on 2023/03/09.
//

import simd

struct PerRayData_radiance {
    var depth: Int
    var seed: UInt

    var done: Bool
    var attenuation: simd_float3
    var radiance: simd_float3
    var origin: simd_float3
    var direction: simd_float3

    var pdf: Float
}

struct PerRayData_shadow {
    var inShadow: Bool
}