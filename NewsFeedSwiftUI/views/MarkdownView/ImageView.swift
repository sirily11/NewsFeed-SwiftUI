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
    var imageSrc: String
    var body: some View {
        NavigationLink(
            destination: ImageDetailView(imageSrc: imageSrc)
        ) {
            KFImage(URL(string: imageSrc)!)
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .aspectRatio(contentMode: .fit)


        }
            .contextMenu {
                Button(action: {
                    // change country setting
                }) {
                    Text("Save To Local")
                    Image(systemName: "star.fill")
                }
        }
    }
}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView()
//    }
//}
