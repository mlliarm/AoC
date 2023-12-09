from collections import OrderedDict
from typing import List, Dict, Tuple
from dataclasses import dataclass

def input_file(inputfile: str) -> dict:
    with open(inputfile) as f:
        res = dict()
        for i,line in enumerate(f):
            line = line.replace("\n", "")
            line = line.split(" ")
            line = [int(x) for x in line]
            res[i] = line
    return res

def get_new_sequences(l: List) -> (List):
    tmpl = list()
    if set(l) != {0}:   
        for i,x in enumerate(l):
            if i < len(l)-1:
                tmp = l[i+1]
                tmpl.append(tmp-x)
                # print("tmp, tmp-x, tmpl: ", tmp, tmp-x,tmpl)
        l = l + [tmp+tmpl[-1]]
        print(l)
        return get_new_sequences(tmpl)
    else:
        tmpl.append(l)
        print(tmpl[0]+[0])
        # pass
    # return l
    

def main():
    data = input_file("inputsmall.txt")
    
    for k,v in enumerate(data):
        l = data[k]
        get_new_sequences(l)
        print(" ")

if __name__ == "__main__":
    main()
