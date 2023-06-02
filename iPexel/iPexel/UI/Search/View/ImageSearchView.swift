//
//  ImageSearchView.swift
//  iPexel
//
//  Created by mobile_ on 2023/05/31.
//

import SwiftUI

struct ImageSearchView: View {
    @State private var searchText = ""
    @StateObject var model: ImageSearchModel = ImageSearchModel()
    
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                .environmentObject(model)
            ScrollView {
                ForEach(model.photos, id: \.id) { photo in
                    NavigationLink(destination: ImageSearchDetailView(photo: photo)) {
                        AsyncImage(url: URL(string: photo.src.original), content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        }, placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                .scaleEffect(3)
                        })
                    }
                }
            }
            Spacer()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    @EnvironmentObject var model: ImageSearchModel
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Search", text: $text)
                    .foregroundColor(.primary)
                    .onSubmit {
                        model.photos = []
                        model.searchImage(searchText: text, page: 1)
                    }
                    .submitLabel(.search)
                
                
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}
