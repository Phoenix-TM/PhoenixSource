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
 
 
-- !help command
local function telegram_help()
  local text = "Sudo Help :\n\n!creategroup [name]\nCreate a group\n\n!createrealm [name]\nCreate a realm\n\n!setname [name]\nSet realm name\n\n!setabout [group_id] [text]\nSet a group's about text\n\n!setrules [grupo_id] [text]\nSet a group's rules\n\n!lock [grupo_id] [setting]\nLock a group's setting\n\n!unlock [grupo_id] [setting]\nUnock a group's setting\n\n!wholist\nGet a list of members in group/realm\n\n!who\nGet a file of members in group/realm\n\n!type\nGet group type\n\n!kill chat [grupo_id]\nKick all memebers and delete group\n\n!kill realm [realm_id]\nKick all members and delete realm\n\n!addadmin [id|username]\nPromote an admin by id OR username *Sudo only\n\n!removeadmin [id|username]\nDemote an admin by id OR username *Sudo only\n\n!list groups\nGet a list of all groups\n\n!list realms\nGet a list of all realms\n\n!log\nGet a logfile of current group or realm\n\n!broadcast [text]\n!broadcast Hello !\nSend text to all groups\n» Only sudo users can run this command\n\n!bc [group_id] [text]\n!bc 123456789 Hello !\nThis command will send text to [group_id]\n\n» U can use both \"/\" and \"!\" \n\n» Only mods, owner and admin can add bots in group\n\n» Only moderators and owner can use kick,ban,unban,newlink,link,setphoto,setname,lock,unlock,set rules,set about and settings commands\n\n» Only owner can use res,setowner,promote,demote and log commands\n\n"

  return text
end
 
 
-- !help all command
local function help_sudo(requester)
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
  if matches[1] == "[!/$#][Ss][Uu][Dd][Oo][Hh][Ee][Ll][Pp]" then
    return telegram_help()
  elseif matches[1] == "[!/][Ss][Dd][Hh][Ee][Ll][Pp]" then
    return help_sudo(requester)
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
    "/help : view items list",
    "/helps : view all commands and info",
    "/help (name) : view a item commands and info",
  },
  patterns = {
    "^[!/$#][Ss][Dd][Hh][Ee][Ll][Pp]$",
    "^[!/$#][Ss][Uu][Dd][Oo][Hh][Ee][Ll][Pp]"
  },
  run = run
}
 
end
-- By @Nim_Bo
-- @Phoenix_TM
