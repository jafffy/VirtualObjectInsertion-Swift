//
// Created by Jaewon Choi on 2023/03/09.
//

import Foundation

class InverseRenderingResult {
    let env: EnvMapNpy
    let im: ImageNpy
    let albedo: ImageNpy
    let normal: ImageNpy
    let rough: ImageNpy

    init(rootDir: String) {
        let rootDirURL = URL(fileURLWithPath: rootDir)

        env = loadEnv(rootDirURL.appendingPathComponent("env.npz"))
        im = loadImageNpy(rootDirURL.appendingPathComponent("im.npy"))
        albedo = loadImageNpy(rootDirURL.appendingPathComponent("albedo.npy"))
        normal = loadImageNpy(rootDirURL.appendingPathComponent("normal.npy"))
        rough = loadImageNpy(rootDirURL.appendingPathComponent("rough.npy"))
    }
}
