//
//  ContentView.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 10/24/20.
//

import SwiftUI

struct NewsFeedView: View {
    @EnvironmentObject var newsFeedModel: NewsFeedModel
    @State var showPublisher = false


    var body: some View {
        NavigationView {
            NewsList(feeds: newsFeedModel.feeds)
                .navigationTitle(newsFeedModel.navigationTitleText)
                .toolbar() {
                    Button("Publishers", action: {
                        showPublisher = true
                    })
            }
            Text(newsFeedModel.navigationTitleText )
        }

            .onAppear {
                newsFeedModel.fetchPublisher()
                newsFeedModel.fetchNews()
            }
            .sheet(isPresented: $showPublisher) {
                PublisherList(isShowing: $showPublisher)

        }
    }
}



struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
            .environmentObject(NewsFeedModel())
    }
}