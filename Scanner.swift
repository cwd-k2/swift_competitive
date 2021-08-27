import Foundation

final class Scanner {
  var iter: IndexingIterator<[String]>
  init(_ handle: FileHandle) {
    iter = try! handle
      .readToEnd()!
      .split { $0 == 0x20 || $0 == 0x0A }
      .map { String.init(data: $0, encoding: .utf8)! }
      .makeIterator()
  }
  public func read() -> String { iter.next()! }
  public func rInt() -> Int { Int(read())! }
  public func rDbl() -> Double { Double(read())! }
}

// let scanner = Scanner(FileHandle.standardInput)
