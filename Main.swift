/*************
 * Main Part *
 *************/

// example
// paiza ラーニング > レベルアップ問題集 > スキルチェック見本問題 > 島探し
let (m, n) = *line().split(toInt)

var lands = (0..<n).map { _ in line().split(toInt) }

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

/*************
 * Utilities *
 *************/
import Foundation
// line: read line
@inlinable func line() -> String { readLine()! }
// shorthand
public typealias Dbl = Double
// string utils
extension String {
  @inlinable public func toInt() -> Int { Int(self)! }
  @inlinable public func toDbl() -> Dbl { Dbl(self)! }
  @inlinable public func split
  (sep c: Character = " ") -> [String]
  { self.split(separator: c).map(String.init) }
  @inlinable public func split<T>
  (sep c: Character = " ", _ f: (String) -> T) -> [T]
  { self.split(sep: c).map(f) }
}
@inlinable func toInt(_ s: String) -> Int { Int(s)! }
@inlinable func toDbl(_ s: String) -> Dbl { Dbl(s)! }
// splat: let (a, b) = *arrayOfInt
prefix operator *
@inlinable prefix func * <E> (a: [E]) -> (E, E)
{ (a[0], a[1]) }
@inlinable prefix func * <E> (a: [E]) -> (E, E, E)
{ (a[0], a[1], a[2]) }
@inlinable prefix func * <E> (a: [E]) -> (E, E, E, E)
{ (a[0], a[1], a[2], a[3]) }
@inlinable prefix func * <E> (a: [E]) -> (E, E, E, E, E)
{ (a[0], a[1], a[2], a[3], a[4]) }
// ruby like assigment for nullable
infix operator ||=: AdditionPrecedence
@inlinable
func ||= <T> (lhs: inout T?, rhs: @autoclosure () -> T) { lhs = lhs ?? rhs() }
