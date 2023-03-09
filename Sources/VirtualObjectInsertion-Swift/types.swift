//
// Created by Jaewon Choi on 2023/03/09.
//

import Foundation

typealias ImageNpy = ([UInt8], [Int])
typealias EnvMapNpy = ([Float], [Int])

struct Mesh {
    let vertices: [Float]
    let verticesShape: [Int]
    let faces: [Int]
    let facesShape: [Int]
    let textureCoords: [Float]
    let textureCoordsShape: [Int]
    let normals: [Float]
    let normalsShape: [Int]
}

struct Transform {
    let meshRotateAngle: Float
    let meshRotateAxis: [Float]
    let meshTranslate: [Float]
    let meshScale: [Float]
}

struct Material {
    let r = 0.8
    let g = 0.8
    let b = 0.8

    let roughness = 0.2
    let metallic = 0.0
}

struct CropInfo {
    let xMask: [Float]
    let yMask: [Float]
    let xObj: Float
    let yObj: Float
}

struct SceneInfo {
    let fovX: Float = 63.4149
    let isGamma = false

    let scale: Float = 0.2 // TODO: Check what this is
}