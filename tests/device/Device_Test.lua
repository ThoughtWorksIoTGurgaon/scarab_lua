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