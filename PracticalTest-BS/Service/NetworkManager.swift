//
//  NetworkManager.swift
//  PracticalTest-BS
//
//  Created by Md Jubel Hossain on 12/9/23.
//

import Foundation
class NetworkManager: ObservableObject {
    @Published var movies = MovieList(results: [])
    @Published var loading = false
  
    init() {
        loading = true
        loadData()
    }
    
    private func loadData() {
        guard let url = URL(string: "\(api_url_base)\(api_key)") else { return }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else { return }
            let movies = try! JSONDecoder().decode(MovieList.self, from: data)
            DispatchQueue.main.async {
                self.movies = movies
                self.loading = false
            }
        }.resume()
    }
}
