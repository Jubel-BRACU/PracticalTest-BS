//
//  MovieListView.swift
//  PracticalTest-BS
//
//  Created by Md Jubel Hossain on 12/9/23.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var networkManager = NetworkManager()
    var body: some View {
        VStack(alignment: .leading){
            Text("Movie List")
                .font(.title)
                .fontWeight(.bold)
            Divider()
            ScrollView{
                if networkManager.loading {
                    ZStack{
                        ProgressView()
                            .tint(.orange) // 1
                            .foregroundColor(.gray) // 2
                    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                } else {
                    LazyVStack{
                        ForEach(networkManager.movies.results, id: \.self){movie in
                            MovieRow(movie: movie)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
