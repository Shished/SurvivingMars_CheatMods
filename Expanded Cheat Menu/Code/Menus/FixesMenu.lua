-- See LICENSE for terms

local Concat = ChoGGi.ComFuncs.Concat
local S = ChoGGi.Strings
local Actions = ChoGGi.Temp.Actions
local icon = "CommonAssets/UI/Menu/ReportBug.tga"

local str_ExpandedCM_Fixes = "Expanded CM.Fixes"
Actions[#Actions+1] = {
  ActionMenubar = "Expanded CM",
  ActionName = Concat(S[302535920000922--[[Fixes--]]]," .."),
  ActionId = str_ExpandedCM_Fixes,
  ActionIcon = "CommonAssets/UI/Menu/folder.tga",
  OnActionEffect = "popup",
  ActionSortKey = "1Fixes",
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes,
  ActionName = S[302535920001299--[[Toggle Working On All Buildings--]]],
  ActionId = "Expanded CM.Fixes.Toggle Working On All Buildings",
  ActionIcon = icon,
  RolloverText = S[302535920001300--[[Does what it says; all buildings will have their working status toggled (fixes a couple issues).-]]],
  OnAction = ChoGGi.MenuFuncs.ToggleWorkingAll,
  ActionSortKey = "9",
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes,
  ActionName = S[302535920001295--[[Drones Not Repairing Domes--]]],
  ActionId = "Expanded CM.Fixes.Drones Not Repairing Domes",
  ActionIcon = icon,
  RolloverText = S[302535920001296--[[If your drones are just dumping polymers into the centre of your dome.--]]],
  OnAction = ChoGGi.MenuFuncs.DronesNotRepairingDomes,
  ActionSortKey = "9",
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes,
  ActionName = S[302535920000461--[[All Pipe Skins To Default--]]],
  ActionId = "Expanded CM.Fixes.All Pipe Skins To Default",
  ActionIcon = icon,
  RolloverText = S[302535920000463--[[Large Water Tank + Pipes + Chrome skin = borked looking connections.
This resets all pipes to the default skin.--]]],
  OnAction = ChoGGi.MenuFuncs.AllPipeSkinsToDefault,
  ActionSortKey = "9",
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes,
  ActionName = S[302535920000292--[[Reset Rovers--]]],
  ActionId = "Expanded CM.Fixes.Reset Rovers",
  ActionIcon = icon,
  RolloverText = S[302535920000882--[[If you have borked rovers, this will probably fix them (may take a few seconds to apply).

You may need to toggle the recall drones button (for certain issues).--]]],
  OnAction = ChoGGi.MenuFuncs.ResetRovers,
  ActionSortKey = "9",
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes,
  ActionName = S[302535920000055--[[Reset All Colonists--]]],
  ActionId = "Expanded CM.Fixes.Reset All Colonists",
  ActionIcon = icon,
  RolloverText = S[302535920000939--[[Fix certain freezing issues (mouse still moves screen, keyboard doesn't), will lower comfort by about 20.--]]],
  OnAction = ChoGGi.MenuFuncs.ResetAllColonists,
  ActionSortKey = "9",
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes,
  ActionName = S[302535920000581--[[Toggle Collisions On Selected Object--]]],
  ActionId = "Expanded CM.Fixes.Toggle Collisions On Selected Object",
  ActionIcon = icon,
  RolloverText = S[302535920000582--[[Just in case you get something stuck somewhere.--]]],
  OnAction = ChoGGi.MenuFuncs.CollisionsObject_Toggle,
  ActionSortKey = "9",
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes,
  ActionName = S[302535920000583--[[Rebuild Walkable Points In Domes--]]],
  ActionId = "Expanded CM.Fixes.Rebuild Walkable Points In Domes",
  ActionIcon = icon,
  RolloverText = S[302535920000584--[[Useful? who knows, won't hurt.--]]],
  OnAction = ChoGGi.MenuFuncs.RebuildWalkablePointsInDomes,
  ActionSortKey = "9",
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes,
  ActionName = S[302535920000585--[[Colonists Stuck Outside Rocket--]]],
  ActionId = "Expanded CM.Fixes.Colonists Stuck Outside Rocket",
  ActionIcon = icon,
  RolloverText = S[302535920000586--[[If any colonists are stuck AND you don't have any other rockets unloading colonists.

This will do a little copy n paste fix (they'll keep the same traits/whatnot).--]]],
  OnAction = ChoGGi.MenuFuncs.ColonistsStuckOutsideRocket,
  ActionSortKey = "9",
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes,
  ActionName = S[302535920000587--[[Remove Missing Class Objects (Warning)--]]],
  ActionId = "Expanded CM.Fixes.Remove Missing Class Objects (Warning)",
  ActionIcon = icon,
  RolloverText = Concat(S[6779--[[Warning--]]],": ",S[302535920000588--[[May crash game, SAVE FIRST. These are probably from mods that were removed (if you're getting a PinDlg error then this should fix it).--]]]),
  OnAction = ChoGGi.MenuFuncs.RemoveMissingClassObjects,
  ActionSortKey = "9",
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes,
  ActionName = Concat(" ",S[302535920000589--[[Fire Most Fixes--]]]),
  ActionId = "Expanded CM.Fixes.Fire Most Fixes",
  ActionIcon = icon,
  RolloverText = S[302535920000590--[[Fires all the fixes in the "Most" menu (nuke 'em from orbit and all that).
Should be safe to use without breaking anything.--]]],
  OnAction = ChoGGi.MenuFuncs.FireMostFixes,
  ActionSortKey = "0",
}

local str_ExpandedCM_Fixes_Most = "Expanded CM.Fixes.Most"
Actions[#Actions+1] = {
  ActionMenubar = "Expanded CM.Fixes",
  ActionName = Concat(S[302535920000935--[[Most--]]]," .."),
  ActionId = str_ExpandedCM_Fixes_Most,
  ActionIcon = "CommonAssets/UI/Menu/folder.tga",
  OnActionEffect = "popup",
  ActionSortKey = "0Most",
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Most,
  ActionName = S[302535920000591--[[Colonists Trying To Board Rocket Freezes Game--]]],
  ActionId = "Expanded CM.Fixes.Most.Colonists Trying To Board Rocket Freezes Game",
  ActionIcon = icon,
  RolloverText = S[302535920000592--[[Doesn't fix the underlying cause, but it works.--]]],
  OnAction = ChoGGi.MenuFuncs.ColonistsTryingToBoardRocketFreezesGame,
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Most,
  ActionName = S[302535920000593--[[Remove Particles With Null Polylines--]]],
  ActionId = "Expanded CM.Fixes.Most.Remove Particles With Null Polylines",
  ActionIcon = icon,
  RolloverText = S[302535920000594--[["It won't hurt anything to run this, as for when/if: I suppose if you have a broken looking object? or a meteor crashes into your mirror sphere power decoy thingy.
This may remove some smoke stacks like the concrete extractors (just toggle working on any that don't have smoke)."--]]],
  OnAction = ChoGGi.MenuFuncs.ParticlesWithNullPolylines,
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Most,
  ActionName = S[302535920000595--[[Mirror Sphere Stuck--]]],
  ActionId = "Expanded CM.Fixes.Most.Mirror Sphere Stuck",
  ActionIcon = icon,
  RolloverText = S[302535920000596--[[If you have a mirror sphere stuck at the edge of the map, and it just won't die/move... (also removes any borked cone of a captured sphere)--]]],
  OnAction = ChoGGi.MenuFuncs.MirrorSphereStuck,
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Most,
  ActionName = S[302535920000597--[[Stutter With High FPS--]]],
  ActionId = "Expanded CM.Fixes.Most.Stutter With High FPS",
  ActionIcon = icon,
  RolloverText = S[302535920000598--[[If your units are doing stutter movement, but your FPS is fine then you likely have a unit with borked pathing (or there's one of those magical invisible walls in it's way).

This also works for colonists practicing the human centipede.--]]],
  OnAction = ChoGGi.MenuFuncs.StutterWithHighFPS,
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Most,
  ActionName = S[302535920000599--[[Drones Keep Trying Blocked Areas--]]],
  ActionId = "Expanded CM.Fixes.Most.Drones Keep Trying Blocked Areas",
  ActionIcon = icon,
  RolloverText = S[302535920000600--[[If you have a certain dronehub who's drones keep trying to get somewhere they can't reach, try this.--]]],
  OnAction = ChoGGi.MenuFuncs.DronesKeepTryingBlockedAreas,
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Most,
  ActionName = S[302535920000601--[[Idle Drones Won't Build When Resources Available--]]],
  ActionId = "Expanded CM.Fixes.Most.Idle Drones Won't Build When Resources Available",
  ActionIcon = icon,
  RolloverText = S[302535920000602--[[If you have drones that are idle while contruction sites need to be built and resources are available then you likely have some unreachable building sites.

This removes any of those (resources won't be touched).--]]],
  OnAction = ChoGGi.MenuFuncs.RemoveUnreachableConstructionSites,
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Most,
  ActionName = S[302535920000603--[[Remove Yellow Grid Marks--]]],
  ActionId = "Expanded CM.Fixes.Most.Remove Yellow Grid Marks",
  ActionIcon = icon,
  RolloverText = S[302535920000604--[[If you have any buildings with those yellow grid marks around them (or anywhere else), then this will remove them.--]]],
  OnAction = ChoGGi.MenuFuncs.RemoveYellowGridMarks,
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Most,
  ActionName = S[302535920001193--[[Remove Blue Grid Marks--]]],
  ActionId = "Expanded CM.Fixes.Most.Remove Blue Grid Marks",
  ActionIcon = icon,
  RolloverText = S[302535920001197--[[If you have any buildings with the selection grid around it, and you don't have it selected.--]]],
  OnAction = ChoGGi.MenuFuncs.RemoveBlueGridMarks,
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Most,
  ActionName = S[302535920000605--[[Project Morpheus Radar Fell Down--]]],
  ActionId = "Expanded CM.Fixes.Most.Project Morpheus Radar Fell Down",
  ActionIcon = icon,
  RolloverText = S[302535920000606--[[Sometimes the blue radar thingy falls off.--]]],
  OnAction = ChoGGi.MenuFuncs.ProjectMorpheusRadarFellDown,
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Most,
  ActionName = Concat(S[302535920000157--[[Cables & Pipes--]]],": ",S[302535920000607--[[Instant Repair--]]]),
  ActionId = "Expanded CM.Fixes.Most.Cables & Pipes: Instant Repair",
  ActionIcon = "CommonAssets/UI/Menu/ViewCamPath.tga",
  RolloverText = S[302535920000608--[[Instantly repair all broken pipes and cables.--]]],
  OnAction = ChoGGi.MenuFuncs.CablesAndPipesRepair,
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Most,
  ActionName = S[302535920000609--[[Attach Buildings To Nearest Working Dome--]]],
  ActionId = "Expanded CM.Fixes.Most.Attach Buildings To Nearest Working Dome",
  ActionIcon = icon,
  RolloverText = S[302535920000610--[[If you placed inside buildings outside and removed the dome they're attached to; use this.--]]],
  OnAction = ChoGGi.MenuFuncs.AttachBuildingsToNearestWorkingDome,
}

local str_ExpandedCM_Fixes_Toggles = "Expanded CM.Fixes.Toggles"
Actions[#Actions+1] = {
  ActionMenubar = "Expanded CM.Fixes",
  ActionName = Concat(S[302535920000938--[[Toggles--]]]," .."),
  ActionId = str_ExpandedCM_Fixes_Toggles,
  ActionIcon = "CommonAssets/UI/Menu/folder.tga",
  OnActionEffect = "popup",
  ActionSortKey = "6Toggles",
}

if ChoGGi.testing then
  Actions[#Actions+1] = {
    ActionMenubar = str_ExpandedCM_Fixes_Toggles,
    ActionName = S[302535920001071--[[Drone Charges From Rover Wrong Angle--]]],
    ActionId = "Expanded CM.Fixes.Toggles.Drone Charges From Rover Wrong Angle",
    ActionIcon = icon,
    RolloverText = function()
      return ChoGGi.ComFuncs.SettingState(
        ChoGGi.UserSettings.DroneChargesFromRoverWrongAngle,
        302535920001071--[[Drone Charges From Rover Wrong Angle--]]
      )
    end,
    OnAction = ChoGGi.MenuFuncs.DroneChargesFromRoverWrongAngle_Toggle,
  }
end

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Toggles,
  ActionName = S[302535920001266--[[Borked Transport Pathing--]]],
  ActionId = "Expanded CM.Fixes.Toggles.Borked Transport Pathing",
  ActionIcon = icon,
  RolloverText = function()
    return ChoGGi.ComFuncs.SettingState(
      ChoGGi.UserSettings.CheckForBorkedTransportPath,
      302535920001268--[["RC Transports on a route have a certain tendency to get stuck and bog the game down (high speed feels like normal speed).

This'll check for and stop any borked ones (it'll show a popup msg when it stops one)."--]]
    )
  end,
  OnAction = ChoGGi.MenuFuncs.CheckForBorkedTransportPath_Toggle,
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Toggles,
  ActionName = S[302535920000248--[[Colonists Stuck Outside Service Buildings--]]],
  ActionId = "Expanded CM.Fixes.Toggles.Colonists Stuck Outside Service Buildings",
  ActionIcon = icon,
  RolloverText = function()
    return ChoGGi.ComFuncs.SettingState(
      ChoGGi.UserSettings.ColonistsStuckOutsideServiceBuildings,
      302535920000249--[["Colonists will leave a diner/etc and stop outside of it and not move anymore (might be related to one of those smarter worker ai mods).

Seems to fix it after a Sol or two, so you shouldn't need to leave this running."--]]
    )
  end,
  OnAction = ChoGGi.MenuFuncs.ColonistsStuckOutsideServiceBuildings_Toggle,
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Toggles,
  ActionName = S[302535920000613--[[Drone Carry Amount--]]],
  ActionId = "Expanded CM.Fixes.Toggles.Drone Carry Amount",
  ActionIcon = icon,
  RolloverText = function()
    return ChoGGi.ComFuncs.SettingState(
      ChoGGi.UserSettings.DroneResourceCarryAmountFix,
      302535920000614--[["Drones only pick up resources from buildings when the amount stored is equal or greater then their carry amount.
This forces them to pick up whenever there's more then one resource).

If you have an insane production amount set then it'll take an (in-game) hour between calling drones."--]]
    )
  end,
  OnAction = ChoGGi.MenuFuncs.DroneResourceCarryAmountFix_Toggle,
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_Toggles,
  ActionName = S[302535920000615--[[Sort Command Center Dist--]]],
  ActionId = "Expanded CM.Fixes.Toggles.Sort Command Center Dist",
  ActionIcon = "CommonAssets/UI/Menu/Axis.tga",
  RolloverText = function()
    return ChoGGi.ComFuncs.SettingState(
      ChoGGi.UserSettings.SortCommandCenterDist,
      302535920000616--[["Each Sol goes through all buildings and sorts their cc list by nearest.

Takes less then a second on a map with 3600+ buildings and 50+ drone hubs."--]]
    )
  end,
  OnAction = ChoGGi.MenuFuncs.SortCommandCenterDist_Toggle,
}

local str_ExpandedCM_Fixes_ECMFixes = "Expanded CM.Fixes.ECM Fixes"
Actions[#Actions+1] = {
  ActionMenubar = "Expanded CM.Fixes",
  ActionName = Concat(S[302535920000887--[[ECM--]]]," ",S[302535920000922--[[Fixes--]]]," .."),
  ActionId = str_ExpandedCM_Fixes_ECMFixes,
  ActionIcon = "CommonAssets/UI/Menu/folder.tga",
  OnActionEffect = "popup",
  ActionSortKey = "99",
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_ECMFixes,
  ActionName = S[302535920000617--[[See tooltip--]]],
  ActionId = "Expanded CM.Fixes.ECM Fixes.See tooltip",
  ActionIcon = "CommonAssets/UI/Menu/help.tga",
  RolloverText = S[302535920000618--[[Fixes for stuff that I messed up, these should all be fine to fire even without the issues, but they shouldn't be needed.--]]],
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_ECMFixes,
  ActionName = S[302535920000619--[[Fix Black Cube Colonists--]]],
  ActionId = "Expanded CM.Fixes.ECM Fixes.Fix Black Cube Colonists",
  ActionIcon = icon,
  RolloverText = S[302535920000620--[[If any colonists are black cubes click this.--]]],
  OnAction = ChoGGi.MenuFuncs.ColonistsFixBlackCube,
  ActionSortKey = "1",
}

Actions[#Actions+1] = {
  ActionMenubar = str_ExpandedCM_Fixes_ECMFixes,
  ActionName = S[302535920000621--[[Align All Buildings To Hex Grid--]]],
  ActionId = "Expanded CM.Fixes.ECM Fixes.Align All Buildings To Hex Grid",
  ActionIcon = icon,
  RolloverText = S[302535920000622--[[If you have any buildings that aren't aligned to the hex grids use this.--]]],
  OnAction = ChoGGi.MenuFuncs.AlignAllBuildingsToHexGrid,
  ActionSortKey = "1",
}
