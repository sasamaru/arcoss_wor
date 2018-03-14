PlayerInfoA = {1 => { attack: 32, defense: 3},
               2 => { attack: 11, defense: 4},
               3 => { attack: 21, defense: 1},
               4 => { attack: 48, defense: 5},
               5 => { attack: 21, defense: 12},
               6 => { attack: 15, defense: 2},
               7 => { attack: 51, defense: 5},
               8 => { attack: 13, defense: 6},
               9 => { attack: 11, defense: 66}}

PlayerInfoB = {1 => { attack: 30, defense: 1},
               2 => { attack: 101, defense: 2},
               3 => { attack: 40, defense: 3},
               4 => { attack: 120, defense: 4},
               5 => { attack: 100, defense: 5},
               6 => { attack: 55, defense: 6},
               7 => { attack: 71, defense: 7},
               8 => { attack: 51, defense: 8},
               9 => { attack: 31, defense: 9}}

INNINGS = 5

###############

points = { "A"=>0, "B"=>0}
now_player = { "A"=>1, "B"=>1}
hit_mater = { "A"=>0, "B"=>0}
defences = { "A"=>104, "B"=>45}
runners = { "A"=>[], "B"=>[]}

# return get point
def hit(base, runners)
  point = 0
  runners.each_with_index do |runner, i|
    runners[i] += base
    point += 1 if runners[i]>=4
  end
  if base==4
    point += 1
  else
    runners.push(base)
  end
  point.times{runners.shift}
  print(base.to_s+"ベースhit "+point.to_s+"得点 \n\r")
  return point
end

INNINGS.times do |inning|
  # Ateam
  out = 0
  print("\n\r")
  print (inning+1).to_s + "回表"
  while out<2
    hit_mater["A"] += PlayerInfoA[now_player["A"]][:attack]
    if hit_mater["A"]>defences["B"]
      hit_mater["A"]-=defences["B"]
      base = hit_mater["A"]%4+1
      points["A"] += hit(base, runners["A"])
    else
      out+=1
    end
    now_player["A"] = now_player["A"]==9 ? 1 : now_player["A"]+1
  end
  runners["A"]=[]
  # Bteam
  out = 0
  print("\n\r")
  print (inning+1).to_s + "回裏"
  while out<2
    hit_mater["B"] += PlayerInfoB[now_player["B"]][:attack]
    if hit_mater["B"]>defences["A"]
      hit_mater["B"]-=defences["A"]
      # ranner処理
      base = hit_mater["B"]%4+1
      points["B"] += hit(base, runners["B"])
    else
      out+=1
    end
    now_player["B"] = now_player["B"]==9 ? 1 : now_player["B"]+1
  end
  runners["B"]=[]
end

print points