//
//  MandelbrotSet.swift
//  Mandelbrot
//
//  Created by gary on 29/04/2017.
//  Copyright © 2017 Gary Kerr. All rights reserved.
//

// Notes for improvements
//
// https://en.wikibooks.org/wiki/Fractals/Iterations_in_the_complex_plane/Mandelbrot_set#Real_Escape_Time
// http://www.mrob.com/pub/muency/speedimprovements.html
//

import Foundation

struct MandelbrotSet {

    let xMin = -2.0
    let xMax = 1.0
    let yMin = -1.5
    let yMax = 1.5
    let iterations: Int

    var grid: [MandelbrotSetPoint] = []
    var imageSize: (width: Int, height: Int)


    init(config: MandelbrotSetConfig) {
        self.iterations = config.iterations
        let ys = Array(stride(from: config.yMin, to: config.yMax, by: config.dy))
        let xs = Array(stride(from: config.xMin, to: config.xMax, by: config.dx))
        imageSize = (xs.count, ys.count)
        for y in ys {
            for x in xs {
                let z = ComplexNumber(x: x, y: y)
                grid.append(MandelbrotSetPoint(point: z, test: isInSetFast(point: z)))
            }
        }
    }


    func gridIterations(config: MandelbrotSetConfig) -> Int {
        var total = 0
        for point in grid {
            switch point.test {
            case .inSet:
                total += config.iterations
            case .notInSet(let iterations, _):
                total += iterations
            }
        }
        return total
    }


    // MARK:- Private

    private func isInSet(point: ComplexNumber) -> MandelbrotSetPoint.Test {
        var z = point
        for i in 0 ..< iterations {
            if z.modulus() >= 4 {
                return .notInSet(iterations: i, finalPoint: z)
            }
            z = z*z + point
        }
        return .inSet
    }


    // Maybe this could be faster because not using operator overloading on the ComplexNumber struct
    private func isInSetFast(point: ComplexNumber) -> MandelbrotSetPoint.Test {
        let (u, v) = (point.x, point.y)
        var (x, y) = (point.x, point.y)
        for i in 0 ..< iterations {
            if x*x + y*y >= 4 {
                return .notInSet(iterations: i, finalPoint: ComplexNumber(x: x, y: y))
            }
            (x, y) = (x*x - y*y + u, 2*x*y + v)
        }
        return .inSet
    }
}
