-- See LICENSE for terms

local Concat = ChoGGi.ComFuncs.Concat
local DialogUpdateMenuitems = ChoGGi.ComFuncs.DialogUpdateMenuitems
local RetButtonTextSize = ChoGGi.ComFuncs.RetButtonTextSize
local RetCheckTextSize = ChoGGi.ComFuncs.RetCheckTextSize
local RetName = ChoGGi.ComFuncs.RetName
local RetSortTextAssTable = ChoGGi.ComFuncs.RetSortTextAssTable
local ShowMe = ChoGGi.ComFuncs.ShowMe
local TableConcat = ChoGGi.ComFuncs.TableConcat
local T = ChoGGi.ComFuncs.Trans
local S = ChoGGi.Strings

local pairs,type,tostring,tonumber,rawget,table,debug = pairs,type,tostring,tonumber,rawget,table,debug

local CmpLower = CmpLower
local GetStateName = GetStateName
local IsPoint = IsPoint
local IsValid = IsValid
local IsValidEntity = IsValidEntity
local point = point

transp_mode = rawget(_G, "transp_mode") or false
local HLEnd = "</h></color>"
--~ Transparency

local white = white
local black = black
local dark_gray = -13158858
local light_gray = -2368549
-- make 'em lower_case
local DumpText = Concat(S[302535920000004--[[Dump--]]]," ",S[1000145--[[Text--]]])
local DumpObject = Concat(S[302535920000004--[[Dump--]]]," ",S[298035641454--[[Object--]]])
local ViewText = Concat(S[302535920000048--[[View--]]]," ",S[1000145--[[Text--]]])
local ViewObject = Concat(S[302535920000048--[[View--]]]," ",S[298035641454--[[Object--]]])
local EditObject = Concat(S[327465361219--[[Edit--]]]," ",S[298035641454--[[Object--]]])
local ExecCode = S[302535920000323--[[Exec Code--]]]
local Functions = S[302535920001239--[[Functions--]]]
local str_title = Concat(S[302535920000069--[[Examine--]]],": ")

-- 1 above console log
local zorder = 2000001
DefineClass.Examine = {
  __parents = {"ChoGGi_Window"},
  -- clickable purple text
  onclick_handles = {},
  -- what we're examining
  obj = false,
  -- if user checks the autorefresh checkbox
  autorefresh_thread = false,

--~   border = false,
  XRolloverWindow_ZOrder = false,
  ZOrder = zorder,

  -- needed?
  show_times = "relative",
  offset = 1,
  page = 1,
}

--~ box(left,top, right, bottom)

function Examine:Init(parent, context)
--~   XEdit:new({
--~     Id = "idEdit",
--~     Dock = "bottom",
--~     TextFont = "Editor18Bold",
--~     OnTextChanged = function(edit)
--~       XEdit.OnTextChanged(edit)
--~       self:TextChanged()
--~     end
--~   }, self)
  local ChoGGi = ChoGGi
  local g_Classes = g_Classes
  local const = const
  local point = point
  local RGBA = RGBA

  -- any self. values from :new()
  self.obj = context.obj

  self.dialog_width = 500
  self.dialog_height = 600

  -- By the Power of Grayskull!
  g_Classes.ChoGGi_Window.AddElements(self, parent, context)

--~ box(left, top, right, bottom) :minx() :miny() :sizex() :sizey()

  self.idLinks = g_Classes.ChoGGi_Text:new({
    Id = "idLinks",
    VAlign = "top",
    FontStyle = "Editor14",
    BackgroundColor = RGBA(0, 0, 0, 16),
  }, self.idDialog)

  function self.idLinks.OnHyperLink(_, link, _, box, pos, button)
    self.onclick_handles[tonumber(link)](box, pos, button)
  end
  self.idLinks:AddInterpolation{
    type = const.intAlpha,
    startValue = 255,
    flags = const.intfIgnoreParent
  }


--~   function ChoGGi.ComFuncs.DialogXAddButton(parent,text,hint,onpress)
--~     g_Classes.XTextButton:new({
--~       RolloverTemplate = "Rollover",
--~       RolloverTitle = S[126095410863--[[Info--]]],
--~       MinWidth = 60,
--~       Text = ChoGGi.ComFuncs.CheckText(text,S[6878--[[OK--]]]),
--~       OnPress = onpress,
--~       --center text
--~       LayoutMethod = "VList",
--~     }, parent)
--~   end

  self.idButtons = g_Classes.XWindow:new({
    Id = "idButtons",
  }, self.idDialog)

