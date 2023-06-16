//
//  ImagePopularModel.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/16.
//

import Foundation
import Combine

class ImagePopularModel: ObservableObject {
    let repository: PopularRepository = PopularRepository()
    var subscriptions = Set<AnyCancellable>()
    
    @Published var photos: [ResponseImagePhoto] = []
    @Published var page: Int = 1
    
    init() {
        getCuratedImage(page: page)
    }
    
    func getCuratedImage(page: Int) {
        repository.getCuratedImage(page: page)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error): print("Error \(error)")
                    case .finished: print("Publisher is finished")
                    }

                },
                receiveValue: { value in
                    self.photos = value
                }
            )
            .store(in: &subscriptions)
    }
}
