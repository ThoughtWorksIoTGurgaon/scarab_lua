-- Keeping uninitialized/default values of service_id and characteristic_count as -1
-- GLOBAL VARIABLES
SERVICE_ID_INDEX = 6 -- INDICES IN LUA START FROM 1
CHARACTERISTICS_COUNT_INDEX = 7 -- DO I NEED TO REPEAT, IT STARTS FROM 1

-- Meta class
Write_Packet = { service_id = -1, characteristic_count = -1, characteristics = {} }

-- Derived class method new
function Write_Packet:new(o, service_id, characteristic_count, characteristics)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.service_id = service_id or -1
    self.characteristic_count = characteristic_count or -1
    self.characteristics = characteristics or {}
    return o
end

-- Derived class method parse_write

function parse_write(binary_packet)
    service_id = binary_packet[SERVICE_ID_INDEX];
    characteristic_count = binary_packet[CHARACTERISTICS_COUNT_INDEX];
    characteristics = {}
    return Write_Packet:new { service_id = service_id, characteristic_count = characteristic_count, characteristics = characteristics }
end