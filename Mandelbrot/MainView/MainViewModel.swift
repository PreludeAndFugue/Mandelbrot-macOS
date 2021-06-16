//
//  MainViewModel.swift
//  Mandelbrot
//
//  Created by gary on 09/06/2021.
//  Copyright © 2021 Gary Kerr. All rights reserved.
//

import Cocoa
import Combine

import MandelbrotEngine

class MainViewModel: ObservableObject {
    @Published var image = NSImage(size: .init(width: 600, height: 600))
    @Published var progress = Progress(totalUnitCount: 100)
    @Published var isInProgress = false
    @Published var colourSelection = 1

    private var config = MandelbrotSetConfig(imageWidth: 600, imageHeight: 600)
    private var colourMap = ColourMapFactory.maps[0]


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
        config = MandelbrotSetConfig(imageWidth: 600, imageHeight: 600)
        makeSet()
    }


    func save() {
        print("save")
    }
}


// MARK: - Private

private extension MainViewModel {
    func makeSet() {
        progress = Progress(totalUnitCount: 100)
        isInProgress = true
        DispatchQueue.global().async {
            let mandelbrotSet = MandelbrotSet(config: self.config, progress: self.progress)
            print(mandelbrotSet.imageSize)
            DispatchQueue.main.async {
                self.image = NSImage.from(mandelbrotSet: mandelbrotSet, colourMap: self.colourMap)
                self.isInProgress = false
            }
        }
    }
}
