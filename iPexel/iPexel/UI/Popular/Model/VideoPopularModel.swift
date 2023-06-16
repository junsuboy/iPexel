//
//  VideoPopularModel.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/16.
//

import Foundation
import Combine

class VideoPopularModel: ObservableObject {
    let repository: PopularRepository = PopularRepository()
    var subscriptions = Set<AnyCancellable>()
    
    @Published var videos: [ResponseVideoSource] = []
    @Published var page: Int = 1
    
    init() {
        getPopularVideo(page: page)
    }
    
    func getPopularVideo(page: Int) {
        repository.getPopularVideo(page: page)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error): print("Error \(error)")
                    case .finished: print("Publisher is finished")
                    }

                },
                receiveValue: { value in
                    self.videos = value
                }
            )
            .store(in: &subscriptions)
    }
}
