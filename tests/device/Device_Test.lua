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