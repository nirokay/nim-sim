import random
randomize()

# Variables:
const
    dice*: array[7, int] = [4, 6, 8, 10, 12, 20, 100]
    alldice*: string = $dice

# Die Roll Operations:
proc throwDie*(times, die: Natural): seq[int] =
    var r: seq[int]
    for i in 1..(times):
        r.add(rand(die-1)+1)
    
    return r

proc throw100*(times, die: Natural): seq[int] =
    var r = throwDie(times, 10)
    for i, v in r:
        r[i] = v*10
    
    return r
