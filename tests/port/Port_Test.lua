require('./src/port/Port')
require('./lib/luacolor/color')
luaunit = require('./lib/luaunit/luaunit')
print(CYAN .. "PORT TESTS")

function should_read_data_from_port()

    testable_port = Port:new { pin = 5, toggle = OFF }

    expected_toggle = OFF
    actual_toggle = testable_port.toggle

    luaunit.assertEquals(actual_toggle, expected_toggle)
    print(GREEN .. "should_read_data_from_port passed")
end
should_read_data_from_port()

function should_read_deafaut_toggle_as_OFF_from_port()

    testable_port = Port:new { pin = 5 }

    expected_toggle = OFF
    actual_toggle = testable_port.toggle

    luaunit.assertEquals(actual_toggle, expected_toggle)
    print(GREEN .. "should_read_data_from_port passed")
end
should_read_deafaut_toggle_as_OFF_from_port()