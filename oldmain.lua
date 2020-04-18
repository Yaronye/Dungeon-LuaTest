math.randomseed(os.time())
gameOver = false

function create_room(matrix, wall, floor)
  --matrix = {}
  rows = math.random(3,20)
  columns = math.random(3,20)
  for i = 0,rows do                              
    matrix[i]={}
    for j = 0,columns do
      if i == 0 or j == 0 or i == rows or j == columns then
        matrix[i][j] = tostring(wall)
      else
        matrix[i][j] = tostring(floor)
      end
    end
  end
  return matrix
  --table.insert(room_list, matrix)
end

function add_room(wall, floor)
  matrix = {}
  create_room(matrix, wall, floor)

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
    print("Room added! nr of rooms %d", roomNR)
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

function update_board(board, rows, columns)         --updates and prints the board
  board[position_x][position_y] = "@"
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
  for p = 0, 30 do
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

main()