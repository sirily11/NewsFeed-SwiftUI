//
//  LikesView.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 1/25/21.
//

import SwiftUI

struct LikesView: View {
    @EnvironmentObject var databaseModel: DatabaseModel

    var body: some View {
        List {

            ForEach(databaseModel.feeds) {
                feed in

                FeedRow(feed: feed)

            }
                .onDelete(perform: { indexSet in
                    if let index = indexSet.first {
                        let feed = databaseModel.feeds[index]
                        databaseModel.deleteFeed(feed: feed)
                    }
                })
        }

    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView()
    }
}
