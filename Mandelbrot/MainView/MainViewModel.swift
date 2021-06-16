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

    var colourMaps = ColourMapFactory.maps

    private var config = MandelbrotSetConfig(imageWidth: 600, imageHeight: 600)
    private var mandelbrotSet: MandelbrotSet?


    func draw() {
        guard let set = mandelbrotSet else { return }
        let colourMap = colourMaps[colourSelection]
        image = NSImage.from(mandelbrotSet: set, colourMap: colourMap)
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


    func onAppear() {
        makeSet()
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
                self.isInProgress = false
            }
        }
    }
}
