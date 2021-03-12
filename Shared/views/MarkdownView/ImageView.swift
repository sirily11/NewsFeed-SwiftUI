//
//  ImageView.swift
//  NewsFeedUIKit
//
//  Created by 李其炜 on 10/29/19.
//  Copyright © 2019 李其炜. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageView: View {
    @EnvironmentObject var detailImageModel: DetailImageViewModel
    
    var imageSrc: String
    var body: some View {
        
        WebImage(url: URL(string: imageSrc)!)
            .placeholder {
                ProgressView()
            }
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .onTapGesture {
                detailImageModel.imageStr = imageSrc
                detailImageModel.show = true
            }
    }
}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView()
//    }
//}
