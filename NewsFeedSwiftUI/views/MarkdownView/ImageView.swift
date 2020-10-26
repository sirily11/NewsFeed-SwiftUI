//
//  ImageView.swift
//  NewsFeedUIKit
//
//  Created by 李其炜 on 10/29/19.
//  Copyright © 2019 李其炜. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ImageView: View {
    var imageSrc : String
    var body: some View {
        KFImage(URL(string: imageSrc)!)
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView()
//    }
//}
