Room = {rows, columns, positionx, positiony, matrix, edges, cell}    --Room class
function Room:new(rows, columns)
  local self = setmetatable({}, Room)
  self.rows = rows
  self.columns = columns
  self.positionx = 0
  self.positiony = 0
  self.matrix = matrix -- change to {} if using rooms own insert tiles function
  return self
end

-- UNUSED INSERT TILES FUNCTION, had to be recreated in main file
--function Room:insert_tiles(wall, floor)
--    for i = 0, self.rows do                              
--    self.matrix[i]={}
--    for j = 0,self.columns do
--      if i == 0 or j == 0 or i == self.rows or j == self.columns then
--        self.matrix[i][j] = tostring(wall)
--      else
--        self.matrix[i][j] = tostring(floor)
--      end
--    end
--  end
--end

return Room, self