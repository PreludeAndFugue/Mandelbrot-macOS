//
//  Formatter.swift
//  Mandelbrot
//
//  Created by gary on 11/07/2021.
//  Copyright © 2021 Gary Kerr. All rights reserved.
//

import Foundation

final class Formatter {
    func format(renderTime: TimeInterval) -> String {
        let m = Measurement(value: renderTime, unit: UnitDuration.seconds)
        return renderTimeFormatter.string(from: m)
    }


    func format(iterations: Int) -> String {
        let n = NSNumber(value: iterations)
        return intFormatter.string(from: n) ?? "0"
    }
}


private var intFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.allowsFloats = false
    f.groupingSize = 3
    f.hasThousandSeparators = true
    f.localizesFormat = true
    f.numberStyle = .decimal
    return f
}()


private var renderTimeFormatter: MeasurementFormatter = {
    let f = MeasurementFormatter()
    let nf = NumberFormatter()
    nf.maximumFractionDigits = 2
    f.numberFormatter = nf
    return f
}()
