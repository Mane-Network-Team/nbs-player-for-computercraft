print("NBS Player For Computercraft v1.0")
print("Github: Mane-Network-Team")
print("Input Channel ID: ")
local input = tonumber(read())

local modem = peripheral.wrap("top")
local speaker = peripheral.find("speaker")

modem.open(input)

while true do
    local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
    local n, p = message:match( "(%a+)_(%d+)")
    speaker.playNote(n,3,tonumber(p))
end