//
//  ImageSearchModel.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/01.
//

import Foundation
import Combine

class ImageSearchModel: ObservableObject {
    let repository: ImageSearchRepository = ImageSearchRepository()
    var subscriptions = Set<AnyCancellable>()
    
    @Published var photos: [ResponseImagePhoto] = []
    
    func searchImage(searchText: String, page: Int) {
        repository.searchImage(searchText: searchText, page: page)
            .sink(
                receiveCompletion: { completion in
                    print(completion)
                },
                receiveValue: { value in
                    self.photos = value
                }
            )
            .store(in: &subscriptions)
    }
}
