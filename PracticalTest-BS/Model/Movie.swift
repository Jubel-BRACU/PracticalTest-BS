//
//  Movie.swift
//  PracticalTest-BS
//
//  Created by Md Jubel Hossain on 11/9/23.
//

import Foundation

struct Movie: Decodable, Identifiable,Hashable {
    let id: Int
    var title: String
    var poster_path: String
    var overview: String
    let voteAverage: Double
    let releaseDate: String?
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Utils.yearFormatter.string(from: date)
    }
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case poster_path, overview,releaseDate
        case voteAverage
    }
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
            self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? "Hello"
            self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path) ?? "Hello"
            self.overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
            self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0.0
            self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
            
        }
    }
    init() {
        self.id = 0
        self.title = "Moview Name"
        self.poster_path = ""
        self.overview = "This is overview"
        self.voteAverage = 0.0
        self.releaseDate = "2023"
    }
}
