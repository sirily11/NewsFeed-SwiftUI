import SwiftUI

struct MarkdownNodeView: Identifiable {
    var view: AnyView
    var id = UUID()
}

struct MarkdownView: View {
    var markdownStr: String
    @State var views: [MarkdownNodeView] = []


    var body: some View {
        ScrollView {
            LazyVStack {
                if views.count == 0 {
                    Text("Loading")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                ForEach(views) { view in
                    view.view
                        .multilineTextAlignment(.leading)


                }
            }
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                let parser = MarkdownParser(markdown: self.markdownStr)
                let nodes = parser.parseMarkdown()
                var views: [MarkdownNodeView] = []
                var text: Text? = nil

                for (index, element) in nodes.enumerated() {
                    if element.type == .link || element.type == .text {
                        var prev_element: MarkdownNode? = nil
                        var next_element: MarkdownNode? = nil

                        if index < nodes.count - 1 {
                            next_element = nodes[index + 1]
                        }

                        if index > 1 {
                            prev_element = nodes[index - 1]
                        }

                        if prev_element?.type == .link || prev_element?.type == .text {
                            if let t = text {
                                text = t + textView(node: element)
                            }

                        } else {
                            text = textView(node: element)
                        }

                        if next_element?.type != .text && next_element?.type != .link {
                            views.append(MarkdownNodeView(view: AnyView(text.padding(.vertical))))
                        }

                    } else {
                        views.append(MarkdownNodeView(view: containedView(node: element)))

                    }

                }
                self.views = views
        }
    }

    func textView(node: MarkdownNode) -> Text {
        switch node.type {
        case .link:
            return Text(node.content).foregroundColor(.blue)
        default:
            return Text(node.content)
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

        case .link:
            return AnyView(Text(node.content).foregroundColor(.blue))
        default:
            return AnyView(Text(node.content))


        }

    }
}


struct MarkdownView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownView(markdownStr: "hello world")
    }
}
