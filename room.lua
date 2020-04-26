Room = {rows, columns, positionx, positiony, matrix, edges}    --Room class
function Room:new(rows, columns)
  local self = setmetatable({}, Room)
  self.rows = rows
  self.columns = columns
  self.positionx = 0
  self.positiony = 0
  self.matrix = matrix
  self.edges = edges
  return self
end

function Room:getpositionx()
  return self.positionx
end

function Room:getpositiony()
  return self.positiony
end

function Room:insert_tiles(wall, floor)
  self.matrix = {}
    for i = 0,self.rows do                              
    self.matrix[i]={}
    for j = 0,self.columns do
      if i == 0 or j == 0 or i == self.rows or j == self.columns then
        self.matrix[i][j] = tostring(wall)
      else
        self.matrix[i][j] = tostring(floor)
      end
    end
  end
  return self.matrix
end

function Room:add_edge(node)
  self.edges = {}
  table.insert(self.edges, node)
end

function Room:set_center_position()
  self.positionx = math.floor(self.rows/2)
  self.positiony = math.floor(self.columns/2)
end

player = {positionx, positiony} --player class
function player:new(positionx, positiony)
  self.positionx = positionx
  self.positiony = positiony
  io.write(self.positionx, " positions ", self.positiony)
  return self.positionx, self.positiony
end

return Room