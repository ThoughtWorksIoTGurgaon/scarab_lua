require('./lib/luacolor/color')
luaunit = require('./lib/luaunit/luaunit')
require('./src/port/Port')
require('./src/device/Device')
print(CYAN .. "DEVICE TESTS")

function should_read_all_ports_from_device()

    usable_ports = { Port:new { pin = 1, toggle = ON }, Port:new { pin = 8 }, Port:new { pin = 3 } }
    testable_device = Device:new { ports = usable_ports }

    for unused_port_index, port in pairs(testable_device.ports) do
        expected_toggle = OFF
        actual_toggle = port.toggle
        if port.pin == 1 then
            expected_toggle = ON
        end
        luaunit.assertEquals(actual_toggle, expected_toggle)
    end
    print(GREEN .. "should_read_all_ports_from_device passed")
end
should_read_all_ports_from_device()

function should_turn_ON_the_port_from_device()

    usable_ports = { Port:new { pin = 1 }, Port:new { pin = 8 }, Port:new { pin = 3 } }
    testable_device = Device:new { ports = usable_ports }
    status = ON
    testable_device.ports[2]:write(status)

    luaunit.assertEquals(testable_device.ports[2].toggle, status)
    print(GREEN .. "should_turn_ON_the_port_from_device passed")
end
should_turn_ON_the_port_from_device()

function should_turn_OFF_the_port_from_device()

    usable_ports = { Port:new { pin = 1 }, Port:new { pin = 8, toggle = ON }, Port:new { pin = 3 } }
    testable_device = Device:new { ports = usable_ports }
    status = OFF
    testable_device.ports[2]:write(status)

    luaunit.assertEquals(testable_device.ports[2].toggle, status)
    print(GREEN .. "should_turn_OFF_the_port_from_device passed")
end
should_turn_OFF_the_port_from_device()

callback_invoked = false
function test_write_callback(pin, toggle)
    callback_invoked = true
    return toggle
end

function should_invoke_callback_write_function()
    usable_ports = { Port:new { pin = 1 }}
    testable_device = Device:new { ports = usable_ports }

    test_pin = 1
    test_pin_toggle = ON

    testable_device:write(test_pin, test_pin_toggle, test_write_callback)
    luaunit.assertTrue(callback_invoked)
    luaunit.assertEquals(testable_device.ports[1].toggle, test_pin_toggle)
    print(GREEN .. "should_invoke_callback_write_function passed")
end
should_invoke_callback_write_function()

callback_invoked = false
function test_read_callback(pin)
    callback_invoked = true
    return true
end

function should_invoke_callback_read_function()
    usable_ports = { Port:new { pin = 1 }}
    testable_device = Device:new { ports = usable_ports }

    test_pin = 1

    expected_toggle = testable_device:read(test_pin, test_read_callback)
    luaunit.assertTrue(callback_invoked)
    luaunit.assertEquals(expected_toggle, OFF)
    luaunit.assertEquals(testable_device.ports[1].toggle, OFF)

    print(GREEN .. "should_invoke_callback_read_function passed")
end
should_invoke_callback_read_function()