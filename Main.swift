import Foundation

// example
// paiza ラーニング > レベルアップ問題集 > スキルチェック見本問題 > 島探し
var scanner = try FileHandle
  .standardInput
  .readToEnd()!
  .split { $0 == 0x20 || $0 == 0x0A }
  .map { String.init(data: $0, encoding: .utf8)! }
  .makeIterator()

let m = Int(scanner.next()!)!
let n = Int(scanner.next()!)!

var lands = (0..<n).map { _ in
  (0..<m).map { _ in
    Int(scanner.next()!)!
  }
}

var count = 0
var stack = [(Int, Int)]()

for i in 0..<n {
  for j in 0..<m {
    if lands[i][j] == 0 { continue }
    stack.append((i, j))
    count &+= 1

    while let (y, x) = stack.popLast() {
      lands[y][x] = 0
      if y > 0 && lands[y - 1][x] == 1 { stack.append((y - 1, x)) }
      if y < n - 1 && lands[y + 1][x] == 1 { stack.append((y + 1, x)) }
      if x > 0 && lands[y][x - 1] == 1 { stack.append((y, x - 1)) }
      if x < m - 1 && lands[y][x + 1] == 1 { stack.append((y, x + 1)) }
    }
  }
}

print(count)
