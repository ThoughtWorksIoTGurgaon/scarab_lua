luaunit = require('./lib/luaunit/luaunit')
main = require('./src/port/Port')

function should_read_data_from_port()

    testable_port = Port:new { pin = 5, toggle = OFF }

    expected_toggle = OFF
    actual_toggle = testable_port.toggle

    luaunit.assertEquals(actual_toggle, expected_toggle)
    print("should_read_data_from_port passed")
end
should_read_data_from_port()

