//
//  VideoPopularDetailView.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/16.
//

import SwiftUI
import Alamofire
import AVKit

struct VideoPopularDetailView: View {
    @State var isShowAlert = false
    
    var video: ResponseVideoSource
    
    var body: some View {
        VStack(spacing: 20) {
            
            VideoPlayer(player: AVPlayer(url:  URL(string: video.videoFiles[0].link)!))
                .frame(height: 400)
            
            Button("Download Video") {
                isShowAlert = true
            }
            .buttonStyle(.borderedProminent)
            
            HStack() {
                Text("photographer")
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(video.user.name)
                    .lineLimit(1)
            }
            Spacer()
            
        }
        .navigationTitle("Detail")
        .alert("Save This Video", isPresented: $isShowAlert) {
            Button("cancel", role: .cancel) {}
            Button("save") {
                downloadVideo(url: video.videoFiles[0].link)
            }
        }
    }
    
    func downloadVideo(url: String) {
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let uuid = "\(UUID())"
            let fileURL = documentsURL.appendingPathComponent(uuid + ".mp4")

            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        AF.download(url, to: destination).response { response in
            debugPrint(response)
        }
        
        print("download complete!")
    }
}
