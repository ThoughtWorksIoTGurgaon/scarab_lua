Device = { ports = {} }

function Device:new(o, ports)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.ports = ports or {}
    return o
end