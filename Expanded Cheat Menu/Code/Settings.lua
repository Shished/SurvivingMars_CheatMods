-- See LICENSE for terms

-- stores default values and some tables

local Concat = ChoGGi.ComFuncs.Concat
--~ local T = ChoGGi.ComFuncs.Translate
local S = ChoGGi.Strings
local blacklist = ChoGGi.blacklist

local next,pairs,type,table = next,pairs,type,table

do -- cheat menu custom menus
  local Actions = ChoGGi.Temp.Actions
  local function AddMenuitem(name,str_id,sort)
    Actions[#Actions+1] = {
      ActionMenubar = "DevMenu",
      ActionName = S[str_id],
      ActionId = name,
      OnActionEffect = "popup",
      ActionSortKey = sort,
    }
  end
  AddMenuitem("Cheats",27,"01")
  AddMenuitem("Expanded CM",302535920000104,"02")
  AddMenuitem("Game",283142739680,"03")
  AddMenuitem("Presets",302535920000979,"04")
  AddMenuitem("Debug",1000113,"05")
  AddMenuitem("Help",487939677892,"06")
end -- do

-- useful lists
ChoGGi.Tables = {
  -- display names only! (stored as numbers, not names like the rest; which is why i'm guessing)
--~ s.race = 1
--~ s:ChooseEntity()
  ColonistRaces = {
    S[1859--[[White--]]],[S[1859--[[White--]]]] = true,
    S[302535920000739--[[Black--]]],[S[302535920000739--[[Black--]]]] = true,
    S[302535920000740--[[Asian--]]],[S[302535920000740--[[Asian--]]]] = true,
    S[302535920001283--[[Indian--]]],[S[302535920001283--[[Indian--]]]] = true,
    S[302535920001284--[[Southeast Asian--]]],[S[302535920001284--[[Southeast Asian--]]]] = true,
  },
  -- some names need to be fixed when doing construction placement
  ConstructionNamesListFix = {
    RCRover = "RCRoverBuilding",
    RCDesireTransport = "RCDesireTransportBuilding",
    RCTransport = "RCTransportBuilding",
    ExplorerRover = "RCExplorerBuilding",
    Rocket = "SupplyRocket",
  },
}
-- easy access to colonist data, cargo, mystery
ChoGGi.ComFuncs.UpdateDataTables()

-- stores defaults
ChoGGi.Defaults = {
  -- oh we'll change it
  _VERSION = 0,
  --dark background for the console log
  ConsoleDim = true,
  -- shows the console log on screen
  ConsoleToggleHistory = true,
  -- shows a msg in the console log (maybe a popup would be better)
  FirstRun = true,
  -- show Cheats pane in the selection panel
  InfopanelCheats = true,
  -- removes some useless shit from the Cheats pane (unless you're doing the tutorial then not as useless it seems)
  CleanupCheatsInfoPane = true,
  -- maybe you don't want to see the interface in screenshots
  ShowInterfaceInScreenshots = true,
  -- 1-0 + shift+ 1-0 shows the build menus
  NumberKeysBuildMenu = true,
  -- keep orientation of last placed building
  UseLastOrientation = true,
  -- show the cheats menu...
  ShowCheatsMenu = true,
  -- blinky blink
  FlashExamineObject = true,
  -- dumps the log to disk on startup, and every new Sol (good for some crashes)
  FlushLog = true,
  -- dumps log to disk every in-game hour (30 000 ticks of GameTime)
  FlushLogConstantly = false,
  -- okay, maybe some people don't want a mod to change the title of their game
  ChangeWindowTitle = true,
  -- msg that shows in the console after tabbing back to the game and "heaven forbid" you have the cheats menu open
  HideuiWindowErrorMsg = true,
  -- how wide the starting radius, how much to step per press
  FlattenGround_Radius = 2500,
  FlattenGround_HeightDiff = 100,
  FlattenGround_RadiusDiff = 100,
  -- the build/passibility grid in debug menu
  DebugGridSize = 10,
  DebugGridOpacity = 15,
  -- how long to wait before hiding the cheats pane in the selection panel
  CheatsInfoPanelHideDelay = 1500,
  -- how wide the text for the history menu in the Console is
  ConsoleHistoryMenuLength = 50,
  -- shows how many ticks it takes between the start of ECM and when the game loads
  ShowStartupTicks = false,
  -- if a mod added certain buildings and user removed removed mod without removing buildings then inf loop
  FixMissingModBuildings = false,
  -- Mod Editor shows the help page every single time you open it.
  SkipModHelpPage = true,
  -- stores custom settings for each building
  BuildingSettings = {},
  -- resupply settings
  CargoSettings = {},
  -- transparent UI stored here
	Transparency = {},
  -- shortcut keys
  KeyBindings = {
    -- Keys.lua
    ClearConsoleLog = "F9",
    ObjectColourRandom = "Shift-F6",
    ObjectColourDefault = "Ctrl-F6",
    ShowConsoleTilde = "~",
    ShowConsoleEnter = "Enter",
    ConsoleRestart = "Ctrl-Alt-Shift-R",
    LastConstructedBuilding = "Ctrl-Space",
    LastPlacedObject = "Ctrl-Shift-Space",
    -- Buildings.lua
    SetMaxChangeOrDischarge = "Ctrl-Shift-R",
    SetProductionAmount = "Ctrl-Shift-P",
    UseLastOrientation = "F7",
    -- CheatsMenu.lua
    CheatCompleteAllConstructions = "Alt-B",
    -- ColonistsMenu.lua
    TheSoylentOption = "Ctrl-Alt-Numpad 1",
    -- DebugMenu.lua
    MeasureTool_Toggle = "Ctrl-M",
--~     MeasureTool_Clear = "Ctrl-Shift-M",
    ObjectCloner = "Shift-Q",
    SetPathMarkersGameTime = "Ctrl-Numpad .",
    SetPathMarkersVisible = "Ctrl-Numpad 0",
    OpenInObjectManipulator = "F5",
    ObjectSpawner = "Ctrl-Shift-S",
    Editor_Toggle = "Ctrl-Shift-E",
    DeleteObject = "Ctrl-Alt-Shift-D",
    ObjExaminer = "F4",
    ToggleTerrainDepositGrid = "Ctrl-F4",
    debug_grid_build = "Shift-F1",
    debug_grid_squares = "Shift-F2",
    -- DronesAndRCMenu.lua
    SetDroneAmountDroneHub = "Shift-D",
    -- ExpandedMenu
    SetWorkerCapacity = "Ctrl-Shift-W",
    SetBuildingCapacity = "Ctrl-Shift-C",
    SetVisitorCapacity = "Ctrl-Shift-V",
    SetFunding = "Ctrl-Shift-0",
    FillResource = "Ctrl-F",
    -- GameMenu.lua
    SetTransparencyUI = "Ctrl-F3",
    CameraFree_Toggle = "Shift-C",
    CameraFollow_Toggle = "Ctrl-Shift-F",
    CursorVisible_Toggle = "Ctrl-Alt-F",
    FlattenTerrain_Toggle = "Shift-F",
    FlattenGround_RaiseHeight = "Shift-Up",
    FlattenGround_LowerHeight = "Shift-Down",
    FlattenGround_WidenRadius = "Shift-Right",
    FlattenGround_ShrinkRadius = "Shift-Left",
    TerrainEditor_Toggle = "Ctrl-Shift-T",
    -- HelpMenu.lua
    TakeScreenshot = "-PrtScr",
    TakeScreenshotUpsampled = "-Ctrl-PrtScr",
    ToggleInterface = "Ctrl-Alt-I",
    SignsInterface_Toggle = "Ctrl-Alt-S",
    ReportBugDlg = "Ctrl-F1",
    CheatsMenu_Toggle = "F2",
    -- MiscMenu.lua
    CreateObjectListAndAttaches = "F6",
    SetObjectOpacity = "F3",
    InfopanelCheats_Toggle = "Ctrl-F2",
  },

  -- if transport on a route has a borked route then lag happens (can't set faster game speeds)
--~   CheckForBorkedTransportPath = true,
}
-- my defaults
if ChoGGi.testing then
  local ChoGGi = ChoGGi
  -- add extra debugging defaults for me
  ChoGGi.Defaults.ShowStartupTicks = true
  ChoGGi.Defaults.WriteLogs = true
  ChoGGi.Defaults.FixMissingModBuildings = true
  -- and maybe a bit of class
  ChoGGi.Defaults.Transparency = {
		HUD = 50,
		PinsDlg = 50,
		XShortcutsHost = 100,
  }
  -- probably not useful for anyone who isn't loading up borked saves to test
  ChoGGi.Defaults.SkipMissingMods = true
  ChoGGi.Defaults.SkipMissingDLC = true
end

--~ function OnMsg.ChoGGi_Loaded()
--~ if blacklist then
--~   dlgConsole:Exec([[ChoGGi.Temp.g = _G
--~ dlgConsole.history_queue_idx = 0
--~ dlgConsole.history_queue = {}
--~ LocalStorage.history_log = {}
--~ SaveLocalStorage()]])
--~   dlgConsole:AddHistory("print(ChoGGi.Strings[302535920000242])")
--~ end
--~ end

-- and constants
ChoGGi.Consts = {
	LightmodelCustom = {
		id = "ChoGGi_Custom",
    pp_bloom_strength = 100,
    pp_bloom_threshold = 25,
    pp_bloom_contrast = 75,
    pp_bloom_colorization = 65,
    pp_bloom_inner_tint = RGBA(187, 23, 146, 255),
    pp_bloom_mip2_radius = 8,
    pp_bloom_mip3_radius = 10,
    pp_bloom_mip4_radius = 27,
    exposure = -100,
    gamma = RGBA(76, 76, 166, 255),
	},

-- const.* (I don't think these have default values in-game anywhere, so manually set them.) _GameConst.lua
  RCRoverMaxRadius = 20,
  CommandCenterMaxRadius = 35,
  BreakThroughTechsPerGame = 13,
  OmegaTelescopeBreakthroughsCount = 3,
  ExplorationQueueMaxSize = 10,
  fastGameSpeed = 5,
  mediumGameSpeed = 3,
  MoistureVaporatorPenaltyPercent = 40,
  MoistureVaporatorRange = 5,
  ResearchQueueSize = 4,
  ResourceScale = 1000,
  ResearchPointsScale = 1000,
  guim = 100,
  AutosavePeriod = 5,
--Consts.* (Consts is a prop object, so we can get the defaults with ReadSettingsInGame below.) _const.lua
  AvoidWorkplaceSols = false,
  BirthThreshold = false,
  CargoCapacity = false,
  ColdWaveSanityDamage = false,
  CommandCenterMaxDrones = false,
  Concrete_cost_modifier = false,
  Concrete_dome_cost_modifier = false,
  CrimeEventDestroyedBuildingsCount = false,
  CrimeEventSabotageBuildingsCount = false,
  CropFailThreshold = false,
  DeepScanAvailable = false,
  DefaultOutsideWorkplacesRadius = false,
  DroneBuildingRepairAmount = false,
  DroneBuildingRepairBatteryUse = false,
  DroneCarryBatteryUse = false,
  DroneConstructAmount = false,
  DroneConstructBatteryUse = false,
  DroneDeconstructBatteryUse = false,
--~   DroneMeteorMalfunctionChance = false,
  DroneMoveBatteryUse = false,
  DroneRechargeTime = false,
  DroneRepairSupplyLeak = false,
  DroneResourceCarryAmount = false,
  DroneTransformWasteRockObstructorToStockpileAmount = false,
  DroneTransformWasteRockObstructorToStockpileBatteryUse = false,
  DustStormSanityDamage = false,
  Electronics_cost_modifier = false,
  Electronics_dome_cost_modifier = false,
  FoodPerRocketPassenger = false,
  HighStatLevel = false,
  HighStatMoraleEffect = false,
  InstantCables = false,
  InstantPipes = false,
  IsDeepMetalsExploitable = false,
  IsDeepPreciousMetalsExploitable = false,
  IsDeepWaterExploitable = false,
  LowSanityNegativeTraitChance = false,
  LowSanitySuicideChance = false,
  LowStatLevel = false,
  MachineParts_cost_modifier = false,
  MachineParts_dome_cost_modifier = false,
  MaxColonistsPerRocket = false,
  Metals_cost_modifier = false,
  Metals_dome_cost_modifier = false,
  MeteorHealthDamage = false,
  MeteorSanityDamage = false,
  MinComfortBirth = false,
  MysteryDreamSanityDamage = false,
  NoHomeComfort = false,
  NonSpecialistPerformancePenalty = false,
  OutsourceResearch = false,
  OutsourceResearchCost = false,
  OxygenMaxOutsideTime = false,
  PipesPillarSpacing = false,
  Polymers_cost_modifier = false,
  Polymers_dome_cost_modifier = false,
  positive_playground_chance = false,
  PreciousMetals_cost_modifier = false,
  PreciousMetals_dome_cost_modifier = false,
  ProjectMorphiousPositiveTraitChance = false,
  RCRoverDroneRechargeCost = false,
  RCRoverMaxDrones = false,
  RCRoverTransferResourceWorkTime = false,
  RCTransportGatherResourceWorkTime = false,
  rebuild_cost_modifier = false,
  RenegadeCreation = false,
  SeeDeadSanity = false,
  TimeBeforeStarving = false,
  TravelTimeEarthMars = false,
  TravelTimeMarsEarth = false,
  VisitFailPenalty = false,
}

--set game values to saved values
do -- SetConstsToSaved
  local function SetConstsG(ChoGGi,name)
    ChoGGi.ComFuncs.SetConstsG(name,ChoGGi.UserSettings[name])
  end
  local function SetConst(ChoGGi,const,name)
    if ChoGGi.UserSettings[name] then
      const[name] = ChoGGi.UserSettings[name]
    end
  end
  function ChoGGi.SettingFuncs.SetConstsToSaved()
    local ChoGGi = ChoGGi
    local const = const
--Consts.
    SetConstsG(ChoGGi,"AvoidWorkplaceSols")
    SetConstsG(ChoGGi,"BirthThreshold")
    SetConstsG(ChoGGi,"CargoCapacity")
    SetConstsG(ChoGGi,"ColdWaveSanityDamage")
    SetConstsG(ChoGGi,"CommandCenterMaxDrones")
    SetConstsG(ChoGGi,"Concrete_cost_modifier")
    SetConstsG(ChoGGi,"Concrete_dome_cost_modifier")
    SetConstsG(ChoGGi,"CrimeEventDestroyedBuildingsCount")
    SetConstsG(ChoGGi,"CrimeEventSabotageBuildingsCount ")
    SetConstsG(ChoGGi,"CropFailThreshold")
    SetConstsG(ChoGGi,"DeepScanAvailable")
    SetConstsG(ChoGGi,"DefaultOutsideWorkplacesRadius")
    SetConstsG(ChoGGi,"DroneBuildingRepairAmount")
    SetConstsG(ChoGGi,"DroneBuildingRepairBatteryUse")
    SetConstsG(ChoGGi,"DroneCarryBatteryUse")
    SetConstsG(ChoGGi,"DroneConstructAmount")
    SetConstsG(ChoGGi,"DroneConstructBatteryUse")
    SetConstsG(ChoGGi,"DroneDeconstructBatteryUse")
--~     SetConstsG(ChoGGi,"DroneMeteorMalfunctionChance")
    SetConstsG(ChoGGi,"DroneMoveBatteryUse")
    SetConstsG(ChoGGi,"DroneRechargeTime")
    SetConstsG(ChoGGi,"DroneRepairSupplyLeak")
    SetConstsG(ChoGGi,"DroneResourceCarryAmount")
    SetConstsG(ChoGGi,"DroneTransformWasteRockObstructorToStockpileAmount")
    SetConstsG(ChoGGi,"DroneTransformWasteRockObstructorToStockpileBatteryUse")
    SetConstsG(ChoGGi,"DustStormSanityDamage")
    SetConstsG(ChoGGi,"Electronics_cost_modifier")
    SetConstsG(ChoGGi,"Electronics_dome_cost_modifier")
    SetConstsG(ChoGGi,"FoodPerRocketPassenger")
    SetConstsG(ChoGGi,"HighStatLevel")
    SetConstsG(ChoGGi,"HighStatMoraleEffect")
    SetConstsG(ChoGGi,"InstantCables")
    SetConstsG(ChoGGi,"InstantPipes")
    SetConstsG(ChoGGi,"IsDeepMetalsExploitable")
    SetConstsG(ChoGGi,"IsDeepPreciousMetalsExploitable")
    SetConstsG(ChoGGi,"IsDeepWaterExploitable")
    SetConstsG(ChoGGi,"LowSanityNegativeTraitChance")
    SetConstsG(ChoGGi,"LowSanitySuicideChance")
    SetConstsG(ChoGGi,"LowStatLevel")
    SetConstsG(ChoGGi,"MachineParts_cost_modifier")
    SetConstsG(ChoGGi,"MachineParts_dome_cost_modifier")
    SetConstsG(ChoGGi,"MaxColonistsPerRocket")
    SetConstsG(ChoGGi,"Metals_cost_modifier")
    SetConstsG(ChoGGi,"Metals_dome_cost_modifier")
    SetConstsG(ChoGGi,"MeteorHealthDamage")
    SetConstsG(ChoGGi,"MeteorSanityDamage")
    SetConstsG(ChoGGi,"MinComfortBirth")
    SetConstsG(ChoGGi,"MysteryDreamSanityDamage")
    SetConstsG(ChoGGi,"NoHomeComfort")
    SetConstsG(ChoGGi,"NonSpecialistPerformancePenalty")
    SetConstsG(ChoGGi,"OutsourceResearch")
    SetConstsG(ChoGGi,"OutsourceResearchCost")
    SetConstsG(ChoGGi,"OxygenMaxOutsideTime")
    SetConstsG(ChoGGi,"PipesPillarSpacing")
    SetConstsG(ChoGGi,"Polymers_cost_modifier")
    SetConstsG(ChoGGi,"Polymers_dome_cost_modifier")
    SetConstsG(ChoGGi,"positive_playground_chance")
    SetConstsG(ChoGGi,"PreciousMetals_cost_modifier")
    SetConstsG(ChoGGi,"PreciousMetals_dome_cost_modifier")
    SetConstsG(ChoGGi,"ProjectMorphiousPositiveTraitChance")
    SetConstsG(ChoGGi,"RCRoverDroneRechargeCost")
    SetConstsG(ChoGGi,"RCRoverMaxDrones")
    SetConstsG(ChoGGi,"RCRoverTransferResourceWorkTime")
    SetConstsG(ChoGGi,"RCTransportGatherResourceWorkTime")
    SetConstsG(ChoGGi,"rebuild_cost_modifier")
    SetConstsG(ChoGGi,"RenegadeCreation")
    SetConstsG(ChoGGi,"SeeDeadSanity")
    SetConstsG(ChoGGi,"TimeBeforeStarving")
    SetConstsG(ChoGGi,"TravelTimeEarthMars")
    SetConstsG(ChoGGi,"TravelTimeMarsEarth")
    SetConstsG(ChoGGi,"VisitFailPenalty")
--const.
    SetConst(ChoGGi,const,"BreakThroughTechsPerGame")
    SetConst(ChoGGi,const,"ExplorationQueueMaxSize")
    SetConst(ChoGGi,const,"fastGameSpeed")
    SetConst(ChoGGi,const,"mediumGameSpeed")
    SetConst(ChoGGi,const,"MoistureVaporatorPenaltyPercent")
    SetConst(ChoGGi,const,"MoistureVaporatorRange")
    SetConst(ChoGGi,const,"ResearchQueueSize")
    SetConst(ChoGGi,const,"RCRoverMaxRadius")
    SetConst(ChoGGi,const,"CommandCenterMaxRadius")
    SetConst(ChoGGi,const,"OmegaTelescopeBreakthroughsCount")
  end
end -- do

do -- WriteSettingsOrig
  local AsyncCopyFile = AsyncCopyFile
  local AsyncStringToFile = AsyncStringToFile
  local TableToLuaCode = TableToLuaCode
  local ThreadLockKey = ThreadLockKey
  local ThreadUnlockKey = ThreadUnlockKey
  -- called everytime we set a setting in menu
  function ChoGGi.SettingFuncs.WriteSettingsOrig(settings)
    local ChoGGi = ChoGGi
    settings = settings or ChoGGi.UserSettings

    local bak = Concat(ChoGGi.SettingsFile,".bak")
    --locks the file while we write (i mean it says thread, ah well can't hurt)?
    ThreadLockKey(bak)
    AsyncCopyFile(ChoGGi.SettingsFile,bak)
    ThreadUnlockKey(bak)

    ThreadLockKey(ChoGGi.SettingsFile)
    table.sort(settings)
    --and write it to disk
    local DoneFuckedUp = AsyncStringToFile(ChoGGi.SettingsFile,TableToLuaCode(settings))
    ThreadUnlockKey(ChoGGi.SettingsFile)

    if DoneFuckedUp then
      print(S[302535920000006--[[Failed to save settings to %s : %s--]]]:format(ChoGGi.SettingsFile,DoneFuckedUp))
      return false, DoneFuckedUp
    end
  end
end -- do

do -- ReadSettingsOrig
  local AsyncFileToString = AsyncFileToString
  local LuaCodeToTuple = LuaCodeToTuple
  -- read saved settings from file
  function ChoGGi.SettingFuncs.ReadSettingsOrig(settings_str)
    local ChoGGi = ChoGGi
    local is_error

    -- try to read settings
    if not settings_str then
      local file_error
      file_error, settings_str = AsyncFileToString(ChoGGi.SettingsFile)
      if file_error then
        -- no settings file so make a new one and read it
        ChoGGi.SettingFuncs.WriteSettingsOrig()
        file_error, settings_str = AsyncFileToString(ChoGGi.SettingsFile)
        -- something is definitely wrong so just abort, and let user know
        if file_error then
          ChoGGi.Temp.StartupMsgs[#ChoGGi.Temp.StartupMsgs+1] = Concat(S[302535920000000--[[Expanded Cheat Menu--]]],": ",S[302535920000007--[[Problem loading settings! Error: %s--]]]:format(file_error))
          is_error = true
        end
      end
    end

    -- and convert it to lua / update in-game settings
    local code_error
    code_error, ChoGGi.UserSettings = LuaCodeToTuple(settings_str)
    if code_error then
      ChoGGi.Temp.StartupMsgs[#ChoGGi.Temp.StartupMsgs+1] = Concat(S[302535920000000--[[Expanded Cheat Menu--]]],": ",S[302535920000007--[[Problem loading settings! Error: %s--]]]:format(code_error))
      is_error = true
    end

    if is_error or type(ChoGGi.UserSettings) ~= "table" then
      -- so now at least the game will start
      ChoGGi.UserSettings = ChoGGi.Defaults
      if ChoGGi.testing then
        ChoGGi.UserSettings.WriteLogs = true
      end
      return ChoGGi.Defaults
    end

    -- all is well
    return settings_str

  end
end -- do

do -- WriteSettingsAcct
  local TableToLuaCode = TableToLuaCode
  local AsyncCompress = AsyncCompress
  local WriteModPersistentData = blacklist and WriteModPersistentData
  local MaxModDataSize = const.MaxModDataSize
  local function RetError(err)
    if ChoGGi.Temp.GameLoaded then
      print(Concat(S[302535920000000--[[Expanded Cheat Menu--]]],": ",S[302535920000243--[[Problem saving settings! Error: %s--]]]:format(err)))
    else
      ChoGGi.Temp.StartupMsgs[#ChoGGi.Temp.StartupMsgs+1] = Concat(S[302535920000000--[[Expanded Cheat Menu--]]],": ",S[302535920000243--[[Problem saving settings! Error: %s--]]]:format(err))
    end
  end
  function ChoGGi.SettingFuncs.WriteSettingsAcct(settings)
    local ChoGGi = ChoGGi
    settings = settings or ChoGGi.UserSettings

    -- lz4 is quicker, but less compressy
    local err, data = AsyncCompress(TableToLuaCode(settings), false, "lz4")
    if err then
      RetError(err)
      return
    end

    local acmpd = acmpd
    if acmpd then
      if not acmpd then
        acmpd = {}
      end
      acmpd.ChoGGi_CheatMenu = data
      acsac(5000)
    else
      if #data > MaxModDataSize then
        err, data = AsyncCompress(TableToLuaCode(settings), false, "zstd")
        if err then
          RetError(err)
          return
        end

        if #data > MaxModDataSize then
          RetError(S[302535920000222--[[Oh look ECM hit the itty bitty limit of const.MaxModDataSize. Who'd a thunk it? Eh' Mortimer.--]]])
          return
        end
      end

      local err = WriteModPersistentData(data)
      if err then
        RetError(err)
        return
      end
    end

    return data
  end
end -- do

do -- ReadSettingsAcct
  local ReadModPersistentData = blacklist and ReadModPersistentData
  local AsyncDecompress = AsyncDecompress
  local LuaCodeToTuple = LuaCodeToTuple
  local function RetError(err)
    if ChoGGi.Temp.GameLoaded then
      print(Concat(S[302535920000000--[[Expanded Cheat Menu--]]],": ",S[302535920000007--[[Problem loading settings! Error: %s--]]]:format(err)))
    else
      ChoGGi.Temp.StartupMsgs[#ChoGGi.Temp.StartupMsgs+1] = Concat(S[302535920000000--[[Expanded Cheat Menu--]]],": ",S[302535920000007--[[Problem loading settings! Error: %s--]]]:format(err))
    end
  end
  function ChoGGi.SettingFuncs.ReadSettingsAcct(settings_str)
    local ChoGGi = ChoGGi
    local is_error,err

    -- try to read settings
    if not settings_str then
      local settings_data
      err,settings_data = ReadModPersistentData()

      if err or not settings_data or settings_data == "" then
        -- no settings so use defaults
        settings_data = ChoGGi.SettingFuncs.WriteSettingsAcct(ChoGGi.Defaults)
      end

      some_error, settings_str = AsyncDecompress(settings_data)
      if err then
        RetError(err)
        is_error = true
      end
    end

    -- and convert it to lua / update in-game settings
    err, ChoGGi.UserSettings = LuaCodeToTuple(settings_str)
    if err then
      RetError(err)
      is_error = true
    end

    if is_error or ChoGGi.UserSettings == empty_table or type(ChoGGi.UserSettings) ~= "table" then
      -- so now at least the game will start
      ChoGGi.UserSettings = ChoGGi.Defaults
      if ChoGGi.testing then
        ChoGGi.UserSettings.WriteLogs = true
      end
      return ChoGGi.Defaults
    end

    -- all is well
    return settings_str

  end
end -- do

-- OptionsApply is the earliest we can call Consts:GetProperties()
function OnMsg.OptionsApply()
  local ChoGGi = ChoGGi
  local Consts = Consts
  local g_Classes = g_Classes

  --if setting doesn't exist then add default
  for key,value in pairs(ChoGGi.Defaults) do
    if type(ChoGGi.UserSettings[key]) == "nil" then
      ChoGGi.UserSettings[key] = value
    end
  end
  for key,value in pairs(ChoGGi.Defaults.KeyBindings) do
    if type(ChoGGi.UserSettings.KeyBindings[key]) == "nil" then
      ChoGGi.UserSettings.KeyBindings[key] = value
    end
  end

  --get the default values for our Consts
  for SettingName,_ in pairs(ChoGGi.Consts) do
    local setting = Consts:GetDefaultPropertyValue(SettingName)
    if setting then
      ChoGGi.Consts[SettingName] = setting
    end
  end

  -- get other defaults not stored in Consts
  ChoGGi.Consts.DroneFactoryBuildSpeed = g_Classes.DroneFactory:GetDefaultPropertyValue("performance")
  ChoGGi.Consts.StorageShuttle = g_Classes.CargoShuttle:GetDefaultPropertyValue("max_shared_storage")
  ChoGGi.Consts.SpeedShuttle = g_Classes.CargoShuttle:GetDefaultPropertyValue("move_speed")
  ChoGGi.Consts.ShuttleHubShuttleCapacity = g_Classes.ShuttleHub:GetDefaultPropertyValue("max_shuttles")
  ChoGGi.Consts.GravityColonist = 0
  ChoGGi.Consts.GravityDrone = 0
  ChoGGi.Consts.GravityRC = 0
  ChoGGi.Consts.SpeedDrone = g_Classes.Drone:GetDefaultPropertyValue("move_speed")
  ChoGGi.Consts.SpeedRC = g_Classes.RCRover:GetDefaultPropertyValue("move_speed")
  ChoGGi.Consts.SpeedColonist = g_Classes.Colonist:GetDefaultPropertyValue("move_speed")
  ChoGGi.Consts.RCTransportStorageCapacity = g_Classes.RCTransport:GetDefaultPropertyValue("max_shared_storage")
  ChoGGi.Consts.StorageUniversalDepot = g_Classes.UniversalStorageDepot:GetDefaultPropertyValue("max_storage_per_resource")
  --ChoGGi.Consts.StorageWasteDepot = WasteRockDumpSite:GetDefaultPropertyValue("max_amount_WasteRock")
  ChoGGi.Consts.StorageWasteDepot = 70 * ChoGGi.Consts.ResourceScale --^ that has 45000 as default...
  ChoGGi.Consts.StorageOtherDepot = 180 * ChoGGi.Consts.ResourceScale
  ChoGGi.Consts.StorageMechanizedDepot = 3950 * ChoGGi.Consts.ResourceScale
  --^ they're all UniversalStorageDepot

  ChoGGi.Consts.CameraZoomToggle = 8000
  ChoGGi.Consts.HigherRenderDist = 120 --hr.LODDistanceModifier
end

do -- AddOldSettings
  -- used to add old lists to new combined list
  local function AddOldSettings(ChoGGi,old_cat,new_name)
    local BuildingTemplates = BuildingTemplates
    -- then loop through it
    for key,value in pairs(ChoGGi.UserSettings[old_cat] or empty_table) do
      --it likely doesn't exist, but check first and add a blank table
      if not ChoGGi.UserSettings.BuildingSettings[key] then
        ChoGGi.UserSettings.BuildingSettings[key] = {}
      end
      -- add it to vistors list?
      if new_name == "capacity" and BuildingTemplates[key].max_visitors then
        ChoGGi.UserSettings.BuildingSettings[key].visitors = value
      else
        ChoGGi.UserSettings.BuildingSettings[key][new_name] = value
      end
    end
    -- remove old settings
    ChoGGi.UserSettings[old_cat] = nil
    return true
  end

  function OnMsg.ModsLoaded()
    local ChoGGi = ChoGGi

    -- remove empty entries in BuildingSettings
    if next(ChoGGi.UserSettings.BuildingSettings) then
      --remove any empty building tables
      for Key,_ in pairs(ChoGGi.UserSettings.BuildingSettings) do
        if not next(ChoGGi.UserSettings.BuildingSettings[Key]) then
          ChoGGi.UserSettings.BuildingSettings[Key] = nil
        end
      end
    -- if empty table then new settings file or old settings
    else
      --then we check if this is an older version still using the old way of storing building settings and convert over to new
      local errormsg = Concat(S[302535920000008--[[Error: Couldn't convert old settings to new settings--]]],": ")
      if not AddOldSettings(ChoGGi,"BuildingsCapacity","capacity") then
        ChoGGi.Temp.StartupMsgs[#ChoGGi.Temp.StartupMsgs+1] = Concat(errormsg,"BuildingsCapacity")
      end
      if not AddOldSettings(ChoGGi,"BuildingsProduction","production") then
        ChoGGi.Temp.StartupMsgs[#ChoGGi.Temp.StartupMsgs+1] = Concat(errormsg,"BuildingsProduction")
      end
    end

    -- remove empty entries in CargoSettings
    for Key,_ in pairs(ChoGGi.UserSettings.CargoSettings or empty_table) do
      if not next(ChoGGi.UserSettings.CargoSettings[Key]) then
        ChoGGi.UserSettings.CargoSettings[Key] = nil
      end
    end
  end
end -- do

local ChoGGi = ChoGGi

-- saving settings to a file or (shudder) in-game
if blacklist then
  ChoGGi.SettingFuncs.ReadSettings = ChoGGi.SettingFuncs.ReadSettingsAcct
  ChoGGi.SettingFuncs.WriteSettings = ChoGGi.SettingFuncs.WriteSettingsAcct
else
  ChoGGi.SettingFuncs.ReadSettings = ChoGGi.SettingFuncs.ReadSettingsOrig
  ChoGGi.SettingFuncs.WriteSettings = ChoGGi.SettingFuncs.WriteSettingsOrig
end

-- read settings from AppData/CheatMenuModSettings.lua
ChoGGi.SettingFuncs.ReadSettings()

if ChoGGi.testing or ChoGGi.UserSettings.ShowStartupTicks then
  -- from here to the end of OnMsg.ChoGGi_Loaded()
  ChoGGi.Temp.StartupTicks = GetPreciseTicks()
end

--bloody hint popups
if ChoGGi.UserSettings.DisableHints then
  mapdata.DisableHints = true
  HintsEnabled = false
end

-- if writelogs option
if ChoGGi.UserSettings.WriteLogs then
  ChoGGi.ComFuncs.WriteLogs_Toggle(ChoGGi.UserSettings.WriteLogs)
end
