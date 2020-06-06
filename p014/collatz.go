package collatz

import "log"

type Collatz interface {
  FillTable()
  LargestChain() (int, int)
}

type collatz struct {
  final int
  table []int
}

func New(final int) Collatz {
  return &collatz{
    final: final,
    table: make([]int, final, final),
  }
}

func (c *collatz) FillTable() {
  c.table[0] = 1
  var seq []int
  var n int
  var val int
  for i := 1; i < c.final; i++ {
    seq = make([]int, 0)
    n = i+1
    val = 0
    for {
      seq = append(seq, n)
      if (n-1 < c.final && c.table[n-1] > 0) {
        val += c.table[n-1]
        break
      }
      if n%2 == 0 {
        n = n/2
      } else {
        n = 3*n+1
      }
      val += 1
    }
    // Subtract index
    for i, s := range seq {
      if (s-1 < c.final && c.table[s-1] == 0) {c.table[s-1] = val - i}
    }
  }
}

func (c *collatz) LargestChain() (int, int) {
  maxIdx := -1
  maxVal := 0
  for i, v := range c.table {
    if v > maxVal {
      maxVal = v
      maxIdx = i+1
    }
  }
  return maxIdx, maxVal
}
