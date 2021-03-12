//
//  ContentView.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 10/24/20.
//

import SwiftUI
#if os(iOS)
import ImageViewerRemote
#endif

struct NewsFeedView: View {
    @EnvironmentObject var detailImageModel: DetailImageViewModel
    @EnvironmentObject var newsFeedModel: NewsFeedModel
    @State var showPublisher = false
    
    #if os(iOS)
    @ViewBuilder
    func makeIOSView() -> some View{
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
        .overlay(ImageViewerRemote(imageURL: $detailImageModel.imageStr, viewerShown: $detailImageModel.show))
    }
    #endif
    
    
    @ViewBuilder
    func makeMacOSView() -> some View{
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
    
    var body: some View {
        #if os(iOS)
        makeIOSView()
        #else
        makeMacOSView()
        #endif
    }
    
}



struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
            .environmentObject(NewsFeedModel())
    }
}
