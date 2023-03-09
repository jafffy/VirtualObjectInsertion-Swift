//
//  main.swift
//  VirtualObjectInsertion-Swift
//
//  Created by Jaewon Choi on 2023/03/09.
//
//

import Foundation
import SwiftNpy

let irResult = InverseRenderingResult(rootDir: "./data/Example1")

let mesh = loadObjNpz("./sphere.npz")
let transform = loadTransformNpz("./sphereInit.npz")
let material = Material()
let sceneInfo = SceneInfo()

// Optional: cropInfo
let cropInfo = loadCropInfoNpz("./data/Example1/im_new.npz")

let (im, imShape) = irResult.im
let (normal, normalShape) = irResult.normal

assert(imShape == normalShape)
let shape = imShape
let height = shape[0]
let width = shape[1]

print(shape)

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

saveArrayAsNpy("../mask.npy", data: mask.map { $0 == 1 }, shape: [height, width])

