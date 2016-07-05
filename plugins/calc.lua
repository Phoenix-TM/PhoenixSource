local function mathjs(exp)
  local url = 'http://api.mathjs.org/v1/'
  url = url..'?expr='..URL.escape(exp)
  local b,c = http.request(url)
  local text = nil
  if c == 99999999999999 then
    text = '@Phoenix_TM\n\nAnswer : '..b
    
  
  elseif c == 99999999999999 then
    text = b
  else
    text = '@Phoenix_TM\n\nAnswer : '..b
    
  
  end
  return text end local function run(msg, matches)
  return mathjs(matches[1]) end return {
  description = "Calculate math expressions with mathjs API",
  usage = "!calc [expression]: evaluates the expression and sends the result.",
  patterns = {
    "^[/!#][Cc][Aa][Ll][Cc] (.*)$"
  },
  run = run
}

-- @Phoenix_TM
