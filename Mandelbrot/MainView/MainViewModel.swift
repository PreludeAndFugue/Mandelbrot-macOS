//
//  MainViewModel.swift
//  Mandelbrot
//
//  Created by gary on 09/06/2021.
//  Copyright © 2021 Gary Kerr. All rights reserved.
//

import Cocoa
import Combine

class MainViewModel: ObservableObject {
    @Published var image = NSImage(size: .init(width: 600, height: 600))
    @Published var colourSelection = 1

    private var config = MandelbrotSetConfig.standard


    func draw() {
        makeSet()
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
        let newCentre = transform.transform(point: location)
        config = config.zoomIn(centre: newCentre)
        makeSet()
    }


    func reset() {
        config = .standard
        makeSet()
    }


    func save() {
        print("save")
    }
}


// MARK: - Private

private extension MainViewModel {
    func makeSet() {
        print("colour selection", colourSelection)
        let mandelbrotSet = MandelbrotSet(config: config)
        let colourMap = GreyScale(numberOfGreys: 200)

        let pixels = mandelbrotSet.grid.map({ colourMap.pixel(from: $0.test) })
        image = NSImage.from(
            pixels: pixels,
            width: mandelbrotSet.imageSize.width,
            height: mandelbrotSet.imageSize.height
        )
    }
}
