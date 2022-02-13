//
//  HomeView.swift
//  AnimationWave
//
//  Created by FX on 2022/02/12.
//

import SwiftUI

struct HomeView: View {
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0
    
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
            GeometryReader{proxy in
                let size = proxy.size
                
                ZStack {
                    // MARK: Flame Animation
                    
                    Image(systemName: "flame.fill")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .scaleEffect(x: 1.1, y: 1)
                        .offset(y: -1)
                    
                    // Flame Form Shape
                    FlameWave(progress: progress, waveHeight: 0.1, offset: startAnimation)
                        .fill(Color.orange)
                        .overlay(content: {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.4))
                                    .frame(width: 15, height: 15)
                                    .offset(x: -40)
                                
                                Circle()
                                    .fill(Color.white.opacity(0.5))
                                    .frame(width: 15, height: 15)
                                    .offset(x: 50, y: 30)
                                
                                Circle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 25, height: 25)
                                    .offset(x: -50, y: 80)
                                
                                Circle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 25, height: 25)
                                    .offset(x: -80, y: 70)
                                
                                Circle()
                                    .fill(Color.white.opacity(0.5))
                                    .frame(width: 25, height: 25)
                                    .offset(x: 60, y: 100)
                                
                                Circle()
                                    .fill(Color.white.opacity(0.5))
                                    .frame(width: 25, height: 25)
                                    .offset(x: -70, y: 10)
                            }
                        })
                        .mask {
                            Image(systemName: "flame.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(15)
                        }
                        .overlay(alignment: .bottom) {
                            Button {
                                progress += 0.01
                            } label: {
                                 Image(systemName: "plus")
                                    .font(.system(size: 40, weight: .black))
                                    .foregroundColor(Color.orange)
                                    .shadow(radius: 2)
                                    .padding(25)
                                    .background(.white, in: Circle())
                            }
                            .offset(y: 40)
                        }
                }//ZStak
                .frame(width: size.width, height: size.height, alignment: .center)
                .onAppear {
                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                        startAnimation = size.width
                    }//withAnimation
                }//onAppear
            }
            .frame(height: 350)
            Slider(value: $progress)
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
    
    var animatableData: CGFloat {
        get{offset}
        set{offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
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
