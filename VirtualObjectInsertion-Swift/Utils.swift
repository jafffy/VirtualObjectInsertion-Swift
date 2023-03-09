//
// Created by Jaewon Choi on 2023/03/09.
//

import Foundation
import SwiftNpy

func loadNpy(_ path: String) -> ([Float], [Int]) {
    loadNpy(URL(fileURLWithPath: path))
}

func loadEnv(_ path: String) -> ([Float], [Int]) {
    loadEnv(URL(fileURLWithPath: path))
}

func loadNpy(_ path: URL) -> ([Float], [Int]) {
    let npy = try! Npy(contentsOf: path)
    let elements: [Float] = npy.elements()
    let shape = npy.shape
    return (elements, shape)
}

func loadEnv(_ path: URL) -> ([Float], [Int]) {
    let npz = try! Npz(contentsOf: path)
    let npy = npz["env"]!
    let elements: [Float] = npy.elements()
    let shape = npy.shape
    return (elements, shape)
}
