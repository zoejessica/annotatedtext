import XCTest
@testable import AnnotatedText

let inputA = "See what <b>zoejessica</b> is saying about your Minecraft Dungeons clip \"ch-ching\"! 👀"
let inputB = "<b>GoldEagle, DragonWolf</b> and others just published 20 new clips. 👀"
let inputC = "On 🔥! <b>StelseyLesser and Thornex</b> and -1 others started following you."
let inputD = "<b>wafflehog</b> has tagged you in and didn&#39;t it seem to all be going so well :(  ."

final class AnnotatedTextTests: XCTestCase {
  func test_serverResponsesParseCorrectly() {
    XCTAssertEqual(parseFlatHTML(inputA), [
                    AnnotatedText(text: "See what ", annotation: nil),
                    AnnotatedText(text: "zoejessica", annotation: .bold),
      AnnotatedText(text: " is saying about your Minecraft Dungeons clip \"ch-ching\"! 👀", annotation: nil)])

    XCTAssertEqual(parseFlatHTML(inputB), [
                    AnnotatedText(text: "GoldEagle, DragonWolf", annotation: .bold),
                    AnnotatedText(text: " and others just published 20 new clips. 👀", annotation: nil)])

    XCTAssertEqual(parseFlatHTML(inputC), [
                    AnnotatedText(text: "On 🔥! ", annotation: nil),
                    AnnotatedText(text: "StelseyLesser and Thornex", annotation: .bold),
                    AnnotatedText(text: " and -1 others started following you.", annotation: nil)])

    XCTAssertEqual(parseFlatHTML(inputD), [
                    AnnotatedText(text: "wafflehog", annotation: .bold),
                    AnnotatedText(text: " has tagged you in and didn't it seem to all be going so well :(  .", annotation: nil)])
  }

  static var allTests = [
      ("Server responses parse correctly", test_serverResponsesParseCorrectly),
  ]
}
