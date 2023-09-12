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
            AsyncImage(url: URL(string: "\(BASE_IMAGE_URL)\(movie.poster_path)")){image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            } placeholder: {
                Color.gray
            }
            .frame(width: 90, height: 120)
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
