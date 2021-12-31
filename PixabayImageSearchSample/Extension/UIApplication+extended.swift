//
//  UIApplication+extended.swift
//  PixabayImageSearchSample
//
//  Created by cano on 2021/12/31.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
