from typing import List, Dict
from numpy import diff, array

def input_file(inputfile: str) -> dict:
    with open(inputfile) as f:
        res = dict()
        for i,line in enumerate(f):
            line = line.replace("\n", "")
            line = line.split(" ")
            line = [int(x) for x in line]
            res[i] = line
    return res

def get_new_sequences(l: List) -> (int,int):
    tmpl = list()
    l = array(l)
    while set(l) != {0}:
        tmpl.append(l)
        l = diff(l)
    tmpl.append(array([0]*(len(l))))

    sum=0
    for x in tmpl:
        sum += x[-1]
    return sum

def get_new_sequences2(l: List) -> int:
    tmpl = list()
    l = array(l)
    while set(l) != {0}:
        tmpl.insert(0,list(l))
        l = diff(l)
    tmpl.insert(0,array([0]*(len(l)+1)))
    
    sum = 0
    tmpl2 = list()
    for i,x in enumerate(tmpl):
        if i < len(tmpl)-1:
            tmpl2 = extrapolate_back(tmpl[i+1],list(x))
            sum -= x[0] - tmpl2[0]
    return sum

def extrapolate_back(l1: List, l2: List) -> List:
    l1.insert(0, -l2[0]+l1[0])
    return l1

def part_one_solution(data: Dict) -> int:
    res = 0
    for k,_ in enumerate(data):
        l = data[k]
        r = get_new_sequences(l)
        res += r
    return res

def part_two_solution(data: Dict) -> int:
    res = 0
    for k,_ in enumerate(data):
        l = data[k]
        r2 = get_new_sequences2(l)
        res += r2
    return res

def main():
    data = input_file("input.txt")
    
    # Part One 
    print(part_one_solution(data))
    
    # Part Two
    print(part_two_solution(data))

if __name__ == "__main__":
    main()
