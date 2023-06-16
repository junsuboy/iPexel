//
//  ImagePopularView.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/16.
//

import SwiftUI

struct ImagePopularView: View {
    @StateObject var model: ImagePopularModel = ImagePopularModel()
    
    
    var body: some View {
        VStack {
            ScrollView {
                if model.photos.count != 0 {
                    ForEach(model.photos, id: \.id) { photo in
                        NavigationLink(destination: ImagePopularDetailView(photo: photo)) {
                            AsyncImage(url: URL(string: photo.src.original), content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            }, placeholder: {
                                
                            })
                        }
                    }
                }
                
                if model.photos.count > 0 {
                    HStack() {
                        if model.page > 1 {
                            Button {
                                print("Prev")
                                model.page = model.page - 1
                                model.photos = []
                                model.getCuratedImage(page: model.page)
                            } label: {
                                Image(systemName: "arrow.left")
                                Text("Prev")
                            }
                        }
                        
                        Spacer()
                        
                        if model.photos.count > 0 && model.photos.count == 15 {
                            Button {
                                print("Next")
                                model.page = model.page + 1
                                model.photos = []
                                model.getCuratedImage(page: model.page)
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
