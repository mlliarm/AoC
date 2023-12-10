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

// Convention: degrees start to coun
// from Ox' axis, counterclockwise
var pipes = map[string]Pipe{
	"|": {Name: "|", DegreesOfBend: 180, Connecting: "NS"},
	"-": {Name: "-", DegreesOfBend: 180, Connecting: "EW"},
	"L": {Name: "L", DegreesOfBend: 90, Connecting: "NE"},
	"J": {Name: "J", DegreesOfBend: 90, Connecting: "NW"},
	"7": {Name: "7", DegreesOfBend: 90, Connecting: "SW"},
	"F": {Name: "F", DegreesOfBend: 90, Connecting: "SE"},
	".": {Name: ".", DegreesOfBend: 0, Connecting: ""},
	"S": {Name: "S", DegreesOfBend: 1, Connecting: "?"},
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

func GetNext(data []string, myDp DataPoint) DataPoint {
	initNeighs := FindNeighbours(data, myDp)
	next := DataPoint{Name: " "}
	for next.Name != "S" {
		for _, iNeigh := range initNeighs {
			if iNeigh.Name == "." {
				continue
			} else if iNeigh.Name == "|" && iNeigh.Coordinates.y == myDp.Coordinates.y-1 {
				next.Coordinates.x = myDp.Coordinates.x
				next.Coordinates.y = myDp.Coordinates.y - 1
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			} else if iNeigh.Name == "|" && iNeigh.Coordinates.y == myDp.Coordinates.y+1 {
				next.Coordinates.x = myDp.Coordinates.x
				next.Coordinates.y = myDp.Coordinates.y + 1
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			} else if iNeigh.Name == "-" && iNeigh.Coordinates.x == myDp.Coordinates.x+1 {
				next.Coordinates.x = myDp.Coordinates.x + 1
				next.Coordinates.y = myDp.Coordinates.y
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			} else if iNeigh.Name == "-" && iNeigh.Coordinates.x == myDp.Coordinates.x-1 {
				next.Coordinates.x = myDp.Coordinates.x - 1
				next.Coordinates.y = myDp.Coordinates.y
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			} else if iNeigh.Name == "L" && iNeigh.Coordinates.x == myDp.Coordinates.x-1 {
				next.Coordinates.x = myDp.Coordinates.x - 1
				next.Coordinates.y = myDp.Coordinates.y
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			} else if iNeigh.Name == "L" && iNeigh.Coordinates.y == myDp.Coordinates.y-1 {
				next.Coordinates.x = myDp.Coordinates.x
				next.Coordinates.y = myDp.Coordinates.y - 1
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			} else if iNeigh.Name == "J" && iNeigh.Coordinates.y == myDp.Coordinates.y-1 {
				next.Coordinates.x = myDp.Coordinates.x
				next.Coordinates.y = myDp.Coordinates.y - 1
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			} else if iNeigh.Name == "J" && iNeigh.Coordinates.x == myDp.Coordinates.x+1 {
				next.Coordinates.x = myDp.Coordinates.x + 1
				next.Coordinates.y = myDp.Coordinates.y
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			} else if iNeigh.Name == "7" && iNeigh.Coordinates.x == myDp.Coordinates.x+1 {
				next.Coordinates.x = myDp.Coordinates.x + 1
				next.Coordinates.y = myDp.Coordinates.y
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			} else if iNeigh.Name == "7" && iNeigh.Coordinates.y == myDp.Coordinates.y+1 {
				next.Coordinates.x = myDp.Coordinates.x
				next.Coordinates.y = myDp.Coordinates.y + 1
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			} else if iNeigh.Name == "F" && iNeigh.Coordinates.y == myDp.Coordinates.y+1 {
				next.Coordinates.x = myDp.Coordinates.x
				next.Coordinates.y = myDp.Coordinates.y + 1
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			} else if iNeigh.Name == "F" && iNeigh.Coordinates.x == myDp.Coordinates.x-1 {
				next.Coordinates.x = myDp.Coordinates.x - 1
				next.Coordinates.y = myDp.Coordinates.y
				next.Name = string(data[next.Coordinates.y][next.Coordinates.x])
			}
		}
	}
	return next
}

func GetLargestDistance() {
	panic("tmp")
}

func main() {
	data := GetInput("inputsmall2.txt")
	fmt.Println(data)

	x, y := LocateStart(data)
	// fmt.Println(x, y)

	// fmt.Println(len(data[0]), len(data))
	S := DataPoint{Coordinates: Pair{x: x, y: y}, Name: "S"}
	InitCoords := FindNeighbours(data, S)
	fmt.Println(InitCoords) // [{{0 1} .} {{1 1} F} {{1 2} J} {{0 3} |} {{1 3} F}]

	next := GetNext(data, S)
	fmt.Println(next)

	dps := AddCoordsToData(data)
	fmt.Println(dps)
}
