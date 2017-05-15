luaunit = require('./lib/luaunit/luaunit')
main = require('./src/packet/Write_Packet')

function should_parse_write_packet_for_one_service_and_zero_characteristic()
    binary_packet = {
        1, 3, 1, 1, 1, --header
        1, --service_id
        0 --char_count
    }

    write_packet = parse_write(binary_packet)
    luaunit.assertEquals(write_packet.service_id, 1)
    luaunit.assertEquals(write_packet.characteristic_count, 0)
    luaunit.assertEquals(write_packet.characteristics, {})
    print("should_parse_write_packet_for_one_service_and_zero_characteristic passed")
end
should_parse_write_packet_for_one_service_and_zero_characteristic()

function should_parse_write_packet_for_one_service_and_one_characteristic()
    binary_packet = {
        1, 3, 1, 1, 1, --header
        1, --service_id
        1, --char_count
        1, 1, 1, --Characteristic id,size,data
        0 -- Ending string
    }

    write_packet = parse_write(binary_packet)
    luaunit.assertEquals(write_packet.service_id, 1)
    luaunit.assertEquals(write_packet.characteristic_count, 1)

    characteristic_data = { 1 }
    characteristic = Characteristic:new { id = 1, size = 1, data = characteristic_data }
    characteristic_array = { characteristic }

    write_packet = Write_Packet:new { service_id = 0, characteristic_count = 1, characteristics = characteristic_array }

    for i = 1, write_packet.characteristic_count do
        luaunit.assertEquals(write_packet.characteristics[i], characteristic_array[i])
    end

    print("should_parse_write_packet_for_one_service_and_one_characteristic passed")
end
should_parse_write_packet_for_one_service_and_one_characteristic()