--~   self.idLinks = g_Classes.ChoGGi_Button:new({
--~     Id = "idLinks",
--~     RolloverText = "hint",
--~     VAlign = "top",
--~     FontStyle = "Editor14",
--~     BackgroundColor = RGBA(0, 0, 0, 16),
--~   }, self.idDialog)

  g_Classes.ChoGGi_Window.AddTextBox(self, parent, context)

  -- look at them sexy internals
  self.transp_mode = transp_mode
  self:SetTranspMode(self.transp_mode)

  self:SetObj(self.obj)
end

function Examine:idAutoRefreshButOnButtonPressed()
  -- if already running then stop and return
  if self.autorefresh_thread then
    DeleteThread(self.autorefresh_thread)
    self.autorefresh_thread = false
    return
  end
  -- otherwise fire it up
  local Sleep = Sleep
  self.autorefresh_thread = CreateRealTimeThread(function()
    while true do
      if self.obj then
        self:SetObj(self.obj)
      else
        DeleteThread(self.autorefresh_thread)
      end
      Sleep(1000)
    end
  end)
end

function Examine:idFilterOnKbdKeyDown(char, vk)
  if vk == const.vkEnter then
    self:FindNext(self.idFilter:GetText())
    return "break"
  elseif vk == const.vkUp then
    self.idText:SetTextOffset(point(0,0))
    return "break"
  elseif vk == const.vkEsc then
    self.idCloseX:Press()
--~     self:SetFocus()
    return "break"
  else
    SingleLineEdit.OnKbdKeyDown(self.idFilter, char, vk)
  end
end

function Examine:MenuOnComboClose(menu,idx,which)
  --close hint
  XDestroyRolloverWindow(true)
  if self[which].list.rollover then
    local item = menu.items[idx]
    if not item.text:find("-") then
      if which == "idParentsMenu" then
        OpenExamine(_G[item.text],self)
      else
        OpenExamine(item.obj,self)
      end
    end
  end
end

local menu_added
local menu_list_items

-- adds class name then list of functions below
local function BuildFuncList(obj_name,prefix)
  prefix = prefix or ""
  local class = _G[obj_name] or empty_table
  local skip = true
  for key,_ in pairs(class) do
    if type(class[key]) == "function" then
      menu_list_items[Concat(prefix,obj_name,".",key,": ")] = class[key]
      skip = false
    end
  end
  if not skip then
    menu_list_items[Concat(prefix,obj_name)] = "\n\n\n"
  end
end

local function ProcessList(list,prefix)
  for i = 1, #list do
    if not menu_added[list[i]] then
      -- CObject and Object are pretty much the same (Object has a couple more funcs)
      if list[i] == "CObject" then
        -- keep it for later (for the rare objects that use CObject, but not Object)
        menu_added[list[i]] = prefix
      else
        menu_added[list[i]] = true
        BuildFuncList(list[i],prefix)
      end
    end
  end
end

