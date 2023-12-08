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
	node_map := make(map[string]string)
	for _, v := range data[2:] {
		// fmt.Println(i, v)
		a := strings.Split(v, " = ")
		node_map[a[0]] = a[1]
	}
	N := len(node_map)
	nodes := make([]Node, N)
	i := 0
	for k, v := range node_map {
		node := Node{Name: k, Left: v[1:4], Right: v[6:9]}
		nodes[i] = node
		i++
	}
	return nodes
}

func main() {
	data := GetInput("inputsmall.txt")
	rules := data[0]
	fmt.Println(rules)
	nodes := MakeNodesFromData(data)
	for i, n := range nodes {
		fmt.Println(i, n.Name, n.Left, n.Right)
	}
}
