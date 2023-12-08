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

func MakeNodesFromData(data []string) map[string]Node {
	node_map := make(map[string]string)
	for _, v := range data[2:] {
		a := strings.Split(v, " = ")
		node_map[a[0]] = a[1]
	}
	nodes := make(map[string]Node)
	for k, v := range node_map {
		node := Node{Name: k, Left: v[1:4], Right: v[6:9]}
		nodes[k] = node
	}
	return nodes
}

func PartOneSolution(nodes map[string]Node, rules string) int {
	next := Node{}
	steps := 0
	init := nodes["AAA"]
	for next.Name != "ZZZ" {
		for _, direction := range rules {
			d := string(direction)
			if d == "R" {
				if init.Name != "ZZZ" {
					next.Name = init.Right
					init = nodes[init.Right]
					steps++
				} else {
					break
				}
			} else if d == "L" {
				if init.Name != "ZZZ" {
					next.Name = init.Left
					init = nodes[init.Left]
					steps++
				} else {
					break
				}
			}
		}
	}
	return steps
}

func main() {
	data := GetInput("input.txt")
	rules := data[0]
	nodes := MakeNodesFromData(data)

	// Part 1 solution
	steps := PartOneSolution(nodes, rules)
	fmt.Println(steps)
}
