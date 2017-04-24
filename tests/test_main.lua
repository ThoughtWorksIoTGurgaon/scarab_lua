luaunit = require('./lib/luaunit/luaunit')
main = require('./src/main')

function testAddPositive()
    luaunit.assertEquals(add(1,1),2)
    print("testAddPositive")
end

function testAddZero()
    luaunit.assertEquals(add(1,0),0)
    luaunit.assertEquals(add(0,5),0)
    luaunit.assertEquals(add(0,0),0)
    print("testAddZero passed")
end

testAddPositive()
testAddZero()