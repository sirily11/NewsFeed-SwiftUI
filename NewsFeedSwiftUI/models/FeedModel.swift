//
//  FeedModel.swift
//  NewsFeed
//
//  Created by 李其炜 on 10/26/19.
//  Copyright © 2019 李其炜. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class NewsFeedModel: ObservableObject {

    @Published var isUpdating = false
    @Published var feeds: [Feed] = []
    @Published var publishers: [NewsPublisher] = []
    @Published var nextURL: String?
    @Published var selectedPublisher = 0
    @Published var searchKeyword = ""
    private var cancellable: AnyCancellable? = nil
    let baseURL = "https://api.sirileepage.com/news-feed"


    let newsURL = "/news/"
    let publisherURL = "/publisher/"

    var navigationTitleText: String {
        get {
            if selectedPublisher == 0 {
                return "NewsFeed"
            } else {
                for publisher in publishers {
                    if publisher.id == selectedPublisher {
                        return publisher.name
                    }
                }

            }

            return ""
        }
    }


    /**
     Fetching news from internet
     */
    func fetchNews() {
        print("Fetch")
        var u = ""
        if(self.selectedPublisher != 0) {
            u = "\(baseURL)\(newsURL)?publisher=\(selectedPublisher)"
        } else {
            u = "\(baseURL)\(newsURL)"
        }

        guard let url = URL(string: u) else {
            return
        }
        withAnimation {
            self.feeds = []
            self.isUpdating = true
        }

        URLSession.shared.dataTask(with: url) {
            (data, resp, err) in
            if err != nil {
                print(err!)
            }

            guard let data = data else { return }

            DispatchQueue.main.async {
                do {
                    let response = try JSONDecoder().decode(NetworkResponse.self, from: data)
                    self.feeds = response.results
                    self.nextURL = response.next
                    self.isUpdating = false
                } catch {
                    print(error)
                }

            }

        }.resume()
    }




    /**
     Fetching news publisher from internet
     */
    func fetchPublisher() {
        guard let url = URL(string: "\(baseURL)\(publisherURL)") else {
            return
        }
        URLSession.shared.dataTask(with: url) {
            (data, resp, err) in

            guard let data = data else { return }

            DispatchQueue.main.async {
                let response = try! JSONDecoder().decode([NewsPublisher].self, from: data)
                self.publishers = [NewsPublisher(id: 0, name: "All")] + response
            }

        }.resume()
    }

    func fetchMore() {
        isUpdating = true
        if let nextURL = self.nextURL {
            guard let url = URL(string: nextURL) else {
                return
            }
            URLSession.shared.dataTask(with: url) {
                (data, resp, err) in

                guard let data = data else { return }

                DispatchQueue.main.async {
                    let response = try! JSONDecoder().decode(NetworkResponse.self, from: data)
                    self.feeds += response.results
                    self.nextURL = response.next
                    self.isUpdating = false
                }

            }.resume()
        }

    }

    func search(keyword: String) {
        let u = "\(newsURL)?search=\(keyword)"
        guard let url = URL(string: u.urlEncoded()) else {
            return
        }

        self.isUpdating = true
        URLSession.shared.dataTask(with: url) {
            (data, resp, err) in
            if err != nil {
                print(err!)
            }

            guard let data = data else { return }

            DispatchQueue.main.async {
                do {
                    let response = try JSONDecoder().decode(NetworkResponse.self, from: data)
                    print("Updated")
                    self.feeds = response.results
                    self.nextURL = response.next
                    self.isUpdating = false
                } catch {
                    print(error)
                }

            }

        }.resume()
    }
}


class TestFeedModel: NewsFeedModel {
    init(selected_publisher: Int) {
        super.init()
        self.feeds = test_feeds
        self.publishers = [NewsPublisher(id: 1, name: "People's Daily"), NewsPublisher(id: 1, name: "CNN")]
        self.selectedPublisher = selected_publisher
    }
}
