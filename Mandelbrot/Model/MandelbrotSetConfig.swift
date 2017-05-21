//
//  MandelbrotSetConfig.swift
//  Mandelbrot
//
//  Created by gary on 03/05/2017.
//  Copyright © 2017 Gary Kerr. All rights reserved.
//

struct MandelbrotSetConfig: CustomStringConvertible {

    static let standard = MandelbrotSetConfig(imageWidth: 800, imageHeight: 800, width: 3, height: 3, centre: ComplexNumber(x: -0.5, y: 0), iterations: 300)

    let imageWidth: Int
    let imageHeight: Int
    let width: Double
    let height: Double
    let centre: ComplexNumber
    let iterations: Int

    var xMin: Double {
        return centre.x - width/2
    }

    var xMax: Double {
        return centre.x + width/2
    }

    var yMin: Double {
        return centre.y - height/2
    }

    var yMax: Double {
        return centre.y + height/2
    }

    var dx: Double {
        return width/Double(imageWidth)
    }

    var dy: Double {
        return height/Double(imageWidth)
    }

    var description: String {
        return "Config(imageWidth: \(imageWidth), imageHeight: \(imageHeight), width: \(width), height: \(height), centre: \(centre), iterations: \(iterations), xMin: \(xMin), xMax: \(xMax), yMin: \(yMin), yMax: \(yMax), dx: \(dx), dy: \(dy))"
    }

    func description(set: MandelbrotSet) -> String {
        let totalIterations = set.gridIterations(config: self)
        let averageIterations = Double(totalIterations) / Double(imageWidth * imageHeight)
        return "dx:\n\(xMax - xMin)\n\ndy:\n\(yMax - yMin)\n\nmax iterations:\n\(iterations)\n\ntotal iterations:\n\(totalIterations)\n\nav. per pixel:\n\(averageIterations)"
    }


    func zoomIn(centre: ComplexNumber) -> MandelbrotSetConfig {
        return MandelbrotSetConfig(imageWidth: imageWidth, imageHeight: imageHeight, width: width/2, height: height/2, centre: centre, iterations: Int(1.4*Double(iterations)))
    }


    func reset() -> MandelbrotSetConfig {
        return MandelbrotSetConfig.standard
    }
}
