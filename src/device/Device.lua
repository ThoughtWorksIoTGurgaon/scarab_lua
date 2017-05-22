Device = { ports = {} }

function Device:new(o, ports)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.ports = ports or {}
    return o
end

-- Get user given pin from the list of ports
-- Invoke callback function with pin and toggle
-- Update appropriate toggle state of port from the callback

function Device:write(pin, toggle, callback)

    for unused_port_index, port in pairs(self.ports) do
        if port.pin == pin then
            status = callback(pin, toggle)
            if toggle == status then
                port.toggle = toggle
                return true
            end
        end
    end
    return false
end

function Device:read(pin, callback)

    for unused_port_index, port in pairs(self.ports) do
        if port.pin == pin then
            if callback(pin) then
                return port.toggle
            end
        end
    end
    return false
end