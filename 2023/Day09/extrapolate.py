from collections import OrderedDict
from typing import List, Dict, Tuple
from dataclasses import dataclass
from numpy import diff, array, ediff1d

def input_file(inputfile: str) -> dict:
    with open(inputfile) as f:
        res = dict()
        for i,line in enumerate(f):
            line = line.replace("\n", "")
            line = line.split(" ")
            line = [int(x) for x in line]
            res[i] = line
    return res

def get_new_sequences(l: List) -> int:
    tmpl = list()
    l = array(l)
    while set(l) != {0}:
        tmpl.append(l)
        l = diff(l)
    tmpl.append(array([0]*(len(l))))

    sum = 0
    for x in tmpl:
        sum += x[-1]
    return sum

def PartOneSolution(data: Dict) -> int:
    res = 0
    for k,v in enumerate(data):
        l = data[k]
        r = get_new_sequences(l)
        res += r
    return res

def main():
    data = input_file("input.txt")
    
    
    # Part One 
    print(PartOneSolution(data))

if __name__ == "__main__":
    main()
