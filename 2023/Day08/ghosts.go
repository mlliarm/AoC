package main

import (
	"fmt"
	"os"
	"strings"
)

type Node struct {
	Name  string
	Left  string
	Right string
}

func GetInput(filename string) []string {
	file, err := os.ReadFile(filename)
	if err != nil {
		panic(err)
	}
	clean_data := strings.Trim(string(file), "\n")
	return strings.Split(clean_data, "\n")
}

func MakeNodesFromData(data []string) []Node {
	node_list := make([]Node, len(data[2:]))
	for i, v := range data[2:] {
		a := strings.Split(v, " = ")
		node := Node{Name: a[0], Left: a[1][1:4], Right: a[1][6:9]}
		node_list[i] = node
	}
	return node_list
}

func main() {
	data := GetInput("inputsmall.txt")
	rules := data[0]
	fmt.Println(rules)
	fmt.Println(data[2:])
	nodes := MakeNodesFromData(data)
	for i, n := range nodes {
		fmt.Println(i, n.Name, n.Left, n.Right)
	}

	next := Node{}
	step := 0
	for _, direction := range rules {
		for _, n := range nodes {
			if string(direction) == "R" {
				if n.Name == n.Right {
					next.Name = n.Right
					step++
				} else {
					continue
				}
			} else if string(direction) == "L" {
				if n.Name == n.Left {
					next.Name = n.Left
					step++
				} else {
					continue
				}
			}
		}
	}
	fmt.Println(step)
}
