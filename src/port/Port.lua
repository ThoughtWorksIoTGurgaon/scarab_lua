ON = 1
OFF = 2

Port = { pin = -1, toggle = -1 }

function Port:new(o, pin, toggle)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.pin = pin or -1
    self.toggle = toggle or OFF
    return o
end

function Port:write(status)
    self.toggle = status
end