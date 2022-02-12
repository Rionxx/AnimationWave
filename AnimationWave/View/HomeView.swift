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
                .foregroundColor(Color.orange)
            
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
                }
                .frame(width: size.width, height: size.height, alignment: .center)
            }
            .frame(height: 350)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.green)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
