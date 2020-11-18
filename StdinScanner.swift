/*************
 * Main Part *
 *************/

// example
// paiza ラーニング > レベルアップ問題集 > スキルチェック見本問題 > 島探し
let s = StdinScanner()

let m = s.rInt()
let n = s.rInt()

var lands = s.rInt(n, m)
var count = 0
var stack = [(Int, Int)]()

for i in 0..<n {
  for j in 0..<m {
    if lands[i][j] == 0 { continue }
    stack.append((i, j))
    count &+= 1

    while let (y, x) = stack.popLast() {
      lands[y][x] = 0
      if y > 0     && lands[y - 1][x] == 1 { stack.append((y - 1, x)) }
      if y < n - 1 && lands[y + 1][x] == 1 { stack.append((y + 1, x)) }
      if x > 0     && lands[y][x - 1] == 1 { stack.append((y, x - 1)) }
      if x < m - 1 && lands[y][x + 1] == 1 { stack.append((y, x + 1)) }
    }
  }
}

print(count)

/****************
 * StdinScanner *
 ****************/
import Foundation

public class StdinScanner {
  let sep: Character
  var buf: ArraySlice<String> = []

  public init(_ sep: Character = " ") { self.sep = sep }

  func read() -> ArraySlice<String> {
    readLine()!.split(separator: self.sep).lazy.map(String.init)[...]
  }

  public func next() -> String {
    if self.buf.count == 0 { self.buf = read() }
    return self.buf.popFirst()!
  }
  @inlinable public func rInt() -> Int    { Int(next())!    }
  @inlinable public func rDbl() -> Double { Double(next())! }

  public func line() -> String {
    if self.buf.count == 0 { return readLine()! }
    let retval = self.buf.joined(separator: String(self.sep))
    self.buf = []
    return retval
  }

  @inlinable public func next(_ n: Int) -> [String] {
    (0..<n).lazy.map { _ in next() }
  }
  @inlinable public func rInt(_ n: Int) -> [Int]    {
    (0..<n).lazy.map { _ in rInt() }
  }
  @inlinable public func rDbl(_ n: Int) -> [Double] {
    (0..<n).lazy.map { _ in rDbl() }
  }
  // maybe a bit slower
  @inlinable public func next(_ n: Int, _ m: Int) -> [[String]] {
    (0..<n).lazy.map { _ in next(m) }
  }
  @inlinable public func rInt(_ n: Int, _ m: Int) -> [[Int]]    {
    (0..<n).lazy.map { _ in rInt(m) }
  }
  @inlinable public func rDbl(_ n: Int, _ m: Int) -> [[Double]] {
    (0..<n).lazy.map { _ in rDbl(m) }
  }
}
