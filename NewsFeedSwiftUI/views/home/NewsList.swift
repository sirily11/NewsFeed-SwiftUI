//
//  NewsList.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 10/24/20.
//

import SwiftUI


struct NewsList: View {
    let feeds: [Feed]
    @EnvironmentObject var feedModel: NewsFeedModel

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(feeds) { feed in
                    FeedRow(feed: feed)
                    Divider()
                }
                if feedModel.isUpdating {
                    ProgressView()
                }

                if feedModel.nextURL != nil && !feedModel.isUpdating {
                    Text("Load More")
                        .onAppear {
                            feedModel.fetchMore()
                    }
                }
            }
        }

    }
}

struct NewsList_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            NewsList(feeds: test_feeds)
                .previewDevice("iPhone 11 Pro")
                .environmentObject(NewsFeedModel())

        }
    }
}
