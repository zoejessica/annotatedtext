import Foundation
import Textino
import HTMLString

public func parseFlatHTML(_ string: String) -> [AnnotatedText]? {
  return tinyFlatHTMLParser.run(string.removingHTMLEntities()).match
}

let tinyFlatHTMLParser = Parser.oneOf([Annotation.bold.text,
                                       Annotation.italic.text,
                         plainText])
  .oneOrMore()

let plainText = zip(
  Parser.consumeIfPresent(anyOpenTag),
  Parser.prefix(until: eitherOpenOrClose),
  Parser.consumeIfPresent(anyCloseTag))
  .map { _, text, _ -> AnnotatedText in
    return AnnotatedText(text: String(text), annotation: nil)
  }
