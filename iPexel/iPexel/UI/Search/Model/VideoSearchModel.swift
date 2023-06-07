//
//  VideoSearchModel.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/07.
//

import Foundation
import Combine

class VideoSearchModel: ObservableObject {
    let repository: SearchRepository = SearchRepository()
    var subscriptions = Set<AnyCancellable>()
    
    @Published var photos: [ResponseImagePhoto] = []
    @Published var page: Int = 1
    @Published var isSearched: Bool = false
    
    func searchImage(searchText: String, page: Int) {
        repository.searchImage(searchText: searchText, page: page)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error): print("Error \(error)")
                    case .finished: print("Publisher is finished")
                    }

                },
                receiveValue: { value in
                    self.photos = value
                    self.isSearched = true
                }
            )
            .store(in: &subscriptions)
    }
}
