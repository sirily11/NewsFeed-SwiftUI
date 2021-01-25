//
//  SearchView.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 10/27/20.
//

import SwiftUI

struct SearchView: View {
    var feedModel: NewsFeedModel
    @State var isSearching: Bool = false
    @State var feeds: [Feed] = []
    @State var hasSearched = false

    var body: some View {
        VStack {
            SearchBar(onEditingEnd: { keyword in
                print("Searching")
                isSearching = true

                feedModel.search(keyword: keyword) { feeds in
                    withAnimation {
                        self.hasSearched = true
                        self.feeds = feeds
                        self.isSearching = false
                    }
                }

            }) {
                feeds = []
                isSearching = false
                hasSearched = false
            }
            Spacer()
            if isSearching {
                ProgressView()
            }
            ScrollView {
                LazyVStack {
                    ForEach(feeds) { feed in
                        FeedRow(feed: feed)
                        Divider()

                    }
                    if hasSearched {
                        Text("Total results: \(feeds.count)")
                            .foregroundColor(Color.gray)
                        Divider()
                    }

                }
            }
        }
    }
}


struct SearchBar: View {
    @State var text: String = ""
    @State private var isEditing = false

    var onEditingEnd: (String) -> ()
    var onClear: () -> ()

    var body: some View {
        HStack {

            TextField("Search ...", text: $text, onCommit:
                    {
                    onEditingEnd(text)
            })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color.gray)
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
            }

            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    onClear()

                }) {
                    Text("Cancel")
                }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(feedModel: TestFeedModel(selected_publisher: 0))

    }
}
