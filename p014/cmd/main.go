package main

import (
  "github.com/CodyPerakslis/polymath/p014"
  "fmt"
)

func main() {
  c := collatz.New(1000000)
  c.FillTable()
  fmt.Println(c.LargestChain())
}
