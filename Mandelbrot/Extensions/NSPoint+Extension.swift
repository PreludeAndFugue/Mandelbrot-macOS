//
//  NSImage+Extension.swift
//  Mandelbrot
//
//  Created by gary on 05/05/2017.
//  Copyright © 2017 Gary Kerr. All rights reserved.
//

import Foundation

extension NSPoint {

    func invertY(height: Int) -> NSPoint {
        return NSPoint(x: self.x, y: CGFloat(height) - self.y)
    }
}
