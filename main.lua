math.randomseed(os.time())
gameOver = false

function create_room(wall, floor)
  matrix = {}
  rows = math.random(3,6)
  columns = math.random(3,6)
  for i = 1,rows do                              
    matrix[i]={}
    for j = 1,columns do
      if i == 1 or j == 1 or i == rows or j == columns then
        matrix[i][j] = tostring(wall)
      else
        matrix[i][j] = tostring(floor)
      end
    end
  end
  return matrix
end

function create_board(rows, columns, a) --creates a (big) matrix filled with the a parameter
  for i = 1,rows do
    board[i]={}
    for j = 1,columns do
      board[i][j] = tostring(a)
    end
  end
  return board
end

function update_board(rows, columns)         --updates and prints the board
  board[position_x][position_y] = "@"
  for i = 1,rows do
    for j = 1,columns do
      io.write(board[i][j], " ")
    end
    io.write("\n")
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
  position_y = 2
  position_x = 2
  
  create_board(boardx, boardy, " ")
  
  while gameOver == false do
    update_board(boardx,boardy)
    move_player(board, ".")
  end
end

main()

