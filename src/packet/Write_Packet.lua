-- Keeping uninitialized/default values of service_id and characteristic_count as -1
main = require('./src/packet/Characteristic')

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

    last_written_index = CHARACTERISTICS_COUNT_INDEX

    for index = 1, characteristic_count do
        last_written_index = last_written_index + 1
        id = binary_packet[last_written_index]
        last_written_index = last_written_index + 1
        size = binary_packet[last_written_index]
        data = {}

        for i = 1, size do
            last_written_index = last_written_index + 1
            data[i] = binary_packet[last_written_index]
        end
        characteristics[index] = Characteristic:new { id = id, size = size, data = data }
    end

    return Write_Packet:new { service_id = service_id, characteristic_count = characteristic_count, characteristics = characteristics }
end