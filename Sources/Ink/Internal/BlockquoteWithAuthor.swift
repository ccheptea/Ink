//
//  File.swift
//  
//
//  Created by Constantin Cheptea on 21/05/2020.
//

internal struct BlockquoteWithAuthor: Fragment {
    var modifierTarget: Modifier.Target { .blockquoteWithAuthor }

    private static let marker: Character = "@"

    private var author: Substring
    private var quote: String

    static func read(using reader: inout Reader) throws -> BlockquoteWithAuthor {
        let startingMarkerCount = reader.readCount(of: marker)
        try require(startingMarkerCount >= 2)
        reader.discardWhitespaces()

        let author = reader
            .readUntilEndOfLine()
            .trimmingTrailingWhitespaces()

        var quote = ""

        while !reader.didReachEnd {
            if quote.last == "\n", reader.currentCharacter == marker {
                let markerCount = reader.readCount(of: marker)

                if markerCount == startingMarkerCount {
                    break
                } else {
                    quote.append(String(repeating: marker, count: markerCount))
                    guard !reader.didReachEnd else { break }
                }
            }

            if let escaped = reader.currentCharacter.escaped {
                quote.append(escaped)
            } else {
                quote.append(reader.currentCharacter)
            }

            reader.advanceIndex()
        }

        return BlockquoteWithAuthor(author: author, quote: quote)
    }

    func html(usingURLs urls: NamedURLCollection,
              modifiers: ModifierCollection) -> String {

        return "<div class=\"quote\"><div class=\"text\">\(quote)</div><div class=\"author\">\(author)</div></div>"
    }

    func plainText() -> String {
        quote
    }
}
