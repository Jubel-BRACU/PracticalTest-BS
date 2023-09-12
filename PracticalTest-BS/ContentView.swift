//
//  ContentView.swift
//  PracticalTest-BS
//
//  Created by Md Jubel Hossain on 11/9/23.
//

import SwiftUI
//MARK: - ContentView
struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemGray5
    }
    var body: some View {
        TabView {
            //MARK: - MovieList View
            MovieListView()
                .tabItem {
                    VStack {
                        Image(systemName: "film")
                        Text("Movies")
                    }
                }
                .tag(0)
            
            //MARK: - Movie Search View
            MoviewSearchView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
                .tag(1)
        }
        .accentColor(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
