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
        TabView {
            NavigationView {
                NewsList()
                    .navigationTitle(newsFeedModel.navigationTitleText)
                    .toolbar() {
                        Button("Publishers", action: {
                            showPublisher = true
                        })
                }
                Text(newsFeedModel.navigationTitleText)

            }

                .sheet(isPresented: $showPublisher) {
                    PublisherList(isShowing: $showPublisher)
                        .environmentObject(newsFeedModel)

                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
            }

            NavigationView {
                LikesView()
                    .navigationTitle("Likes")
            }
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Likes")
            }

            NavigationView {
                SearchView(feedModel: newsFeedModel)
                    .navigationTitle("Search")
            }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
            }
        }
            .onAppear {
                newsFeedModel.fetchPublisher()
                newsFeedModel.fetchNews()
        }
    }

}



struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
            .environmentObject(NewsFeedModel())
    }
}
