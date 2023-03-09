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
