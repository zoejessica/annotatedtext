import Foundation
import Textino

public func parseFlatHTML(_ string: String) -> [AnnotatedText]? {
  tinyFlatHTMLParser.run(string).match
}

let tinyFlatHTMLParser = Parser.oneOf([Bold().text,
                         Italic().text,
                         plainText])
  .oneOrMore()

let plainText = zip(
  Parser.consumeIfPresent(anyOpenTag),
  Parser.prefix(until: eitherOpenOrClose),
  Parser.consumeIfPresent(anyCloseTag))
  .map { _, text, _ -> AnnotatedText in
    return AnnotatedText(text: String(text), annotation: nil)
  }
