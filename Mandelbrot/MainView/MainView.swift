//
//  MainView.swift
//  Mandelbrot
//
//  Created by gary on 09/06/2021.
//  Copyright © 2021 Gary Kerr. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Button(action: viewModel.draw) {
                    Text("Draw")
                }

                Button(action: viewModel.reset) {
                    Text("Reset")
                }

                Button(action: viewModel.save) {
                    Text("Save")
                }

                Picker("Colours", selection: $viewModel.colourSelection) {
                    Text("c 1").tag(1)
                    Text("c 2").tag(2)
                    Text("c 3").tag(3)
                    Text("c 4").tag(4)
                    Text("c 5").tag(5)
                }
                .pickerStyle(MenuPickerStyle())
                .labelsHidden()

                Spacer()

                Text("dx: 1")

                Text("dy: 2")

                Text("iterations: 1000")
            }
            .frame(minWidth: 100)

            ZStack {
                Image(nsImage: viewModel.image)
                    .resizable()
                    .frame(width: 600, height: 600)
                    .background(Color.black)
                    .cornerRadius(8)
                    .gesture(makeGesture())

                ProgressView(viewModel.progress)
                    .frame(width: 250)
                    .padding()
                    .background(Color.init(.sRGB, white: 1, opacity: 0.15))
                    .cornerRadius(8)
                    .opacity(viewModel.isInProgress ? 1 : 0)
            }
        }
        .padding()
    }


    func makeGesture() -> _EndedGesture<DragGesture> {
        let gesture = DragGesture(minimumDistance: 0, coordinateSpace: .local)
        let x = gesture.onEnded() { value in
            viewModel.select(location: value.location)
        }
        return x
    }
}


#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
//            .previewLayout(.fixed(width: 800.0, height: 800.0))
    }
}
#endif
