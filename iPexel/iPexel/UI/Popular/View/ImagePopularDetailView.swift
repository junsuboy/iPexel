//
//  ImagePopularDetailView.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/16.
//

import SwiftUI
import Alamofire

struct ImagePopularDetailView: View {
    @State var isShowAlert = false
    
    var photo: ResponseImagePhoto
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: photo.src.original), content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            }, placeholder: {
                EmptyView()
            })
            
            Button("Download Image") {
                isShowAlert = true
            }
            .buttonStyle(.borderedProminent)
            
            HStack() {
                VStack(alignment: .leading) {
                    Text("name")
                        .fontWeight(.bold)
                    Text("photographer")
                        .fontWeight(.bold)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    if photo.alt != "" {
                        Text(photo.alt)
                            .lineLimit(1)
                    } else {
                        Text("Unnamed")
                    }
                    Text(photo.photographer)
                        .lineLimit(1)
                }
            }
            Spacer()
        }
        .navigationTitle("Detail")
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

