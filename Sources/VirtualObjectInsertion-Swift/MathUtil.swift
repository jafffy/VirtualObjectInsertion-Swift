//
// Created by Jaewon Choi on 2023/03/09.
//

import Foundation

func meshgrid(height: Int, width: Int) -> (X: [[Int]], Y: [[Int]]) {
    var X = Array(repeating: Array(repeating: 0, count: width), count: height)
    var Y = Array(repeating: Array(repeating: 0, count: width), count: height)
    for i in 0..<height {
        for j in 0..<width {
            X[i][j] = j
            Y[i][j] = i
        }
    }
    return (X, Y)
}

func ones(_ shape: [Int]) -> [Float] {
    Array(repeating: 1.0, count: shape.reduce(1, *))
}

func ones(_ shape: [Int]) -> [Int] {
    Array(repeating: 1, count: shape.reduce(1, *))
}

func ones(_ shape: [Int]) -> [Bool] {
    Array(repeating: true, count: shape.reduce(1, *))
}