//
//  Image+UIImageView.swift
//  NewsFeedUIKit
//
//  Created by 李其炜 on 10/28/19.
//  Copyright © 2019 李其炜. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit



extension UIImageView {
    func downloadImageFrom(link link:String, contentMode: UIView.ContentMode) {
       
        URLSession.shared.dataTask( with: URL(string:link)!, completionHandler: {
            (data, response, error) -> Void in
               DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
#endif
