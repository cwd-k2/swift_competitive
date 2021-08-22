// heap: for priority queue
public struct Heap<T> {
  private var data: [T]
  private var compare: (T, T) -> Bool

  public var isEmpty: Bool { data.isEmpty }

  public init(from a: [T] = [], compare: @escaping (T, T) -> Bool) {
    data = a
    compare = compare
    heapify()
  }

  public func peek() -> T? { data.first }

  public mutating func insert(_ v: T) {
    data.append(v)
    shiftUp(data.count - 1)
  }

  @discardableResult
  public mutating func remove() -> T? {
    if data.count <= 1 { return data.popLast() }
    let value = data[0]
    data[0] = data.removeLast()
    shiftDown(0)
    return value
  }

  internal func parentIndex(_ index: Int) -> Int { (index - 1) / 2 }
  internal func lChildIndex(_ index: Int) -> Int { 2 * index + 1 }
  internal func rChildIndex(_ index: Int) -> Int { 2 * index + 2 }

  private mutating func heapify() {
    if data.count < 2 { return }
    for i in stride(from: (data.count / 2 - 1), through: 0, by: -1) { shiftDown(i) }
  }

  internal mutating func shiftUp(_ index: Int) {
    let put = data[index]
    var (insertIndex, parentIndex) = (index, parentIndex(index))

    while insertIndex > 0 && compare(put, data[parentIndex]) {
      data[insertIndex] = data[parentIndex]
      (insertIndex, parentIndex) = (parentIndex, parentIndex(parentIndex))
    }

    data[insertIndex] = put
  }

  internal mutating func shiftDown(from: Int, until end: Int) {
    var here = from
    let l = lChildIndex(from)
    let r = rChildIndex(from)

    if l < end && compare(data[l], data[here]) { here = l }
    if r < end && compare(data[r], data[here]) { here = r }

    if here == from { return }

    data.swapAt(from, here)
    shiftDown(from: here, until: end)
  }

  internal mutating func shiftDown(_ index: Int) {
    shiftDown(from: index, until: data.count)
  }
}
