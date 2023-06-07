//
//  ImageDto.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/01.
//

import Foundation

struct ResponseImage: Codable, Hashable {
    let page: Int
    let perPage: Int
    let photos: [ResponseImagePhoto]
    
    enum CodingKeys : String, CodingKey{
        case page
        case perPage = "per_page"
        case photos
    }
}

struct ResponseImagePhoto: Codable, Hashable, Identifiable {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let photographer: String
    let photographerUrl: String
    let avgColor: String
    let src: ResponseImagePhotoSrc
    let liked: Bool
    let alt: String
    
    enum CodingKeys : String, CodingKey {
        case id
        case width
        case height
        case url
        case photographer
        case photographerUrl = "photographer_url"
        case avgColor = "avg_color"
        case src
        case liked
        case alt
    }
    
}

struct ResponseImagePhotoSrc: Codable, Hashable {
    let original: String
    let large2x: String
    let large: String
    let medium: String
    let small: String
    let portrait: String
    let landscape: String
    let tiny: String
    
    enum CodingKeys : String, CodingKey {
        case original
        case large2x
        case large
        case medium
        case small
        case portrait
        case landscape
        case tiny
    }
}
