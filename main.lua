math.randomseed(os.time())
require("room")
roommax = 20
gameOver = false
room_list = {}

function create_room(wall, floor, key)  --CLASS MODIFIED,     (rows, columns, positionx, positiony, matrix, edges)
  room_list[key] = room:new(math.random(3,roommax), math.random(3,roommax))
  room_list[key]:insert_tiles(wall, floor)
  room_list[key]:set_center_position()
end

function add_room2(wall, floor, key)
  create_room(wall, floor, key)
  r_rows = room_list[key].rows
  r_columns = room_list[key].columns
  
  randomx = math.random(0, boardx - r_rows)  --rand int from 1 to boardlen
  randomy = math.random(0, boardy - r_columns)
  
  xlen = r_rows + randomx
  ylen = r_columns + randomy
  
  isEmpty = true
  for i = randomx, xlen do       --check for empty space on the board
    for j = randomy, ylen do -- somewhere on the board
      if board[i][j] ~= " " then
        isEmpty = false
        break
      end
    end
  end
  if isEmpty then
    for i = 0, r_rows do
      for j = 0, r_columns do
        board[randomx + i][randomy + j] = room_list[key].matrix[i][j]
      end
    end
  else
    print("isEmpty is false")
  end
end

function add_room(wall, floor)
  create_room()

  xlen = table.getn(matrix) --len of room 
  ylen = table.getn(matrix[0])
  
  randx = math.random(0, boardx - xlen)  --rand int from 1 to boardlen
  randy = math.random(0, boardy - ylen)
  
  xxlen = xlen + randx
  yylen = ylen + randy
  
  isEmpty = true
  for i = randx, xxlen do       --check for empty space on the board
    for j = randy, yylen do -- somewhere on the board
      if board[i][j] ~= " " then
        isEmpty = false
        break
      end
    end
  end
  if isEmpty then
    for i = 0, xlen do
      for j = 0, ylen do
        board[randx + i][randy + j] = matrix[i][j]
      end
    end
  else
    print("isEmpty is false")
  end
end

function create_board(rows, columns, a) --creates a (big) matrix filled with the a parameter
  for i = 0,rows do
    board[i]={}
    for j = 0,columns do
      board[i][j] = tostring(a)
    end
  end
  return board
end


function random_connections()
  random1 = math.random(0, table.getn(room_list))
  random2 = math.random(0, table.getn(room_list))
  if random1 ~= random2 then
    room_list[random1]:add_edge(room_list[random2])
    room_list[random2]:add_edge(room_list[random1])
  else
    io.write("Cannot connect a room to itself", " ")
  end
end

function update_board(board, rows, columns)         --prints the current board
  board[position_x][position_y] = "@"   -- player position
  for i = 0,rows do
    for j = 0,columns do
      io.write(board[i][j], " ")
    end
    io.write("\n")
  end
end

function player_start_position()
  startx = math.random(0, boardx)
  starty = math.random(0, boardy)
  
  if board[startx][starty] == "." then
    position_x = startx
    position_y = starty
    placement = true
    print("floor found, placing player at", position_x, position_y)
  else
    print("placement not found")
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
  board = {}
  boardx = 50
  boardy = 100
  position_y = 0
  position_x = 0
  --room_list = {}
  placement = false
  
  create_board(boardx, boardy, " ")
  for p = 0, 200 do
    add_room("#", ".")
  end
  
  while placement == false do   -- placement of player
    player_start_position()
  end
  
  while gameOver == false do
    update_board(board, boardx,boardy)
    move_player(board, ".")
  end
end

function main2()
  wall = "#"
  floor = "."
  board = {}
  boardx = 50
  boardy = 100
  position_y = 0
  position_x = 0
  placement = false
  create_board(boardx, boardy, " ")

  for i = 0, 50 do
    add_room2(wall, floor, i)
    --update_board(room_list[i].matrix, room_list[i].rows, room_list[i].columns)
  end
  for i = 0, table.getn(room_list) do
    random_connections()
  end
  
  while placement == false do   -- placement of player
    player_start_position()
  end
  while gameOver == false do
    update_board(board, boardx,boardy)
    move_player(board, ".")
  end
end
main2()