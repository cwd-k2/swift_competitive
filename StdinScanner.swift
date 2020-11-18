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
  private let sep: Character
  private var idx: Int = 0
  private var buf: [String] = []

  public init(_ sep: Character = " ") { self.sep = sep }

  private func read() -> Void {
    buf = readLine()!.split(separator: sep).lazy.map(String.init)
    idx = 0
  }

  @discardableResult
  public func next() -> String {
    if idx == buf.count { read() }
    idx &+= 1
    return buf[idx - 1]
  }
  @inlinable public func rInt() -> Int    { Int(next())!    }
  @inlinable public func rDbl() -> Double { Double(next())! }

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

  // ignoring current line's leftover
  @discardableResult
  public func line() -> String {
    idx = buf.count
    return readLine()!
  }
  @inlinable public func lInt() -> Int    { Int(line())!    }
  @inlinable public func lDbl() -> Double { Double(line())! }

  @inlinable public func line(_ n: Int) -> [String] {
    (0..<n).lazy.map { _ in line() }
  }
  @inlinable public func lInt(_ n: Int) -> [Int]    {
    (0..<n).lazy.map { _ in lInt() }
  }
  @inlinable public func lDbl(_ n: Int) -> [Double] {
    (0..<n).lazy.map { _ in lDbl() }
  }

  @discardableResult
  public func rest() -> String {
    let ret = buf[idx..<buf.count].joined(separator: String(sep))
    idx = buf.count
    return ret
  }
}
