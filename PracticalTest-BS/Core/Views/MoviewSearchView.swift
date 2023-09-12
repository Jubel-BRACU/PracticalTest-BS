//
//  MoviewSearchView.swift
//  PracticalTest-BS
//
//  Created by Md Jubel Hossain on 12/9/23.
//

import SwiftUI

struct MoviewSearchView: View{
    @ObservedObject var viewModel = MovieSearchViewModel()
    @State var isPresented: Bool = false
    @State var id: Int = 0
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var showNetworkAlert = false
    var body: some View{
        VStack{
            SearchBar(text: $viewModel.searchText)
                .padding()
            
            ScrollView{
                LazyVStack(alignment: .leading){
                    ForEach(viewModel.movies ?? [], id: \.self){movie in
                        
                        VStack(alignment: .leading, spacing: 10){
                            HStack{
                                Spacer()
                                Text(movie.title)
                                    .font(.title3)
                                    .fontWeight(.medium)
                                Spacer()
                            }
                            Text(movie.overview)
                                .fixedSize(horizontal: false, vertical: true)
                            Divider()
                        }.padding(.horizontal)
                    
                    }
                    
                }
                
            }
        }
        .alert("Network connection seems to be offline.", isPresented: $showNetworkAlert) {
            Button("OK", role: .cancel) { }
        }
        .onAppear {
            if networkMonitor.isConnected{
                viewModel.startSearch()
            }
            else {
                showNetworkAlert = true
            }
        }
    }
}


struct MoviewSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MoviewSearchView()
    }
}
