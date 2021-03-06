--local is faster then global (assuming you call it more then once)
local XTemplates = XTemplates
local ObjModified = ObjModified
local PlaceObj = PlaceObj

function OnMsg.ClassesBuilt()
  --check if the buttons were already added (you can have one for each, but meh)
  if not XTemplates.sectionWorkplace.SOMETHINGUNIQUE then
    XTemplates.sectionWorkplace.SOMETHINGUNIQUE = true

    --this adds a button to all workplaces that changes depending on Object.working (a building that works...)
    XTemplates.sectionWorkplace[#XTemplates.sectionWorkplace+1] = PlaceObj("XTemplateTemplate", {
    --use OpenExamine(XTemplates) to see the complete list (and check that yours was added).
    --and https://github.com/HaemimontGames/SurvivingMars/tree/master/Lua/XTemplates

      --added to the workplace panel, for more see OpenExamine(somebuilding) > click the class at the top till you get to metatable Building > then either __ancestors or __parents
      "__context_of_kind", "Workplace", --change this to say SecurityStation to only show up for them, but you can just use OnContextUpdate to hide it
      "__template", "InfopanelSection",

      --you can set these here or in OnContextUpdate below
      --"Icon", "",
      --"Title", "",
      --"RolloverText", "",

      "RolloverTitle", "Hello, this needs to have something here for the hint to showup",
      "RolloverHint",  "",
      "OnContextUpdate", function(self, context)
        -- context is the object selected
        if context.working then
          self:SetRolloverText("This building is working.")
          self:SetTitle("Working")
          self:SetIcon("UI/Icons/Upgrades/factory_ai_01.tga")
        else
          self:SetRolloverText("This building isn't working.")
          self:SetTitle("Not Working")
          self:SetIcon("UI/Icons/Upgrades/factory_ai_03.tga")
        end
        ---
      end,
    }, {
      PlaceObj("XTemplateFunc", {
        "name", "OnActivate(self, context)",
        "parent", function(parent, context)
          return parent.parent
        end,
        "func", function(self, context)
          ---
          if context.working then
            --do something on a working building
          else
            --and a not working building
          end

          --if you modified a value then use this, if not remove
          ObjModified(context)
          ---
        end
      })
    })

    --slider added to all workplaces to adjust number of workers allowed
    XTemplates.sectionWorkplace[#XTemplates.sectionWorkplace+1] = PlaceObj("XTemplateTemplate", {
      "__context_of_kind", "Workplace",
      "__template", "InfopanelSection",

      --only show up for buildings that need maintenance
      "__condition", function (parent, context) return context:DoesRequireMaintenance() end,

      "RolloverText", "Look ma it slides!",
      "RolloverHintGamepad", "",
      "RolloverTitle", " ",
      "Title", " ", --updated below, can't be blank
      "Icon", "UI/Icons/Sections/facility.tga",
    }, {
      PlaceObj("XTemplateTemplate", {
        "__template", "InfopanelSlider",
        "BindTo", "max_workers",
        -- if it's a resource unit then add 1000, so 25000
        "Max", 25,
        "Min", 5,
				"StepSize", 5,
--~ PageSize: 1
--~ StepSize: 1
--~ FullPageAtEnd: false
--~ SnapToItems: false
--~ AutoHide: false
--~ Horizontal: false
        "OnContextUpdate", function(self, context)
          -- make the slider scroll to current amount
          self.Scroll = context.max_workers
          self.parent.parent:SetTitle([[Change "max_workers" limit: ]] .. context.max_workers)
        end
      })
    })

    --two sliders, one header, or just remove Title to not have one at all
    XTemplates.sectionWorkplace[#XTemplates.sectionWorkplace+1] = PlaceObj("XTemplateTemplate", {
      "__context_of_kind", "Workplace",
      "__template", "InfopanelSection",

      --only show up for buildings that require main
      "__condition", function (parent, context) return context:DoesRequireMaintenance() end,

      "RolloverText", "Look ma it slides!",
      "RolloverHintGamepad", "",
      "RolloverTitle", " ",
      "Title", " ", --updated below, can't be blank as it isn't updated auto
      "Icon", "UI/Icons/Sections/facility.tga",
    }, {
      PlaceObj("XTemplateTemplate", {
        "__template", "InfopanelSlider",
        "BindTo", "max_workers",
        "Max", 25,
        "min", 5,
        "StepSize", 5, --change 5 per movement
        "OnContextUpdate", function(self, context)
          --self.parent.parent:SetTitle([[Change "max_workers" limit: ]] .. context.max_workers)
        end
      }),
      PlaceObj("XTemplateTemplate", {
        "__template", "InfopanelSlider",
        "BindTo", "max_workers",
				"StepSize", 5, --change 5 per movement
        "OnContextUpdate", function(self, context)
          self.parent.parent:SetTitle([[Change "max_workers" limit: ]] .. context.max_workers)
        end
      }),
    })

    --this adds a button to the resource overview that only shows when hour is over 10
    --it needs the [1] or it takes over the whole screen (it's usually only needed for ipResourceOverview not the section ones)
    XTemplates.ipResourceOverview[1][#XTemplates.ipResourceOverview[1]+1] = PlaceObj("XTemplateTemplate", {

      --added to the resource overview panel
      "__context_of_kind", "ResourceOverview",
      "__template", "InfopanelActiveSection",

      --you can set these here or in OnContextUpdate below
      "Icon", "UI/Icons/Upgrades/factory_ai_03.tga",
      "Title", "hour over 10",
      "RolloverText", "only shows when hour is 10 or over",
      "RolloverTitle", " ",
      "RolloverHint",  "",
      "OnContextUpdate", function(self, context)
        if UICity.hour >= 10 then
          self:SetVisible(true)
          self:SetMaxHeight()
        else
          self:SetVisible(false)
          self:SetMaxHeight(0)
        end
      end
    })

    --add an actual button (at the top of the panel)
    XTemplates.ipSubsurfaceDeposit[1][#XTemplates.ipSubsurfaceDeposit[1]+1] = PlaceObj("XTemplateTemplate", {
      "__template", "InfopanelButton",
      "Icon", "UI/Icons/Sections/Metals_2.tga",
      "Title", "5 Times the amount",
      "RolloverText", "Clicking this once will add 5 times the amount of stored resources.",
      "RolloverTitle", "",
      "RolloverHint",  "",
      "OnPress", function(self, context)
        ---
        local objs = UICity.labels.SubsurfaceDeposit or ""
        for i = 1, #objs do
          objs[i].max_amount = objs[i].max_amount * 5
          objs[i]:CheatRefill()
        end
        ---
      end,
    })

  end --if

end

--ipBuilding/"__context_of_kind", "Building",  < all buildings
