//
//  PublisherList.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 10/26/20.
//

import SwiftUI

struct PublisherList: View {
    @Binding var isShowing: Bool
    @EnvironmentObject var newsFeedModel: NewsFeedModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $newsFeedModel.selectedPublisher, label: Text("Publisher")) {
                        ForEach(newsFeedModel.publishers) { publisher in
                            Text(publisher.name).tag(publisher.id)
                        }
                        
                    }
                    .onChange(of: newsFeedModel.selectedPublisher, perform: { value in
                        newsFeedModel.fetchNews()
                    })
                }
                
            }
            .frame(minWidth: 300)
            .padding()
            .toolbar {
                Button("Close", action: {
                    isShowing = false
                    
                })
            }
            
        }
    }
    
}



