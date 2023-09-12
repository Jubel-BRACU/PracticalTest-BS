//
//  SearchBar.swift
//  PracticalTest-BS
//
//  Created by Md Jubel Hossain on 12/9/23.
//

import SwiftUI

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    var body: some View {
        HStack{
            TextField("search...",text: $text)
                .padding(8)
                .padding(.horizontal,24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        Spacer()
                        Image(systemName: "multiply") .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing)
                            .opacity(text.isEmpty ? 0 : 1)
                            .onTapGesture {
                                text.removeAll()
                            }
                    }
                )
            
        }.padding(.horizontal, 4)
    }
}


struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
