import XCTest
@testable import AnnotatedText

let inputA = "See what <b>zoejessica</b> is saying about your Minecraft Dungeons clip \"ch-ching\"! 👀"
let inputB = "<b>GoldEagle, DragonWolf</b> and others just published 20 new clips. 👀"
let inputC = "On 🔥! <b>StelseyLesser and Thornex</b> and -1 others started following you."

final class AnnotatedTextTests: XCTestCase {
  func test_serverResponsesParseCorrectly() {
    let (matchA, restA) = tinyFlatHTMLParser.run(inputA)
    XCTAssertEqual(restA, "")
    XCTAssertEqual(matchA, [
                    AnnotatedText(text: "See what ", annotation: nil),
                    AnnotatedText(text: "zoejessica", annotation: .bold),
      AnnotatedText(text: " is saying about your Minecraft Dungeons clip \"ch-ching\"! 👀", annotation: nil)])
    
    let (matchB, restB) = tinyFlatHTMLParser.run(inputB)
    XCTAssertEqual(restB, "")
    XCTAssertEqual(matchB, [
                    AnnotatedText(text: "GoldEagle, DragonWolf", annotation: .bold),
                    AnnotatedText(text: " and others just published 20 new clips. 👀", annotation: nil)])
    
    let (matchC, restC) = tinyFlatHTMLParser.run(inputC)
    XCTAssertEqual(restC, "")
    XCTAssertEqual(matchC, [
                    AnnotatedText(text: "On 🔥! ", annotation: nil),
                    AnnotatedText(text: "StelseyLesser and Thornex", annotation: .bold),
                    AnnotatedText(text: " and -1 others started following you.", annotation: nil)])
  }

  static var allTests = [
      ("Server responses parse correctly", test_serverResponsesParseCorrectly),
  ]
}
