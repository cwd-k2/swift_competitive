/*=Main Part==================================================================*/
let (n, _) = *line().split(toInt)

for _ in 0..<n {
  print(line().split(toInt).reduce(0, +))
}

/*=Utilities for Programming Contests ========================================*/
import Foundation
// input: read a line to ...
@inlinable func line() -> String { readLine()! }
// shorthand
public typealias Dbl = Double
// misc: string manipulation utils
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
// structured bindings: splat - let (a, b) = *arrayOfInt
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
