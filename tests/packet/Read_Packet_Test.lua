luaunit = require('./lib/luaunit/luaunit')
main = require('./src/packet/Read_Packet')

function should_read_packet_for_one_service_and_zero_characteristic()
    binary_packet = {
        1, 3, 1, 1, 1, --header
        1, --service_id
        0 --char_count
    }
    read_packet = parse_read(binary_packet)
    luaunit.assertEquals(read_packet.service_id, 1)
    luaunit.assertEquals(read_packet.characteristic_count, 0)
    print("should_read_packet_for_one_service_and_zero_characteristic passed")
end
should_read_packet_for_one_service_and_zero_characteristic()

function should_read_packet_for_one_service_and_one_characteristic()
    binary_packet = {
        1, 3, 1, 1, 1, --header
        1, --service_id
        1, 1 --char_count,char_id
    }

    read_packet = parse_read(binary_packet)
    luaunit.assertEquals(read_packet.service_id, 1)
    luaunit.assertEquals(read_packet.characteristic_count, 1)

    characteristics_ids = { 1 };

    for i = 1, read_packet.characteristic_count do
        luaunit.assertEquals(read_packet.characteristics_ids[i], characteristics_ids[i])
    end

    print("should_read_packet_for_one_service_and_one_characteristic passed")
end
should_read_packet_for_one_service_and_one_characteristic()

function should_read_packet_for_one_service_and_two_characteristics()
    binary_packet = {
        1, 3, 1, 1, 1, --header
        4, --service_id
        2, 2, 1 --char_count,char_ids...
    }

    read_packet = parse_read(binary_packet)
    luaunit.assertEquals(read_packet.service_id, 4)
    luaunit.assertEquals(read_packet.characteristic_count, 2)

    characteristics_ids = { 2, 1 };

    for i = 1, read_packet.characteristic_count do
        luaunit.assertEquals(read_packet.characteristics_ids[i], characteristics_ids[i])
    end

    print("should_read_packet_for_one_service_and_two_characteristics passed")
end
should_read_packet_for_one_service_and_two_characteristics()
