//
//  YellowScale.swift
//  Mandelbrot
//
//  Created by gary on 29/04/2017.
//  Copyright © 2017 Gary Kerr. All rights reserved.
//

import Foundation

struct YellowScale: ColourMapProtocol {

    internal let pixels: [Pixel]
    internal let blackPixel = Pixel(r: 0, g: 0, b: 0)
    private let pixelMin = 20
    private let pixelMax = 255


    init(numberOfYellows: Int) {
        var pixelList: [Pixel] = []
        let step = max(Int(Double(pixelMax - pixelMin)/Double(numberOfYellows)), 1)
        for i in stride(from: pixelMin, to: pixelMax, by: step) {
            let j = UInt8(i)
            pixelList.append(Pixel(r: j, g: j, b: 0))
        }
        pixels = pixelList + pixelList.reversed()
    }
}
