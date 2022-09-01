//
//  LaunchScreenView.swift
//  Edvora IOS Test
//
//  Created by Mroot on 02/09/2022.
//

import SwiftUI

struct LaunchScreenView: View {
    @State var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        if isActive {
            TabsView()
        } else {
            VStack {
                VStack(alignment: .center) {
                    Image("appImage")
                        .resizable()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black.opacity(0.1),lineWidth:4)
                            .shadow(color: Color.gray, radius: 5, x: -2, y: 0))
                        .mask(Circle().padding(.leading, -30))
                        .frame(width: 200, height: 200, alignment: .center)
                        .padding(.top, 20)
                    Text("Edvora IOS Test")
                        .font(.custom("Papyrus", size: 24))
                        .fontWeight(.bold)
                        .font(.system(size: 38))
                        .padding(.bottom, 50)
                        ProgressView()
                            .scaleEffect(2)
                            .font(.system(size:8))
                            .frame(alignment: .bottom)
                            .padding()
                            .padding(.bottom, 60)
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Theme.baseColor).opacity(0.9)
            } .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0 ) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
