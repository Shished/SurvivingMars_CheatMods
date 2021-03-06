-- See LICENSE for terms

local Concat = Terraformer.ComFuncs.Concat --added in Init.lua

local pcall,tostring,pairs,print,type = pcall,tostring,pairs,print,type
local table,debug = table,debug

local local_T = T -- T replaced below

local g_Classes = g_Classes

-- I want a translate func to always return a string
function Terraformer.ComFuncs.Trans(...)
  local trans
  local vararg = {...}
  -- just in case a
  pcall(function()
    if type(vararg[1]) == "userdata" then
      trans = _InternalTranslate(table.unpack(vararg))
    else
      trans = _InternalTranslate(local_T(vararg))
    end
  end)
  -- just in case b
  if type(trans) ~= "string" then
    if type(vararg[2]) == "string" then
      return vararg[2]
    end
    -- done fucked up (just in case c)
    return Concat(vararg[1]," < Missing locale string id")
  end
  return trans
end
local T = Terraformer.ComFuncs.Trans

-- shows a popup msg with the rest of the notifications
function Terraformer.ComFuncs.MsgPopup(Msg,Title,Icon)
  local Terraformer = Terraformer
  Icon = type(tostring(Icon):find(".tga")) == "number" and Icon or Concat(Terraformer.MountPath,"TheIncal.tga")
  --eh, it needs something for the id, so I can fiddle with it later
  local id = AsyncRand()
  --build our popup
  local timeout = 10000
  local params = {
    expiration=timeout, --{expiration=99999999999999999}
    --dismissable=false,
  }
  local cycle_objs = params.cycle_objs
  local dlg = GetXDialog("OnScreenNotificationsDlg")
  if not dlg then
    if not GetInGameInterface() then
      return
    end
    dlg = OpenXDialog("OnScreenNotificationsDlg", GetInGameInterface())
  end
  local data = {
    id = id,
    --name = id,
    title = tostring(Title or ""),
    text = tostring(Msg or T(3718--[[NONE--]])),
    image = Icon
  }
  table.set_defaults(data, params)
  table.set_defaults(data, g_Classes.OnScreenNotificationPreset)

  CreateRealTimeThread(function()
		local popup = g_Classes.OnScreenNotification:new({}, dlg.idNotifications)
		popup:FillData(data, nil, params, cycle_objs)
		popup:Open()
		dlg:ResolveRelativeFocusOrder()
  end)
end

function Terraformer.ComFuncs.FilterFromTable(Table,ExcludeList,IncludeList,Type)
  return FilterObjects({
    filter = function(Obj)
      if ExcludeList or IncludeList then
        if ExcludeList and IncludeList then
          if not ExcludeList[Obj[Type]] then
            return Obj
          elseif IncludeList[Obj[Type]] then
            return Obj
          end
        elseif ExcludeList then
          if not ExcludeList[Obj[Type]] then
            return Obj
          end
        elseif IncludeList then
          if IncludeList[Obj[Type]] then
            return Obj
          end
        end
      else
        if Obj[Type] then
          return Obj
        end
      end
    end
  },Table)
end

-- well that's the question isn't it?
function Terraformer.ComFuncs.QuestionBox(msg,func,title,ok_msg,cancel_msg,image,context,parent)
  -- thread needed for WaitMarsQuestion
  CreateRealTimeThread(function()
    if WaitMarsQuestion(
      parent,
      tostring(title or ""),
      tostring(msg or ""),
      tostring(ok_msg or T(6878--[[OK--]])),
      tostring(cancel_msg or T(6879--[[Cancel--]])),
      image,
      context
    ) == "ok" then
      if func then
        func(true)
      end
      return "ok"
    else
      -- user canceled / closed it
      if func then
        func()
      end
      return "cancel"
    end
  end)
end
