local modem = peripheral.wrap("top")

print("NBS Player For Computercraft v1.0")
print("Github: Mane-Network-Team")

print("Input song name:")
local afile = io.open(read(),'rb')
local tempo = 1000
local inst = {"harp","bass","basedrum","snare","hat","guitar","flute","bell","chime","xylophone","iron_xylophone","cow_bell","didgeridoo","bit","banjo","pling"}
local channel = 3

function jump_string()
    local l1 = afile:read(1)
    local l2 = afile:read(1)
    local l3 = afile:read(1)
    local l4 = afile:read(1)

    l1 = tonumber(string.byte(l1))
    l2 = tonumber(string.byte(l2))
    l3 = tonumber(string.byte(l3))
    l4 = tonumber(string.byte(l4))

    afile:read(l1 + l2*256 + l3*256*256 + l4*256*256*256)
end

function read_short()
    local l1 = afile:read(1)
    local l2 = afile:read(1)
    l1 = tonumber(string.byte(l1))
    l2 = tonumber(string.byte(l2))
    return l1 + l2*256
end

function wait_tick(tick)
    local time = tick / tempo * 100
    os.sleep(time)
    channel = 3
end

function read_delay()
    local l1 = afile:read(1)
    local l2 = afile:read(1)
    l1 = tonumber(string.byte(l1))
    l2 = tonumber(string.byte(l2))
    if (l1 + l2 * 256 == 0 ) then
        print("-- finish --")
        os.exit()
    end
    wait_tick(l1 + l2 * 256) 
end

function playNote(inst_num,pich)
    local message = inst[inst_num] .."_".. tostring(pich)
    modem.transmit(channel, 1, message ) 
    channel = channel + 1    
end

function read_noteblock()
    local l1 = afile:read(1)
    local l2 = afile:read(1)

    l1 = tonumber(string.byte(l1))
    l2 = tonumber(string.byte(l2))

    if (l1 + l2 * 256 == 0) then
        return false
    end

    local l3 = afile:read(1)
    local l4 = afile:read(1)
    local l5 = afile:read(1)
    local l6 = afile:read(1)
    local l7 = afile:read(1)
    local l8 = afile:read(1)

    l3 = tonumber(string.byte(l3)) + 1
    l4 = tonumber(string.byte(l4)) - 33

    playNote(l3,l4)
    return true
end


afile:read(8)
jump_string()
jump_string()
jump_string()
jump_string()

tempo = tonumber(string.byte(afile:read(1))) + tonumber(string.byte(afile:read(1)))*256
print("-- tempo --")
print(tempo)

afile:read(23)
jump_string()
afile:read(4)

while true do
    read_delay()
    while read_noteblock() do
    end
end

afile:close()




