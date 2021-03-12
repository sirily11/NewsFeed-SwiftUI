//
//  DetailView.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 10/24/20.
//

import SwiftUI
import KingfisherSwiftUI
import Parma
import AVFoundation
import SDWebImageSwiftUI

struct DetailView: View {
    let feed: Feed
    @State var isPlaying: Bool = false
    @State var like: Bool = false
    @EnvironmentObject var databaseModel: DatabaseModel

    
    let synthesizer = AVSpeechSynthesizer()
    
    fileprivate func speak() {
        if !isPlaying {
            let utterance = AVSpeechUtterance(string: feed.pureText ?? "")
            utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
            for voice in AVSpeechSynthesisVoice.speechVoices() {
                if voice.identifier.contains("siri") && voice.language == "zh-CN" {
                    utterance.voice = voice
                    break
                }
            }
            if synthesizer.isPaused {
                synthesizer.continueSpeaking()
            } else {
                synthesizer.speak(utterance)
            }
            
            
            isPlaying = true
        } else {
            synthesizer.pauseSpeaking(at: .word)
            isPlaying = false
        }
    }
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text(feed.newsPublisher.name)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding(.leading)
                    
                    Spacer()
                    #if os(iOS)
                    Button(action: {
                        speak()
                        
                    }) {
                        if isPlaying {
                            Image(systemName: "speaker.fill")
                        } else {
                            Image(systemName: "speaker")
                        }
                        
                    }
                    .padding(.trailing)
                    #endif
                    
                }
                
                if (feed.cover != nil) {
                    #if os(iOS)
                    WebImage(url: URL(string: feed.cover!))
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, minHeight: 300, alignment: .center)
                    #else
                    WebImage(url: URL(string: feed.cover!))
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 300, alignment: .center)
                        .padding()
                    #endif
                    
                    
                }
                Parma(feed.content ?? "", render: MyRenderer())
                    .padding(.horizontal)
                
                
            }
            
        }
        .onDisappear{
            synthesizer.stopSpeaking(at: .immediate)
        }
        .onAppear {
            like = databaseModel.existFeed(feed: feed)
        }
        
        .toolbar {
            
            Button(action: {
                    withAnimation {
                        
                        if(like) {
                            databaseModel.deleteFeed(feed: feed)
                        } else {
                            databaseModel.addFeed(feed: feed)
                        }
                        like.toggle()
                        
                    } }) {
                if like {
                    Image(systemName: "star.fill")
                } else {
                    Image(systemName: "star")
                }
                
                
            }
            
            Button(action: {
                speak()
                
            }) {
                if isPlaying {
                    Image(systemName: "speaker.fill")
                } else {
                    Image(systemName: "speaker")
                }
                
            }
            
            
        }
        .navigationTitle(feed.title)
    }
}

struct MyRenderer: ParmaRenderable {
    
    func link(textView: Text, destination: String?) -> Text {
        textView
            .foregroundColor(.blue)
    }
    
    func imageView(with urlString: String, altTextView: AnyView?) -> AnyView {
        AnyView(ImageView(imageSrc: urlString))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(feed: test_feeds[0])
            .environmentObject(DatabaseModel())
            .environmentObject(DetailImageViewModel())
    }
}
