// ruby like assigment for nullable
infix operator ||=: AdditionPrecedence
@inlinable
func ||= <T> (lhs: inout T?, rhs: @autoclosure () -> T) { lhs = lhs ?? rhs() }

// can be used as both stack and queue
public struct Skewer<T> {
  private class Node {
    let value: T
    var next, prev: Node?
    init(_ value: T) { self.value = value }
  }
  private var __head, __tail: Node?
  public var isEmpty: Bool { self.__head == nil && self.__tail == nil }
  public var head: T? { self.__head?.value }
  public var tail: T? { self.__tail?.value }
  public init() { /* nothing to do */ }
  public init(from a: [T], reverse: Bool = false) {
    if reverse {
      for v in a { self.pushHead(v) }
    } else {
      for v in a { self.pushTail(v) }
    }
  }
  public mutating func pushHead(_ v: T) -> Void {
    let n = Node(v)
    self.__head?.prev = n
    n.next = self.__head
    self.__head = n
    self.__tail ||= n
  }
  public mutating func pushTail(_ v: T) -> Void {
    let n = Node(v)
    self.__tail?.next = n
    n.prev = self.__tail
    self.__tail = n
    self.__head ||= n
  }
  @discardableResult
  public mutating func popHead() -> T? {
    guard let n = self.__head else { return nil }
    n.next?.prev = nil
    self.__head = n.next
    return n.value
  }
  @discardableResult
  public mutating func popTail() -> T? {
    guard let n = self.__tail else { return nil }
    n.prev?.next = nil
    self.__tail = n.prev
    return n.value
  }
}

