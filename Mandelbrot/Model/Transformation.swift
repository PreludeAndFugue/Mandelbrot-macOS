//
//  LinearTransformation.swift
//  Mandelbrot
//
//  Created by gary on 29/04/2017.
//  Copyright © 2017 Gary Kerr. All rights reserved.
//

import Foundation

// Affine transformation to help convert between image and complex plane coordinates.
struct Transformation {
    let from: Rectangle
    let to: Rectangle
    let mx: Double
    let my: Double
    let cx: Double
    let cy: Double


    init(from: Rectangle, to: Rectangle) {
        self.from = from
        self.to = to
        mx = (to.xMax - to.xMin) / (from.xMax - from.xMin)
        my = (to.yMax - to.yMin) / (from.yMax - from.yMin)
        cx = to.xMin - mx * from.xMin
        cy = to.yMin - my * from.yMin
    }


    func transform(x: Double, y: Double) -> (x: Double, y: Double) {
        return (x: mx * x + cx, y: my * y + cy)
    }


    func transform(x: Int, y: Int) -> ComplexNumber {
        return ComplexNumber(x: mx * Double(x) + cx, y: my * Double(y) + cy)
    }


    func transform(z: ComplexNumber) -> CGRect {
        return CGRect(x: mx * z.x + cx, y: my * z.y + cy, width: 1, height: 1)
    }


    func transform(point: NSPoint) -> ComplexNumber {
        return ComplexNumber(x: mx * Double(point.x) + cx, y: my * Double(point.y) + cy)
    }
}
