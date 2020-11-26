package main

import (
	"crypto/md5"
	"encoding/hex"
	"fmt"
)

var letter = []string{"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "x", "y", "z"}

func check(check string, password string) bool {
	hash := md5.New()
	hash.Write([]byte(check))
	bs := hash.Sum(nil)
	//decoded, _ := hex.DecodeString(password)
	decoded := hex.EncodeToString(bs)
	//fmt.Println(decoded)
	//fmt.Println(password)
	if decoded == password {
		println(check)
		return true
	}
	return false
}
func Stepper(depth int, password string) []string {
	rt := make([]string, 1)
	end := make([]string, 0)
	if depth == 1 {
		for i := 0; i < 25; i++ {
			//println("S was: " + letter[i])
			if check(letter[i], password) == true {
				print("the word was:", letter[i])
				println(":")
				return rt
			}
		}
		return letter
	}
	soFar := Stepper(depth-1, password)
	for i := 1; i < 26; i++ {
		for _, starter := range soFar {
			s := starter + letter[i-1]
			//println("S was: " + s)

			if check(s, password) == true {
				println("the word was: " + s)
				return rt
			}
			end = append(end, starter+letter[i-1])
		}
	}
	return end
}
func main() {
	var password string
	var length int
	fmt.Println("Give me a MD5 hash, then hit enter")
	fmt.Scan(&password)
	fmt.Println("Maximum length password to search for?")
	fmt.Scan(&length)
	Stepper(length, password)
}
