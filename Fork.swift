// heap: for priority queue
public struct Fork<T> {
  private var data: [T]
  private var compare: (T, T) -> Bool
  public var isEmpty: Bool { self.data.isEmpty }
  public init(from a: [T] = [], compare: @escaping (T, T) -> Bool) {
    self.data = a
    self.compare = compare
    self.heapify()
  }
  public func peek() -> T? { self.data.first }
  public mutating func insert(_ v: T) -> Void {
    self.data.append(v)
    self.shiftUp(self.data.count - 1)
  }
  @discardableResult
  public mutating func remove() -> T? {
    if self.data.count <= 1 { return self.data.popLast() }
    let value = self.data[0]
    self.data[0] = self.data.removeLast()
    self.shiftDown(0)
    return value
  }
  @inlinable internal func parentIndex(_ index: Int) -> Int { (index - 1) / 2 }
  @inlinable internal func lChildIndex(_ index: Int) -> Int { 2 * index + 1 }
  @inlinable internal func rChildIndex(_ index: Int) -> Int { 2 * index + 2 }
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
  internal mutating func shiftDown(_ index: Int) -> Void {
    self.shiftDown(from: index, until: self.data.count)
  }
}

