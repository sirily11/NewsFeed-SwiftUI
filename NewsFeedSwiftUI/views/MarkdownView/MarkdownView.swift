//
//  MarkdownView.swift
//  NewsFeedUIKit
//
//  Created by 李其炜 on 10/29/19.
//  Copyright © 2019 李其炜. All rights reserved.
//

import SwiftUI


struct MarkdownView: View {
    var markdownStr: String
    @State var nodes: [MarkdownNode] = []


    var body: some View {
        ScrollView {
            if nodes.count == 0 {
                Text("Loading")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            ForEach(nodes) { node in
                self.containedView(node: node)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)

            }
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                let parser = MarkdownParser(markdown: self.markdownStr)
                let nodes = parser.parseMarkdown()
                self.nodes = nodes
        }
    }

    func containedView(node: MarkdownNode) -> AnyView {
        switch node.type {
        case .header:
            return AnyView(HeaderTextView(content: "\(node.content)\n"))

        case .image:
            if let link = node.link {
                return AnyView(ImageView(imageSrc: link))
            }
            return AnyView(ContentTextView(content: node.content))

        default:
            return AnyView(ContentTextView(content: node.content))


        }

    }
}


struct MarkdownView_Previews: PreviewProvider {
    static var previews: some View {

        MarkdownView(markdownStr: """
        # This is the title
        this is the content lol.
        ![alt text](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Logo Title Text 1")

        """)
    }
}
