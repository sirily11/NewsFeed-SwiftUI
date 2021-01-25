//
//  FeedDB.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 1/25/21.
//

import Foundation

import RealmSwift



// MARK: - Comment
class CommentDB: Object {
    @objc dynamic var author: AuthorDB?
    @objc dynamic var comment: String = ""
    @objc dynamic var id: Double = 0


}

// MARK: - Author
class AuthorDB: Object {
    @objc dynamic var username: String = ""
}



class FeedDB: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var link: String = ""
    @objc dynamic var cover: String?
    @objc dynamic var newsPublisher: NewsPublisherDB?
    @objc dynamic var content: String?
    @objc dynamic var sentiment: Double = 0
    @objc dynamic var postedTime: Date = Date()
    @objc dynamic var publisher: Int = 0
    @objc dynamic var pureText = ""
    let feed_comments = List<CommentDB>()

}

class NewsPublisherDB: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}

