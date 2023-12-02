def input_file(inputfile: str) -> dict:
    with open('input.txt') as f:
        res = list()
        for i,line in enumerate(f):
            j = i+1
            line = line.replace("\n", "")
            line = line.split(":")
            line = {int(line[0][5:]):line[1:][0].split(";")}
            line[j] = [l[1:] for l in line[j]]
            line[j] = {k:y for k,y in enumerate([x.split(", ") for x in line[j]])}
            res.append(line)
    return res


def lol(a: list) -> list:
    alist = list()
    for i in a.keys():
        for j in a[i]:
            alist.append(j.split(" "))
    return alist


def choose(color:str, alol:list) -> list:
    return [x for x in alol if x[1]==color]


def myfilt(alol:list) -> list:
    return max(alol, key=lambda x: int(x[0]))


def solution(data:dict) -> tuple:
    sum = 0
    sum2 = 0
    for i,x in enumerate(data):
        a = lol(data[i][i+1])
        R = myfilt(choose('red',a))
        G = myfilt(choose('green',a))
        B = myfilt(choose('blue',a))
        R,G,B = int(R[0]),int(G[0]),int(B[0])
        if R <= 12 and G <= 13 and B <= 14:
            sum += i+1
        sum2 += R*G*B
    return sum, sum2


def main():
    data = input_file("input.txt")
    print(solution(data))


if __name__ == "__main__":
    main()
