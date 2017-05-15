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
