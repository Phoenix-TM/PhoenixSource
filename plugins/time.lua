function run(msg, matches)
local url , res = http.request('http://api.gpmod.ir/time/')
if res ~= 200 then return "No connection" end
local jdat = json:decode(url)
local text = '🕒 Hour : '..jdat.FAtime..' \n📆 Day : '..jdat.FAdate..' \n    ----\n🕒 '..jdat.ENtime..'\n📆 '..jdat.ENdate.. '\n'@Phoenix_TM
return text
end
return {
  patterns = {"^[/!]([Tt][iI][Mm][Ee])$"}, 
run = run 
}
-- @Phoenix_TM


