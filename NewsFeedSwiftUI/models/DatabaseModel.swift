//
//  DatabaseModel.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 1/25/21.
//

import Foundation
import RealmSwift


class DatabaseModel: ObservableObject {

    var realm: Realm?
    @Published var feeds: [Feed] = []
    var token: NotificationToken?


    init() {
        do {
            self.realm = try Realm()
            token = realm?.objects(FeedDB.self).observe {
                changeset in
                self.fetchFeeds()
//                switch changeset {
//                case .update(let bks, let deletetions, let insertions, let mofidications):
////                    print("\(bks), \(deletetions), \(insertions), \(mofidications)")
//                    self.fetchFeeds()
//                case .initial(_):
//                    print("Init")
//                case .error(_):
//                    print("Error")
//                }
            }
        } catch {
            print("Cannot init realm!")
        }

    }

    func existFeed(feed: Feed) -> Bool {
        let feedDB = realm?.objects(FeedDB.self).filter("id = \(feed.id)").first
        if let _ = feedDB {
            return true
        }

        return false
    }

    func fetchFeeds() {
        print("Fetch feeds")
        let feedsDB = realm?.objects(FeedDB.self).sorted(byKeyPath: "postedTime")
        if let feedsDB = feedsDB {
            feeds = feedsDB.map {
                feed in
                Feed(from: feed)
            }
        }
    }

    func addFeed(feed: Feed) {
        try? realm?.write {
            let feedDB = feed.toDB()
            realm?.add(feedDB)
        }

    }

    func deleteFeed(feed: Feed) {
        try? realm?.write {
            let feedDB = realm?.objects(FeedDB.self).filter("id = \(feed.id)").first
            if let feedDB = feedDB {
                realm?.delete(feedDB)
            }
        }

    }


}
