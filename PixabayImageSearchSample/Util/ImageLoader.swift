//
//  ImageLoader.swift
//  PixabayImageSearchSample
//
//  Created by cano on 2021/12/31.
//

import Foundation

class ImageLoader: ObservableObject  {
    
    @Published var imageList: [ImageData] = []
    
    func searchImages(_ keyword: String) async throws {
        self.imageList = []
        
        let urlStr = "https://pixabay.com/api/?key=\(Constants.api_key)&q=\(keyword)"
        let url = URL(string:urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // レスポンスコードが200でなければエラー
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ImageError.serverError }

        // JSONを解析して作成した構造体の通りにマッピング
        guard let decoded = try? JSONDecoder().decode(HitsModel.self, from: data) else { throw ImageError.noData }
        
        DispatchQueue.main.async {  // メインスレッドで処理
            self.imageList = decoded.hits
        }
    }
}
