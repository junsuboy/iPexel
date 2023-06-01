//
//  Image.swift
//  iPexel
//
//  Created by mobile_ on 2023/05/31.
//

import Foundation

struct ImageVo {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let photographer: String
    let photographerUrl: String
    let avgColor: String
    let src: ImageSrcVo
    let liked: Bool
    let alt: String
}

struct ImageSrcVo {
    let original: String
    let large2x: String
    let large: String
    let medium: String
    let small: String
    let portrait: String
    let landscape: String
    let tiny: String
}
