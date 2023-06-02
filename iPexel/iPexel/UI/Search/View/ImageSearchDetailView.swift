//
//  ImageSearchDetailView.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/02.
//

import SwiftUI
import Alamofire

struct ImageSearchDetailView: View {
    @State var isShowAlert = false
    
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
            .onTapGesture {
                isShowAlert = true
            }
            Spacer()
        }
        .alert("Save This Image", isPresented: $isShowAlert) {
            Button("cancel", role: .cancel) {}
            Button("save") {
                downloadImage(url: photo.src.original)
            }
        }
    }
    
    func downloadImage(url: String) {
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let uuid = "\(UUID())"
            let fileURL = documentsURL.appendingPathComponent(uuid + ".jpeg")

            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        AF.download(url, to: destination).response { response in
            debugPrint(response)
        }
        
        print("download complete!")
    }
}
