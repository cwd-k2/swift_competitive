/*************
 * Main Part *
 *************/
import Foundation

// example
// paiza ラーニング > レベルアップ問題集 > スキルチェック見本問題 > 島探し
// TODO: lazy の有無, 位置
var scanner = AnyIterator { readLine() }.join(separator: " ").split(separator: " ").makeIterator()

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
