Board = {rows, columns, matrix}    --Room class
function Board:new(rows, columns)
  setmetatable({}, Room)
  self.rows = rows
  self.columns = columns
  self.matrix = matrix
  return self
end