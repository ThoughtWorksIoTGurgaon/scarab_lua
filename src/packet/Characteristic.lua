-- Keeping uninitialized/default values of id and size as -1

-- Meta class
Characteristic = { id = -1, size = -1, data = {} }

-- Derived class method new

function Characteristic:new(o, id, size, data)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.id = id or -1
    self.size = size or -1
    self.data = data or {}
    return o
end

