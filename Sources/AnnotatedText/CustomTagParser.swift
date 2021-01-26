import Foundation
import Textino
import HTMLString

public func customTagParser(annotations: [Annotation]) -> (String) -> [AnnotatedText]? {
  let customParser = Parser.oneOf(annotations.map(\.text) + [plainText]).oneOrMore()
  return { string in customParser.run(string.removingHTMLEntities()).match }
}
