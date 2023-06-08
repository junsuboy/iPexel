//
//  VideoSearchDetailView.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/07.
//

import SwiftUI
import Alamofire
import AVKit

struct VideoSearchDetailView: View {
    @State var isShowAlert = false
    
    var title: String
    var video: ResponseVideoSource
    
    var body: some View {
        VStack(spacing: 20) {
//            AsyncImage(url: URL(string: photo.src.original), content: { image in
//                image.resizable()
//                    .aspectRatio(contentMode: .fit)
//            }, placeholder: {
//                EmptyView()
//            })
//            .onTapGesture {
//                isShowAlert = true
//            }
            VideoPlayer(player: AVPlayer(url:  URL(string: video.url)!))
                .frame(height: 400)
            HStack() {
                Text("photographer")
                    .fontWeight(.bold)
                Spacer()
                Text(video.user.name)
                    .lineLimit(1)
            }
            Spacer()
        }
        .navigationTitle(title)
        .alert("Save This Video", isPresented: $isShowAlert) {
            Button("cancel", role: .cancel) {}
            Button("save") {
//                downloadImage(url: photo.src.original)
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
