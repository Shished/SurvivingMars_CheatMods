-- See LICENSE for terms

local LICENSE = [[Any code from https://github.com/HaemimontGames/SurvivingMars is copyright by their LICENSE

All of my code is licensed under the MIT License as follows:

MIT License

Copyright (c) [2018] [ChoGGi]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.]]

-- if we use global func more then once: make them local for that small bit o' speed
local select,tostring,type,pcall,table = select,tostring,type,pcall,table
local AsyncFileOpen = AsyncFileOpen

-- just in case they remove oldTableConcat
local TableConcat
pcall(function()
  TableConcat = oldTableConcat
end)
TableConcat = TableConcat or table.concat

-- hello
SolariaTelepresence = {
  _LICENSE = LICENSE,
  email = "SM_Mods@choggi.org",
  id = "ChoGGi_SolariaTelepresence",
  -- orig funcs that we replace
  OrigFuncs = {},
  -- CommonFunctions.lua
  ComFuncs = {
    FileExists = function(file)
      local _,str = AsyncFileOpen(file)
      return str
    end,
    -- thanks for replacing concat... what's wrong with using table.concat2?
    TableConcat = TableConcat,
  },
  -- /Code/_Functions.lua
  CodeFuncs = {},
  -- /Code/*Menu.lua and /Code/*Func.lua
  MenuFuncs = {},
  -- OnMsgs.lua
  MsgFuncs = {},
  -- InfoPaneCheats.lua
  InfoFuncs = {},
  -- Defaults.lua
  SettingFuncs = {},
  -- temporary settings that aren't saved to SettingsFile
  Temp = {
    -- collect msgs to be displayed when game is loaded
    StartupMsgs = {},
  },
  -- settings that are saved to SettingsFile
  UserSettings = {
    BuildingSettings = {},
    Transparency = {},
  },
}
local SolariaTelepresence = SolariaTelepresence
local Mods = Mods
SolariaTelepresence._VERSION = Mods[SolariaTelepresence.id].version
SolariaTelepresence.ModPath = CurrentModPath
SolariaTelepresence.MountPath = SolariaTelepresence.ModPath

do -- Concat
  -- SM has a tendency to inf loop when you return a non-string value that they want to table.concat
  -- so now if i accidentally return say a menu item with a function for a name, it'll just look ugly instead of freezing (cursor moves screen wasd doesn't)
  -- this is also used instead of "str .. str"; anytime you do that lua will hash the new string, and store it till exit (which means this is faster, and uses less memory)
  local concat_table = {}
  function SolariaTelepresence.ComFuncs.Concat(...)
    -- i assume sm added a c func to clear tables, which does seem to be faster than a lua for loop
    table.iclear(concat_table)
    -- build table from args
    local concat_value
    local concat_type
    for i = 1, select("#",...) do
      concat_value = select(i,...)
      -- no sense in calling a func more then we need to
      concat_type = type(concat_value)
      if concat_type == "string" or concat_type == "number" then
        concat_table[i] = concat_value
      else
        concat_table[i] = tostring(concat_value)
      end
    end
    -- and done
    return TableConcat(concat_table)
  end
end
local Concat = SolariaTelepresence.ComFuncs.Concat

do -- translate
  --load up translation strings
  local function LoadLocale(file)
    if not pcall(function()
      LoadTranslationTableFile(file)
    end) then
      local err = [[Problem loading locale: %s

        Please send me latest log file: %s]]
      DebugPrintNL(err:format(file,SolariaTelepresence.email))
    end
  end

  -- load locale translation
  local locale_file = Concat(SolariaTelepresence.ModPath,"Locales/",GetLanguage(),".csv")
  if SolariaTelepresence.ComFuncs.FileExists(locale_file) then
    LoadLocale(locale_file)
  else
    LoadLocale(Concat(SolariaTelepresence.ModPath,"Locales/","English.csv"))
  end
  Msg("TranslationChanged")
end

dofolder_files(Concat(SolariaTelepresence.ModPath,"Code/"))

