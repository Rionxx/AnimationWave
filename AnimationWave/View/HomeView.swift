//
//  HomeView.swift
//  AnimationWave
//
//  Created by FX on 2022/02/12.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image("rion")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding(10)
                .background(Color.white, in: Circle())
            
            Text("Rion")
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
            
            // MARK: Wave Form
            GeometryReader { proxy in
                let size = proxy.size
                
                ZStack {
                    // MARK: Flame Animation
                    
                    Image(systemName: "flame.fill")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .scaleEffect(x: 1.1, y: 1)
                    
                    // Flame Form Shape
                    FlameWave(progress: 0.5, waveHeight: 0, offset: size.width)
                        .fill(Color.orange)
                        .mask {
                            Image(systemName: "flame.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(5)
                        }
                }.frame(width: size.width, height: size.height, alignment: .center)
            }.frame(height: 350)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.green)
    }
}

struct FlameWave: Shape {
    var progress: CGFloat
    var waveHeight: CGFloat
    var offset: CGFloat
    
    var animationData: CGFloat {
        get {offset}
        set {offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: .zero)
            
            //MARK: Drawing Waves using Sine
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2) {
                let x: CGFloat = value
                let sine: CGFloat = sin(Angle(degrees: value + offset).radians)
                let y: CGFloat = progressHeight + (height * sine)
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
            //Bottom Portion
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
