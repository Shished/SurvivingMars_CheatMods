local Concat = ReplaceCursors.ComFuncs.Concat
--~ local TableConcat = ReplaceCursors.ComFuncs.TableConcat

--~ local cursors
--~ if ReplaceCursors.ComFuncs.FileExists("AppData/Cursors") then
--~   cursors = "AppData/Cursors/"
--~ else
--~   cursors = Concat(CurrentModPath,"Cursors/")
--~ end
local cursors = Concat(CurrentModPath,"Cursors/")

-- for some reason this doesn't work for everything... (caching I suppose)
--~ Unmount("UI")

MountFolder("UI/Cursors",cursors)


--~ AsyncMountPack("UI", "Packs/UI.hpk")

--~ UIL.ReloadImage("UI/Cursors/cursor.tga")
--~ UIL.ReloadImage("UI/Cursors/Rollover.tga")

-- for some reason the default cursor doesn't get replaced with the above, so we do this crap
local cursor = Concat(cursors,"cursor.tga")
local rollover = Concat(cursors,"Rollover.tga")
local loading = Concat(cursors,"Loading.tga")
local pipeplace = Concat(cursors,"PipePlacement.tga")
local salvage = Concat(cursors,"Salvage.tga")

-- I would just add the ones I care for, but screw it: just do any using the wrong one
for _,t in pairs(XTemplates) do
  if t[1].MouseCursor == "UI/Cursors/Rollover.tga" then
    t[1].MouseCursor = rollover
  end
end

--~ terminal.desktop:SetMouseCursor("CommonAssets/UI/Controls/Button/Close.tga")

-- default cursor for most objects
PropertyObject.MouseCursor = cursor
InterfaceModeDialog.MouseCursor = cursor
-- new cursors use the new one
const.DefaultMouseCursor = cursor

-- loadin'
MarsBaseLoadingScreen.MouseCursor = loading
MarsLoadingScreen.MouseCursor = loading
MarsAutosaveScreen.MouseCursor = loading
MarsDeleteGameScreen.MouseCursor = loading

-- hud buttons at the bottom of the screen
HUDButton.MouseCursor = rollover
-- a bunch of stuff
XWindow.MouseCursor = rollover
SplashScreen.MouseCursor = rollover
-- probably don't need to bother, but screw it
DemolishModeDialog.MouseCursor = salvage
GridConstructionDialogPipes.MouseCursor = pipeplace
GridSwitchConstructionDialogPipes.MouseCursor = pipeplace
GridSwitchConstructionDialogPassageRamp.MouseCursor = pipeplace

-- bunch of functions that try to use the cached one
local orig_OnScreenNotification_Init = OnScreenNotification.Init
function OnScreenNotification:Init()
  orig_OnScreenNotification_Init(self)
  self.idButton:SetMouseCursor(rollover)
end

local orig_MenuCategoryButton_Init = MenuCategoryButton.Init
function MenuCategoryButton:Init()
  orig_MenuCategoryButton_Init(self)
  self.idButton:SetMouseCursor(rollover)
  self.idCategoryButton:SetMouseCursor(rollover)
end

local orig_HexButtonItem_Init = HexButtonItem.Init
function HexButtonItem:Init()
  orig_HexButtonItem_Init(self)
  self.idButton:SetMouseCursor(rollover)
end

local orig_SplashScreen_Init = SplashScreen.Init
function SplashScreen:Init()
  orig_SplashScreen_Init(self)
  self.idButton:SetMouseCursor(rollover)
end

local orig_XPageScroll_Init = XPageScroll.Init
function XPageScroll:Init()
  orig_XPageScroll_Init(self)
  self.idPrev:SetMouseCursor(rollover)
  self.idNext:SetMouseCursor(rollover)
end

local orig_OnScreenHintDlg_Init = OnScreenHintDlg.Init
function OnScreenHintDlg:Init()
  orig_OnScreenHintDlg_Init(self)
  self.idMinimized:SetMouseCursor(rollover)
  self.idPrev:SetMouseCursor(rollover)
  self.idNext:SetMouseCursor(rollover)
  self.idEncyclopediaBtn:SetMouseCursor(rollover)
  self.idClose:SetMouseCursor(rollover)
end