function Examine:idToolsMenuOnComboClose(menu,idx)
  local g_Classes = g_Classes
  --close hint
  XDestroyRolloverWindow(true)
  if self.idToolsMenu.list.rollover then
    local text = menu.items[idx].text
    if text == self.menuitems.ViewText then
      local str = self:totextex(self.obj)
      --remove html tags
      str = str:gsub("<[/%s%a%d]*>","")
      local dialog = g_Classes.ChoGGi_MultiLineText:new({}, terminal.desktop,{
        checkbox = true,
        zorder = zorder,
        text = str,
        hint_ok = 302535920000047--[[View text, and optionally dumps text to AppData/DumpedExamine.lua (don't use this option on large text).--]],
        func = function(answer,overwrite)
          if answer then
            ChoGGi.ComFuncs.Dump(Concat("\n",str),overwrite,"DumpedExamine","lua")
          end
        end,
      })
      dialog:Open()
    elseif text == self.menuitems.ViewObject then
      local str = ValueToLuaCode(self.obj)
      local dialog = g_Classes.ChoGGi_MultiLineText:new({}, terminal.desktop,{
        checkbox = true,
        zorder = zorder,
        text = str,
        hint_ok = 302535920000049--[["View text, and optionally dumps object to AppData/DumpedExamineObject.lua

This can take time on something like the ""Building"" metatable (don't use this option on large text)"--]],
        func = function(answer,overwrite)
          if answer then
            ChoGGi.ComFuncs.Dump(Concat("\n",str),overwrite,"DumpedExamineObject","lua")
          end
        end,
      })
      dialog:Open()
    elseif text == self.menuitems.DumpText then
      local str = self:totextex(self.obj)
      --remove html tags
      str = str:gsub("<[/%s%a%d]*>","")
      ChoGGi.ComFuncs.Dump(Concat("\n",str),nil,"DumpedExamine","lua")
    elseif text == self.menuitems.DumpObject then
      local str = ValueToLuaCode(self.obj)
      ChoGGi.ComFuncs.Dump(Concat("\n",str),nil,"DumpedExamineObject","lua")
    elseif text == self.menuitems.EditObject then
      ChoGGi.ComFuncs.OpenInObjectManipulator(self.obj,self)
    elseif text == self.menuitems.ExecCode then
      ChoGGi.ComFuncs.OpenInExecCodeDlg(self.obj,self)
    elseif text == self.menuitems.Functions then
      menu_added = {}
      menu_list_items = {}

      ProcessList(self.parents,Concat(" ",S[302535920000520--[[Parents--]]],": "))
      ProcessList(self.ancestors,Concat(S[302535920000525--[[Ancestors--]]],": "))
      -- add examiner object with some spaces so it's at the top
      BuildFuncList(self.obj.class,"  ")
      -- if Object hasn't been added, then add CObject
      if not menu_added.Object and menu_added.CObject then
        BuildFuncList("CObject",menu_added.CObject)
      end

      OpenExamine(menu_list_items,self)

    end

  end
end

function Examine:FindNext(filter)
  local drawBuffer = self.idText.draw_cache or empty_table
  local current_y = -self.idText.text_offset:y()
  local min_match, closest_match = false, false
  for y, list_draw_info in pairs(drawBuffer) do
    for i = 1, #list_draw_info do
      local draw_info = list_draw_info[i]
      if draw_info.text and draw_info.text:lower():find(filter:lower(), 0, true) then
        if not min_match or y < min_match then
          min_match = y
        end
        if y > current_y and (not closest_match or y < closest_match) then
          closest_match = y
        end
      end
    end
  end
  if min_match or closest_match then
    self.idText:SetTextOffset(point(0, -(closest_match or min_match)))
  end
end

function Examine:SetTranspMode(toggle)
  self:ClearModifiers()
  if toggle then
    self:AddInterpolation{
      type = const.intAlpha,
      startValue = 32
    }
    self.idLinks:AddInterpolation{
      type = const.intAlpha,
      startValue = 200,
      flags = const.intfIgnoreParent
    }
  end
  -- update global value (for new windows)
  transp_mode = toggle
end
--

local function Examine_valuetotextex(_, _, button,o,self)
  if button == "L" then
    OpenExamine(o, self)
  elseif IsValid(o) then
    ShowMe(o)
  end
end

local function ShowPoint_valuetotextex(o)
  ShowMe(o)
end

function Examine:valuetotextex(o)
  local objlist = objlist
  local obj_type = type(o)

  if obj_type == "function" then
    local debug_info = debug.getinfo(o, "Sn")
    return Concat(
      self:HyperLink(function(_,_,button)
        Examine_valuetotextex(_,_,button,o,self)
      end),
      tostring(debug_info.name or debug_info.name_what or S[302535920000063--[[unknown name--]]]),
      "@",
      debug_info.short_src,
      "(",
      debug_info.linedefined,
      ")",
      HLEnd
    )

  elseif obj_type == "thread" then
    return Concat(
      self:HyperLink(function(_,_,button)
        Examine_valuetotextex(_,_,button,o,self)
      end),
      tostring(o),
      HLEnd
    )

  elseif obj_type == "string" then
    return Concat(
      "'",
      o,
      "'"
    )

  -- point() is userdata (keep before it)
  elseif IsPoint(o) then
    return Concat(
      self:HyperLink(function()
        ShowPoint_valuetotextex(o)
      end),
      "(",o:x(),",",o:y(),",",o:z() or terrain.GetHeight(o),")",
      HLEnd
    )

  elseif obj_type == "userdata" then
    local str = tostring(o)
    local trans = T(o)
    -- if it isn't translatable then return a clickable link (not that useful, but's it's highlighted)
    if trans == "stripped" or trans:find("Missing locale string id") then
      return Concat(
        self:HyperLink(function(_,_,button)
          Examine_valuetotextex(_,_,button,o,self)
        end),
        str,
        HLEnd
      )
    else
      return Concat(
        trans,
        " < \"",
        obj_type,
        "\""
      )
    end

  elseif obj_type == "table" then

    if IsValid(o) then
      return Concat(
        self:HyperLink(function(_,_,button)
          Examine_valuetotextex(_,_,button,o,self)
        end),
        o.class,
        HLEnd,
        "@",
        self:valuetotextex(o:GetPos())
      )

    else
      local len = #o
      local meta_type = getmetatable(o)

      -- if it's an objlist then we just return a list of the objects
      if meta_type and meta_type == objlist then
        local res = {
          self:HyperLink(function(_,_,button)
            Examine_valuetotextex(_,_,button,o,self)
          end),
          "objlist",
          HLEnd,
          "{",
        }
        for i = 1, Min(len, 3) do
          res[#res+1] = i
          res[#res+1] = " = "
          res[#res+1] = self:valuetotextex(o[i])
        end
        if len > 3 then
          res[#res+1] = "..."
        end
        res[#res+1] = ", "
        res[#res+1] = "}"
        return TableConcat(res)
      else
        -- regular table
        local table_data
        local is_next = next(o)

        if len > 0 and is_next then
          -- next works for both
          table_data = Concat(len," / ",S[302535920001057--[[Data--]]])
  --~       elseif len > 0 then
  --~         -- index based
  --~         table_data = len
        elseif is_next then
          -- ass based
          table_data = S[302535920001057--[[Data--]]]
        else
          -- blank table
          table_data = 0
        end

        return Concat(
          self:HyperLink(function(_,_,button)
            Examine_valuetotextex(_,_,button,o,self)
          end),
          Concat(RetName(o)," (len: ",table_data,")"),
          HLEnd
        )
      end
    end
  end

  return o
end

function Examine:HyperLink(f, custom_color)
  self.onclick_handles[#self.onclick_handles+1] = f
  return Concat(
    (custom_color or "<color 150 170 250>"),
    "<h ",
    #self.onclick_handles,
    " 230 195 50>"
  )
end

---------------------------------------------------------------------------------------------------------------------
local function ExamineThreadLevel_totextex(level, info, o,self)
  local data = {}
  local l = 1
  while true do
    local name, val = debug.getlocal(o, level, l)
    if name then
      data[name] = val
      l = l + 1
    else
      break
    end
  end
  for i = 1, info.nups do
    local name, val = debug.getupvalue(info.func, i)
    if name ~= nil and val ~= nil then
      data[Concat(name,"(up)")] = val
    end
  end
  return function()
    OpenExamine(data, self)
  end
end

local function Examine_totextex(o,self)
  OpenExamine(o, self)
end

function Examine:totextex(o)
  local res = {}
  local sort = {}
  local obj_metatable = getmetatable(o)
  local obj_type = type(o)
  local is_table = obj_type == "table"

  if is_table then

    for k, v in pairs(o) do
      res[#res+1] = Concat(
        self:valuetotextex(k),
        " = ",
        self:valuetotextex(v),
        "<left>"
      )
      if type(k) == "number" then
        sort[res[#res]] = k
      end
    end

  elseif obj_type == "thread" then

    local info, level = true, 0
    while true do
      info = debug.getinfo(o, level, "Slfun")
      if info then
        res[#res+1] = Concat(
          self:HyperLink(function(level, info)
            ExamineThreadLevel_totextex(level, info, o,self)
          end),
          self:HyperLink(ExamineThreadLevel_totextex(level, info, o,self)),
          info.short_src,
          "(",
          info.currentline,
          ") ",
          (info.name or info.name_what or S[302535920000063--[[unknown name--]]]),
          HLEnd
        )
      else
        res[#res+1] = Concat("<color 255 255 255>\nThread info: ",
          "\nIsValidThread: ",IsValidThread(o),
          "\nGetThreadStatus: ",GetThreadStatus(o),
          "\nIsGameTimeThread: ",IsGameTimeThread(o),
          "\nIsRealTimeThread: ",IsRealTimeThread(o),
          "\nThreadHasFlags: ",ThreadHasFlags(o),
          "</color>"
        )
        break
      end
      level = level + 1
    end

  elseif obj_type == "function" then

    local i = 1
    while true do
      local k, v = debug.getupvalue(o, i)
      if k then
        res[#res+1] = Concat(
          self:valuetotextex(k),
          " = ",
          self:valuetotextex(v)
        )
      else
        res[#res+1] = self:valuetotextex(o)
        break
      end
      i = i + 1
    end --while

  end

  table.sort(res, function(a, b)
    if sort[a] and sort[b] then
      return sort[a] < sort[b]
    end
    if sort[a] or sort[b] then
      return sort[a] and true
    end
    return CmpLower(a, b)
  end)

  if IsValid(o) and o:IsKindOf("CObject") then

    table.insert(res,1,Concat(
      "<center>--",
      self:HyperLink(function()
        Examine_totextex(obj_metatable,self)
      end),
      o.class,
      HLEnd,
      "@",
      self:valuetotextex(o:GetPos()),
      "--<vspace 6><left>"
    ))

    if o:IsValidPos() and IsValidEntity(o.entity) and 0 < o:GetAnimDuration() then
      local pos = o:GetVisualPos() + o:GetStepVector() * o:TimeToAnimEnd() / o:GetAnimDuration()
      table.insert(res, 2, Concat(
        GetStateName(o:GetState()),
        ", step:",
        self:HyperLink(function()
          ShowMe(pos)
        end),
        tostring(o:GetStepVector(o:GetState(),0)),
        HLEnd
      ))
    end

  elseif is_table and obj_metatable then
      table.insert(res, 1, Concat(
        "<center>--",
        self:valuetotextex(obj_metatable),
        ": metatable--<vspace 6><left>"
      ))
  end

  -- add strings/numbers to the body
  if obj_type == "number" or obj_type == "string" or obj_type == "boolean" then
    res[#res+1] = tostring(o)
  elseif obj_type == "userdata" then
    local str = T(o)
    -- might as well just return the userdata instead of these
    if str == "stripped" or str:find("Missing locale string id") then
      str = o
    end
    res[#res+1] = tostring(str)
  -- add some extra info for funcs
  elseif obj_type == "function" then
    local dbg_value = "\ndebug.getinfo: "
    local dbg_table = debug.getinfo(o) or empty_table
    for key,value in pairs(dbg_table) do
      dbg_value = Concat(dbg_value,"\n",key,": ",value)
    end
    res[#res+1] = dbg_value
  end

  return TableConcat(res,"\n")
end
---------------------------------------------------------------------------------------------------------------------
--menu
local function Show_menu(o)
  if IsValid(o) then
    ShowMe(o)
  else
    for k, v in pairs(o) do
      if IsPoint(k) or IsValid(k) then
        ShowMe(k)
      end
      if IsPoint(v) or IsValid(v) then
        ShowMe(v)
      end
    end
  end
end
local function ClearShowMe_menu()
  ChoGGi.ComFuncs.ClearShowMe()
end

local function Destroy_menu(o,self)
  local z = self.ZOrder
  self:SetZOrder(1)
  ChoGGi.ComFuncs.QuestionBox(
    S[302535920000414--[[Are you sure you wish to destroy it?--]]],
    function(answer)
      self:SetZOrder(z)
      if answer and IsValid(o) then
    --~     o:delete()
        ChoGGi.CodeFuncs.DeleteObject(o)
      end
    end,
    S[697--[[Destroy--]]]
  )
end

local function Refresh_menu(_,self)
  if self.obj then
    self:SetObj(self.obj)
  end
end
local function SetTransp_menu(_,self)
  self.transp_mode = not self.transp_mode
  self:SetTranspMode(self.transp_mode)
end

function Examine:menu(o)
--~   local obj_metatable = getmetatable(o)
  local obj_type = type(o)
  local res = {"  "}
  res[#res+1] = self:HyperLink(function()
    Refresh_menu(o,self)
  end)
  res[#res+1] = "["
  res[#res+1] = S[1000220--[[Refresh--]]]
  res[#res+1] = "]"
  res[#res+1] = HLEnd
  res[#res+1] = " "
  if IsValid(o) and obj_type == "table" then
    res[#res+1] = self:HyperLink(function()
      Show_menu(o)
    end)
    res[#res+1] = S[302535920000058--[[[ShowIt]--]]]
    res[#res+1] = HLEnd
    res[#res+1] = " "
  end
  res[#res+1] = self:HyperLink(ClearShowMe_menu)
  res[#res+1] = S[302535920000059--[[[Clear Markers]--]]]
  res[#res+1] = HLEnd
  res[#res+1] = " "
  res[#res+1] = self:HyperLink(function()
    SetTransp_menu(o,self)
  end)
  res[#res+1] = S[302535920000064--[[[Transp]--]]]
  res[#res+1] = HLEnd
  if IsValid(o) then
    res[#res+1] = " "
    res[#res+1] = self:HyperLink(function()
      Destroy_menu(o,self)
    end)
    res[#res+1] = S[302535920000060--[[[Destroy It!]--]]]
    res[#res+1] = HLEnd
    res[#res+1] = " "
  end
  return TableConcat(res)
end

-- used to build parents/ancestors menu
local pmenu_list_items
local pmenu_skip_dupes
local function BuildParents(self,list,list_type,title,sort_type)
  if list and next(list) then
    list = RetSortTextAssTable(list,sort_type)
    self[list_type] = list
    pmenu_list_items[#pmenu_list_items+1] = {text = Concat("   ---- ",title)}
    for i = 1, #list do
      -- no sense in having an item in parents and ancestors
      if not pmenu_skip_dupes[list[i]] then
        pmenu_skip_dupes[list[i]] = true
        pmenu_list_items[#pmenu_list_items+1] = {text = list[i]}
      end
    end
  end
end
function Examine:SetObj(o)
  o = o or self.obj

  self.onclick_handles = {}
  self.obj = o
  self.idText:SetText(self:totextex(o))
  self.idLinks:SetText(self:menu(o))

  local is_table = type(o) == "table"
  local name = RetName(o)

--~   -- update attaches button with attaches amount
--~   local attaches = is_table and type(o.GetAttaches) == "function" and o:IsKindOf("ComponentAttach") and o:GetAttaches()
--~   local attach_amount = attaches and #attaches
--~   self.idAttaches:SetHint(S[302535920000070--[[Shows list of attachments. This %s has: %s.--]]]:format(name,attach_amount))
--~   if is_table then

--~     --add object name to title
--~     if type(o.handle) == "number" then
--~       name = Concat(name," (",o.handle,")")
--~     elseif #o > 0 then
--~       name = Concat(name," (",#o,")")
--~     end

--~     -- reset menu list
--~     pmenu_list_items = {}
--~     pmenu_skip_dupes = {}
--~     -- build menu list
--~     BuildParents(self,o.__parents,"parents",S[302535920000520--[[Parents--]]])
--~     BuildParents(self,o.__ancestors,"ancestors",S[302535920000525--[[Ancestors--]]],true)
--~     -- if anything was added to the list then add to the menu
--~     if #pmenu_list_items > 0 then
--~       self.idParentsMenu:SetContent(pmenu_list_items, true)
--~     else
--~       --no parents or ancestors, so hide the button
--~       self.idParents:SetVisible()
--~     end

--~     --attaches menu
--~     if attaches and attach_amount > 0 then

--~       local spacer_text = S[302535920000053--[[Attaches--]]]
--~       local list_items = {
--~         {
--~           text = Concat("   ---- ",spacer_text),
--~           rollover = spacer_text
--~         }
--~       }

--~       for i = 1, #attaches do
--~         local hint = attaches[i].handle or type(attaches[i].GetPos) == "function" and Concat("Pos: ",attaches[i]:GetPos())
--~         if type(hint) == "number" then
--~           hint = Concat(S[302535920000955--[[Handle--]]],": ",hint)
--~         end
--~         list_items[#list_items+1] = {
--~           text = RetName(attaches[i]),
--~           rollover = hint or attaches[i].class,
--~           obj = attaches[i],
--~         }
--~       end

--~       self.idAttachesMenu:SetContent(list_items, true)

--~     else
--~       self.idAttaches:SetVisible()
--~     end
--~   end

  --limit length so we don't cover up close button (only for objlist, everything else is short enough)
  self.idTitle:SetText(utf8.sub(Concat(str_title,name), 1, 45))
end

function Examine:Done(result)
  if self.autorefresh_thread then
    DeleteThread(self.autorefresh_thread)
  end
  ChoGGi_Window.Done(self,result)
end
