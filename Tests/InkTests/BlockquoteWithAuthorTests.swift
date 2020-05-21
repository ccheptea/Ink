//
//  File.swift
//  
//
//  Created by Constantin Cheptea on 21/05/2020.
//

import XCTest
import Ink

final class BlockquoteWithAuthorTests: XCTestCase {

    func testBlockQuoteNoAuthor() {
        let html = MarkdownParser().html(from: """
        @@
        Hello
        @@
        """)

        XCTAssertEqual(html, """
        <div class=\"quote\"><div class=\"text\">Hello
        </div><div class=\"author\"></div></div>
        """)
    }
    
    func testBlockQuoteWithAuthor() {
        let html = MarkdownParser().html(from: """
        @@ John
        Hello
        @@
        """)

        XCTAssertEqual(html, """
        <div class=\"quote\"><div class=\"text\">Hello
        </div><div class=\"author\">John</div></div>
        """)
    }
}

extension BlockquoteWithAuthorTests {
    static var allTests: Linux.TestList<BlockquoteWithAuthorTests> {
        return [
            ("testBlockQuoteNoAuthor", testBlockQuoteNoAuthor)
        ]
    }
}

