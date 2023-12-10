package main

import (
	"fmt"
	"os"
	"strings"
)

type Pair struct {
	x, y int
}

type Pipe struct {
	Name          string
	DegreesOfBend int
	Connecting    string
}

type DataPoint struct {
	Coordinates Pair
	Name        string
}

func GetInput(filename string) []string {
	file, err := os.ReadFile(filename)
	if err != nil {
		panic(err)
	}

	clean_data := strings.Trim(string(file), "\n")
	return strings.Split(clean_data, "\n")
}

func LocateStart(data []string) (int, int) {
	var y int
	for i, d := range data {
		x := strings.Index(d, "S")
		if x != -1 {
			y = i
			return x, y
		} else {
			continue
		}
	}
	return -1, y
}

func AddCoordsToData(data []string) []DataPoint {
	datapoints := []DataPoint{}
	for iy, d := range data {
		for ix, dname := range d {
			datapoints = append(datapoints, DataPoint{Coordinates: Pair{x: ix, y: iy}, Name: string(dname)})
		}
	}
	return datapoints
}

// Convention: y grows in index downwards, and x grows in index rightwards.
func FindNeighbours(data []string, myDp DataPoint) []DataPoint {
	dps := AddCoordsToData(data)
	neighs := []DataPoint{}
	for _, dp := range dps {
		if dp.Coordinates.x == myDp.Coordinates.x-1 && dp.Coordinates.y == myDp.Coordinates.y ||
			dp.Coordinates.x == myDp.Coordinates.x+1 && dp.Coordinates.y == myDp.Coordinates.y ||
			dp.Coordinates.x == myDp.Coordinates.x && dp.Coordinates.y == myDp.Coordinates.y+1 ||
			dp.Coordinates.x == myDp.Coordinates.x && dp.Coordinates.y == myDp.Coordinates.y-1 {
			neighs = append(neighs, dp)
		}
	}
	return neighs
}

func GetUniqueElements(datapoints []DataPoint) []DataPoint {
	uniqueDatapoints := []DataPoint{}
	var tmpDp DataPoint
	for _, dp := range datapoints {
		if dp != tmpDp {
			tmpDp = dp
			uniqueDatapoints = append(uniqueDatapoints, tmpDp)
		} else {
			continue
		}
	}
	return uniqueDatapoints
}

func GetNextLegalMove(data []string, myDp DataPoint) []DataPoint {
	initNeighs := FindNeighbours(data, myDp)
	next := DataPoint{Name: " "}
	possibleNextMove := []DataPoint{}
	if next.Name != "S" {
		for _, iNeigh := range initNeighs {
			if iNeigh.Name == "." {
				continue
			} else if (iNeigh.Name == "|" || iNeigh.Name == "L" || iNeigh.Name == "J") && iNeigh.Coordinates.y == myDp.Coordinates.y+1 {
				next.Coordinates.x = myDp.Coordinates.x
				next.Coordinates.y = myDp.Coordinates.y + 1
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			} else if (iNeigh.Name == "|" || iNeigh.Name == "7" || iNeigh.Name == "F") && iNeigh.Coordinates.y == myDp.Coordinates.y-1 {
				next.Coordinates.x = myDp.Coordinates.x
				next.Coordinates.y = myDp.Coordinates.y - 1
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			} else if (iNeigh.Name == "-" || iNeigh.Name == "J" || iNeigh.Name == "7") && iNeigh.Coordinates.x == myDp.Coordinates.x+1 {
				next.Coordinates.x = myDp.Coordinates.x + 1
				next.Coordinates.y = myDp.Coordinates.y
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			} else if (iNeigh.Name == "-" || iNeigh.Name == "L" || iNeigh.Name == "F") && iNeigh.Coordinates.x == myDp.Coordinates.x-1 {
				next.Coordinates.x = myDp.Coordinates.x - 1
				next.Coordinates.y = myDp.Coordinates.y
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			}
			possibleNextMove = append(possibleNextMove, next)
		}
	} else {
		return GetUniqueElements(possibleNextMove)
	}
	return GetUniqueElements(possibleNextMove)
}

func main() {
	data := GetInput("inputsmall2.txt")
	// fmt.Println(data)

	x, y := LocateStart(data)
	fmt.Println(x, y)

	// fmt.Println(len(data[0]), len(data))
	S := DataPoint{Coordinates: Pair{x: x, y: y}, Name: "S"}
	neighs := FindNeighbours(data, S)
	fmt.Println("neighs:", neighs) // [{{0 1} .} {{1 1} F} {{1 2} J} {{0 3} |} {{1 3} F}]

	next := GetNextLegalMove(data, S) // [{{111 30} F} {{112 31} 7}]
	fmt.Println("Next moves:", next)

	// dps := AddCoordsToData(data)
	// fmt.Println(dps)
}
