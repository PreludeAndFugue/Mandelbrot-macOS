//
//  NSImage+Extension.swift
//  Mandelbrot
//
//  Created by gary on 05/05/2017.
//  Copyright © 2017 Gary Kerr. All rights reserved.
//

import Cocoa

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
            let providerRef = CGDataProvider(data: NSData(bytes: &data, length: data.count * MemoryLayout<Pixel>.size))
        else { fatalError("no cg data provider") }

        guard let image = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: width * MemoryLayout<Pixel>.size,
            space: rgbColorSpace,
            bitmapInfo: bitmapInfo,
            provider: providerRef,
            decode: nil,
            shouldInterpolate: true,
            intent: CGColorRenderingIntent.defaultIntent
        ) else { fatalError("Couldn't create CGImage") }
        return NSImage(cgImage: image, size: NSZeroSize)
    }


    func saveAsJpg(to url: URL) {
        let options: [String: Any] = [NSImageCompressionFactor: 1.0]
        guard
            let imageData = tiffRepresentation,
            let bitmapImageRep = NSBitmapImageRep(data: imageData),
            let data = bitmapImageRep.representation(using: .JPEG, properties: options)
        else { return }
        try? data.write(to: url, options: [])
    }
}
