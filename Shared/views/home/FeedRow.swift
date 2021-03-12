//
//  FeedRow.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 10/24/20.
//

import SwiftUI
import SwiftDate
import SDWebImageSwiftUI

struct FeedRow: View {
    @EnvironmentObject var databaseModel: DatabaseModel
    let feed: Feed
    @State var exist = false
    
    
    var body: some View {
        let diff = DateInRegion(feed.postedTime)!.toRelative(since: DateInRegion(), style: RelativeFormatter.defaultStyle(), locale: Locales.english)
        
        
        
        NavigationLink(destination: DetailView(feed: feed)) {
            VStack {
                if (feed.cover != nil) {
                    
                    WebImage(url: URL(string: feed.cover!))
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .aspectRatio(contentMode: ContentMode.fit)
                        .cornerRadius(10)
                        .frame( height: 300)
                    
                }
                VStack(alignment: .leading) {
                    Text(feed.newsPublisher.name)
                        .font(.caption)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                    
                    Text(feed.title)
                        .fontWeight(.bold)
                        .padding(.trailing)

                    Text("\(diff)")
                        .font(.caption2)
                        .fontWeight(.bold)
                    
                }
                .padding(.leading)
                Spacer()
            }
            
        }
        .buttonStyle(PlainButtonStyle())
        .contextMenu {
            if exist {
                Button(action: {
                    databaseModel.deleteFeed(feed: feed)
                    exist = false
                }) {
                    Text("Remove from local")
                    Image(systemName: "minus.circle.fill")
                }
            } else {
                Button(action: {
                    databaseModel.addFeed(feed: feed)
                    exist = true
                }) {
                    Text("Save To Local")
                    Image(systemName: "star.fill")
                }
            }
            
        }
        
        .onAppear {
            exist = databaseModel.existFeed(feed: feed)
        }
    }
    
}

struct FeedRow_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let feed = Feed(id: 1, title: "Test Post", link: "", cover: "https://img1.gamersky.com/image2020/10/20201022_altbg_412_9/gamersky_01small_02_2020102410486BA.jpg", newsPublisher: NewsPublisher(id: 1, name: "GamerSky"), content: "", sentiment: nil, postedTime: "2020", publisher: 1, feed_comments: [], pureText: "a")
        
        Group {
            FeedRow(feed: feed)
                .previewLayout(.device)
            FeedRow(feed: feed)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
        .environmentObject(NewsFeedModel())
        .environmentObject(DatabaseModel())
    }
}
