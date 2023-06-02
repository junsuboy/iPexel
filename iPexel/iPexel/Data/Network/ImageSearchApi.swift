//
//  ImageSearchApi.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/01.
//

import Alamofire
import Combine

class ImageSearchApi {
    let header: HTTPHeaders = [
        "Authorization": "TMBuhfB9RcMEHUP3tWZVBZ6uKG04CGoRrAvvqrH7CPUXy3t1RavAFbWp"
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
                            promise(.failure(ImageApiError.UNKNOWNERROR))
                        }
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
    }
}

enum ImageApiError: Error {
case UNKNOWNERROR
}
