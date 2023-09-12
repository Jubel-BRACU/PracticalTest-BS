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
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case poster_path, overview
    }
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
            self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? "Hello"
            self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path) ?? "Hello"
            self.overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        }
    }
    init() {
        self.id = 0
        self.title = "Moview Name"
        self.poster_path = ""
        self.overview = "This is overview"
    }
}
