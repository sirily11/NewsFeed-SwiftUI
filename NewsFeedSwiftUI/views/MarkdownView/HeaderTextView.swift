//
//  Header.swift
//  NewsFeedUIKit
//
//  Created by 李其炜 on 10/29/19.
//  Copyright © 2019 李其炜. All rights reserved.
//

import SwiftUI

struct HeaderTextView: View {
    var content: String
    var body: some View {
        Text(content)
            .font(.title)
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
    }
}

//struct Header_Previews: PreviewProvider {
//    static var previews: some View {
//        Header()
//    }
//}
