math.randomseed(os.time())

matrix = {rows, columns} --matrix class
function matrix:new(rows, columns)
  setmetatable({}, matrix)
  self.rows = rows
  self.columns = columns
  return self
end

function matrix:getrows()
  return self.rows
end

function matrix:getcolumns()
  return self.columns
end

function matrix:getvalue()
  return self.value
end

--room = matrix:new() --room class, inherits from matrix
room = {rows, columns, positionx, positiony, matrix}    --Room class
function room:new(rows, columns, postionx, positiony)
  setmetatable({}, room)
  self.rows = rows
  self.columns = columns
  self.positionx = positionx
  self.positiony = positiony
  self.matrix = matrix
  return self
end

function room:getpositionx()
  return self.positionx
end

function room:getpositiony()
  return self.positiony
end

function room:insert_tiles()
  self.matrix = {}
    for i = 0,self.rows do                              
    self.matrix[i]={}
    for j = 0,self.columns do
      if i == 0 or j == 0 or i == self.rows or j == self.columns then
        self.matrix[i][j] = tostring("#")
      else
        self.matrix[i][j] = tostring(".")
      end
    end
  end
  return self.matrix
end

player = {positionx, positiony} --player class
function player:new(positionx, positiony)
  self.positionx = positionx
  self.positiony = positiony
  return self
end

function player:getpositionx()
  return self.positionx
end

function player:getpositiony()
  return self.positiony
end