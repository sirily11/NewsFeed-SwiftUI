//
//  DetailView.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 10/24/20.
//

import SwiftUI
import KingfisherSwiftUI
import MDText

struct DetailView: View {
    let feed: Feed
    var body: some View {

        ScrollView {
            VStack(alignment: .leading) {
                if (feed.cover != nil) {
                    KFImage(URL(string: feed.cover!))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300, alignment: .center)
                }
                MarkdownView(markdownStr: feed.content ?? "")

                    .navigationTitle(feed.title)
            }

        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(feed: test_feeds[0])
    }
}
