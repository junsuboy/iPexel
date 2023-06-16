//
//  SearchRepository.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/01.
//

import Combine
import Foundation

class SearchRepository {
    let api: PexelApi = PexelApi()
    
    func searchImage(searchText: String, page: Int) -> Future<[ResponseImagePhoto], Error> {
        return api.searchImage(searchText: searchText, page: page)
    }
    
    func searchVideo(searchText: String, page: Int) -> Future<[ResponseVideoSource], Error> {
        return api.searchVideo(searchText: searchText, page: page)
    }
}
