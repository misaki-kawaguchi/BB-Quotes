//
//  ContentView.swift
//  BB Quotes
//
//  Created by 川口美咲 on 2024/04/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            QuoteView()
                .tabItem {
                    Label("Breaking Bad", systemImage: "tortoise")
                }
            
            Text("Better Call Saul View")
                .tabItem {
                    Label("Better Call Saul", systemImage: "briefcase")
                }
        }
        .onAppear {
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
