//
//  MandelbrotImage.swift
//  Mandelbrot
//
//  Created by gary on 19/06/2021.
//  Copyright © 2021 Gary Kerr. All rights reserved.
//

import SwiftUI
import UniformTypeIdentifiers

struct MandelbrotImage: FileDocument {
    var image: NSImage

    static var readableContentTypes: [UTType] {
        [.jpeg]
    }

    init(image: NSImage) {
        self.image = image
    }

    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            image = NSImage(data: data) ?? NSImage(size: .zero)
        } else {
            image = NSImage(size: .zero)
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = image.tiffRepresentation ?? Data()
        return FileWrapper(regularFileWithContents: data)
    }
}
