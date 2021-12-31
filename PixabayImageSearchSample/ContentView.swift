//
//  ContentView.swift
//  PixabayImageSearchSample
//
//  Created by cano on 2021/12/31.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var imageLoader = ImageLoader()
    @State var text = ""
    @State var buttonEnabled = false
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 100, maximum: 150))]
    
    var body: some View {
        VStack {
            
            TextField("検索キーワード",text: $text, onEditingChanged: { editing in })
            .onChange(of: text) {
                buttonEnabled = $0.count >= 2  // 2文字以上でボタン押下可能
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())

            .padding([.top, .leading, .trailing], 40.0)
             
            Spacer()
            
            Button(action: {
                UIApplication.shared.endEditing() // キーボードを下げる
                Task {
                    do {
                        // 画像検索
                        try await imageLoader.searchImages(text)
                    } catch {
                        print(error)
                    }
                }
            }) {
                Text ("Search")
            }.disabled(!buttonEnabled)
             
            Spacer()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(imageLoader.imageList) { symbol in
                        VStack {
                            AsyncImage(url: URL(string: symbol.largeImageURL)) { image in
                                image.resizable()
                                     .frame(width: 100, height: 100)
                                     .aspectRatio(contentMode: .fit)
                                     .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
