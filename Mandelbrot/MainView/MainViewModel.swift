//
//  MainViewModel.swift
//  Mandelbrot
//
//  Created by gary on 09/06/2021.
//  Copyright © 2021 Gary Kerr. All rights reserved.
//

import Cocoa
import Combine
import Foundation
import SwiftUI

import MandelbrotEngine

class MainViewModel: ObservableObject {
    private let internalWidth = 1200
    private let internalHeight = 1200
    let viewWidth: CGFloat = 600
    let viewHeight: CGFloat = 600

    @Published var image = NSImage(size: NSSize(width: 0, height: 0))
    @Published var imageFile = MandelbrotImage(image: NSImage(size: .zero))

    @Published var progress = Progress(totalUnitCount: 100)
    @Published var isInProgress = false
    @Published var isSaving = false
    @Published var colourSelection = 1

    var colourMaps = ColourMapFactory.maps

    private lazy var config = {
        MandelbrotSetConfig(imageWidth: internalWidth, imageHeight: internalHeight)
    }()
    private var mandelbrotSet: MandelbrotSet?


    func draw() {
        guard let set = mandelbrotSet else { return }
        let colourMap = colourMaps[colourSelection]
        image = NSImage.from(mandelbrotSet: set, colourMap: colourMap)
        imageFile = MandelbrotImage(image: image)
    }


    func select(location: CGPoint) {
        let imageRect = Rectangle(
            xMin: 0,
            yMin: 0,
            xMax: config.imageWidth,
            yMax: config.imageHeight
        )
        let complexRect = Rectangle(config: config)
        let transform = Transformation(from: imageRect, to: complexRect)
        let scaleX = CGFloat(internalWidth) / CGFloat(viewWidth)
        let scaleY = CGFloat(internalHeight) / CGFloat(viewHeight)
        let affineT = CGAffineTransform(scaleX: scaleX, y: scaleY)
        let scaledLocation = location.applying(affineT)
        let newCentre = transform.transform(point: scaledLocation)
        config = config.zoomIn(centre: newCentre)
        makeSet()
    }


    func reset() {
        config = MandelbrotSetConfig(imageWidth: internalWidth, imageHeight: internalHeight)
        makeSet()
    }


    func save() {
        isSaving = true
    }


    func onAppear() {
        makeSet()
    }


    /// Creates the preview image for the colour map picker
    ///
    /// Note I have to resize the NSImage rather than use the Image
    /// view modifiers in the view because the `resizable` and
    /// `aspectRatio` methods don't seem to change the size of the
    /// image when contained in a `frame`.
    ///
    /// - Parameter map: The colour map.
    /// - Returns: The preview image.
    func previewImage(for map: ColourMapProtocol) -> Image {
        let width = Int(sqrt(Double(map.preview.count)))
        if width == 0 {
            return Image(systemName: "questionmark.square.fill")
        }
        let nsImage = NSImage.from(pixels: map.preview, width: width, height: width)
            .resized(to: CGSize(width: 16, height: 16))
        return Image(nsImage: nsImage)
    }
}


// MARK: - Private

private extension MainViewModel {
    func makeSet() {
        progress = Progress(totalUnitCount: 100)
        isInProgress = true
        DispatchQueue.global().async {
            let mandelbrotSet = MandelbrotSet(config: self.config, progress: self.progress)
            self.mandelbrotSet = mandelbrotSet
            DispatchQueue.main.async {
                let colourMap = self.colourMaps[self.colourSelection]
                self.image = NSImage.from(mandelbrotSet: mandelbrotSet, colourMap: colourMap)
                self.imageFile = MandelbrotImage(image: self.image)
                self.isInProgress = false
                print(self.image.size)
            }
        }
    }
}
