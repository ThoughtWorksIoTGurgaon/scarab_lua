-- Keeping uninitialized/default values of service_id and characteristic_count as -1

-- GLOBAL VARIABLES
SERVICE_ID_INDEX = 6 -- INDICES IN LUA START FROM 1
CHARACTERISTICS_COUNT_INDEX = 7 -- DO I NEED TO REPEAT, IT STARTS FROM 1
CHARACTERISTICS_BUFFER_START_INDEX = 8 -- TRY AND TEST YOURSELF. It's TRUE

-- Meta class
Read_Packet = { service_id = -1, characteristic_count = -1, characteristics_ids = {} }

-- Derived class method new

function Read_Packet:new(o, service_id, characteristic_count, characteristics_ids)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.service_id = service_id or -1
    self.characteristic_count = characteristic_count or -1
    self.characteristics_ids = characteristics_ids or {}
    return o
end

-- Derived class method parse_read		

function parse_read(binary_packet)

    service_id = binary_packet[SERVICE_ID_INDEX];
    characteristic_count = binary_packet[CHARACTERISTICS_COUNT_INDEX];
    characteristics_ids = {}

    for i = 1, characteristic_count do
        characteristics_ids[i] = binary_packet[CHARACTERISTICS_BUFFER_START_INDEX + i - 1]
    end

    return Read_Packet:new { service_id = service_id, characteristic_count = characteristic_count, characteristics_ids = characteristics_ids }
end