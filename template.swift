//=Main Part==================================================================//
func main(args: [String]) -> Int32 {
  // Your code goes here
  return 0
}

//=Utilities for Programming Contests ========================================//
import Foundation
// input: read a line to ...
@inlinable @inline(__always) func input() -> String { readLine()! }
@inlinable @inline(__always) func input() -> Int    { Int(readLine()!)! }
@inlinable @inline(__always) func input() -> Double { Double(readLine()!)! }
@inlinable @inline(__always) func input(separator c: Character = " ") -> [String] { input().split(separator: c).map(String.init) }
@inlinable @inline(__always) func input(separator c: Character = " ") -> [Int]    { input().split(separator: c).map{ Int(String($0))! } }
@inlinable @inline(__always) func input(separator c: Character = " ") -> [Double] { input().split(separator: c).map{ Double(String($0))! } }
// structured bindings: splat - let (a, b) = *arrayOfInt
prefix operator *
@inlinable @inline(__always) prefix func * <E> (a: [E]) -> (E, E)          { (a[0], a[1]) }
@inlinable @inline(__always) prefix func * <E> (a: [E]) -> (E, E, E)       { (a[0], a[1], a[2]) }
@inlinable @inline(__always) prefix func * <E> (a: [E]) -> (E, E, E, E)    { (a[0], a[1], a[2], a[3]) }
@inlinable @inline(__always) prefix func * <E> (a: [E]) -> (E, E, E, E, E) { (a[0], a[1], a[2], a[3], a[4]) }
// ruby like assigment for nullable
infix operator ||=
@inlinable @inline(__always) func ||= <T> (lhs: inout T?, rhs: @autoclosure () -> T) { lhs = lhs ?? rhs() }
// can be used as both stack and queue
public struct Skewer<T> {
  private class Node { let value: T; var next, prev: Node?; init(_ value: T) { self.value = value } }
  private var __head, __tail: Node?
  public var isEmpty: Bool { self.__head == nil && self.__tail == nil }
  public var head: T? { self.__head?.value }
  public var tail: T? { self.__tail?.value }
  public init() { /* nothing to do */ }
  public init(from a: [T], reverse: Bool = false) { if reverse { for v in a { self.pushHead(v) } } else { for v in a { self.pushTail(v) } } }
  public mutating func pushHead(_ v: T) -> Void { let n = Node(v); self.__head?.prev = n; n.next = self.__head; self.__head = n; self.__tail ||= n }
  public mutating func pushTail(_ v: T) -> Void { let n = Node(v); self.__tail?.next = n; n.prev = self.__tail; self.__tail = n; self.__head ||= n }
  @discardableResult public mutating func popHead() -> T? { guard let n = self.__head else { return nil }; n.next?.prev = nil; self.__head = n.next; return n.value }
  @discardableResult public mutating func popTail() -> T? { guard let n = self.__tail else { return nil }; n.prev?.next = nil; self.__tail = n.prev; return n.value }
}
// heap: for priority queue
public struct Fork<T> {
  private var data: [T]
  private var compare: (T, T) -> Bool
  public var isEmpty: Bool { self.data.isEmpty }
  public init(from a: [T] = [], compare: @escaping (T, T) -> Bool) { self.data = a; self.compare = compare; self.heapify() }
  public func peek() -> T? { self.data.first }
  public mutating func insert(_ v: T) -> Void { self.data.append(v); self.shiftUp(self.data.count - 1) }
  @discardableResult
  public mutating func remove() -> T? {
    if self.data.count <= 1 { return self.data.popLast() }
    let value = self.data[0]
    self.data[0] = self.data.removeLast()
    self.shiftDown(0)
    return value
  }
  @inlinable @inline(__always) internal func parentIndex(_ index: Int) -> Int { (index - 1) / 2 }
  @inlinable @inline(__always) internal func lChildIndex(_ index: Int) -> Int { 2 * index + 1 }
  @inlinable @inline(__always) internal func rChildIndex(_ index: Int) -> Int { 2 * index + 2 }
  private mutating func heapify() -> Void {
    if self.data.count < 2 { return }
    for i in stride(from: (self.data.count / 2 - 1), through: 0, by: -1) { shiftDown(i) }
  }
  internal mutating func shiftUp(_ index: Int) -> Void {
    let put = self.data[index]
    var (insertIndex, parentIndex) = (index, self.parentIndex(index))
    while insertIndex > 0 && self.compare(put, self.data[parentIndex]) {
      self.data[insertIndex]     = self.data[parentIndex]
      (insertIndex, parentIndex) = (parentIndex, self.parentIndex(parentIndex))
    }
    self.data[insertIndex] = put
  }
  internal mutating func shiftDown(from: Int, until end: Int) -> Void {
    var here = from
    let l = self.lChildIndex(from)
    let r = self.rChildIndex(from)
    if l < end && self.compare(self.data[l], self.data[here]) { here = l }
    if r < end && self.compare(self.data[r], self.data[here]) { here = r }
    if here == from { return }
    self.data.swapAt(from, here)
    self.shiftDown(from: here, until: end)
  }
  internal mutating func shiftDown(_ index: Int) -> Void { self.shiftDown(from: index, until: self.data.count) }
}
// union find tree
public struct UnionFind {
  private var data: [Int]
  public init(size: Int) { self.data = [Int](repeating: -1, count: size) }
  public mutating func size(of group: Int) -> Int { -self.data[self.root(of: group)] }
  public mutating func root(of id: Int)    -> Int { if (self.data[id] < 0) { return id }; self.data[id] = root(of: self.data[id]); return self.data[id] }
  public mutating func join(_ x: Int, _ y: Int) -> Void {
    let (px, py) = (self.root(of: x), self.root(of: y))
    if px == py { return }
    if (self.data[px] > self.data[py]) { self.data.swapAt(px, py) }
    (self.data[px], self.data[py]) = (self.data[px] &+ self.data[py], px)
  }
}

//=Execution==================================================================//
exit(main(args: CommandLine.arguments))
