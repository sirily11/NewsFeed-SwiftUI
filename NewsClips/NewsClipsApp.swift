//
//  NewsClipsApp.swift
//  NewsClips
//
//  Created by 李其炜 on 10/26/20.
//

import SwiftUI

@main
struct NewsClipsApp: App {
    @StateObject var newsFeedModel = NewsFeedModel()
    
    var body: some Scene {
        WindowGroup {
            NewsFeedView()
                .environmentObject(newsFeedModel)
        }
    }
}
