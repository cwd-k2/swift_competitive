// union find tree
public struct UnionFind {
  private var data: [Int]

  public init(size: Int) {
    data = [Int](repeating: -1, count: size)
  }

  public mutating func size(of group: Int) -> Int {
    -data[root(of: group)]
  }

  public mutating func root(of id: Int) -> Int {
    if data[id] < 0 { return id }

    data[id] = root(of: data[id])

    return data[id]
  }

  public mutating func join(_ x: Int, _ y: Int) {
    let (px, py) = (root(of: x), root(of: y))

    if px == py { return }

    if data[px] > data[py] {
      data.swapAt(px, py)
    }

    (data[px], data[py]) = (data[px] &+ data[py], px)
  }
}
