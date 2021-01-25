//
//  NewsFeedSwiftUIApp.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 10/24/20.
//

import SwiftUI

@main
struct NewsFeedSwiftUIApp: App {
    @StateObject var newsfeedModal = NewsFeedModel()
    @StateObject var databaseModel = DatabaseModel()

    var body: some Scene {
        WindowGroup {
            NewsFeedView()
                .environmentObject(newsfeedModal)
                .environmentObject(databaseModel)
        }
    }
}
