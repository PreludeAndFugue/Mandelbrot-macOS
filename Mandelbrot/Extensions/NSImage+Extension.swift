//
//  NSImage+Extension.swift
//  Mandelbrot
//
//  Created by gary on 05/05/2017.
//  Copyright © 2017 Gary Kerr. All rights reserved.
//

import Cocoa
import MandelbrotEngine

extension NSImage {

    // http://blog.human-friendly.com/drawing-images-from-pixel-data-in-swift
    static func from(pixels: [Pixel], width: Int, height: Int) -> NSImage {
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo: CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)

        let bitsPerComponent: Int = 8
        let bitsPerPixel: Int = 32

        assert(pixels.count == Int(width * height))

        var data = pixels // Copy to mutable []
        guard
            let provider = CGDataProvider(data: NSData(bytes: &data, length: data.count * MemoryLayout<Pixel>.size))
        else {
            fatalError("no cg data provider")
        }

        guard let image = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: width * MemoryLayout<Pixel>.size,
            space: rgbColorSpace,
            bitmapInfo: bitmapInfo,
            provider: provider,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        ) else {
            fatalError("Couldn't create CGImage")
        }
        return NSImage(cgImage: image, size: NSZeroSize)
    }


    static func from(mandelbrotSet: MandelbrotSet, colourMap: ColourMapProtocol) -> NSImage {
        let pixels = mandelbrotSet.grid.map({ colourMap.pixel(from: $0.test) })
        return from(
            pixels: pixels,
            width: mandelbrotSet.imageSize.width,
            height: mandelbrotSet.imageSize.height
        )
    }


    func saveAsJpg(to url: URL) {
        let options: [NSBitmapImageRep.PropertyKey: Any] = [.compressionFactor: 1.0]
        guard
            let imageData = tiffRepresentation,
            let bitmapImageRep = NSBitmapImageRep(data: imageData),
            let data = bitmapImageRep.representation(using: .jpeg, properties: options)
        else { return }
        try? data.write(to: url, options: [])
    }
}
