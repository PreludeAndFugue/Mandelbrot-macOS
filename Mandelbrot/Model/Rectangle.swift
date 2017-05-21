//
//  Rectangle.swift
//  Mandelbrot
//
//  Created by gary on 29/04/2017.
//  Copyright © 2017 Gary Kerr. All rights reserved.
//

struct Rectangle {
    let xMin: Double
    let yMin: Double
    let xMax: Double
    let yMax: Double


    init(xMin: Double, yMin: Double, xMax: Double, yMax: Double) {
        self.xMin = xMin
        self.yMin = yMin
        self.xMax = xMax
        self.yMax = yMax
    }


    init(xMin: Int, yMin: Int, xMax: Int, yMax: Int) {
        self.xMin = Double(xMin)
        self.yMin = Double(yMin)
        self.xMax = Double(xMax)
        self.yMax = Double(yMax)
    }


    init(config: MandelbrotSetConfig) {
        self.xMin = config.xMin
        self.xMax = config.xMax
        self.yMin = config.yMin
        self.yMax = config.yMax
    }
}
