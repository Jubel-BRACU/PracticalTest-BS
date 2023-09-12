//
//  MoviewSearchView.swift
//  PracticalTest-BS
//
//  Created by Md Jubel Hossain on 12/9/23.
//

import SwiftUI

struct MoviewSearchView: View{
    @ObservedObject var viewModel = MovieSearchViewModel()
    var body: some View{
        VStack{
            SearchBar(text: $viewModel.searchText)
                .padding()
            
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.movies ?? [], id: \.self){movie in
                        
                        MovieRow(movie: movie)
                    }
                    
                }
            }
        }.onAppear {
            viewModel.startSearch()
        }
    }
}


struct MoviewSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MoviewSearchView(viewModel: MovieSearchViewModel())
    }
}
