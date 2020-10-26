//
//  ContentTextView.swift
//  NewsFeedUIKit
//
//  Created by 李其炜 on 10/29/19.
//  Copyright © 2019 李其炜. All rights reserved.
//

import SwiftUI

struct ContentTextView: View {
    var content: String
    
    var body: some View {
        Text(content)
            .multilineTextAlignment(.leading)
            .padding(.bottom)
            
    }
}

struct ContentTextView_Previews: PreviewProvider {
    static var previews: some View {
        ContentTextView(content: "Hell, this is a very long text which required a lot of space")
    }
}
