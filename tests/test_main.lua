luaunit = require('./lib/luaunit/luaunit')
main = require('./src/packet/Read_Packet')

--function testAddPositive()
--    luaunit.assertEquals(add(1,1),2)
--    print("testAddPositive passed")
--end
--
--function testAddZero()
--    luaunit.assertEquals(add(1,0),0)
--    luaunit.assertEquals(add(0,5),0)
--    luaunit.assertEquals(add(0,0),0)
--    print("testAddZero passed")
--end
--
--testAddPositive()
--testAddZero()

function should_read_packet_for_one_service_and_zero_characteristic()
  binary_packet = {1,3,1,1,1,1,0}
  read_packet = parse_read(binary_packet)
  luaunit.assertEquals(read_packet.service_id,0)
  luaunit.assertEquals(read_packet.characteristic_count,0)
  print("should_read_packet_for_one_service_and_zero_characteristic passed")
end
   
should_read_packet_for_one_service_and_zero_characteristic()