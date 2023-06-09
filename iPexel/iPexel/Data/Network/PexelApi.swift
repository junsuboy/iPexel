//
//  PexelApi.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/01.
//

import Foundation
import Alamofire
import Combine

class PexelApi {
    let header: HTTPHeaders = [
        "Authorization": Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    ]
    
    func searchImage(searchText: String, page: Int) -> Future<[ResponseImagePhoto], Error> {
        return Future<[ResponseImagePhoto], Error> { promise in
            let parameters = ["query": searchText, "page": page] as [String : Any]
            AF.request("https://api.pexels.com/v1/search", parameters: parameters, headers: self.header)
                .responseDecodable(of: ResponseImage.self) { response in
                    switch response.result {
                    case .success:
                        if let images = response.value {
                            promise(.success(images.photos))
                        } else {
                            promise(.failure(SearchApiError.UNKNOWNERROR))
                        }
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
    }
    
    
    func searchVideo(searchText: String, page: Int) -> Future<[ResponseVideoSource], Error> {
        return Future<[ResponseVideoSource], Error> { promise in
            let parameters = ["query": searchText, "page": page] as [String : Any]
            AF.request("https://api.pexels.com/videos/search", parameters: parameters, headers: self.header)
                .responseDecodable(of: ResponseVideo.self) { response in
                    switch response.result {
                    case .success:
                        if let images = response.value {
                            promise(.success(images.videos))
                        } else {
                            promise(.failure(SearchApiError.UNKNOWNERROR))
                        }
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
    }
    
    func getCuratedImage(page: Int) -> Future<[ResponseImagePhoto], Error> {
        return Future<[ResponseImagePhoto], Error> { promise in
            let parameters = ["page": page] as [String : Any]
            AF.request("https://api.pexels.com/v1/curated", parameters: parameters, headers: self.header)
                .responseDecodable(of: ResponseImage.self) { response in
                    switch response.result {
                    case .success:
                        if let images = response.value {
                            promise(.success(images.photos))
                        } else {
                            promise(.failure(SearchApiError.UNKNOWNERROR))
                        }
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
    }
    
    
    func getPopularVideo(page: Int) -> Future<[ResponseVideoSource], Error> {
        return Future<[ResponseVideoSource], Error> { promise in
            let parameters = ["page": page] as [String : Any]
            AF.request("https://api.pexels.com/videos/popular", parameters: parameters, headers: self.header)
                .responseDecodable(of: ResponseVideo.self) { response in
                    switch response.result {
                    case .success:
                        if let images = response.value {
                            promise(.success(images.videos))
                        } else {
                            promise(.failure(SearchApiError.UNKNOWNERROR))
                        }
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
    }
}

enum SearchApiError: Error {
case UNKNOWNERROR
}
