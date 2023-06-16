//
//  VideoPopularView.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/16.
//

import SwiftUI

struct VideoPopularView: View {
    @State private var searchText = ""
    @StateObject var model: VideoPopularModel = VideoPopularModel()
    
    
    var body: some View {
        VStack {
            ScrollView {
                if model.videos.count != 0 {
                    ForEach(model.videos, id: \.id) { video in
                        NavigationLink(destination: VideoPopularDetailView(video: video)) {
                            AsyncImage(url: URL(string: video.image), content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            }, placeholder: {
                                
                            })
                        }
                    }
                }
                
                if model.videos.count > 0 {
                    HStack() {
                        if model.page > 1 {
                            Button {
                                print("Prev")
                                model.page = model.page - 1
                                model.videos = []
                                model.getPopularVideo(page: model.page)
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
                                model.getPopularVideo(page: model.page)
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
    }
}
