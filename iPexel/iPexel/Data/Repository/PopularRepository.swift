//
//  PopularRepository.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/16.
//

import Combine
import Foundation

class PopularRepository {
    let api: PexelApi = PexelApi()
    
    func getCuratedImage(page: Int) -> Future<[ResponseImagePhoto], Error> {
        return api.getCuratedImage(page: page)
    }
    
    func getPopularVideo(page: Int) -> Future<[ResponseVideoSource], Error> {
        return api.getPopularVideo(page: page)
    }
}
