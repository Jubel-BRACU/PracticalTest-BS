//
//  Movie.swift
//  PracticalTest-BS
//
//  Created by Md Jubel Hossain on 11/9/23.
//

import Foundation

struct Movie: Decodable, Identifiable {
    var id: UUID = UUID()
    var image: String?
    var title: String
    var overview: String
}
