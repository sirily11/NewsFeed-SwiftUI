//
//  NewsList.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 10/24/20.
//

import SwiftUI
import SwiftUIRefresh



struct NewsList: View {

    @EnvironmentObject var feedModel: NewsFeedModel
    @State private var isShowing = false

    var body: some View {

        List {
            ForEach(feedModel.feeds) { feed in
                FeedRow(feed: feed)
            }
            if feedModel.isUpdating {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }

            }

            if feedModel.nextURL != nil && !feedModel.isUpdating {
                Text("Load More")
                    .onAppear {
                        feedModel.fetchMore()
                }
            }
        }
            .listStyle(PlainListStyle())

            .pullToRefresh(isShowing: $isShowing) {
                feedModel.fetchNews()
                feedModel.fetchPublisher()
                self.isShowing = false
        }
    }
}

struct NewsList_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            NewsList()
                .previewDevice("iPhone 11 Pro")
                .environmentObject(NewsFeedModel())

        }
    }
}
