//
// Created by Jaewon Choi on 2023/03/09.
//

import Foundation

typealias NpyArray = (array: [Float], shape: [Int])

class InputSceneDescription {
    let env: NpyArray
    let im: NpyArray
    let albedo: NpyArray
    let normal: NpyArray
    let rough: NpyArray

    init(rootDir: String) {
        let rootDirURL = URL(fileURLWithPath: rootDir)

        env = loadEnv(rootDirURL.appendingPathComponent("env.npz"))
        im = loadNpy(rootDirURL.appendingPathComponent("im.npy"))
        albedo = loadNpy(rootDirURL.appendingPathComponent("albedo.npy"))
        normal = loadNpy(rootDirURL.appendingPathComponent("normal.npy"))
        rough = loadNpy(rootDirURL.appendingPathComponent("rough.npy"))
    }
}
