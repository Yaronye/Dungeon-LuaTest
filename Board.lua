Board = {rows, columns, matrix}    --Room class
function Board:new(rows, columns)
  setmetatable({}, Room)
  self.rows = rows
  self.columns = columns
  self.matrix = matrix
  return self
end

function Board:create_board(rows, columns)
  for i = 0,rows do
    board[i]={}
    for j = 0,columns do
      board[i][j] = tostring(a)
    end
  end
  return board
end