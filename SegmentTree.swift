// in progress
// segment tree: 1-indexed
public struct SegmentTree<T> {
  private var data: [T]
  private var s: Int
  private var f: (T, T) -> T
  private var e: T
  public init(size: Int, operation: @escaping (T, T) -> T, unit: T) {
    self.e = unit
    self.f = operation
    self.s = 1
    while self.s < size { self.s <<= 1 }
    self.data = [T](repeating: self.e, count: self.s * 2)
  }
  public mutating func put(_ at: Int, _ value: T) -> Void { self.data[self.s + at] = value }
  public mutating func update(_ at: Int, _ value: T) -> Void {
    var k = at + self.s
    self.data[k] = value
    k >>= 1
    while k > 0 {
      self.data[k] = self.f(self.data[k<<1|1], self.data[k<<1|0])
      k >>= 1
    }
  }
}

