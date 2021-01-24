//
//  NewsFeedSwiftUITests.swift
//  NewsFeedSwiftUITests
//
//  Created by 李其炜 on 10/24/20.
//

import XCTest
@testable import NewsFeedSwiftUI

class NewsFeedSwiftUITests: XCTestCase {

    func testParseMarkdownLink() {
        let markdown = """
        hello [hello](https://google.com) world
        """
        let parser = MarkdownParser(markdown: markdown)
        let nodes = parser.parseMarkdown()
        XCTAssertEqual(nodes.count, 3)
        XCTAssertEqual(nodes[1].type, .link)
    }

    func testSpacerMarkdown() {
        let markdown = """
    Hello world
    Hello world
    """
        let parser = MarkdownParser(markdown: markdown)
        let nodes = parser.parseMarkdown()
        XCTAssertEqual(nodes.count, 3)
    }

}
