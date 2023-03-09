//
// Created by Jaewon Choi on 2023/03/09.
//

import Foundation
import SwiftNpy

func loadImageNpy(_ path: String) -> ImageNpy {
    loadImageNpy(URL(fileURLWithPath: path))
}

func loadEnv(_ path: String) -> EnvMapNpy {
    loadEnv(URL(fileURLWithPath: path))
}

func loadImageNpy(_ path: URL) -> ImageNpy {
    let npy = try! Npy(contentsOf: path)
    let elements: [UInt8] = npy.elements()
    let shape = npy.shape

    return (elements, shape)
}

func loadEnv(_ path: URL) -> EnvMapNpy {
    let npz = try! Npz(contentsOf: path)
    let npy = npz["env"]!
    let elements: [Float] = npy.elements()
    let shape = npy.shape
    return (elements, shape)
}

func loadObjNpz(_ path: String) -> Mesh {
    loadObjNpz(URL(fileURLWithPath: path))
}

func loadObjNpz(_ path: URL) -> Mesh {
    let npz = try! Npz(contentsOf: path)

    return Mesh(vertices: npz["vertices"]!.elements(),
            verticesShape: npz["vertices"]!.shape,
            faces: npz["faces"]!.elements(),
            facesShape: npz["faces"]!.shape,
            textureCoords: npz["texture_coords"]!.elements(),
            textureCoordsShape: npz["texture_coords"]!.shape,
            normals: npz["normals"]!.elements(),
            normalsShape: npz["normals"]!.shape)
}

func loadTransformNpz(_ path: String) -> Transform {
    loadTransformNpz(URL(fileURLWithPath: path))
}

func loadTransformNpz(_ path: URL) -> Transform {
    let npz = try! Npz(contentsOf: path)

    return Transform(
            meshRotateAngle: npz["meshRotateAngle"]!.elements()[0],
            meshRotateAxis: npz["meshRotateAxis"]!.elements(),
            meshTranslate: npz["meshTranslate"]!.elements(),
            meshScale: npz["meshScale"]!.elements())
}

func loadCropInfoNpz(_ path: String) -> CropInfo {
    loadCropInfoNpz(URL(fileURLWithPath: path))
}

func loadCropInfoNpz(_ path: URL) -> CropInfo {
    let npz = try! Npz(contentsOf: path)

    return CropInfo(
            xMask: npz["xMask"]!.elements(),
            yMask: npz["yMask"]!.elements(),
            xObj: npz["xObj"]!.elements()[0],
            yObj: npz["yObj"]!.elements()[0])
}

func saveArrayAsNpy(_ path: String, data: [Float], shape: [Int]) {
    saveArrayAsNpy(URL(fileURLWithPath: path), data: data, shape: shape)
}

func saveArrayAsNpy(_ path: URL, data: [Float], shape: [Int]) {
    let npy = Npy(shape: shape,
            elements: data,
            endian: .little,
            isFortranOrder: false)
    try! npy.save(to: path)
}

func saveArrayAsNpy(_ path: String, data: [Bool], shape: [Int]) {
    saveArrayAsNpy(URL(fileURLWithPath: path), data: data, shape: shape)
}

func saveArrayAsNpy(_ path: URL, data: [Bool], shape: [Int]) {
    let npy = Npy(shape: shape,
            elements: data,
            isFortranOrder: false)
    try! npy.save(to: path)
}

func saveArrayAsNpy(_ path: String, data: [Int32], shape: [Int]) {
    saveArrayAsNpy(URL(fileURLWithPath: path), data: data, shape: shape)
}

func saveArrayAsNpy(_ path: URL, data: [Int32], shape: [Int]) {
    let npy = Npy(shape: shape,
            elements: data,
            endian: .little,
            isFortranOrder: false)
    try! npy.save(to: path)
}