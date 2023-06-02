//
//  ImageSearchDetailView.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/02.
//

import SwiftUI

struct ImageSearchDetailView: View {
    var photo: ResponseImagePhoto
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: photo.src.original), content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            }, placeholder: {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .scaleEffect(3)
            })
            Spacer()
        }
    }
}
