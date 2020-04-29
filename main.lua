math.randomseed(os.time())
require("Room")
door_listx = {}
door_listy = {}

function create_room(wall, floor, key)  --CLASS MODIFIED,     (rows, columns, positionx, positiony, matrix, edges)
  room_list[key] = Room:new(math.random(4,roommax), math.random(4,roommax))
  --room_list[key]:insert_tiles(wall, floor)
  set_tiles(wall, floor, key)
end

function set_tiles(wall, floor, key)
  room = room_list[key]
  room.matrix = {}
  for i = 0, room.rows do                              
    room.matrix[i] = {}
    for j = 0,room.columns do
      if i == 0 or j == 0 or i == room.rows or j == room.columns then
        room.matrix[i][j] = tostring(wall)
      else
        room.matrix[i][j] = tostring(floor)
      end
    end
  end
end

function add_room(wall, floor, key)
  r_rows = room_list[key].rows
  r_columns = room_list[key].columns
  
  randomx = math.random(0, boardx - r_rows) --rand int from 0 to boardlen for positioning
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
    for i = 0, r_rows do
      for j = 0, r_columns do
        board[randomx + i][randomy + j] = room_list[key].matrix[i][j]
      end
    end
    print("empty space found, adding room")
    room_list[key].positionx = randomx  --set startposition for the room
    room_list[key].positiony = randomy
    table.insert(used_rooms, room_list[key])  --add the room to used_room list
    print_board(room_list[key].matrix, room_list[key].rows, room_list[key].columns)
    
  else
    print("isEmpty is false, removing room")
  end
end

function set_cells(key)
  posx = used_rooms[key].positionx
  posy = used_rooms[key].positiony
  
  xlen = boardx/2
  ylen = boardy/2
  
  if posx <= xlen and posy <= ylen then 
    used_rooms[key].cell = 0 --"upper left"
  elseif posx <= xlen and posy > ylen then
    used_rooms[key].cell = 1 --"upper right"
  elseif posx > xlen and posy > ylen then
    used_rooms[key].cell = 3 --"lower right"
  elseif posx > xlen and posy <= ylen then
    used_rooms[key].cell = 2 --"lower left"
  end
end

function find_direction(x, y, wall, floor, empty, border)
  --print("x:", x, "y:", y)
  local up = board[x - 1][y]
  local down = board[x + 1][y]
  local left = board[x][y - 1]
  local right = board[x][y + 1]
  
  if up == floor then
    direction = "down"
  elseif up == empty or up == border then
    direction = "up"
  elseif left == floor then
    direction = "right"
  elseif left == empty  or left == border then
    direction = "left"
  end
end

function hallways(key, wall, floor, door, empty, border)
    x = door_listx[key]
    y = door_listy[key]
    direction = "empty"
    find_direction(x, y, wall, floor, empty, border)
  if direction == "right" and board[x][y] == door then
    while board[x][y + 1] == empty and board[x][y] ~= boardy do   -- need to add and x not in door_listx
      board[x][y] = floor
      board[x - 1][y] = wall
      board[x + 1][y] = wall
      board[x][y] = floor
      y = y + 1
    end
    if board[x][y + 1] == border then
      board[x + 1][y] = wall
      board[x - 1][y] = wall
      board[x][y] = wall
    elseif board[x][y + 1] == wall then
      board[x + 1][y] = wall
      board[x - 1][y] = wall
      board[x][y] = floor
      board[x][y + 1] = floor
      board[x + 1][y + 1] = wall
      board[x - 1][y + 1] = wall
    end
  elseif direction == "left" and board[x][y] == door then
    while board[x][y - 1] == empty and board[x][y] ~= boardy do   -- need to add "and x not in door_listx"
      board[x][y] = floor
      board[x - 1][y] = wall
      board[x + 1][y] = wall
      board[x][y] = floor
      y = y - 1
    end
    if board[x][y - 1] == border then
      board[x + 1][y] = wall
      board[x - 1][y] = wall
      board[x][y] = wall
    elseif board[x][y - 1] == wall then
      board[x + 1][y] = wall
      board[x - 1][y] = wall
      board[x][y] = floor
      board[x][y - 1] = floor
      board[x + 1][y - 1] = wall
      board[x - 1][y - 1] = wall
    end
  elseif direction == "up" and board[x][y] == door then
    while board[x - 1][y] == empty and board[x][y] ~= boardy do   -- need to add "and x not in door_listx"
      board[x][y] = floor
      board[x][y - 1] = wall
      board[x][y + 1] = wall
      board[x][y] = floor
      x = x - 1
    end
    if board[x - 1][y] == border then
      board[x][y + 1] = wall
      board[x][y - 1] = wall
      board[x][y] = wall
    elseif board[x - 1][y] == wall then
      board[x][y + 1] = wall
      board[x][y - 1] = wall
      board[x][y] = floor
      board[x - 1][y] = floor
      board[x - 1][y + 1] = wall
      board[x - 1][y - 1] = wall
    end
    
  elseif direction == "down" and board[x][y] then
    while board[x + 1][y] == empty and board[x][y] ~= boardy do   -- need to add "and x not in door_listx"
      board[x][y] = floor
      board[x][y - 1] = wall
      board[x][y + 1] = wall
      board[x][y] = floor
      x = x + 1
    end
    if board[x + 1][y] == border then
      board[x][y + 1] = wall
      board[x][y - 1] = wall
      board[x][y] = wall
    elseif board[x + 1][y] == wall then
      board[x][y + 1] = wall
      board[x][y - 1] = wall
      board[x][y] = floor
      board[x  + 1][y] = floor
      board[x + 1][y + 1] = wall
      board[x + 1][y - 1] = wall
    end
  end
