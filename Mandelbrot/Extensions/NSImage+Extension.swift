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
    /// Creates an NSImage from `Pixel`s.
    ///
    /// Note that the image size (width * height) should be the same as
    /// the number of pixels.
    ///
    /// http://blog.human-friendly.com/drawing-images-from-pixel-data-in-swift
    ///
    /// - Parameters:
    ///   - pixels: The Pixels.
    ///   - width: The image width.
    ///   - height: The image height.
    /// - Returns: The image.
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


    /// Creates an NSImage from a `MandelbrotSet` and a `ColourMap`.
    ///
    /// - Parameters:
    ///   - mandelbrotSet: The Mandelbrot set.
    ///   - colourMap: The colour map.
    /// - Returns: The image.
    static func from(mandelbrotSet: MandelbrotSet, colourMap: ColourMapProtocol) -> NSImage {
        let pixels = mandelbrotSet.grid.map({ colourMap.pixel(from: $0.test) })
        return from(
            pixels: pixels,
            width: mandelbrotSet.imageSize.width,
            height: mandelbrotSet.imageSize.height
        )
    }


    /// Resizes an image.
    ///
    /// https://stackoverflow.com/a/30422317/132767
    ///
    /// - Parameter to: The new size.
    /// - Returns: Resized image.
    func resized(to: CGSize) -> NSImage {
        let img = NSImage(size: to)
        img.lockFocus()
        if let ctx = NSGraphicsContext.current {
            ctx.imageInterpolation = .high
            draw(
                in: NSRect(origin: .zero, size: to),
                from: NSRect(origin: .zero, size: size),
                operation: .copy,
                fraction: 1
            )
        }
        img.unlockFocus()
        return img
    }
}
