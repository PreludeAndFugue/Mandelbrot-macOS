//
//  LinearTransformationTests.swift
//  Mandelbrot
//
//  Created by gary on 29/04/2017.
//  Copyright © 2017 Gary Kerr. All rights reserved.
//

import XCTest
@testable import Mandelbrot


typealias Pair = (x: Double, y: Double)

class LinearTransformationTests: XCTestCase {

    func testIdentity() {
        let rectangle = Rectangle(xMin: 0, yMin: 0, xMax: 1, yMax: 1)
        let transform = LinearTransformation(from: rectangle, to: rectangle)
        let pairs: [Pair] = [
            (0, 0), (0, 1), (1, 0), (1, 1)
        ]
        for (x, y) in pairs {
            let (xNew, yNew) = transform.transform(x: x, y: y)
            XCTAssertEqualWithAccuracy(xNew, x, accuracy: 0.001)
            XCTAssertEqualWithAccuracy(yNew, y, accuracy: 0.001)
        }
    }


    func testDouble() {
        let fromRectangle = Rectangle(xMin: 0, yMin: 0, xMax: 1, yMax: 1)
        let toRectangle = Rectangle(xMin: 0, yMin: 0, xMax: 2, yMax: 2)
        let transform = LinearTransformation(from: fromRectangle, to: toRectangle)
        let input: [Pair] = [
            (0, 0), (1, 1), (0.5, 0.5), (0, 1)
        ]
        let output: [Pair] = [
            (0, 0), (2, 2), (1, 1), (0, 2)
        ]
        for (inPair, outPair) in zip(input, output) {
            let (xNew, yNew) = transform.transform(x: inPair.x, y: inPair.y)
            XCTAssertEqualWithAccuracy(xNew, outPair.x, accuracy: 0.001)
            XCTAssertEqualWithAccuracy(yNew, outPair.y, accuracy: 0.001)
        }
    }


    func testScreen() {
        let fromRectangle = Rectangle(xMin: -2, yMin: -1, xMax: 1, yMax: 1)
        let toRectangle = Rectangle(xMin: 0, yMin: 0, xMax: 900, yMax: 600)
        let transform = LinearTransformation(from: fromRectangle, to: toRectangle)
        let input: [Pair] = [
            (-2, -1), (0, 0)
        ]
        let output: [Pair] = [
            (0, 0), (600, 300)
        ]
        for (inPair, outPair) in zip(input, output) {
            let (xNew, yNew) = transform.transform(x: inPair.x, y: inPair.y)
            XCTAssertEqualWithAccuracy(xNew, outPair.x, accuracy: 0.001)
            XCTAssertEqualWithAccuracy(yNew, outPair.y, accuracy: 0.001)
        }
    }
}
