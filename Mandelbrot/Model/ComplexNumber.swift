//
//  ComplexNumber.swift
//  Mandelbrot
//
//  Created by gary on 29/04/2017.
//  Copyright © 2017 Gary Kerr. All rights reserved.
//

import Foundation

struct ComplexNumber {
    let x: Double
    let y: Double


    func modulus() -> Double {
        return x*x + y*y
    }


    static func + (lhs: ComplexNumber, rhs: ComplexNumber) -> ComplexNumber {
        return ComplexNumber(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }


    static func - (lhs: ComplexNumber, rhs: ComplexNumber) -> ComplexNumber {
        return ComplexNumber(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }


    static func * (lhs: ComplexNumber, rhs: ComplexNumber) -> ComplexNumber {
        return ComplexNumber(x: lhs.x * rhs.x - lhs.y * rhs.y, y: lhs.x * rhs.y + lhs.y * rhs.x)
    }
}
