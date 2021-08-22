// ruby like assigment for nullable
infix operator ||=: AssignmentPrecedence
@inlinable
func ||= <T>(lhs: inout T?, rhs: @autoclosure () -> T) { lhs = lhs ?? rhs() }

// can be used as both stack and queue
public struct BiList<T> {
  private class Node {
    let value: T
    var next, prev: Node?
    init(_ value: T) { value = value }
  }

  private var __head, __tail: Node?

  public var isEmpty: Bool { __head == nil && __tail == nil }
  public var head: T? { __head?.value }
  public var tail: T? { __tail?.value }

  public init() { /* nothing to do */  }
  public init(from a: [T], reverse: Bool = false) {
    if reverse {
      for v in a { pushHead(v) }
    } else {
      for v in a { pushTail(v) }
    }
  }

  public mutating func pushHead(_ v: T) {
    let n = Node(v)
    __head?.prev = n
    n.next = __head
    __head = n
    __tail ||= n
  }

  public mutating func pushTail(_ v: T) {
    let n = Node(v)
    __tail?.next = n
    n.prev = __tail
    __tail = n
    __head ||= n
  }

  @discardableResult
  public mutating func popHead() -> T? {
    guard let n = __head else { return nil }

    n.next?.prev = nil
    __head = n.next

    return n.value
  }

  @discardableResult
  public mutating func popTail() -> T? {
    guard let n = __tail else { return nil }

    n.prev?.next = nil
    __tail = n.prev

    return n.value
  }
}
