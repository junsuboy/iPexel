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
            ImageSearchBar(text: $searchText)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                .environmentObject(model)
            ScrollView {
                if model.photos.count != 0 {
                    ForEach(model.photos, id: \.id) { photo in
                        NavigationLink(destination: ImageSearchDetailView(title: $searchText, photo: photo)) {
                            AsyncImage(url: URL(string: photo.src.original), content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            }, placeholder: {
                                
                            })
                        }
                    }
                } else if model.photos.count == 0 && model.isSearched {
                    Image("noresult")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                if model.photos.count > 0 {
                    HStack() {
                        if model.page > 1 {
                            Button {
                                print("Prev")
                                model.isSearched = false
                                model.page = model.page - 1
                                model.photos = []
                                model.searchImage(searchText: searchText, page: model.page)
                            } label: {
                                Image(systemName: "arrow.left")
                                Text("Prev")
                            }
                        }
                        
                        Spacer()
                        
                        if model.photos.count > 0 && model.photos.count == 15 {
                            Button {
                                print("Next")
                                model.isSearched = false
                                model.page = model.page + 1
                                model.photos = []
                                model.searchImage(searchText: searchText, page: model.page)
                            } label: {
                                Image(systemName: "arrow.right")
                                Text("Next")
                            }
                        }
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

struct ImageSearchBar: View {
    @Binding var text: String
    @EnvironmentObject var model: ImageSearchModel
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Search", text: $text)
                    .foregroundColor(.primary)
                    .onSubmit {
                        model.isSearched = false
                        model.page = 1
                        model.photos = []
                        model.searchImage(searchText: text, page: model.page)
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
