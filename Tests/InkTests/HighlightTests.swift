//
//  File.swift
//  
//
//  Created by Constantin Cheptea on 21/05/2020.
//

import XCTest
import Ink

final class HighlightTests: XCTestCase {
    func testInlineHighlight() {
        let html = MarkdownParser().html(from: "Hello ^^^This is a highlight^^^")
        print("[Highlight Test] html: \(html)P")
        XCTAssertEqual(html, "<p>Hello <span class=\"highlight\">This is a highlight</span></p>")
    }
    
    func testMultilineHighlight() {
        let html = MarkdownParser().html(from: """
        Hello ^^^This
        is a highlight^^^
        """)
        print("[Highlight Test] html: \(html)P")
        XCTAssertEqual(html, """
        <p>Hello <span class=\"highlight\">This
        is a highlight</span></p>
        """)
    }
}

extension HighlightTests {
    static var allTests: Linux.TestList<HighlightTests> {
        return [
            ("testInlineHighlight", testInlineHighlight),
            ("testMultilineHighlight", testMultilineHighlight)
        ]
    }
}
