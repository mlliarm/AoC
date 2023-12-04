def input_file(inputfile: str) -> dict:
    with open(inputfile) as f:
        res = dict()
        for i,line in enumerate(f):
            line = line.replace("\n", "")
            line = line.split(":")
            card = line[0]
            nums = line[1].split("|")
            win = nums[0].split(" ")
            win = list(filter(None, win))
            mynums = nums[1].split(" ")
            mynums = list(filter(None, mynums))
            res[card] = [win, mynums]
    return res

def points_per_card(card: list) -> int:
    win = card[0]
    mynums = card[1]
    points = 0
    matchNo = 0
    for wc in win:
        if wc in mynums and matchNo == 0:
            matchNo = 1
            points = 1
            continue
        elif wc in mynums:
            points *= 2
        else:
            continue
    return points

def result(deck: dict) -> int:
    res = 0
    keys = list(deck.keys())
    for key in keys:
        points = points_per_card(deck[key])
        print(points)
        res += points
    return res

def main():
    data = input_file("input.txt")
    print(data)
    keys = list(data.keys())
    print(keys)
    print(result(data))

if __name__ == "__main__":
    main()