end

function add_opening(key, door)
  x = 0
  y = 0
  --either i = 0 or = rows  OR j = 0 or = columns
  --cell = used_rooms[key].cell
  choice = math.random(0, 3)  -- decides thich wall to place a door at
  
  if (choice == 0 or choice == 1) then
    --rowORcell = math.random(0, 1)
    choice2 = math.random(1, used_rooms[key].columns -1) -- 1 and -1 so doors are not places on an edge of a room
    if choice == 0 then
      x = used_rooms[key].positionx
      y = used_rooms[key].positiony + choice2 
    elseif choice == 1 then
      max = used_rooms[key].rows
      x = used_rooms[key].positionx + max
      y = used_rooms[key].positiony + choice2 
    end
  elseif (choice == 2 or choice == 3) then
    choice2 = math.random(1, used_rooms[key].rows -1)
    if choice == 2 then
      x = used_rooms[key].positionx + choice2
      y = used_rooms[key].positiony
    elseif choice == 3 then
      max = used_rooms[key].columns
      x = used_rooms[key].positionx + choice2
      y = used_rooms[key].positiony + max
    end
  end
  --check so no double doors are created
  if(board[x - 1][y] ~= door and board[x + 1][y] ~= door and board[x][y - 1] ~= door and board[x][y + 1] ~= door) then
    board[x][y] = door  -- add door tile to board
    table.insert(door_listx, x)
    table.insert(door_listy, y)
  end
end

function create_board(rows, columns, tile, border) --creates a (big) matrix filled with the tile parameter
  for i = 0,rows do
    board[i]={}
    for j = 0,columns do
      if i == 0 or j == 0 or i == boardx or j == boardy then
        board[i][j] = tostring(border)
      else
        board[i][j] = tostring(tile)
      end
    end
  end
  return board
end


function random_connection(list)
  random1 = math.random(#list)
  random2 = math.random(#list)
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
  roommax = 30
  gameOver = false
  wall_tile = "#"
  floor_tile = "."
  empty_tile = " "
  door_tile = "D"
  border_tile = "  "
  room_list = {}
  used_rooms = {}
  board = {}
  boardx = 51
  boardy = 51
  position_y = 0
  position_x = 0
  
  create_board(boardx, boardy, empty_tile, border_tile)
  for i = 0, 100 do    --create and add rooms to the board
    create_room(wall_tile, floor_tile, i)
    add_room(wall_tile, floor_tile, i)
    --print_board(room_list[i].matrix, room_list[i].rows, room_list[i].columns)
    --print(i)
  end
  for i = 1, #used_rooms do --used_rooms is 1-indexed
    --print(used_rooms[i])
    --print_board(used_rooms[i].matrix, used_rooms[i].rows, used_rooms[i].columns)
    --FUNCTIONS
    --initialize_door_position(i)
    --set_cells(i)
    nr_of_doors = math.random(0, 6)
    for j = 0, nr_of_doors do
      add_opening(i, door_tile)
    end
  end
  --print_board(board, boardx, boardy)
  
  for i = 1, #door_listx do 
    hallways(i, wall_tile, floor_tile, door_tile, empty_tile, border_tile)
  end
  
  --while gameOver == false do
    print_board(board, boardx, boardy)
    --move_player(board, floor_tile)
  --end
end


main()