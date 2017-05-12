luaunit = require('./lib/luaunit/luaunit')
main = require('./src/packet/Response_Packet', './src/packet/Characteristic')

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
    print("should_stringify_response_having_zero_characteristic_data passed")
end
should_stringify_response_having_zero_characteristic_data()