//
//  ContentView.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import SwiftUI

struct HomeView: View {
    @State private var openPhotos = false
    @State private var image: Data? = .init(count: 0)
    var body: some View {
            VStack {
                topView
                Spacer()
            }
        .sheet(isPresented: $openPhotos) {
            ImagePicker(show: $openPhotos, image: $image)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    var topView: some View {
        HStack {
            Spacer()
            Image(data: self.image)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .onTapGesture {
                    openPhotos.toggle()
                }
        }
        .padding()
    }
}

private extension Image {
     init(data: Data?) {
        guard let data = data,
          let uiImage = UIImage(data: data) else {
            self = Symbols.profile
            return
        }
        self = Image(uiImage: uiImage)
    }
}
