//
//  FeedRow.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 10/24/20.
//

import SwiftUI
import KingfisherSwiftUI

struct FeedRow: View {
    let feed: Feed

    var body: some View {
        NavigationLink(destination: DetailView(feed: feed)) {
            HStack {
                if (feed.cover != nil) {
                    KFImage(URL(string: feed.cover!))
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .frame(width: 100, height: 100, alignment: .center)


                }
                VStack(alignment: .leading) {
                    Text(feed.title)
                        .fontWeight(.bold)
                        .padding(.trailing)
                    Text(feed.newsPublisher.name)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
//                    Text(feed.postedTime)
//                        .font(.caption2)
//                        .fontWeight(.bold)

                }
                    .padding(.leading)
                Spacer()
            }

        }
            .buttonStyle(PlainButtonStyle())
    }
}

struct FeedRow_Previews: PreviewProvider {


    static var previews: some View {
        let feed = Feed(id: 1, title: "Test Post", link: "", cover: "https://img1.gamersky.com/image2020/10/20201022_altbg_412_9/gamersky_01small_02_2020102410486BA.jpg", newsPublisher: NewsPublisher(id: 1, name: "GamerSky"), content: "", sentiment: nil, postedTime: "2020", publisher: 1, feed_comments: [])

        Group {
            FeedRow(feed: feed)
                .previewLayout(.device)
            FeedRow(feed: feed)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
