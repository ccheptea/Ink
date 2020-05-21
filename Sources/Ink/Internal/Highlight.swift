//
//  File.swift
//  
//
//  Created by Constantin Cheptea on 21/05/2020.
//

internal struct Highlight: Fragment {
    var modifierTarget: Modifier.Target { .highlight }
    
    private static let marker: Character = "^"
    
    private var highlight: String
    
    static func read(using reader: inout Reader) throws -> Highlight {
        let startingMarkerCount = reader.readCount(of: marker)
        try require(startingMarkerCount >= 3)
        
        var highlight = ""
        print("[Highlight] reading...")
        while !reader.didReachEnd {
            if highlight.last != marker, reader.currentCharacter == marker {
                let markerCount = reader.readCount(of: marker)
                
                if markerCount == startingMarkerCount {
                    break
                } else {
                    highlight.append(String(repeating: marker, count: markerCount))
                    guard !reader.didReachEnd else { break }
                }
            }
            
            if let escaped = reader.currentCharacter.escaped {
                highlight.append(escaped)
            } else {
                highlight.append(reader.currentCharacter)
            }
            
            reader.advanceIndex()
        }
        
        return Highlight(highlight: highlight)
    }
    
    func html(usingURLs urls: NamedURLCollection,
              modifiers: ModifierCollection) -> String {
        return "<span class=\"highlight\">\(highlight)</span>"
    }
    
    func plainText() -> String {
        highlight
    }
}
