return PlaceObj("ModDef", {
	"title", "Expanded Cheat Menu v8.4 Test",
	"version", 84,
	"saved", 1534680000,
	"steam_id", "1411157810",
	"id", "ChoGGi_CheatMenu",
	"image", "Preview.png",
	"TagGameplay", true,
	"TagInterface", true,
	"TagTools", true,
	"TagOther", true,
	"TagCheats", true,
	"code", {
    -- start 'er up
		"Init.lua",
    -- needs before everything else
		"Code/Strings.lua",
		"Code/CommonFunctions.lua",
		"Code/Settings.lua",
    -- custom dialogs
		"Code/Dialogs/_Classes.lua",
		"Code/Dialogs/ConsoleLogWin.lua",
		"Code/Dialogs/Examine.lua",
		"Code/Dialogs/ExecCode.lua",
		"Code/Dialogs/FindValue.lua",
		"Code/Dialogs/ListChoice.lua",
		"Code/Dialogs/MultiLineText.lua",

--~     -- temp added to check out keys for XXXUnknownXXX
--~ 		"Code/Dialogs/KeyPresser.lua",

--~ 		"Code/Dialogs/MonitorInfo.lua",
--~ 		"Code/Dialogs/ObjectManipulator.lua",
    -- stuff that can come later
		"Code/Misc/_Functions.lua",
		"Code/Misc/ConsoleControls.lua",
		"Code/Misc/InfoPaneCheats.lua",
		"Code/Misc/OnMsgs.lua",
		"Code/Misc/ReplacedFunctions.lua",
		"Code/Misc/Testing.lua",
    -- menus/menu items/shortcuts
		"Code/Menus/Keys.lua",
		"Code/Menus/BuildingsFunc.lua",
		"Code/Menus/BuildingsMenu.lua",
		"Code/Menus/CapacityFunc.lua",
		"Code/Menus/CapacityMenu.lua",
		"Code/Menus/CheatsFunc.lua",
		"Code/Menus/CheatsMenu.lua",
		"Code/Menus/ColonistsFunc.lua",
		"Code/Menus/ColonistsMenu.lua",
		"Code/Menus/DebugFunc.lua",
		"Code/Menus/DebugMenu.lua",
		"Code/Menus/ExpandedFunc.lua",
		"Code/Menus/ExpandedMenu.lua",
		"Code/Menus/FixesFunc.lua",
		"Code/Menus/FixesMenu.lua",
		"Code/Menus/GameFunc.lua",
		"Code/Menus/GameMenu.lua",
		"Code/Menus/HelpFunc.lua",
		"Code/Menus/HelpMenu.lua",
		"Code/Menus/MiscFunc.lua",
		"Code/Menus/MiscMenu.lua",
		"Code/Menus/MissionFunc.lua",
		"Code/Menus/MissionMenu.lua",
		"Code/Menus/ResourcesFunc.lua",
		"Code/Menus/ResourcesMenu.lua",
		"Code/Menus/VehiclesFunc.lua",
		"Code/Menus/VehiclesMenu.lua",

    -- gee sure would be nice to load these like the devs do, but i suppose it's too much work to limit dofile env.
	},

  -- i leave this commented out to force users to read description and install helpermod (for now)
	"lua_revision", LuaRevision,

	"author", [[ChoGGi
With thanks to chippydip, admbraden, SkiRich, BoehserOnkel, and Fling.
Random internet users reporting bugs/requesting features.]],

	"description", string.format([[Enables cheat menu, cheat info pane, console, adds a whole bunch of menuitems: set gravity, follow camera, higher render/shadow distance, larger shadow map, change logo/sponsor/commander, unlimited wonders, build almost anywhere, instant mysteries, useful shortcuts, etc... Requests are welcome.

##### Info
F2: Toggle the cheats menu (Ctrl-F2 to toggle cheats panel).
F3: Set object opacity.
F4: Open object examiner.
F5: Open object manipulator (or use edit button in examiner).
F6: Change building colour (Shift or Ctrl to apply random/default).
F7: Toggle using last building orientation.
F9: Clear the console log (or in console uncheck Settings>Console Log).
Enter or Tilde: Show the console.
Ctrl+F: Fill resource of object.
Number keys: Toggle build menu (Shift-*Num for menus above 10).
Ctrl-Alt-Shift-R: Opens console and places "restart" in it.
Ctrl-Space: Opens placement mode with the last built object.
Ctrl-Shift-Space: Opens placement mode with selected object (works with deposits).
Ctrl-Alt-Shift-D: Delete object (select multiple objects in editor and use this to delete them all).
Shift-Q: Clone selected object to mouse position.
Ctrl-Shift-T: Terrain Editor Mode.
More shortcut keys are available, see menu items.

When I say object that means either the selected object or the object under the mouse cursor.

There's a cheats section in most selection panels on the right side of the screen.
Menu>Misc>Infopanel Cheats (on by default)
Hover over menu items for a description (will say if enabled or disabled).

Settings are saved at %%APPDATA%%\Surviving Mars\CheatMenuModSettings.lua
^ delete to reset to default settings (unless it's something like changing capacity of RC Transports, that's kept in savegame)

You can edit the shortcut keys in the settings file (or blank them to disable).



##### For more info see Menu>Help>ECM>Readme
Bleeding edge: https://github.com/ChoGGi/SurvivingMars_CheatMods



##### Thanks
chippydip (for the original mod): http://steamcommunity.com/sharedfiles/filedetails/?id=1336604230
admbraden (for gifting me a Steam copy): https://steamcommunity.com/id/admbraden
HPK archiver: https://github.com/nickelc/hpk
unluac: https://sourceforge.net/projects/unluac/
Everyone else giving suggestions/pointing out issues.


##### Access to missing functionality
Da Vinci updated added a blacklist of functions, you can use this to bypass them.
%sHelperMod
]],ConvertToOSPath(CurrentModPath)),
})
