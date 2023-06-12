//
//  VideoSearchView.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/07.
//

import SwiftUI

struct VideoSearchView: View {
    @State private var searchText = ""
    @StateObject var model: VideoSearchModel = VideoSearchModel()
    
    
    var body: some View {
        VStack {
            VideoSearchBar(text: $searchText)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                .environmentObject(model)
            ScrollView {
                if model.videos.count != 0 {
                    ForEach(model.videos, id: \.id) { video in
                        NavigationLink(destination: VideoSearchDetailView(title: searchText, video: video)) {
                            AsyncImage(url: URL(string: video.image), content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            }, placeholder: {
                                
                            })
                        }
                    }
                } else if model.videos.count == 0 && model.isSearched {
                    Image("noresult")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                if model.videos.count > 0 {
                    HStack() {
                        if model.page > 1 {
                            Button {
                                print("Prev")
                                model.page = model.page - 1
                                model.videos = []
                                model.searchVideo(searchText: searchText, page: model.page)
                            } label: {
                                Image(systemName: "arrow.left")
                                Text("Prev")
                            }
                        }
                        
                        Spacer()
                        
                        if model.videos.count > 0 && model.videos.count == 15 {
                            Button {
                                print("Next")
                                model.page = model.page + 1
                                model.videos = []
                                model.searchVideo(searchText: searchText, page: model.page)
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

struct VideoSearchBar: View {
    @Binding var text: String
    @EnvironmentObject var model: VideoSearchModel
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Search", text: $text)
                    .foregroundColor(.primary)
                    .onSubmit {
                        model.isSearched = false
                        model.page = 1
                        model.videos = []
                        model.searchVideo(searchText: text, page: model.page)
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
