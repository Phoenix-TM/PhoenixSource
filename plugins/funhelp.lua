do
 
function pairsByKeys(t, f)
      local a = {}
      for n in pairs(t) do table.insert(a, n) end
      table.sort(a, f)
      local i = 0      -- iterator variable
      local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
      end
      return iter
    end
 
-- Returns true if is not empty
local function has_usage_data(dict)
  if (dict.usage == nil or dict.usage == '') then
    return false
  end
  return true
end
 
-- Get commands for that plugin
local function plugin_help(name,number,requester)
  local plugin = ""
  if number then
    local i = 0
    for name in pairsByKeys(plugins) do
      if plugins[name].hidden then
        name = nil
      else
        i = i + 1
        if i == tonumber(number) then
          plugin = plugins[name]
        end
      end
    end
  else
    plugin = plugins[name]
    if not plugin then return nil end
  end
 
    local text = ""
    if (type(plugin.usage) == "table") then
      for ku,usage in pairs(plugin.usage) do
          if ku == 'user' then -- usage for user
              if (type(plugin.usage.user) == "table") then
                  for k,v in pairs(plugin.usage.user) do
                      text = text..v..'\n'
                  end
              elseif has_usage_data(plugin) then -- Is not empty
                  text = text..plugin.usage.user..'\n'
              end
          elseif ku == 'moderator' then -- usage for moderator
              if requester == 'moderator' or requester == 'admin' or requester == 'sudo' then
                  if (type(plugin.usage.moderator) == "table") then
                      for k,v in pairs(plugin.usage.moderator) do
                          text = text..v..'\n'
                      end
                  elseif has_usage_data(plugin) then -- Is not empty
                      text = text..plugin.usage.moderator..'\n'
                  end
              end
          elseif ku == 'admin' then -- usage for admin
              if requester == 'admin' or requester == 'sudo' then
                  if (type(plugin.usage.admin) == "table") then
                      for k,v in pairs(plugin.usage.admin) do
                          text = text..v..'\n'
                      end
                  elseif has_usage_data(plugin) then -- Is not empty
                      text = text..plugin.usage.admin..'\n'
                  end
              end
          elseif ku == 'sudo' then -- usage for sudo
              if requester == 'sudo' then
                  if (type(plugin.usage.sudo) == "table") then
                      for k,v in pairs(plugin.usage.sudo) do
                          text = text..v..'\n'
                      end
                  elseif has_usage_data(plugin) then -- Is not empty
                      text = text..plugin.usage.sudo..'\n'
                  end
              end
          else
              text = text..usage..'\n'
          end
      end
      text = text..'______________________________\n'
    elseif has_usage_data(plugin) then -- Is not empty
      text = text..plugin.usage..'\n______________________________\n'
    end
    return text
end
 
 
-- !commands group help
local function telegram_help()
local text = "♨️ Fun Help : ♨️"    
  text = text..'\n\n'..'!calc [Number*Number] '
  text = text..'\n'.. 'You can use this calculator'
  text = text..'\n\n'..'!time'
  text = text..'\n'..'Get time'
  text = text..'\n\n'..'!info'
  text = text..'\n'..'Get user info'
  text = text..'\n\n'..'!insta [User]'
  text = text..'\n'..'Get about of this instagram user'
  text = text..'\n\n'..'!joke'
  text = text..'\n'..'Get a joke'
  text = text..'\n\n'..'!tr [Language] [Language] [Word/Sentence]'
  text = text..'\n'..'Translate your selected word'
  text = text..'\n\n'..'!me'
  text = text..'\n'..'Get your rank of PhoenixTG/Group'
  text = text..'\n\n'..'!vc [Text]'
  text = text..'\n'..'Text to voice'
  text = text..'\n\n'..'!weather [City]'
  text = text..'\n'..'Get weather of your city'  
  text = text..'\n\n'..'!music [Name]'
  text = text..'\n'..'Search and get music'
  text = text..'\n\n'..'!wirte [Word/Sentence]'
  text = text..'\n'..'Get 100 font from your selected word/sentence'
  text = text..'\n\n'..'➖➖➖➖➖➖➖➖➖➖➖'
  text = text..'\n\n'..'🔰 @Phoenix_TM 🔰'
  text = text..'\n\n'..' ⚜ @PhoenixTG ⚜'
  
  return text
end
 
 
-- !help all command
local function help_all(requester)
  local ret = ""
  for name in pairsByKeys(plugins) do
    if plugins[name].hidden then
      name = nil
    else
      ret = ret .. plugin_help(name, nil, requester)
    end
  end
  return ret
end
 
local function run(msg, matches)
  if is_sudo(msg) then
      requester = "sudo"
  elseif is_admin(msg) then
      requester = "admin"
  elseif is_momod(msg) then
      requester = "moderator"
  else
      requester = "user"
  end
  if matches[1] == "[!/#][Ff][Uun][Nn][Hh][Ee][Ll][Pp]$" then
    return telegram_help()
  elseif matches[1] == "[!/#][Ff][Uun][Nn][Hh][Ee][Ll][Pp]" then
    return help_all(requester)
  else
    local text = ""
    if tonumber(matches[1])  then
      text = plugin_help(nil, matches[1], requester)
    else
      text = plugin_help(matches[1], nil, requester)
    end
    if not text then
      text = telegram_help()
    end
    return text
  end
end
 
return {
  description = "Help For Command and Tools",
  usage = {
    "/funhelp"
  },
  patterns = {
    "^[!/#][Ff][Uun][Nn][Hh][Ee][Ll][Pp]$",
    "^[!/#][Ff][Uun][Nn][Hh][Ee][Ll][Pp]"
  },
  run = run
}
 
end
