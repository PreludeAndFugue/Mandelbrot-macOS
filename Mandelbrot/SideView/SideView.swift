//
//  SideView.swift
//  Mandelbrot
//
//  Created by gary on 11/07/2021.
//  Copyright © 2021 Gary Kerr. All rights reserved.
//

import SwiftUI

struct SideView: View {
    @StateObject var model: MainViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Picker("Colours", selection: $model.colourSelection) {
                ForEach(0..<model.colourMaps.count) { i in
                    HStack {
                        model.previewImage(for: model.colourMaps[i])
                        Text(model.colourMaps[i].title)
                    }
                    .tag(i)
                }
            }
            .onChange(of: model.colourSelection, perform: { _ in model.draw() })
            .pickerStyle(MenuPickerStyle())
            .labelsHidden()

            Button(action: model.reset) {
                Text("Reset")
            }

            Button(action: model.save) {
                Text("Save")
            }

            Spacer()

            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading) {
                    Text("Max iterations")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    Text("\(model.iterations)")
                }

                VStack(alignment: .leading) {
                    Text("Total iterations")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    Text(model.totalIterations)
                }

                VStack(alignment: .leading) {
                    Text("Render time")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    Text(model.renderTime)
                }
            }
        }
    }
}


#if DEBUG
struct SideView_Previews: PreviewProvider {
    static var previews: some View {
        SideView(model: MainViewModel())
    }
}
#endif
