main = require('./src/packet/Characteristic')

-- GLOBAL VARIABLES
BINARY_PACKET_HEADER_BYTE_SIZE = 7

-- Meta class
Response_Packet = { service_id = -1, characteristic_count = -1, characteristics = {} }

-- Derived class method new
function Response_Packet:new(o, service_id, characteristic_count, characteristics)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.service_id = service_id or -1
    self.characteristic_count = characteristic_count or -1
    self.characteristics = characteristics or {}
    return o
end

function stringify_response(response_packet)
    characteristics_size = 0

    for index = 1, response_packet.characteristic_count do
        characteristics_size = characteristics_size + response_packet.characteristics[index].size
    end

    binary_packet = {}

    binary_packet[1] = 1; --Version
    binary_packet[2] = 4; --ResponsePacketType
    binary_packet[3] = 1; --Unused Header Byte
    binary_packet[4] = 1; --Unused Header Byte
    binary_packet[5] = 1; --Unused Header Byte
    binary_packet[6] = response_packet.service_id + 1;
    binary_packet[7] = response_packet.characteristic_count;

    last_written_index = BINARY_PACKET_HEADER_BYTE_SIZE;

    for index = 1, response_packet.characteristic_count do
        last_written_index = last_written_index + 1
        binary_packet[last_written_index] = response_packet.characteristics[index].id
        last_written_index = last_written_index + 1
        binary_packet[last_written_index] = response_packet.characteristics[index].size

        for characteristic_index = 1, response_packet.characteristics[index].size do
            last_written_index = last_written_index + 1
            binary_packet[last_written_index] = response_packet.characteristics[index].data[characteristic_index]
        end
    end

    if response_packet.characteristic_count > 0 then
        last_written_index = last_written_index + 1
        binary_packet[last_written_index] = 0
    end

    return binary_packet
end
