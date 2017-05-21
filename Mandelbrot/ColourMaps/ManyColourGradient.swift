//
//  ManyColourGradient.swift
//  Mandelbrot
//
//  Created by gary on 06/05/2017.
//  Copyright © 2017 Gary Kerr. All rights reserved.
//

import Foundation

struct ManyColourGradient: ColourMapProtocol {

    internal let pixels: [Pixel]
    internal let blackPixel = Pixel(r: 0, g: 0, b: 0)


    init(n: Int, colours: RGB...) {
        var secondColours = Array(colours[1 ... colours.count - 1])
        secondColours.append(colours.first!)
        pixels = zip(colours, secondColours)
            .map({ ManyColourGradient.gradient(from: $0, to: $1, n: n) })
            .reduce([], { x, y in x + y })
    }
}
