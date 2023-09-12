//
//  MovieSearchViewModel.swift
//  PracticalTest-BS
//
//  Created by Md Jubel Hossain on 12/9/23.
//

import Combine
import Foundation
class MovieSearchViewModel: ObservableObject {
    
    private let urlSession = URLSession.shared
    @Published var movies: [Movie]?
    @Published var searchText = ""
    private let jsonDecoder = Utils.jsonDecoder
    @Published var movielist = MovieList(results: [])
    private var subscriptionToken: AnyCancellable?
    @Published var movie: Movie?
    
    //MARK: - Start Search
    func startSearch(){
        self.movies = nil
        guard subscriptionToken == nil else { return }
        self.subscriptionToken = self.$searchText
            .map { [weak self] text in
                self?.movies = nil
                return text
                
            }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] in self?.search(query: $0) }
        
        
    }
    //MARK: - Load Movie
    func loadMovie(id: Int){
        self.movie = nil
        self.fetchMovie(id: id) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Search Movie
    func search(query: String) {
        self.fetchMovie(query: searchText.lowercased()) {[weak self] (result) in
            switch result {
            case .success(let response):
                self?.movies = response.results
                print(response.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    //MARK: - Fetch Movie
    func fetchMovie(query: String, completion: @escaping (Result<MovieList, MovieError>) -> ()){
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "language": "en-US",
            "include_adult": "false",
            "region": "US",
            "query": query
        ], completion: completion)
        
    }
    //MARK: - Fetch Movie
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "append_to_response": "videos,credits"
        ], completion: completion)
    }
    //MARK: - Load URL and Decode
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: api_key)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    
}



