-- Keeping uninitialized/default values of service_id and characteristic_count as -1

-- GLOBAL VARIABLES
SERVICE_ID_INDEX = 5+1
CHARACTERISTICS_COUNT_INDEX = 6+1
CHARACTERISTICS_BUFFER_START_INDEX = 7+1

-- Meta class
Read_Packet = {service_id = -1, characteristic_count = -1, characteristics_ids = {}}

-- Derived class method new

function Read_Packet:new (o,service_id,characteristic_count, characteristics_ids)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   self.service_id = service_id or -1	
   self.characteristic_count = characteristic_count or -1
   self.characteristics_ids = characteristics_ids or {}
   return o
end

-- Derived class method parse_read		

function parse_read (binary_packet)
  
  service_id = binary_packet[SERVICE_ID_INDEX]-1;
  characteristic_count = binary_packet[CHARACTERISTICS_COUNT_INDEX];
  characteristic_ids = binary_packet[CHARACTERISTICS_BUFFER_START_INDEX];

  return Read_Packet:new{service_id=service_id, characteristic_count=characteristic_count, characteristic_ids=characteristic_ids}
end



