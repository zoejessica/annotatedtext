import Foundation
import Textino

public struct Annotation: Hashable {
  let value: String
}

extension Annotation {
  private var parser: Parser<Annotation> {
    Parser.prefix(value).map { self }
  }
  
  var openTag: Parser<OpenTag> {
    zip("<", self.parser, ">").map { _, annotation, _ in OpenTag(annotation: annotation) }
  }
  
  var closeTag: Parser<CloseTag> {
    zip("</", self.parser, ">").map { _, annotation, _ in CloseTag(annotation: annotation) }
  }
  
  var text: Parser<AnnotatedText> {
    zip(
      openTag,
      Parser.prefix(until: closeTag),
      closeTag
    ).map { openTag, text, _ in
      AnnotatedText(text: String(text), annotation: openTag.annotation)
    }
  }
}


