//
//  QuoteView.swift
//  BB Quotes
//
//  Created by 川口美咲 on 2024/04/13.
//

import SwiftUI

struct QuoteView: View {
    @StateObject private var viewModel = ViewModel(controller: FetchController())
    
    let show: String
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.lowerNoSpaces)
                    .resizable()
                    .frame(
                        width: geo.size.width * 2.7,
                        height: geo.size.height * 1.2
                    )
                
                VStack {
                    VStack {
                        Spacer(minLength: 120)
                        
                        switch viewModel.status {
                        case .success(let data) :
                            Text("\"\(data.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .cornerRadius(25)
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: data.character.images[0]) { image in
                                    image.resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(
                                    width: geo.size.width / 1.1,
                                    height: geo.size.height / 1.8
                                )
                                
                                Text("\(data.quote.character)")
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
                            
                        case .fetching:
                            ProgressView()
                            
                        default:
                            EmptyView()
                        }
                        
                        Spacer()
                    }
                    
                    Button {
                        Task {
                            await viewModel.getData(for: show)
                        }
                    } label: {
                        Text("Get Random Quote")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("\(show.noSpaces)Button"))
                            .cornerRadius(7)
                            .shadow(color:Color("\(show.noSpaces)Shadow"), radius: 2)
                    }
                    
                    Spacer(minLength: 140)
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
    QuoteView(show: Constants.bcsName)
        .preferredColorScheme(.dark)
}
