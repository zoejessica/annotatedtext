import Foundation
import SwiftUI

public typealias TextModifier = (Text) -> () -> Text

public protocol TextModifierProviding {
  var modifier: TextModifier { get }
}

public func styledText(from annotatedTexts: [AnnotatedText]) -> Text {
  annotatedTexts.reduce(Text(""), { initial, result in
    if let annotation = result.annotation as? TextModifierProviding {
      return initial + annotation.modifier(Text(result.text))()
    } else {
      return initial + Text(result.text)
    }
  })
}

public func styledText(from string: String) -> Text? {
  guard let annotated = parseFlatHTML(string) else { return nil }
  return styledText(from: annotated)
}

