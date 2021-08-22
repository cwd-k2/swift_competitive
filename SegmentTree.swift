// in progress
// segment tree: 1-indexed
public struct SegmentTree<T> {
  private var data: [T]
  private var s: Int
  private var f: (T, T) -> T
  private var u: T
  public init(size: Int, operation: @escaping (T, T) -> T, unit: T) {
    u = unit
    f = operation
    s = 1
    while s < size { s <<= 1 }
    data = [T](repeating: u, count: s * 2)
  }
  public mutating func put(_ at: Int, _ value: T) { data[s + at] = value }
  public mutating func update(_ at: Int, _ value: T) {
    var k = at + s
    data[k] = value
    k >>= 1
    while k > 0 {
      data[k] = f(data[k << 1 | 1], data[k << 1 | 0])
      k >>= 1
    }
  }
}
