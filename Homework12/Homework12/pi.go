package main

import (
	//"math"
	"math/rand"
	"time"
)

var circle = 0
var square = 0
var threadCount = 400

func worker(calc chan bool) {
	for i := 0; i <= 100000; i++ {
		var x = (rand.Float64() - .5)
		var y = (rand.Float64() - .5)

		if ((x * x) + (y * y)) < (.5 * .5) {
			calc <- true
		} else {
			calc <- false
		}
	}
}
func main() {
	start := time.Now()
	calc := make(chan bool)
	for i := 0; i <= threadCount; i++ {
		go worker(calc)
	}
	for {
		if threadCount*100000 == circle+square {
			break
		} else {
			check := <-calc
			if check == true {
				circle++
			} else {
				square++
			}
		}
	}
	println(circle)
	println(square)
	var num = 4 * float64(circle) / (float64(circle) + float64(square))
	println(num)
	elapsed := time.Since(start)
	println("Time passed in seconds:  %s", elapsed/1e+9)
}
