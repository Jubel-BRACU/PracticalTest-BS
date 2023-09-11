//
//  MovieRow.swift
//  PracticalTest-BS
//
//  Created by Md Jubel Hossain on 11/9/23.
//

import SwiftUI

struct MovieRow : View {
    var movie: Movie
    var body: some View {
        HStack(spacing: 30){
            if let image = movie.image {
              Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 120)
            }
            else {
                Image(systemName: "photo")
            }
            
            VStack(alignment: .leading, spacing: 10){
                Text(movie.title)
                    .font(.title3)
                    .fontWeight(.medium)
                Text(movie.overview)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        Divider()
    }
}
