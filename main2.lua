--math.randomseed(os.time())
require("Room")
roommax = 20
gameOver = false
wall_tile = "#"
floor_tile = "."
empty_tile = " "
room_list = {}
used_rooms = {}
board = {}
boardx = 50
boardy = 50
position_y = 0
position_x = 0

a1 = math.random(3,roommax)
a2 = math.random(3,roommax)
room1 = Room:new(a1, a2)
room1:insert_tiles("#", ".")
print(a)

room_list[0] = room1

b1 = math.random(3,roommax)
b2 = math.random(3,roommax)
room2 = Room:new(b1, b2)
room2:insert_tiles("#", ".")

room_list[1] = room2

c1 = math.random(3,roommax)
c2 = math.random(3,roommax)
room3 = Room:new(c1, c2)
room3:insert_tiles("#", ".")

room_list[2] = room3

function create_room(wall, floor, key)  --CLASS MODIFIED,     (rows, columns, positionx, positiony, matrix, edges)
  room_list[key] = Room:new(math.random(3,roommax), math.random(3,roommax))
  room_list[key]:insert_tiles(wall, floor)
end

function add_room(wall, floor, key)
  r_rows = room_list[key].rows
  r_columns = room_list[key].columns
  
  randomx = math.random(0, boardx - r_rows)  --rand int from 1 to boardlen for positioning
  randomy = math.random(0, boardy - r_columns)
  
  xlen = r_rows + randomx
  ylen = r_columns + randomy
  
  isEmpty = true
  for i = randomx, xlen do       --check for empty space on the board
    for j = randomy, ylen do
      if board[i][j] ~= " " then
        isEmpty = false
        break
      end
    end
  end
  if isEmpty then
    table.insert(used_rooms, room_list[key])
    for i = 0, r_rows do
      for j = 0, r_columns do
        board[randomx + i][randomy + j] = room_list[key].matrix[i][j]
      end
    end
    table.insert(used_rooms, room_list[key])
    print("empty space found, adding room")
    return used_rooms
  else
    print("isEmpty is false, removing room")
  end
end

function create_board(rows, columns, tile) --creates a (big) matrix filled with the a parameter
  for i = 0,rows do
    board[i]={}
    for j = 0,columns do
      board[i][j] = tostring(tile)
    end
  end
  return board
end


function random_connection(list)
  random1 = math.random(table.getn(list))
  random2 = math.random(table.getn(list))
  if random1 ~= random2 then
    list[random1]:add_edge(list[random2])
    list[random2]:add_edge(list[random1])
  else
    io.write("Cannot connect a room to itself",  "\n")
  end
end

function print_board(matrix, rows, columns)         --prints the current board
  --board[position_x][position_y] = "@"   -- player position
  for i = 0,rows do
    for j = 0,columns do
      io.write(matrix[i][j], " ")
    end
    io.write("\n")
  end
end

function player_start_position()
  placement = false
  while placement == false do   -- placement of player
    startx = math.random(0, boardx)
    starty = math.random(0, boardy)
    
    if board[startx][starty] == "." then
      position_x = startx
      position_y = starty
      placement = true
      print("placement found, placing player at", position_x, position_y)
    else
      print("placement not found")
    end
  end
end


function move_player(matrix, step)
  key_press = io.read()
  current_position = matrix[position_x][position_y]
  if key_press == "a" then
    matrix[position_x][position_y] = tostring(step)
    position_y = position_y -1
    
  elseif key_press == "d" then
    matrix[position_x][position_y] = tostring(step)
    position_y = position_y +1
      
  elseif key_press == "w" then
    matrix[position_x][position_y] = tostring(step)
    position_x = position_x -1
      
  elseif key_press == "s" then
    matrix[position_x][position_y] = tostring(step)
    position_x = position_x +1
  elseif key_press == "z" then
    gameOver = true
  else
    print("incorrect input: ", key_press, "\n")
  end
  return matrix[position_x][position_y]
end
 
function main()

  
  create_board(boardx, boardy, empty_tile)

  for i = 0, 50 do    --create and add rooms to the board
    create_room(wall_tile, floor_tile, i)
    --add_room(wall_tile, floor_tile, i)
    print_board(room_list[i].matrix, room_list[i].rows, room_list[i].columns)
    print(i)
  end
  for j = 0, table.getn(room_list) do
    print(room_list[j])
    print_board(room_list[j].matrix, room_list[j].rows, room_list[j].columns)
  end
  --while gameOver == false do
    --print_board(board, boardx, boardy)
    --move_player(board, floor_tile)
  --end
end
main()