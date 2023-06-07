//
//  VideoDto.swift
//  iPexel
//
//  Created by mobile_ on 2023/06/07.
//

import Foundation

struct ResponseVideo: Codable, Hashable {
    let page: Int
    let perPage: Int
    let videos: [ResponseVideoSource]
    
    enum CodingKeys : String, CodingKey{
        case page
        case perPage = "per_page"
        case videos
    }
}

struct ResponseVideoSource: Codable, Hashable, Identifiable {
    let id: Int
    let width: Int
    let height: Int
    let duration: Int
    let url: String
    let image: String
    let user: ResponseVideoUser
    let videoFiles: [ResponseVideoFile]
    let videoPictures: [ResponseVideoPicture]
    
    enum CodingKeys : String, CodingKey{
        case id
        case width
        case height
        case duration
        case url
        case image
        case user
        case videoFiles = "video_files"
        case videoPictures = "video_pictures"
    }
    
}

struct ResponseVideoUser: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let url: String
    
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case url
    }
}

struct ResponseVideoFile: Codable, Hashable, Identifiable {
    let id: Int
    let quality: String
    let fileType: String
    let width: Int
    let height: Int
    let fps: Double
    let link: String
    
    enum CodingKeys : String, CodingKey {
        case id
        case quality
        case fileType = "file_type"
        case width
        case height
        case fps
        case link
    }
}


struct ResponseVideoPicture: Codable, Hashable, Identifiable {
    let id: Int
    let nr: Int
    let picture: String
    
    enum CodingKeys : String, CodingKey {
        case id
        case nr
        case picture
    }
}
