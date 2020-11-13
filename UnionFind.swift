// union find tree
public struct UnionFind {
  private var data: [Int]
  public init(size: Int) { self.data = [Int](repeating: -1, count: size) }
  public mutating func size(of group: Int) -> Int { -self.data[self.root(of: group)] }
  public mutating func root(of id: Int)    -> Int {
    if (self.data[id] < 0) { return id }
    self.data[id] = root(of: self.data[id])
    return self.data[id]
  }
  public mutating func join(_ x: Int, _ y: Int) -> Void {
    let (px, py) = (self.root(of: x), self.root(of: y))
    if px == py { return }
    if (self.data[px] > self.data[py]) { self.data.swapAt(px, py) }
    (self.data[px], self.data[py]) = (self.data[px] &+ self.data[py], px)
  }
}

