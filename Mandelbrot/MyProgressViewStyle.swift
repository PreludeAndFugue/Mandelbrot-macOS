//
//  MyProgressViewStyle.swift
//  MandelbrotApp
//
//  Created by gary on 18/06/2021.
//  Copyright © 2021 Gary Kerr. All rights reserved.
//

import SwiftUI

struct MyProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .foregroundColor(.black)
                Capsule()
                    .foregroundColor(.purple)
                    .frame(width: proxy.size.width * CGFloat(configuration.fractionCompleted ?? 0))
            }
        }
    }
}
