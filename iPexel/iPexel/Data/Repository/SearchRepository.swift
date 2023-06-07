//
//  SearchRepository.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/01.
//

import Foundation
import Combine

class SearchRepository {
    let api: SearchApi = SearchApi()
    
    func searchImage(searchText: String, page: Int) -> Future<[ResponseImagePhoto], Error> {
        return api.searchImage(searchText: searchText, page: page)
    }
}
