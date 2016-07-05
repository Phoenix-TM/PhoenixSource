--Created by: @janlou

local function run(msg, matches)
  if matches[1]:lower() == 'semat' and not is_momod(msg) then
     send_document(get_receiver(msg), "./semat/member.webp", ok_cb, false)
    return 'You are a member 👶'
  end
   if matches[1]:lower() == 'semat' and is_sudo(msg) then
     send_document(get_receiver(msg), "./semat/sudo.webp", ok_cb, false)
    return 'You Are My Sudo 😊'
   end
    if matches[1]:lower() == 'semat' and is_owner(msg) then
     send_document(get_receiver(msg), "./semat/owner.webp", ok_cb, false)
    return 'You Are Owner 🗣'
   end
  if matches[1]:lower() == 'semat' and is_momod(msg) then
     send_document(get_receiver(msg), "./semat/momod.webp", ok_cb, false)
    return 'You Are Admin 👤'
  end
end
return {
  patterns = {
    "^[#!/]([Mm][Ee)$"
  }, 
  run = run 
}

-- @Phoenix_TM
