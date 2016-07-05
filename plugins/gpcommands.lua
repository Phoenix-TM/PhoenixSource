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
local text = "♨️ Group Commands List : ♨️"    
  text = text..'\n\n'..'!kick [username/id]'
  text = text..'\n'.. 'You can also do it by reply'
  text = text..'\n\n'..'!ban [ username/id]'
  text = text..'\n'..'You can also do it by reply'
  text = text..'\n\n'..'!unban [ username/id]'
  text = text..'\n'..'You can also do it by reply'
  text = text..'\n\n'..'!who'
  text = text..'\n'..'You can see member list'
  text = text..'\n\n'..'!modlist'
  text = text..'\n'..'You can see moderator list'
  text = text..'\n\n'..'!promote [username]'
  text = text..'\n'..'You can promote someone'
  text = text..'\n\n'..'!demote [username]'
  text = text..'\n'..'You can demote someone'
  text = text..'\n\n'..'!kickme'
  text = text..'\n'..'Will kick user'
  text = text..'\n\n'..'!about'
  text = text..'\n'..'You can see group description'  
  text = text..'\n\n'..'!setphoto'
  text = text..'\n'..'Set and locks group photo'
  text = text..'\n\n'..'!setname'
  text = text..'\n'..'Set group name'
  text = text..'\n\n'..'!rules'
  text = text..'\n'..'You can see group rules'
  text = text..'\n\n'..'!id'
  text = text..'\n'..'Return group id or user id'  
  text = text..'\n\n'..'!lock [member|name|bots|leave] '
  text = text..'\n'..'You can lock [member|name|bots|leaving]'
  text = text..'\n\n'..'!unlock [member|name|bots|leave]'
  text = text..'\n'..'You can unlock [member|name|bots|leaving]'
  text = text..'\n\n'..'!set rules [text]'
  text = text..'\n'..'You can set rules for group'
  text = text..'\n'..'!set about [text]'
  text = text..'\n\n'..'You can set about for group'
  text = text..'\n'..'!settings'
  text = text..'\n\n'..'You can see group settings'
  text = text..'\n'..'!newlink'
  text = text..'\n\n'..'Create or revoke your group link'
  text = text..'\n'..'!link'  
  text = text..'\n\n'..'You can see group link'
  text = text..'\n'..'!owner'
  text = text..'\n'..'You can see owner id'  
  text = text..'\n\n'..'!setowner [id]'
  text = text..'\n'..'You can set owner from id'
  text = text..'\n'..'!setflood [5-100]'
  text = text..'\n'..'You can set flood sensitivity'  
  text = text..'\n\n'..'!stats'
  text = text..'\n'..'Simple message statistics'
  text = text..'\n'..'!save [value] [text]'
  text = text..'\n'..'You can save [text] as [value]'
  text = text..'\n\n'..'!get [value]'
  text = text..'\n'..'You can see text of [value]'
  text = text..'\n'..'!clean [modlist|rules|about]'
  text = text..'\n'..'You can clear [modlist|rules|about] and set it to nil'
  text = text..'\n\n'..'!res [username]'
  text = text..'\n'..'See user id'
  text = text..'\n'..'!log'
  text = text..'\n'..'You can see group logs'
  text = text..'\n\n'..'!banlist'
  text = text..'\n'..'You can see group ban list'
  text = text..'\n'..'!setwlc [message]'
  text = text..'\n'..'Set welcom message'
  text = text..'\n\n'..'!delwlc'
  text = text..'\n'..'Delete welcom message'
  text = text..'\n'..'!setbye [message]'
  text = text..'\n'..'Set bye message'
  text = text..'\n\n'..'!delbye'
  text = text..'\n'..'Delete bye message'
  text = text..'\n\n'..'♨️ U can use both "/" and "!" '
  text = text..'\n\n'..'🔶 Only mods, owner and admin can add bots in group'
  text = text..'\n\n'..'🔷 Only moderators and owner can use kick,ban,unban,newlink,link,setphoto,setname,lock,unlock,set rules,set about and settings commands'
  text = text..'\n\n'..'🔶 Only owner can use res,setowner,promote,demote and log commands'
  text = text..'\n\n'..'For See Supergroup Commands : /superhelp'
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
  if matches[1] == "[!/#][Cc][Oo][Mm][Mm][Aa][Nn][Dd][Ss] [Gg][Rr][Oo][Uu][Pp]$" then
    return telegram_help()
  elseif matches[1] == "[!/#][Cc][Oo][Mm][Mm][Aa][Nn][Dd][Ss] [Gg][Rr][Oo][Uu][Pp]" then
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
    "/commands"
  },
  patterns = {
    "^[!/#][Cc][Oo][Mm][Mm][Aa][Nn][Dd][Ss]$",
    "^[!/#][Cc][Oo][Mm][Mm][Aa][Nn][Dd][Ss]"
  },
  run = run
}
 
end

-- By @Nim_Bo
-- @Phoenix_TM
