//
//  ContentView.swift
//  finditapp
//
//  Created by Son Tung Le on 18/8/26.
//

import SwiftUI

struct ContentView: View {
    @State private var posts: [LostFoundPost] = []
    
    var body: some View {
        TabView {
            NavigationStack {
                BrowseView(posts: $posts)
            }
            .tabItem {
                Label("Browse", systemImage: "magnifyingglass")
            }

            PostView(posts: $posts)
            .tabItem {
                Label("Post", systemImage: "plus.circle")
            }

            NavigationStack {
                MyStuffView()
            }
            .tabItem {
                Label("My stuff", systemImage: "shippingbox")
            }

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
        }
    }
}

#Preview {
    ContentView()
}
