import XCTest
@testable import AnnotatedText

let customTag = "The next interesting word <medal>waffle</medal> should be tagged with a custom tag."

final class CustomTagTests: XCTestCase {
  func test_customTagResponsesParseCorrectly() {
    let medalAnnotation = Annotation(value: "medal")
    let parser = customTagParser(annotations: [medalAnnotation])
    XCTAssertEqual(parser(customTag), [
                    AnnotatedText(text: "The next interesting word ", annotation: nil),
                    AnnotatedText(text: "waffle", annotation: medalAnnotation),
                    AnnotatedText(text: " should be tagged with a custom tag.", annotation: nil)])
  }

  static var allTests = [
      ("Server responses parse correctly", test_customTagResponsesParseCorrectly),
  ]
}
