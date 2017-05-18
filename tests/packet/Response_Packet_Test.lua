require('./src/packet/Response_Packet')
require( './lib/luacolor/color')
luaunit = require('./lib/luaunit/luaunit')
print(CYAN.."RESPONSE_PACKET TESTS")

function should_stringify_response_having_zero_characteristic_data()
    response_packet = Response_Packet:new { service_id = 0, characteristic_count = 0 }
    response_binary_packet = stringify_response(response_packet)

    expected_response_binary_packet = {
        1, --Version
        4, -- ResponsePacketType
        1, 1, 1, --Unused
        1, --serviceId
        0, --charsCount --Ending string
    }

    luaunit.assertEquals(response_binary_packet, expected_response_binary_packet)
    print(GREEN.."should_stringify_response_having_zero_characteristic_data passed")
end
should_stringify_response_having_zero_characteristic_data()

function should_stringify_response_having_one_characteristic_data()
    characteristic_data = { 1 }
    characteristic = Characteristic:new { id = 1, size = 1, data = characteristic_data }
    characteristic_array = { characteristic }

    response_packet = Response_Packet:new { service_id = 0, characteristic_count = 1, characteristics = characteristic_array }
    response_binary_packet = stringify_response(response_packet)

    expected_response_binary_packet = {
        1, --Version
        4, -- ResponsePacketType
        1, 1, 1, --Unused
        1, --serviceId
        1, --charsCount
        1, 1, 1, --Characteristic id,size,data
        0 -- Ending string
    }

    luaunit.assertEquals(response_binary_packet, expected_response_binary_packet)
    print(GREEN.."should_stringify_response_having_one_characteristic_data passed")
end
should_stringify_response_having_one_characteristic_data()

function should_stringify_response_having_two_characteristic_data()
    characteristic_data = { 1 }
    characteristic_1 = Characteristic:new { id = 1, size = 1, data = characteristic_data }
    characteristic_2 = Characteristic:new { id = 2, size = 1, data = characteristic_data }
    characteristic_array = { characteristic_1, characteristic_2 }

    response_packet = Response_Packet:new { service_id = 0, characteristic_count = 2, characteristics = characteristic_array }
    response_binary_packet = stringify_response(response_packet)

    expected_response_binary_packet = {
        1, --Version
        4, -- ResponsePacketType
        1, 1, 1, --Unused
        1, --serviceId
        2, --charsCount
        1, 1, 1, --Characteristic id,size,data
        2, 1, 1, --Characteristic id,size,data
        0 -- Ending string
    }

    luaunit.assertEquals(response_binary_packet, expected_response_binary_packet)
    print(GREEN.."should_stringify_response_having_two_characteristic_data passed")
end
should_stringify_response_having_two_characteristic_data()