//
//  main.swift
//  VirtualObjectInsertion-Swift
//
//  Created by Jaewon Choi on 2023/03/09.
//
//

import Foundation
import simd

let irResult = InverseRenderingResult(rootDir: "./data/Example1")

let mesh = loadObjNpz("./sphere.npz")
let transform = loadTransformNpz("./sphereInit.npz")
let material = Material()
let sceneInfo = SceneInfo()

// Optional: cropInfo
let cropInfo = loadCropInfoNpz("./data/Example1/im_new.npz")

let (im, imShape) = irResult.im
let (normalMap, normalShape) = irResult.normal

assert(imShape == normalShape)
let shape = imShape
let height = shape[0]
let width = shape[1]

let (xgrid, ygrid) = meshgrid(height: height, width: width)
var mask: [Int] = ones([height, width])

// TODO: Write slow first, then optimize.
for i in 0..<4 {
    let seg: [Float]

    if i == 3 {
        seg = [cropInfo.xMask[0] - cropInfo.xMask[i],
               cropInfo.yMask[0] - cropInfo.yMask[i]]
    } else {
        seg = [cropInfo.xMask[i + 1] - cropInfo.xMask[i],
               cropInfo.yMask[i + 1] - cropInfo.yMask[i]]
    }

    for y in 0..<height {
        for x in 0..<width {
            let x1 = Float(xgrid[y][x]) - cropInfo.xMask[i]
            let y1 = Float(ygrid[y][x]) - cropInfo.yMask[i]

            let y2 = x1 * seg[1] - y1 * seg[0]

            if y2 > 0 {
                mask[y * width + x] *= 1
            } else {
                mask[y * width + x] *= 0
            }
        }
    }
}

// Generate 3D Point
var normals: [simd_float3] = []  // TODO: Count the number of nonzero element in mask

for y in 0..<height {
    for x in 0..<width {
        if mask[y * width + x] == 0 {
            continue
        }

        // Normal vector
        let (nx, ny, nz) = (normalMap[y * width + x * 3 + 0],
                normalMap[y * width + x * 3 + 1],
                normalMap[y * width + x * 3 + 2])

        let vn = simd_float3(Float(nx), Float(ny), Float(nz))
        normals.append(vn)
    }
}

var normal = normals.reduce(simd_make_float3(0.0)) {
    $0 + $1
} / Float(normals.count)
normal = normal / 127.5 - 1
normal = simd_normalize(normal)
normal[0] = -normal[0]
normal[2] = -normal[2]

// Positions
var points: [simd_float3] = []

let atanFovX = tan(sceneInfo.fovX / 2.0 * Float.pi / 180.0)
let atanFovY = atanFovX * Float(height) / Float(width)

for i in 0..<4 {
    let x = cropInfo.xMask[i]
    let y = cropInfo.yMask[i]

    let width = Float(width)
    let height = Float(height)

    let vx = ((width + 1) / 2.0 - x) / ((width - 1) / 2.0) * atanFovX
    let vy = ((height + 1) / 2.0 - y) / ((height - 1) / 2.0) * atanFovY

    points.append(simd_float3(vx, vy, 1.0))
}

let ref = points[0]
let refDotNormal = simd_dot(ref, normal)

for i in 1..<points.count {
    let d = refDotNormal / simd_dot(points[i], normal)
    assert(d > 0)
    points[i] = points[i] * d
}

var textureCoords: [simd_float2] = []

for i in 0..<4 {
    let x = cropInfo.xMask[i]
    let y = cropInfo.yMask[i]

    let width = Float(width)
    let height = Float(height)

    let vtx = (x - 1) / (width - 1)
    let vty = (height - y) / (height - 1)

    textureCoords.append(simd_float2(vtx, vty))
}

let faces: [simd_uint3] = [
    simd_uint3(0, 1, 2),
    simd_uint3(0, 2, 3),
]

// Object placing
let xobj = cropInfo.xObj
let yobj = cropInfo.yObj

let vxobj = (((Float(width) + 1) / 2.0) - xobj) / ((Float(width) - 1) / 2.0) * atanFovX
let vyobj = (((Float(height) + 1) / 2.0) - yobj) / ((Float(height) - 1) / 2.0) * atanFovY
var vobj = simd_float3(vxobj, vyobj, 1.0)
let d = refDotNormal / simd_dot(vobj, normal)
assert(d > 0)
vobj = vobj * d

let dist: [Float] = [simd_length(vobj - ref), simd_length(vobj - points[1])]
let scale = sceneInfo.scale * simd_min(dist[0], dist[1])

if sceneInfo.isGamma {
    print("Not implemented yet")
}

// Environment map
// TODO: Check the result is same with HDR file result.
var (envMap, envShape) = irResult.env

for i in 0..<envMap.count {
    if envMap[i] < 0 {
        envMap[i] = 0
    }
}
