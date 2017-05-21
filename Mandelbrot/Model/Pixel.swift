//
//  Pixel.swift
//  Mandelbrot
//
//  Created by gary on 03/05/2017.
//  Copyright © 2017 Gary Kerr. All rights reserved.
//

struct Pixel {
    var a: UInt8 = 255
    var r: UInt8
    var g: UInt8
    var b: UInt8


    init(r: UInt8, g: UInt8, b: UInt8) {
        self.r = r
        self.g = g
        self.b = b
    }
}
