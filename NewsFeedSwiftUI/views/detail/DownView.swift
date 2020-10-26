//
//  DownView.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 10/26/20.
//

import Foundation
import SwiftUI
import Down
import WebKit

struct SwiftDownView: UIViewRepresentable {
    @Binding var height: CGFloat
    var markdownStr: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView(frame: .zero)
        textView.isEditable = false
        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {

        // calculate height based on main screen, but this might be
        // improved for more generic cases
        DispatchQueue.main.async { // << fixed
            height = textView.sizeThatFits(UIScreen.main.bounds.size).height
            let down = Down(markdownString: markdownStr)
            let attributedString = try? down.toAttributedString()
            if let attributedString = attributedString{
                textView.attributedText = attributedString
            }
        }
    }
}

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
