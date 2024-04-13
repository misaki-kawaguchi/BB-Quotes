//
//  QuoteView.swift
//  BB Quotes
//
//  Created by 川口美咲 on 2024/04/13.
//

import SwiftUI

struct QuoteView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.breakingbad)
                    .resizable()
                    .frame(
                        width: geo.size.width * 2.7,
                        height: geo.size.height * 1.2
                    )
                VStack {
                    Spacer(minLength: 120)
                    
                    Text("\"You either run from things, or you face them, Mr. White.\"")
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                        .background(.black.opacity(0.5))
                        .cornerRadius(25)
                        .padding(.horizontal)
                    
                    ZStack(alignment: .bottom) {
                        Image(.jessepinkman)
                            .resizable()
                            .scaledToFill()
                        
                        Text("Jesse Pinkman")
                            .foregroundColor(.white)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                    }
                    .frame(
                        width: geo.size.width / 1.1,
                        height: geo.size.height / 1.8
                    )
                    .cornerRadius(80)
                    
                    Button {
                        
                    } label: {
                        Text("Get Random Quote")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(.breakingBadGreen)
                            .cornerRadius(7)
                            .shadow(color: .breakingBadYellow, radius: 2)
                    }
                    
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                }
                .frame(width: geo.size.width)
            }
            .frame(
                width: geo.size.width,
                height: geo.size.height
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    QuoteView()
        .preferredColorScheme(.dark)
}
