local function run(msg)
if msg.text == "hi" then
	return "Hi"
end
if msg.text == "Hi" then
	return "Hi"
end
if msg.text == "Hello" then
	return "Hi"
end
if msg.text == "hello" then
	return "Hi"
end
if msg.text == "Salam" then
	return "Aleyk"
end
if msg.text == "salam" then
	return "Aleyk"
end
if msg.text == "Phoenix" then
	return "?"
end
if msg.text == "phoenix" then
	return "What?"
end
if msg.text == "bot" then
	return "hum?"
end
if msg.text == "Bot" then
	return "Huuuum?"
end
if msg.text == "?" then
	return "Hum?"
end
if msg.text == "Bye" then
	return "Bye"
end
if msg.text == "bye" then
	return "Bye Bye"
end
if msg.text == "Slm" then
	return "Salam"
end	
if msg.text == "سلام" then
	return "Salam :)"
end
if msg.text == "Hum?" then
	return "Hum :|"
end
end

return {
	description = "Chat With Robot Server", 
	usage = "chat with robot",
	patterns = {
		"^[Hh]i$",
		"^[Hh]ello$",
		"^[Bb]ot$",
		"^[Pp]hoenix$",
		"^[Bb]ye$",
		"^?$",
		"^[Ss]alam$",
		"^[Ss]lm$",
		"^[Hh]um?$",
		"^سلام$"
		
		}, 
	run = run,
    --privileged = true,
	pre_process = pre_process
}
-- @Phoenix_TM
