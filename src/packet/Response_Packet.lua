main = require('./src/packet/Characteristic')
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


-- GLOBAL VARIABLES
BINARY_PACKET_HEADER_BYTE_SIZE = 7

-- Meta class
Response_Packet = { service_id = -1, characteristic_count = -1, characteristics = {} }

-- Derived class method new
function Response_Packet:new(o, service_id, characteristic_count)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.service_id = service_id or -1
    self.characteristic_count = characteristic_count or -1
    return o
end

function stringify_response(response_packet)
    characteristics_size = 0

    for index = 1, response_packet.characteristic_count do
        characteristics_size = characteristics_size + response_packet.characteristic[index].size
    end

    binary_packet = {}

    binary_packet[1] = 1; --Version
    binary_packet[2] = 4; --ResponsePacketType
    binary_packet[3] = 1; --Unused Header Byte
    binary_packet[4] = 1; --Unused Header Byte
    binary_packet[5] = 1; --Unused Header Byte
    binary_packet[6] = response_packet.service_id + 1;
    binary_packet[7] = response_packet.characteristic_count;

    return binary_packet
end
