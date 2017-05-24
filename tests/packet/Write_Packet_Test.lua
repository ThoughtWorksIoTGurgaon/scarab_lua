require('./src/packet/Write_Packet')
require('./lib/luacolor/color')
luaunit = require('./lib/luaunit/luaunit')
print(CYAN .. "WRITE_PACKET TESTS")

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
    print(GREEN .. "should_parse_write_packet_for_one_service_and_zero_characteristic passed" .. RED)
end

should_parse_write_packet_for_one_service_and_zero_characteristic()

function should_parse_write_packet_for_one_service_and_one_characteristic()
    expected_characteristic_data = { 1 }
    expected_characteristic = Characteristic:new { id = 1, size = 1, data = expected_characteristic_data }
    expected_characteristic_array = { expected_characteristic }

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

    for i = 1, write_packet.characteristic_count do
        luaunit.assertEquals(write_packet.characteristics[i], expected_characteristic_array[i])
    end

    print(GREEN .. "should_parse_write_packet_for_one_service_and_one_characteristic passed" .. RED)
end

should_parse_write_packet_for_one_service_and_one_characteristic()

function should_parse_write_packet_for_one_service_and_two_characteristics()
    expected_characteristic_data = { 1 }
    expected_characteristic_1 = Characteristic:new { id = 1, size = 1, data = expected_characteristic_data }
    expected_characteristic_2 = Characteristic:new { id = 2, size = 1, data = expected_characteristic_data }
    expected_characteristic_array = { expected_characteristic_1, expected_characteristic_2 }

    binary_packet = {
        1, 3, 1, 1, 1, --header
        1, --service_id
        2, --characteristic_count
        1, 1, 1, --Characteristic id,size,data
        2, 1, 1,
        0 -- Ending string
    }

    write_packet = parse_write(binary_packet)

    luaunit.assertEquals(write_packet.service_id, 1)
    luaunit.assertEquals(write_packet.characteristic_count, 2)

    for i = 1, write_packet.characteristic_count do
        luaunit.assertEquals(write_packet.characteristics[i], expected_characteristic_array[i])
    end

    print(GREEN .. "should_parse_write_packet_for_one_service_and_two_characteristics passed" .. RED)
end

should_parse_write_packet_for_one_service_and_two_characteristics()