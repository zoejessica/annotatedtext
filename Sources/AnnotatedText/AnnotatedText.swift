import Foundation

public struct AnnotatedText: CustomDebugStringConvertible, Equatable {
  public static func == (lhs: AnnotatedText, rhs: AnnotatedText) -> Bool {
    lhs.text == rhs.text && lhs.annotation?.value == rhs.annotation?.value
  }
  
  public let text: String
  public let annotation: Annotation?
  
  public var debugDescription: String {
    "\(text) [\(annotation.map(\.value) ?? "plain text")]"
  }
}
