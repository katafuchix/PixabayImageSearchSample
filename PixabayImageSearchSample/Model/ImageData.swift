//
//  ImageData.swift
//  PixabayImageSearchSample
//
//  Created by cano on 2021/12/31.
//

import Foundation

// hitsを格納する構造体
struct HitsModel:Codable{
    let total: Int
    let totalHits: Int
    let hits : [ImageData]
}

// ユーザー情報を格納す構造体
struct ImageData: Identifiable, Codable  {
    let id: Int
    let largeImageURL: String
}

// APIのエラー
enum ImageError: Error {
    case serverError
    case noData
}
