import Foundation
import Textino

struct OpenTag {
  let annotation: Annotation
}

struct CloseTag {
  let annotation: Annotation
}

let anyOpenTag = zip("<", Parser.prefix(until: ">"), ">")
let anyCloseTag = zip("</", Parser.prefix(until: ">"), ">")

let eitherOpenOrClose: Parser<Void> = Parser.oneOf(anyOpenTag.map({ _ in () }),
                                                   anyCloseTag.map({ _ in () }))

let anyKnownOpenTag = Parser.oneOf([Annotation.bold.openTag,
                                    Annotation.italic.openTag])
let anyKnownCloseTag = Parser.oneOf([Annotation.bold.closeTag,
                                     Annotation.italic.closeTag])
