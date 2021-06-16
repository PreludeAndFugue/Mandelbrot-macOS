//
//  ViewController.swift
//  Mandelbrot
//
//  Created by gary on 29/04/2017.
//  Copyright © 2017 Gary Kerr. All rights reserved.
//

import Foundation
import Cocoa

class ViewController: NSViewController {

//    var colourMaps: [ColourMapProtocol]?
//    var config: MandelbrotSetConfig!
//    var mandelbrotSet: MandelbrotSet?
//
//    @IBOutlet weak var colourSelection: NSPopUpButton!
//    @IBOutlet weak var imageView: NSImageView!
//    @IBOutlet weak var information: NSTextField!
//
//
//    @IBAction func clickImage(_ sender: NSClickGestureRecognizer) {
//        let imageCoords = sender.location(in: imageView).invertY(height: config.imageHeight)
//        let imageRect = Rectangle(xMin: 0, yMin: 0, xMax: config.imageWidth, yMax: config.imageHeight)
//        let complexRect = Rectangle(config: config)
//        let transform = Transformation(from: imageRect, to: complexRect)
//        let newCentre = transform.transform(point: imageCoords)
//        config = config.zoomIn(centre: newCentre)
//        makeSet(with: config)
//    }
//
//
//    @IBAction func draw(_ sender: NSButton) {
//        guard let mandelbrotSet = mandelbrotSet else {
//            makeSet(with: config)
//            return
//        }
//        let colourMap = colourMaps![colourSelection.indexOfSelectedItem]
//        let pixels = mandelbrotSet.grid.map({ colourMap.pixel(from: $0.test) })
//        let image = NSImage.from(pixels: pixels, width: mandelbrotSet.imageSize.width, height: mandelbrotSet.imageSize.height)
//        imageView.image = image
//    }
//
//
//    @IBAction func reset(_ sender: NSButton) {
//        config = config.reset()
//        makeSet(with: config)
//    }
//
//
//    @IBAction func save(_ sender: NSButton) {
//        let savePanel = NSSavePanel()
//        savePanel.nameFieldStringValue = "mandelbrot.jpg"
//        if savePanel.runModal() == .OK {
//            guard let url = savePanel.url else { return }
//            imageView.image?.saveAsJpg(to: url)
//        }
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        colourMaps = [
//            GreyScale(numberOfGreys: 200),
//            YellowScale(numberOfYellows: 100),
//            SmoothScale(),
//            ManyColourGradient(n: 100, colours: (r: 255, g: 0, b: 0), (r: 255, g: 255, b: 0)),
//            ManyColourGradient(n: 70, colours: (r: 255, g: 0, b: 0), (r: 255, g: 255, b: 0), (r: 255, g: 255, b: 255))
//        ]
//        config = MandelbrotSetConfig.standard
//    }
//
//
//    // MARK:- Private
//
//    private func makeSet(with config: MandelbrotSetConfig) {
//        mandelbrotSet = MandelbrotSet(config: config)
//        information.stringValue = config.description(set: mandelbrotSet!)
//        let colourMap = colourMaps![colourSelection.indexOfSelectedItem]
//        let pixels = mandelbrotSet!.grid.map({ colourMap.pixel(from: $0.test) })
//        let image = NSImage.from(pixels: pixels, width: mandelbrotSet!.imageSize.width, height: mandelbrotSet!.imageSize.height)
//        imageView.image = image
//    }
}
