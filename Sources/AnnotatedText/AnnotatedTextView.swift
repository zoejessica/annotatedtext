import Foundation
import SwiftUI

public typealias TextModifier = (Text) -> () -> Text

public protocol TextModifierProviding {
  var modifier: TextModifier { get }
}

public func textModifier<A>(_ modifier: @escaping (Text) -> (A) -> Text,
                     _ configuration: A) -> TextModifier {
  { text in
    { modifier(text)(configuration) }
  }
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

public struct StyledText: View {
  public struct Configuration {
    public init(_ modifiers: [Annotation : TextModifier],
                parser: @escaping (String) -> [AnnotatedText]? = parseFlatHTML) {
      self.modifiers = modifiers
      self.parser = parser
    }
    
    let modifiers: [Annotation : TextModifier]
    let parser: (String) -> [AnnotatedText]?
    
    public static var standard: Configuration {
      Configuration([Annotation.bold : Text.bold,
                     Annotation.italic: Text.italic],
                    parser: parseFlatHTML)
    }
  }
  
  public init(_ simpleHTML: String, configuration: Configuration = Configuration.standard) {
    self.text = simpleHTML
    self.configuration = configuration
    self.annotatedText = configuration.parser(simpleHTML)
  }
  
  let configuration: Configuration
  let text: String
  let annotatedText: [AnnotatedText]?
  var modifiedText: [(text: String, modifier: TextModifier?)]? {
    annotatedText?.map { data in
      if let annotation = data.annotation,
         let modifier = configuration.modifiers[annotation] {
        return (data.text, modifier)
      } else {
        return (data.text, nil)
      }
    }
  }
  
  public var body: some View {
    if let modifiedText = modifiedText {
      return modifiedText.reduce(Text(""), { initial, result in
        if let modifier = result.modifier {
          return initial + modifier(Text(result.text))()
        } else {
          return initial + Text(result.text)
        }
      })
    } else {
      return Text(text)
    }
  }
}


