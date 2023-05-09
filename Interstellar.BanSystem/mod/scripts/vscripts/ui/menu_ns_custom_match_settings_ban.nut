global function AddNorthstarCustomMatchSettingsBanMenu
global function OnMenu_Open
global function OpenBanMenu
global function ImportBanConfig

const UI_PLAYER_INDEX = 0
const UI_EQUIPMENT_INDEX = 1
const UI_WEAPON_INDEX = 2
const UI_TITAN_INDEX = 3
const UI_BOOST_INDEX = 4

const NR_OF_BANABLE_ELEMENTS = 201

struct BoolAttributte {
  bool disabled = false
  asset image
}

struct ArrayAttribute {
    array<asset> images
    array<string> values
}

struct Loadout {
    string name
    asset image
    bool disabled = false

    int selectedAtr0 = 0
    int selectedAtr1 = 0
    int selectedAtr2 = 0

    ArrayAttribute &atr0
    ArrayAttribute &atr1
    ArrayAttribute &atr2
}

struct Category {
    string prefix = ""
    string displayName

    array<Loadout> loadouts
}

struct PilotDisplay {
  var loadoutDisplay

  array< BoolAttributte > attributes
}

struct LoadoutDisplay {
  var loadoutDisplay

  int categorySelected = 1
  int selectedAttribute
  int selectedLoadout

  array<var> buttons = []
  array<Category> categories
  array<var> displays
}

struct BoostDisplay {
  var loadoutDisplay

  array< BoolAttributte > boosts
}

struct {
  var menu
  var subMenu

  int selected = 0

  array<var> buttons = []
  array<var> loadoutDisplays = []
  PilotDisplay pilot
  PilotDisplay equipment
  LoadoutDisplay weapon
  LoadoutDisplay titan
  BoostDisplay boost
} file

void function AddNorthstarCustomMatchSettingsBanMenu()
{
   AddMenu("CustomMatchBanSettingsMenu", $"resource/ui/menus/custom_match_settings_ban.menu", InitNorthstarCustomMatchSettingsBanMenu, "#MENU_MATCH_SETTINGS")
   AddSubmenu( "customSelectMenu", $"resource/ui/menus/modselect.menu", InitCustomSelectMenu )
}

void function OpenBanMenu()
{
  AdvanceMenu( GetMenu( "CustomMatchBanSettingsMenu" ) )
}

void function InitNorthstarCustomMatchSettingsBanMenu()
{
  file.menu = GetMenu( "CustomMatchBanSettingsMenu" )
  AddMenuEventHandler( file.menu, eUIEvent.MENU_OPEN, OnMenu_Open )

  AddCustomPrivateMatchSettingsCategory("#BAN_PAGE", "CustomMatchBanSettingsMenu")

  AddMenuFooterOption( file.menu, BUTTON_B, "#B_BUTTON_BACK", "#BACK" )
  AddMenuFooterOption(file.menu, BUTTON_A, "#A_RESTORE_DEFAULTS", "#RESTORE_DEFAULTS", callRestoreDefaults )
  AddMenuFooterOption(file.menu, BUTTON_Y, "#Y_BAN_ALL", "#BAN_ALL", callBanAll )

  AddButtonEventHandler( Hud_GetChild(file.menu, "Export"), UIE_CLICK, exportConfigToString )
  AddButtonEventHandler( Hud_GetChild(file.menu, "Import"), UIE_CLICK, importConfigToString )

  file.loadoutDisplays = GetElementsByClassname( file.menu, "loadoutDisplay" )

  initPilot()
  initEquipment()
  initWeapon()
  initTitan()
  initBoost()

  file.buttons = GetElementsByClassname( file.menu, "BanSettingCategoryButton" )
  RHud_SetText( file.buttons[0], Localize("#MODE_SETTING_BAN_PILOT") )
  RHud_SetText( file.buttons[1], Localize("#MODE_SETTING_BAN_EQUIPMENT") )
  RHud_SetText( file.buttons[2], Localize("#MODE_SETTING_BAN_WEAPON") )
  RHud_SetText( file.buttons[3], Localize("#MODE_SETTING_BAN_TITAN") )
  RHud_SetText( file.buttons[4], Localize("#MODE_SETTING_BAN_BOOST") )

  selectButton(file.buttons, 2, 0)
  selectDisplay(file.loadoutDisplays, 2, 0)

  foreach (var button in file.buttons )
  {
    AddButtonEventHandler( button, UIE_CLICK, callChangeMainDisplay )
    Hud_SetVisible( button, true)
	}
}

void function OnMenu_Open()
{
  reloadCurrentScreen()
}

void function InitCustomSelectMenu()
{
	var menu = GetMenu( "customSelectMenu" )
  file.subMenu = menu

  array<var> modButton = GetElementsByClassname( menu, "ModSelectClass" )
  for(int i = 0; i < modButton.len(); i++)
  {
    AddButtonEventHandler( modButton[i], UIE_CLICK, clickSelectInSubmenu )
  }

	var screen = Hud_GetChild( menu, "Screen" )
	var rui = Hud_GetRui( screen )
	RuiSetFloat( rui, "basicImageAlpha", 0.0 )
	Hud_AddEventHandler( screen, UIE_CLICK, OnModSelectBGScreen_Activate )

	AddMenuFooterOption( menu, BUTTON_A, "#A_BUTTON_SELECT" )
	AddMenuFooterOption( menu, BUTTON_B, "#B_BUTTON_BACK", "#BACK" )


}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// UI Functions
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void function OnModSelectBGScreen_Activate( var button )
{
	CloseActiveMenu(true)
  RestoreHiddenSubmenuBackgroundElems()
}

void function clickOpenSubMenu(var pressedButton) {
  OpenSubmenu( file.subMenu )
  var menu = file.subMenu

	var vguiButtonFrame = Hud_GetChild( menu, "ButtonFrame" )
	var ruiButtonFrame = Hud_GetRui( vguiButtonFrame )
	RuiSetImage( ruiButtonFrame, "basicImage", $"rui/borders/menu_border_button" )
	RuiSetFloat3( ruiButtonFrame, "basicImageColor", <0,0,0> )
	RuiSetFloat( ruiButtonFrame, "basicImageAlpha", 0.25 )

	array<var> buttons = GetElementsByClassname( menu, "ModSelectClass" )

  int uiElementId = int(Hud_GetScriptID( Hud_GetParent( pressedButton ) ) )
  int buttonSelected = int(Hud_GetScriptID( pressedButton ))

  array<asset> items
  int currentlySelected = 0

  //This defines the screen which calls this button so that weapons and titans can use the same logic
  LoadoutDisplay loadout
  if (file.selected == UI_WEAPON_INDEX) {
    loadout = file.weapon
  } else if (file.selected == UI_TITAN_INDEX) {
    loadout = file.titan
  }

  loadout.selectedAttribute = buttonSelected
  loadout.selectedLoadout = uiElementId

  if (0 == buttonSelected) {
    items = loadout.categories[loadout.categorySelected].loadouts[uiElementId].atr0.images
    currentlySelected = loadout.categories[loadout.categorySelected].loadouts[uiElementId].selectedAtr0
  } else if (1 == buttonSelected) {
    items = loadout.categories[loadout.categorySelected].loadouts[uiElementId].atr1.images
    currentlySelected = loadout.categories[loadout.categorySelected].loadouts[uiElementId].selectedAtr1
  } else {
    items = loadout.categories[loadout.categorySelected].loadouts[uiElementId].atr2.images
    currentlySelected = loadout.categories[loadout.categorySelected].loadouts[uiElementId].selectedAtr2
  }

	int maxRowCount = 4
	int numItems = items.len()
	int displayRowCount = int( ceil( numItems / 2.0 ) )

	int buttonWidth = 72
	int spacerWidth = 6
	int vguiButtonFrameWidth = int( ContentScaledX( (buttonWidth * displayRowCount) + (spacerWidth * (displayRowCount-1)) ) )
	Hud_SetWidth( vguiButtonFrame, vguiButtonFrameWidth )

  for(int i = 0; i < buttons.len();i++) {
    var button = buttons[rearangeButtonTwoInt(i)]
    var rui = Hud_GetRui( button )
    Hud_SetSelected( button, false )

    if (i < items.len()) {
		  Hud_SetEnabled( button, true )
      RuiSetBool( rui, "isVisible", true )
      RuiSetImage( rui, "buttonImage", items[i] )
    } else {
		  Hud_SetEnabled( button, false )
      RuiSetBool( rui, "isVisible", false )
    }
  }

  Hud_SetSelected( buttons[rearangeButtonTwoInt(currentlySelected)], true )

  HideSubmenuBackgroundElems()
  thread RestoreHiddenElemsOnMenuChange()
}

void function clickSelectInSubmenu(var pressedButton)
{
  OnModSelectBGScreen_Activate(null)
  int modSelected = rearangeIntToButton(int(Hud_GetScriptID( pressedButton )))

  string uiType
  LoadoutDisplay loadoutDisplay
  //This defines the screen which calls this button so that weapons and titans can use the same logic
  if (file.selected == UI_WEAPON_INDEX) {
    uiType = "weapon"
    loadoutDisplay = file.weapon
  } else {
    uiType = "titan"
    loadoutDisplay = file.titan
  }

  Loadout loadout = loadoutDisplay.categories[loadoutDisplay.categorySelected].loadouts[loadoutDisplay.selectedLoadout]

  if (0 == loadoutDisplay.selectedAttribute) {
    loadout.selectedAtr0 = modSelected
  } else if (1 == loadoutDisplay.selectedAttribute) {
    loadout.selectedAtr1 = modSelected
  } else {
    loadout.selectedAtr2 = modSelected
  }

  SendLoadoutChangesToServer(uiType, loadoutDisplay.categorySelected, loadoutDisplay.selectedLoadout, ParseLoadoutToDataString(loadout, loadoutDisplay.categorySelected))

  reloadActiveUI()
}

void function RestoreHiddenElemsOnMenuChange()
{
	while ( uiGlobal.activeMenu == file.subMenu )
		WaitFrame()

	RestoreHiddenSubmenuBackgroundElems()
}

//I could code this dynamicly but I just don't want to spend the time
int function rearangeButtonTwoInt(int value) {
  switch(value) {
    case 0:
      return 0
    case 1:
      return 4
    case 2:
      return 1
    case 3:
      return 5
    case 4:
      return 2
    case 5:
      return 6
    case 6:
      return 3
    case 7:
      return 7
  }
  return 0
}

int function rearangeIntToButton(int value) {
  switch(value) {
    case 0:
      return 0
    case 1:
      return 2
    case 2:
      return 4
    case 3:
      return 6
    case 4:
      return 1
    case 5:
      return 3
    case 6:
      return 5
    case 7:
      return 7
  }
  return 0
}

void function HideSubmenuBackgroundElems()
{
  int subLoadout
  array<var> elems
  if(file.selected == UI_WEAPON_INDEX)
  {
    elems = GetElementsByClassname( file.menu, "HideWhenEditing_" + file.weapon.selectedAttribute )
    subLoadout = file.weapon.selectedLoadout
  } else {
    elems = GetElementsByClassname( file.menu, "HideWhenEditing_" + file.titan.selectedAttribute )
    subLoadout = file.titan.selectedLoadout
  }
	foreach ( elem in elems ) {
    if(int(Hud_GetScriptID( Hud_GetParent( elem ) ) ) == subLoadout) {
      Hud_Hide( elem )
    }
  }
}

void function RestoreHiddenSubmenuBackgroundElems()
{
	array<string> classnames
	classnames.append( "HideWhenEditing_0" )
	classnames.append( "HideWhenEditing_1" )
  classnames.append( "HideWhenEditing_2" )


	foreach ( classname in classnames )
	{
		array<var> elems = GetElementsByClassname( file.menu , classname )

		foreach ( elem in elems )
			Hud_Show( elem )
	}
  //This is here to not show the sights on weapon categories without sights
  if(file.weapon.categorySelected > 4 && file.selected == UI_WEAPON_INDEX)
  {
    array<var> elems = GetElementsByClassname( file.menu , "HideWhenNoVisor" )
	  foreach ( elem in elems )
		  Hud_Hide( elem )
  }
}

void function selectButton(array<var> buttons, int current, int selected) {
    Hud_SetSelected( buttons[current] , false )
    Hud_SetSelected( buttons[selected] , true )
}

void function selectDisplay(array<var>  loadoutDisplays, int selected, int newSelected) {
      Hud_SetVisible( loadoutDisplays[selected] , false )
      Hud_SetVisible( loadoutDisplays[newSelected] , true )
}

void function callChangeMainDisplay( var pressedButton )
{
  int selected = int( Hud_GetScriptID( pressedButton ))
  if(selected != file.selected) {
    selectButton(file.buttons, file.selected, selected)
    selectDisplay(file.loadoutDisplays, file.selected, selected)
    file.selected = selected


    reloadCurrentScreen()
  }
}

void function reloadCurrentScreen()
{
  UpdateBanData()
  reloadActiveUI()
}

void function reloadActiveUI()
{
  if (file.selected == UI_PLAYER_INDEX) {
    reloadPilotScreen()
  } else if (file.selected == UI_EQUIPMENT_INDEX)  {
    reloadEquipmentScreen()
  } else if(file.selected == UI_WEAPON_INDEX) {
    loadWeaponCategory(file.weapon.categories[file.weapon.categorySelected])
  } else if (file.selected == UI_TITAN_INDEX) {
    loadTitanCategory(file.titan.categories[file.titan.categorySelected])
  } else if (file.selected == UI_BOOST_INDEX) {
    reloadBoostScreen()
  }
  RestoreHiddenSubmenuBackgroundElems()
}

void function callPilotButtonClick(var pressedButton)
{
  int id = int( Hud_GetScriptID( pressedButton ) )
  BoolAttributte attribute = file.pilot.attributes[ id ];
  switchBoolAttribute(pressedButton ,attribute)

  SendChangesToServer("ability", id, (attribute.disabled ? "1" : "0"))
}

void function callEquipmentButtonClick(var pressedButton)
{
  int id = int( Hud_GetScriptID( pressedButton ) )
  BoolAttributte attribute = file.equipment.attributes[ id ];
  switchBoolAttribute(pressedButton ,attribute)

  SendChangesToServer("equipment", id, (attribute.disabled ? "1" : "0"))
}

void function callBoostClick(var pressedButton)
{
  int id = int( Hud_GetScriptID( pressedButton ) )
  BoolAttributte attribute = file.boost.boosts[ id ];
  switchBoolAttribute(pressedButton, attribute)

  SendChangesToServer("boost", id, (attribute.disabled ? "1" : "0"))
}

void function callLoadoutButtonClick(var pressedButton)
{
  int id = int(Hud_GetScriptID( Hud_GetParent( pressedButton ) ) )
  LoadoutDisplay loadoutDisplay
  string uiType

  if(file.selected == UI_WEAPON_INDEX)
  {
    loadoutDisplay = file.weapon
    uiType = "weapon"
  }
  else
  {
    loadoutDisplay = file.titan
    uiType = "titan"
  }

  Loadout loadout = loadoutDisplay.categories[loadoutDisplay.categorySelected].loadouts[id]
  bool state = !loadout.disabled
  loadout.disabled = state

  SendLoadoutChangesToServer(uiType, loadoutDisplay.categorySelected, id, ParseLoadoutToDataString(loadout, loadoutDisplay.categorySelected))

  Hud_SetSelected( pressedButton , state )
}

void function callRestoreDefaults(var pressedButton)
{
  setAllAttributes(true)
}

void function callBanAll(var pressedButton)
{
  setAllAttributes(false)
}

void function switchBoolAttribute(var button, BoolAttributte attribute)
{
  attribute.disabled = !attribute.disabled
  Hud_SetSelected( button , attribute.disabled )
}

void function changeWeaponDisplay( var pressedButton )
{
  int selected = int( Hud_GetScriptID( pressedButton ))
  if(selected != file.weapon.categorySelected) {
    UpdateBanData()
    selectButton(file.weapon.buttons, file.weapon.categorySelected, selected)
    loadWeaponCategory(file.weapon.categories[selected])

    file.weapon.categorySelected = selected
  }
}

void function loadWeaponCategory(Category category)
{
  for(int i = 0; i < file.weapon.displays.len();i++) {
      if(i < category.loadouts.len()) {

        Hud_SetSelected( Hud_GetChild( file.weapon.displays[i], "ButtonMain" ) , category.loadouts[i].disabled )

        RuiSetImage(
          Hud_GetRui( Hud_GetChild( file.weapon.displays[i], "ButtonMain" )),
          "buttonImage",
          category.loadouts[i].image )

        RuiSetImage(
          Hud_GetRui( Hud_GetChild( file.weapon.displays[i], "ButtonAtr0" )),
          "buttonImage",
          category.loadouts[i].atr0.images[category.loadouts[i].selectedAtr0] )

        RuiSetImage(
          Hud_GetRui( Hud_GetChild( file.weapon.displays[i], "ButtonAtr1" )),
          "buttonImage",
          category.loadouts[i].atr1.images[category.loadouts[i].selectedAtr1] )

        if (category.loadouts[i].atr2.images.len() > 0) {
          RuiSetImage(
            Hud_GetRui( Hud_GetChild( file.weapon.displays[i], "ButtonAtr2" )),
            "buttonImage",
            category.loadouts[i].atr2.images[category.loadouts[i].selectedAtr2] )

            Hud_SetVisible( Hud_GetChild( file.weapon.displays[i], "ButtonAtr2" ) , true )
        }
        else
        {
          Hud_SetVisible( Hud_GetChild( file.weapon.displays[i], "ButtonAtr2" ) , false )
        }


        Hud_SetVisible( file.weapon.displays[i] , true )
      } else {
        Hud_SetVisible( file.weapon.displays[i] , false )
      }
  }
}

void function changeTitanDisplay( var pressedButton )
{
  int selected = int( Hud_GetScriptID( pressedButton ))
  if(selected != file.titan.categorySelected) {
    UpdateBanData()
    selectButton(file.titan.buttons, file.titan.categorySelected, selected)
    loadTitanCategory(file.titan.categories[selected])

    file.titan.categorySelected = selected
  }
}

void function loadTitanCategory(Category category) {
  for(int i = 0; i < file.titan.displays.len();i++) {
    if(i < category.loadouts.len()) {

      Hud_SetSelected( Hud_GetChild( file.titan.displays[i], "ButtonMain" ) , category.loadouts[i].disabled )

      RuiSetImage(
        Hud_GetRui( Hud_GetChild( file.titan.displays[i], "ButtonMain" )),
        "buttonImage",
        category.loadouts[i].image )

      RuiSetImage(
        Hud_GetRui( Hud_GetChild( file.titan.displays[i] ,"ButtonFrame")),
        "basicImage",
        category.loadouts[i].image )

      RuiSetImage(
        Hud_GetRui( Hud_GetChild( file.titan.displays[i], "ButtonAtr0" )),
        "buttonImage",
        category.loadouts[i].atr0.images[category.loadouts[i].selectedAtr0] )


      RuiSetImage(
        Hud_GetRui( Hud_GetChild( file.titan.displays[i], "ButtonAtr1" )),
        "buttonImage",
        category.loadouts[i].atr1.images[category.loadouts[i].selectedAtr1] )

      RuiSetImage(
        Hud_GetRui( Hud_GetChild( file.titan.displays[i], "ButtonAtr2" )),
        "buttonImage",
        category.loadouts[i].atr2.images[category.loadouts[i].selectedAtr2] )

      //Check if is Monarch Core Abilities
      if(category.loadouts[i].name == "monarchCores")
      {
        Hud_SetVisible( Hud_GetChild( file.titan.displays[i], "ButtonMain" ) , false )
        Hud_SetVisible( Hud_GetChild( file.titan.displays[i] ,"ButtonFrame" ) , false )

      }
      else
      {
        Hud_SetVisible( Hud_GetChild( file.titan.displays[i], "ButtonMain" ) , true )
        Hud_SetVisible( Hud_GetChild( file.titan.displays[i] ,"ButtonFrame" ) , true )
      }

      Hud_SetVisible( file.titan.displays[i] , true )

    } else {
      Hud_SetVisible( file.titan.displays[i] , false )
    }
  }
}

void function reloadBoostScreen()
{
  foreach(var button in GetElementsByClassname( file.menu, "BoostLoadoutPanelButtonClass" ))
  {
     Hud_SetSelected( button , file.boost.boosts[ int ( Hud_GetScriptID(button) )].disabled )
  }
}

void function reloadPilotScreen()
{
  foreach(var button in GetElementsByClassname( file.menu, "PilotLoadoutPanelButtonClass" ))
  {
    Hud_SetSelected( button , file.pilot.attributes[ int( Hud_GetScriptID(button) ) ].disabled )
  }
}

void function reloadEquipmentScreen()
{
  foreach(var button in GetElementsByClassname( file.menu, "EquipmentLoadoutPanelButtonClass" ))
  {
    Hud_SetSelected( button , file.equipment.attributes[ int( Hud_GetScriptID(button) ) ].disabled )
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Data import/export
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void function setAllAttributes(bool enabled)
{
  //Pilot
  foreach(BoolAttributte attribute in file.pilot.attributes)
  {
    attribute.disabled = !enabled
  }
  foreach(BoolAttributte attribute in file.equipment.attributes)
  {
    attribute.disabled = !enabled
  }
  //Weapon
  for(int i = 0; i < file.weapon.categories.len();i++)
  {
    for(int j = 0; j < file.weapon.categories[i].loadouts.len(); j++)
    {
      Loadout weapon = file.weapon.categories[i].loadouts[j]
      weapon.disabled = !enabled
      if(enabled) {
        weapon.selectedAtr0 = 0
        weapon.selectedAtr1 = 0
        weapon.selectedAtr2 = 0
      }
    }
  }
  //Titan
  for(int i = 0; i < file.titan.categories.len(); i++)
  {
    for(int j = 0; j < file.titan.categories[i].loadouts.len(); j++)
    {
      Loadout titan = file.titan.categories[i].loadouts[j]
      titan.disabled = !enabled
      if(enabled) {
        titan.selectedAtr0 = 0
        titan.selectedAtr1 = 0
        titan.selectedAtr2 = 0
      }
    }
  }
  //Boost
  foreach(BoolAttributte attribute in file.boost.boosts)
  {
    attribute.disabled = !enabled
  }

  sendPilotConfig()
  sendEquipmentConfig()
  sendWeaponConfig()
  sendTitanConfig()
  sendBoostConfig()
  reloadActiveUI()
}

void function exportConfigToString(var pressedButton)
{
  string exportString = ""
  //Pilot
  foreach(BoolAttributte attribute in file.pilot.attributes)
  {
    exportString += attribute.disabled ? "1" : "0"
  }
  foreach(BoolAttributte attribute in file.equipment.attributes)
  {
    exportString += attribute.disabled ? "1" : "0"
  }
  //Weapon
  for(int i = 0; i < file.weapon.categories.len();i++)
  {
    for(int j = 0; j < file.weapon.categories[i].loadouts.len(); j++)
    {
      Loadout weapon = file.weapon.categories[i].loadouts[j]
      exportString += weapon.disabled ? "1" : "0"

      exportString += weapon.atr0.values[weapon.selectedAtr0]
      exportString += weapon.atr1.values[weapon.selectedAtr1]
      try {
        exportString += weapon.atr2.values[weapon.selectedAtr2]
      } catch (exception) {
        exportString += "0"
      }
    }
  }
  //Titan
  for(int i = 0; i < file.titan.categories.len(); i++)
  {
    for(int j = 0; j < file.titan.categories[i].loadouts.len(); j++)
    {
      Loadout titan = file.titan.categories[i].loadouts[j]
      exportString += titan.disabled ? "1" : "0"

      exportString += titan.atr0.values[titan.selectedAtr0]
      exportString += titan.atr1.values[titan.selectedAtr1]
      exportString += titan.atr2.values[titan.selectedAtr2]
    }
  }
  //Boost
  foreach(BoolAttributte attribute in file.boost.boosts)
  {
    exportString += attribute.disabled ? "1" : "0"
  }

  Hud_SetText( Hud_GetChild( file.menu, "ImportExportArea" ), exportString )
}

int function importPilotUIConfig( array<int> config, int count = 0 )
{

  foreach(BoolAttributte attribute in file.pilot.attributes)
  {
    attribute.disabled = (config[count++] == 1) ? true : false
  }
  return count
}

int function importEquipmentUIConfig( array<int> config, int count = 0 )
{

  foreach(BoolAttributte attribute in file.equipment.attributes)
  {
    attribute.disabled = (config[count++] == 1) ? true : false
  }
  return count
}

int function importWeaponUIConfig( array<int> config, int count = 0 )
{
  for(int i = 0; i < file.weapon.categories.len();i++)
  {
    count = importWeaponCategoryUIConfig(i, config, count)
  }
  return count
}

int function importWeaponCategoryUIConfig(int category ,array<int> config, int count = 0 )
{
  for(int i = 0; i < file.weapon.categories[category].loadouts.len(); i++)
  {
    Loadout weapon = file.weapon.categories[category].loadouts[i]

    weapon.disabled = (config[count++] == 1) ? true : false

    int indexOfAtr

    indexOfAtr = arrayContains( weapon.atr0.values, config[count++] + "" )
    weapon.selectedAtr0 = ( indexOfAtr != -1 ) ? indexOfAtr : 0

    indexOfAtr = arrayContains( weapon.atr1.values, config[count++] + "" )
    weapon.selectedAtr1 = ( indexOfAtr != -1 ) ? indexOfAtr : 0

    indexOfAtr = arrayContains( weapon.atr2.values, config[count++] + "" )
    weapon.selectedAtr2 =  ( indexOfAtr != -1 ) ? indexOfAtr : 0

  }
  return count
}

int function importTitanUIConfig( array<int> config, int count = 0 )
{
  for(int i = 0; i < file.titan.categories.len(); i++)
  {
    count = importTitanCategoryUIConfig(i, config, count)
  }
  return count
}

int function importTitanCategoryUIConfig(int category ,array<int> config, int count = 0 )
{
  for(int i = 0; i < file.titan.categories[category].loadouts.len(); i++)
  {
    Loadout titan = file.titan.categories[category].loadouts[i]
    titan.disabled = (config[count++] == 1) ? true : false

    int indexOfAtr

    indexOfAtr = arrayContains( titan.atr0.values, config[count++] + "" )
    titan.selectedAtr0 = ( indexOfAtr != -1 ) ? indexOfAtr : 0

    indexOfAtr = arrayContains( titan.atr1.values, config[count++] + "" )
    titan.selectedAtr1 = ( indexOfAtr != -1 ) ? indexOfAtr : 0

    indexOfAtr = arrayContains( titan.atr2.values, config[count++] + "" )
    titan.selectedAtr2 =  ( indexOfAtr != -1 ) ? indexOfAtr : 0
    }
    return count
}

int function importBoostUIConfig( array<int> config, int count = 0 )
{
  foreach(BoolAttributte attribute in file.boost.boosts)
  {
    attribute.disabled = (config[count++] == 1) ? true : false
  }
  return count
}

void function importConfigToString(var pressedButton)
{
  string importString = Hud_GetUTF8Text( Hud_GetChild( file.menu, "ImportExportArea" ) )
  if(importString.len() != NR_OF_BANABLE_ELEMENTS) {
    return
  }
  importUIConfig(importString)
  sendPilotConfig()
  sendEquipmentConfig()
  sendWeaponConfig()
  sendTitanConfig()
  sendBoostConfig()
}

void function importUIConfig(string input)
{
  if(input.len() != NR_OF_BANABLE_ELEMENTS) {
    return
  }

  array<int> importArray = parseImportData(input)
  int count = 0

  if(importArray.len() != NR_OF_BANABLE_ELEMENTS) {
    return
  }

  count = importPilotUIConfig(importArray, count)
  count = importEquipmentUIConfig(importArray, count)
  count = importWeaponUIConfig(importArray, count)
  count = importTitanUIConfig(importArray, count)
  count = importBoostUIConfig(importArray, count)

  reloadActiveUI()
}

void function ImportBanConfig(string importString)
{
  if(importString.len() != NR_OF_BANABLE_ELEMENTS) {
    print("BanSystem Config has invalid length")
    return
  }
  importUIConfig(importString)
  sendPilotConfig()
  sendEquipmentConfig()
  sendWeaponConfig()
  sendTitanConfig()
  sendBoostConfig()
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///Data Init
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void function initPilot()
{
  PilotDisplay pilot = file.pilot
  pilot.loadoutDisplay = file.loadoutDisplays[UI_PLAYER_INDEX]

  var lableOne = Hud_GetChild( file.pilot.loadoutDisplay, "TacticalName" )
  SetLabelRuiText( lableOne, Localize("#MODE_SETTING_BAN_PILOT_TACTICAL") )

  var lableTwo = Hud_GetChild( file.pilot.loadoutDisplay, "OrdnanceName" )
  SetLabelRuiText( lableTwo, Localize("#MODE_SETTING_BAN_PILOT_ORDINANCE") )

  pilot.attributes.append(createBoolAttributte($"rui/pilot_loadout/suit/geist"))
  pilot.attributes.append(createBoolAttributte($"rui/pilot_loadout/suit/medium"))
  pilot.attributes.append(createBoolAttributte($"rui/pilot_loadout/suit/grapple"))
  pilot.attributes.append(createBoolAttributte($"rui/pilot_loadout/suit/nomad"))
  pilot.attributes.append(createBoolAttributte($"rui/pilot_loadout/suit/heavy"))
  pilot.attributes.append(createBoolAttributte($"rui/pilot_loadout/suit/light"))
  pilot.attributes.append(createBoolAttributte($"rui/pilot_loadout/suit/stalker"))

  pilot.attributes.append(createBoolAttributte( $"rui/pilot_loadout/ordnance/frag_menu"))
  pilot.attributes.append(createBoolAttributte($"rui/pilot_loadout/ordnance/arc_grenade_menu"))
  pilot.attributes.append(createBoolAttributte($"rui/pilot_loadout/ordnance/firestar_menu"))
  pilot.attributes.append(createBoolAttributte( $"rui/pilot_loadout/ordnance/gravity_grenade_menu"))
  pilot.attributes.append(createBoolAttributte($"rui/pilot_loadout/ordnance/electric_smoke_menu"))
  pilot.attributes.append(createBoolAttributte($"rui/pilot_loadout/ordnance/satchel_menu"))

  foreach(var button in GetElementsByClassname( file.menu, "PilotLoadoutPanelButtonClass" ))
  {
    int buttonId = int(Hud_GetScriptID( button ))

    RuiSetImage( Hud_GetRui( button  ), "buttonImage",  pilot.attributes[buttonId].image)
    AddButtonEventHandler( button, UIE_CLICK, callPilotButtonClick )
  }


  var rui = Hud_GetRui( Hud_GetChild( pilot.loadoutDisplay, "PilotDetails" ) )

	RuiSetString( rui, "nameText", Localize("#MODE_SETTING_BAN_PILOT_LBL_TITLE") )
	RuiSetString( rui, "descText", Localize("#MODE_SETTING_BAN_PILOT_LBL_TEXT") )
}

BoolAttributte function createBoolAttributte( asset image)
{
    BoolAttributte attribute
    attribute.image = image
    return attribute
}

void function initEquipment()
{
  PilotDisplay equipment = file.equipment
  equipment.loadoutDisplay = file.loadoutDisplays[UI_EQUIPMENT_INDEX]

  var lableOne = Hud_GetChild( file.equipment.loadoutDisplay, "ExecutionName" )
  SetLabelRuiText( lableOne, Localize("#MODE_SETTING_BAN_PILOT_EXECUTION") )

  var lableTwo = Hud_GetChild( file.equipment.loadoutDisplay, "Kit1Name" )
  SetLabelRuiText( lableTwo, Localize("#MODE_SETTING_BAN_PILOT_KIT_1") )

  var lableThree = Hud_GetChild( file.equipment.loadoutDisplay, "Kit2Name" )
  SetLabelRuiText( lableThree, Localize("#MODE_SETTING_BAN_PILOT_KIT_2") )

  var lableFour = Hud_GetChild( file.equipment.loadoutDisplay, "MeleeName" )
  SetLabelRuiText( lableFour, Localize("#MODE_SETTING_BAN_PILOT_MELEE") )

  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/execution/execution_neck_snap"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/execution/execution_inner_pieces"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/execution/execution_grapple"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/execution/execution_straight_blast"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/execution/execution_now_you_see_me"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/execution/execution_amped_wall"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/execution/execution_holopilot"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/execution/execution_pulseblade"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/execution/execution_face_stab"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/execution/execution_backshot"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/execution/execution_combo"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/execution/execution_knockout"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/execution/execution_random"))

  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/kit/power_cell_menu"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/kit/quick_regen_menu"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/kit/ordnance_expert_menu"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/kit/phase_embark_menu"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/kit/kill_report_menu"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/kit/wall_hang_menu"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/kit/hover_menu"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/kit/stealth_movement_menu"))
  equipment.attributes.append(createBoolAttributte($"rui/pilot_loadout/kit/titan_hunter_menu"))

  equipment.attributes.append(createBoolAttributte($"rui/gencard_icons/dlc5/gc_icon_pilot_circle"))
  equipment.attributes.append(createBoolAttributte($"rui/gencard_icons/dlc5/gc_icon_tri_chevron"))


  int frameCount = 0;
  foreach(var button in GetElementsByClassname( file.menu, "EquipmentLoadoutPanelButtonClass" ))
  {
    int buttonId = int(Hud_GetScriptID( button ))
    if(buttonId == 22 || buttonId == 23) {
      var buttonFrame = Hud_GetChild( file.equipment.loadoutDisplay, "ButtonFrame" + frameCount++ )
      RuiSetImage( Hud_GetRui( buttonFrame  ), "basicImage",  equipment.attributes[buttonId].image)
    } else {
      RuiSetImage( Hud_GetRui( button  ), "buttonImage",  equipment.attributes[buttonId].image)
    }

    AddButtonEventHandler( button, UIE_CLICK, callEquipmentButtonClick )

  }





  var rui = Hud_GetRui( Hud_GetChild( equipment.loadoutDisplay, "EquipmentDetails" ) )

	RuiSetString( rui, "nameText", Localize("#MODE_SETTING_BAN_EQUIPMENT_LBL_TITLE") )
	RuiSetString( rui, "descText", Localize("#MODE_SETTING_BAN_EQUIPMENT_LBL_TEXT") )
}

void function initWeapon()
{
  LoadoutDisplay weapon = file.weapon
  weapon.loadoutDisplay = file.loadoutDisplays[UI_WEAPON_INDEX]
  weapon.displays = GetElementsByClassname( file.menu, "weaponDisplay")

  weapon.buttons = GetElementsByClassname( file.menu, "BanWeaponCategoryButton" )

  ArrayAttribute defaultMod
  defaultMod.images = [
    $"rui/menu/common/unlock_random",
    $"rui/pilot_loadout/mods/extended_ammo",
    $"rui/pilot_loadout/mods/gunrunner",
    $"rui/pilot_loadout/kit/speed_loader",
    $"rui/pilot_loadout/mods/gun_ready",
    $"rui/pilot_loadout/mods/speed_transition",
    $"rui/pilot_loadout/mods/tactikill",
    $"ui/menu/items/mod_icons/none"]
  defaultMod.values = [
    "0",
    "1",
    "4",
    "2",
    "3",
    "6",
    "5",
    "7"]

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Category ar1
  ar1.displayName = "#MENU_TITLE_AR"
  ar1.prefix = "1. "

  ArrayAttribute arVisor
  arVisor.images = [
    $"rui/menu/common/unlock_random",
    $"r2_ui/menus/loadout_icons/attachments/iron_sights",
    $"r2_ui/menus/loadout_icons/attachments/hcog_ranger",
    $"r2_ui/menus/loadout_icons/attachments/hcog" ,
    $"r2_ui/menus/loadout_icons/attachments/threat_scope"]
  arVisor.values = [
    "0",
    "7",
    "3",
    "2",
    "6"]

  ar1.loadouts.append(createWeapon(
    "r201",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_r102",
    defaultMod,
    defaultMod,
    arVisor))

  ArrayAttribute r101Visor = {
      images = [
        $"rui/menu/common/unlock_random",
        $"r2_ui/menus/loadout_icons/attachments/aog",
        $"r2_ui/menus/loadout_icons/attachments/hcog_ranger",
        $"r2_ui/menus/loadout_icons/attachments/hcog" ,
        $"r2_ui/menus/loadout_icons/attachments/threat_scope"],
      values = [
        "0",
        "7",
        "3",
        "2",
        "6"]
    }
  ar1.loadouts.append(createWeapon(
    "r101",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_r101_aog",
    defaultMod,
    defaultMod,
    r101Visor
    ))
  ar1.loadouts.append(createWeapon(
    "hemlok",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_hemlok",
    defaultMod,
    defaultMod,
    arVisor))

  weapon.categories.append(ar1)

  Category ar2
  ar2.displayName = "#MENU_TITLE_AR"
  ar2.prefix = "2. "

  ar2.loadouts.append(createWeapon(
    "g2",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_g2a5",
    defaultMod,
    defaultMod,
    arVisor))
  ar2.loadouts.append(createWeapon(
    "flatline",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_vinson",
    defaultMod,
    defaultMod,
    arVisor))


  weapon.categories.append(ar2)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Category smg
  smg.displayName = "#MENU_TITLE_SMG"

  ArrayAttribute smgVisor
  smgVisor.images = [
    $"rui/menu/common/unlock_random",
    $"r2_ui/menus/loadout_icons/attachments/iron_sights",
    $"r2_ui/menus/loadout_icons/attachments/hcog_ranger",
    $"r2_ui/menus/loadout_icons/attachments/holosight" ,
    $"r2_ui/menus/loadout_icons/attachments/threat_scope"]
  smgVisor.values = [
    "0",
    "7",
    "3",
    "1",
    "6"]

  smg.loadouts.append(createWeapon(
    "car",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_car",
    defaultMod,
    defaultMod,
    smgVisor))

  smg.loadouts.append(createWeapon(
    "alternator",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_alternator",
    defaultMod,
    defaultMod,
    arVisor))

  smg.loadouts.append(createWeapon(
    "volt",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_volt",
    defaultMod,
    defaultMod,
    smgVisor))

  smg.loadouts.append(createWeapon(
    "r97",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_r97n",
    defaultMod,
    defaultMod,
    smgVisor))

  weapon.categories.append(smg)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Category lmg
  lmg.displayName = "#MENU_TITLE_LMG"

  ArrayAttribute lmgVisor
  lmgVisor.images = [
    $"rui/menu/common/unlock_random",
    $"r2_ui/menus/loadout_icons/attachments/iron_sights",
    $"r2_ui/menus/loadout_icons/attachments/hcog_ranger",
    $"r2_ui/menus/loadout_icons/attachments/aog",
    $"r2_ui/menus/loadout_icons/attachments/threat_scope"]
  lmgVisor.values = [
    "0",
    "7",
    "3",
    "4",
    "6"]

  lmg.loadouts.append(createWeapon(
    "spitfire",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_spitfire",
    defaultMod,
    defaultMod,
    lmgVisor))

  lmg.loadouts.append(createWeapon(
    "lstar",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_lstar",
    defaultMod,
    defaultMod,
    lmgVisor))

  lmg.loadouts.append(createWeapon(
    "devotion",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_esaw",
    defaultMod,
    defaultMod,
    lmgVisor))

  weapon.categories.append(lmg)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Category sniper
  sniper.displayName = "#MENU_TITLE_SNIPER"

  ArrayAttribute sniperViser
  sniperViser.images = [
    $"rui/menu/common/unlock_random",
    $"r2_ui/menus/loadout_icons/attachments/stock_scope",
    $"r2_ui/menus/loadout_icons/attachments/variable_zoom",
    $"r2_ui/menus/loadout_icons/attachments/threat_scope",]
  sniperViser.values = [
    "0"
    "7",
    "5",
    "6",]

  ArrayAttribute takeViser
  takeViser.images = [
    $"rui/menu/common/unlock_random",
    $"r2_ui/menus/loadout_icons/attachments/stock_doubletake_sight",
    $"r2_ui/menus/loadout_icons/attachments/variable_zoom",
    $"r2_ui/menus/loadout_icons/attachments/threat_scope",]
  takeViser.values = [
    "0",
    "7",
    "5",
    "6",]

  ArrayAttribute sniperModOne
  sniperModOne.images = [
    $"rui/menu/common/unlock_random",
    $"rui/pilot_loadout/mods/extended_ammo",
    $"rui/pilot_loadout/kit/speed_loader",
    $"rui/pilot_loadout/mods/gun_ready",
    $"rui/pilot_loadout/mods/speed_transition",
    $"rui/pilot_loadout/mods/tactikill",
    $"rui/pilot_loadout/mods/ricochet",
    $"ui/menu/items/mod_icons/none"]
  sniperModOne.values = [
    "0",
    "1",
    "2",
    "3",
    "6",
    "5",
    "8",
    "7"]

  ArrayAttribute sniperModTwo
  sniperModTwo.images = [
    $"rui/menu/common/unlock_random",
    $"rui/pilot_loadout/mods/extended_ammo",
    $"rui/pilot_loadout/kit/speed_loader",
    $"rui/pilot_loadout/mods/gun_ready",
    $"rui/pilot_loadout/mods/speed_transition",
    $"rui/pilot_loadout/mods/tactikill",
    $"ui/menu/items/mod_icons/none"]
  sniperModTwo.values = [
    "0",
    "1",
    "2",
    "3",
    "6",
    "5",
    "7"]

  sniper.loadouts.append(createWeapon(
    "kraber",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_kraber",
    sniperModOne,
    sniperModOne,
    sniperViser))

  sniper.loadouts.append(createWeapon(
    "doubletake",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_doubletake",
    sniperModOne,
    sniperModOne,
    takeViser))

  sniper.loadouts.append(createWeapon(
    "dmr",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_longbow",
    sniperModTwo,
    sniperModTwo,
    sniperViser))

  weapon.categories.append(sniper)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Category shotgun
  shotgun.displayName = "#MENU_TITLE_SHOTGUN"

  shotgun.loadouts.append(createWeapon(
    "eva",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_eva8",
    defaultMod,
    defaultMod,
    smgVisor))

  shotgun.loadouts.append(createWeapon(
    "mastiff",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_mastiff",
    defaultMod,
    defaultMod,
    smgVisor))

  weapon.categories.append(shotgun)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Category grenadier
  grenadier.displayName = "#MENU_TITLE_GRENADIER"

  grenadier.loadouts.append(createWeaponNoVisor(
    "smr",
    $"r2_ui/menus/loadout_icons/anti_titan/at_sidewinder",
    defaultMod,
    defaultMod))

  grenadier.loadouts.append(createWeaponNoVisor(
    "epg",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_epg1",
    defaultMod,
    defaultMod))

  grenadier.loadouts.append(createWeaponNoVisor(
    "softball",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_softball",
    defaultMod,
    defaultMod))

  grenadier.loadouts.append(createWeaponNoVisor(
    "coldwar",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_coldwar",
    defaultMod,
    defaultMod))

  weapon.categories.append(grenadier)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Category handgun
  handgun.displayName = "#MENU_TITLE_HANDGUN"

  ArrayAttribute handgunMod
  handgunMod.images = [
    $"rui/menu/common/unlock_random",
    $"rui/pilot_loadout/mods/extended_ammo",
    $"r2_ui/menus/loadout_icons/attachments/suppressor",
    $"rui/pilot_loadout/mods/gunrunner",
    $"rui/pilot_loadout/kit/speed_loader",
    $"rui/pilot_loadout/mods/gun_ready",
    $"rui/pilot_loadout/mods/tactikill",
    $"ui/menu/items/mod_icons/none"]
  handgunMod.values = [
    "0",
    "1",
    "8",
    "4",
    "2",
    "3",
    "5",
    "7"]

  ArrayAttribute wingmanMod
  wingmanMod.images = [
    $"rui/menu/common/unlock_random",
    $"rui/pilot_loadout/mods/extended_ammo",
    $"rui/pilot_loadout/mods/ricochet",
    $"rui/pilot_loadout/mods/gunrunner",
    $"rui/pilot_loadout/kit/speed_loader",
    $"rui/pilot_loadout/mods/gun_ready",
    $"rui/pilot_loadout/mods/tactikill",
    $"ui/menu/items/mod_icons/none"]
  wingmanMod.values = [
    "0",
    "2",
    "8",
    "4",
    "2",
    "3",
    "5",
    "7"]

  handgun.loadouts.append(createWeaponNoVisor(
    "wingman_elite",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_wingman_elite",
    wingmanMod,
    wingmanMod))

  handgun.loadouts.append(createWeaponNoVisor(
    "mozambique",
    $"r2_ui/menus/loadout_icons/secondary_weapon/secondary_mozambique",
    handgunMod,
    handgunMod))

  handgun.loadouts.append(createWeaponNoVisor(
    "re45",
    $"r2_ui/menus/loadout_icons/secondary_weapon/secondary_autopistol",
    handgunMod,
    handgunMod))

  handgun.loadouts.append(createWeaponNoVisor(
    "p2016",
    $"r2_ui/menus/loadout_icons/secondary_weapon/secondary_hammondp2011",
    handgunMod,
    handgunMod))

  handgun.loadouts.append(createWeaponNoVisor(
    "b3",
    $"r2_ui/menus/loadout_icons/primary_weapon/primary_wingman_m",
    handgunMod,
    handgunMod))

  weapon.categories.append(handgun)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Category antiTitan
  antiTitan.displayName = "#MENU_TITLE_ANTI_TITAN"

  ArrayAttribute antiTitanMod
  antiTitanMod.images = [
    $"rui/menu/common/unlock_random",
    $"rui/pilot_loadout/mods/extended_ammo",
    $"rui/pilot_loadout/mods/gun_ready",
    $"rui/pilot_loadout/kit/speed_loader",
    $"rui/pilot_loadout/mods/speed_transition",
    $"ui/menu/items/mod_icons/none"]
  antiTitanMod.values = [
    "0",
    "1",
    "3",
    "2",
    "6",
    "7"]

  ArrayAttribute chargerifleMod
  chargerifleMod.images = [
    $"rui/menu/common/unlock_random",
    $"rui/pilot_loadout/mods/extended_ammo",
    $"rui/pilot_loadout/mods/charge_hack",
    $"rui/pilot_loadout/mods/gun_ready",
    $"rui/pilot_loadout/mods/speed_transition",
    $"ui/menu/items/mod_icons/none"]
  chargerifleMod.values = [
    "0",
    "1",
    "8",
    "4",
    "3",
    "7"]

  antiTitan.loadouts.append(createWeaponNoVisor(
    "chargerifle",
    $"r2_ui/menus/loadout_icons/anti_titan/at_defenderc",
    chargerifleMod,
    chargerifleMod))

  antiTitan.loadouts.append(createWeaponNoVisor(
    "mgl",
    $"r2_ui/menus/loadout_icons/anti_titan/at_mgl",
    antiTitanMod,
    antiTitanMod))

  antiTitan.loadouts.append(createWeaponNoVisor(
    "thunderbolt",
    $"r2_ui/menus/loadout_icons/anti_titan/at_arcball",
    antiTitanMod,
    antiTitanMod))

  antiTitan.loadouts.append(createWeaponNoVisor(
    "archer",
    $"r2_ui/menus/loadout_icons/anti_titan/at_archer",
    antiTitanMod,
    antiTitanMod))

  weapon.categories.append(antiTitan)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  for(int i = 0; i < weapon.buttons.len() ; i++)
  {
    RHud_SetText( weapon.buttons[i], weapon.categories[i].prefix + Localize(weapon.categories[i].displayName) )
    AddButtonEventHandler( weapon.buttons[i], UIE_CLICK, changeWeaponDisplay )
	}

  array<var> weaponButton = GetElementsByClassname( file.menu, "LoadoutPanelButtonClass" )

  for(int i = 0; i < weaponButton.len(); i++) {
    AddButtonEventHandler( weaponButton[i], UIE_CLICK, callLoadoutButtonClick )
  }

  array<var> modTypeButtons = GetElementsByClassname( file.menu, "HideWhenEditing_0" )

  for(int i = 0; i < modTypeButtons.len(); i++) {
    AddButtonEventHandler( modTypeButtons[i], UIE_CLICK, clickOpenSubMenu )
  }



  selectButton(weapon.buttons, 1, 0)
  changeWeaponDisplay(weapon.buttons[0])

  var rui = Hud_GetRui( Hud_GetChild( weapon.loadoutDisplay, "WeaponDetails" ) )

	RuiSetString( rui, "nameText", Localize("#MODE_SETTING_BAN_WEAPON_LBL_TITLE") )
	RuiSetString( rui, "descText", Localize("#MODE_SETTING_BAN_WEAPON_LBL_TEXT") )
}

Loadout function createWeapon(string name, asset image, ArrayAttribute atr0, ArrayAttribute atr1, ArrayAttribute atr2)
{
  Loadout weapon
  weapon.image = image
  weapon.disabled = false
  weapon.selectedAtr0 = 0
  weapon.selectedAtr1 = 0
  weapon.selectedAtr2 = 0
  weapon.name = name
  weapon.atr0 = atr0
  weapon.atr1 = atr1
  weapon.atr2 = atr2

  return weapon
}

Loadout function createWeaponNoVisor(string name, asset image, ArrayAttribute atr0, ArrayAttribute atr1)
{
  ArrayAttribute visor

  Loadout weapon
  weapon.image = image
  weapon.disabled = false
  weapon.selectedAtr0 = 0
  weapon.selectedAtr1 = 0
  weapon.selectedAtr2 = 0
  weapon.name = name
  weapon.atr0 = atr0
  weapon.atr1 = atr1
  weapon.atr2 = visor

  return weapon
}

void function initTitan()
{
  LoadoutDisplay titan = file.titan

  titan.loadoutDisplay = file.loadoutDisplays[UI_TITAN_INDEX]

  var lableOne = Hud_GetChild( file.titan.loadoutDisplay, "TitanName" )
  SetLabelRuiText( lableOne, Localize("#MODE_SETTING_BAN_TITAN") )

  titan.buttons = GetElementsByClassname( file.menu, "BanTitanCategoryButton" )

  titan.displays = GetElementsByClassname( file.menu, "titanDisplay")

  ArrayAttribute fallKit
  fallKit.images = [
    $"rui/menu/common/unlock_random",
    $"rui/titan_loadout/passive/titanfall_kit_bubbleshield",
    $"rui/titan_loadout/passive/titanfall_kit_warpfall"]
  fallKit.values = [
    "0"
    "7",
    "8"
  ]

  ArrayAttribute titanKit
  titanKit.images = [
    $"rui/menu/common/unlock_random",
    $"rui/titan_loadout/passive/assault_chip",
    $"rui/titan_loadout/passive/auto_eject",
    $"rui/titan_loadout/passive/dash_plus",
    $"rui/titan_loadout/passive/overcore",
    $"rui/titan_loadout/passive/nuke_eject",
    $"rui/titan_loadout/passive/improved_anti_rodeo"]
  titanKit.values = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6"
  ]

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Category stryder
  stryder.displayName = "Stryder"

  Loadout northstar
  northstar.name = "northstar"
  northstar.image = $"rui/callsigns/callsign_fd_northstar_hard"
  northstar.disabled = false
  northstar.selectedAtr0 = 0
  northstar.selectedAtr1 = 0
  northstar.selectedAtr2 = 0
  ArrayAttribute northstarKit
  northstarKit.images = [
    $"rui/menu/common/unlock_random",
    $"rui/titan_loadout/passive/northstar_piercing_shot",
    $"rui/titan_loadout/passive/northstar_enhanced_payload",
    $"rui/titan_loadout/passive/northstar_twin_trap",
    $"rui/titan_loadout/passive/northstar_viper_thrusters",
    $"rui/titan_loadout/passive/northstar_threat_optics"
  ]
  northstarKit.values = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5"
  ]
  northstar.atr0 = northstarKit
  northstar.atr1 = titanKit
  northstar.atr2 = fallKit
  stryder.loadouts.append(northstar)

  Loadout ronin
  ronin.name = "ronin"
  ronin.image = $"rui/callsigns/callsign_fd_ronin_hard"
  ronin.disabled = false
  ronin.selectedAtr0 = 0
  ronin.selectedAtr1 = 0
  ronin.selectedAtr2 = 0
  ArrayAttribute roninKit
  roninKit.images = [
    $"rui/menu/common/unlock_random",
    $"rui/titan_loadout/passive/ronin_ricochet_round",
    $"rui/titan_loadout/passive/ronin_thunderstorm",
    $"rui/titan_loadout/passive/ronin_temporal_anomaly",
    $"rui/titan_loadout/passive/ronin_highlander",
    $"rui/titan_loadout/passive/ronin_auto_shift"
  ]
  roninKit.values = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5"
  ]
  ronin.atr0 = roninKit
  ronin.atr1 = titanKit
  ronin.atr2 = fallKit

  stryder.loadouts.append(ronin)
  titan.categories.append(stryder)
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Category atlas
  atlas.displayName = "Atlas"

  Loadout ion
  ion.name = "ion"
  ion.image = $"rui/callsigns/callsign_fd_ion_hard"
  ion.disabled = false
  ion.selectedAtr0 = 0
  ion.selectedAtr1 = 0
  ion.selectedAtr2 = 0
  ArrayAttribute ionKit
  ionKit.images = [
    $"rui/menu/common/unlock_random",
    $"rui/titan_loadout/passive/ion_entangled_energy",
    $"rui/titan_loadout/passive/ion_zero_point_tripwire",
    $"rui/titan_loadout/passive/ion_vortex_amp",
    $"rui/titan_loadout/passive/ion_grand_canon",
    $"rui/titan_loadout/passive/ion_diffraction_lens"
  ]
  ionKit.values = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5"
  ]
  ion.atr0 = ionKit
  ion.atr1 = titanKit
  ion.atr2 = fallKit

  atlas.loadouts.append(ion)

  Loadout tone
  tone.name = "tone"
  tone.image = $"rui/callsigns/callsign_fd_tone_hard"
  tone.disabled = false
  tone.selectedAtr0 = 0
  tone.selectedAtr1 = 0
  tone.selectedAtr2 = 0
  ArrayAttribute toneKit
  toneKit.images = [
    $"rui/menu/common/unlock_random",
    $"rui/titan_loadout/passive/tone_enhanced_tracker",
    $"rui/titan_loadout/passive/tone_reinforced_partical_wall",
    $"rui/titan_loadout/passive/tone_pulse_echo",
    $"rui/titan_loadout/passive/tone_rocket_barrage",
    $"rui/titan_loadout/passive/tone_40mm_burst"
  ]
  toneKit.values = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5"
  ]
  tone.atr0 = toneKit
  tone.atr1 = titanKit
  tone.atr2 = fallKit

  atlas.loadouts.append(tone)

  Loadout monarch
  monarch.name = "monarch"
  monarch.image = $"rui/callsigns/callsign_fd_monarch_hard"
  monarch.disabled = false
  monarch.selectedAtr0 = 0
  monarch.selectedAtr1 = 0
  monarch.selectedAtr2 = 0
  ArrayAttribute monarchKit
  monarchKit.images = [
    $"rui/menu/common/unlock_random",
    $"rui/titan_loadout/passive/vanguard_fittest",
    $"rui/titan_loadout/passive/vanguard_siphon",
    $"rui/titan_loadout/passive/vanguard_survivor",
    $"rui/titan_loadout/passive/vanguard_rearm"
  ]
  monarchKit.values = [
    "0",
    "1",
    "2",
    "3",
    "4"
  ]
  monarch.atr0 = monarchKit
  monarch.atr1 = titanKit
  monarch.atr2 = fallKit

  atlas.loadouts.append(monarch)

  Loadout monarchCores
  monarchCores.name = "monarchCores"
  monarchCores.image = $"rui/callsigns/callsign_fd_monarch_hard"
  monarchCores.disabled = false
  monarchCores.selectedAtr0 = 0
  monarchCores.selectedAtr1 = 0
  monarchCores.selectedAtr2 = 0
  ArrayAttribute monarchCore0
  monarchCore0.images = [
    $"rui/menu/common/unlock_random",
    $"rui/titan_loadout/passive/monarch_core_arc_rounds",
    $"rui/titan_loadout/passive/monarch_core_energy_field",
    $"rui/titan_loadout/passive/monarch_core_missile_racks"
  ]
  monarchCore0.values = [
    "0",
    "1",
    "2",
    "3"
  ]
  ArrayAttribute monarchCore1
  monarchCore1.images = [
    $"rui/menu/common/unlock_random",
    $"rui/titan_loadout/passive/monarch_core_swift_rearm",
    $"rui/titan_loadout/passive/monarch_core_maelstrom",
    $"rui/titan_loadout/passive/monarch_core_energy_transfer"
  ]
  monarchCore1.values = [
    "0",
    "1",
    "2",
    "3"
  ]
  ArrayAttribute monarchCore2
  monarchCore2.images = [
    $"rui/menu/common/unlock_random",
    $"rui/titan_loadout/passive/monarch_core_multi_target",
    $"rui/titan_loadout/passive/monarch_core_superior_chassis",
    $"rui/titan_loadout/passive/monarch_core_xo16"
  ]
  monarchCore2.values = [
    "0",
    "1",
    "2",
    "3"
  ]
  monarchCores.atr0 = monarchCore0
  monarchCores.atr1 = monarchCore1
  monarchCores.atr2 = monarchCore2

  atlas.loadouts.append(monarchCores)

  titan.categories.append(atlas)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Category ogre
  ogre.displayName = "Ogre"

  Loadout scorch
  scorch.name = "scorch"
  scorch.image = $"rui/callsigns/callsign_fd_scorch_hard"
  scorch.disabled = false
  scorch.selectedAtr0 = 0
  scorch.selectedAtr1 = 0
  scorch.selectedAtr2 = 0
  ArrayAttribute scorchKit
  scorchKit.images = [
    $"rui/menu/common/unlock_random",
    $"rui/titan_loadout/passive/scorch_wildfire_launcher",
    $"rui/titan_loadout/passive/scorch_fuel",
    $"rui/titan_loadout/passive/scorch_scorched_earth",
    $"rui/titan_loadout/passive/scorch_inferno_shield",
    $"rui/titan_loadout/passive/scorch_tempered_plating"
  ]
  scorchKit.values = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5"
  ]
  scorch.atr0 = scorchKit
  scorch.atr1 = titanKit
  scorch.atr2 = fallKit

  ogre.loadouts.append(scorch)


  Loadout legion
  legion.name = "legion"
  legion.image = $"rui/callsigns/callsign_fd_legion_hard"
  legion.disabled = false
  legion.selectedAtr0 = 0
  legion.selectedAtr1 = 0
  legion.selectedAtr2 = 0
  ArrayAttribute legionKit
  legionKit.images = [
    $"rui/menu/common/unlock_random",
    $"rui/titan_loadout/passive/legion_enhanced_ammo",
    $"rui/titan_loadout/passive/legion_sensor_array",
    $"rui/titan_loadout/passive/legion_bulwark",
    $"rui/titan_loadout/passive/legion_lightweight_alloys",
    $"rui/titan_loadout/passive/legion_siege_mode"
  ]
  legionKit.values = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5"
  ]
  legion.atr0 = legionKit
  legion.atr1 = titanKit
  legion.atr2 = fallKit

  ogre.loadouts.append(legion)

  titan.categories.append(ogre)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  for(int i = 0; i < titan.buttons.len() ; i++)
  {
    RHud_SetText( titan.buttons[i], Localize(titan.categories[i].displayName) )
    AddButtonEventHandler( titan.buttons[i], UIE_CLICK, changeTitanDisplay )
	}

  var rui = Hud_GetRui( Hud_GetChild( titan.loadoutDisplay, "TitanDetails" ) )

  selectButton(titan.buttons, 1, 0)
  changeTitanDisplay(titan.buttons[0])

	RuiSetString( rui, "nameText", Localize("#MODE_SETTING_BAN_TITAN_LBL_TITLE") )
	RuiSetString( rui, "descText", Localize("#MODE_SETTING_BAN_TITAN_LBL_TEXT") )
}

void function initBoost()
{
  BoostDisplay boost = file.boost

  boost.loadoutDisplay = file.loadoutDisplays[UI_BOOST_INDEX]

  var lableOne = Hud_GetChild( file.boost.loadoutDisplay, "BoostName" )
  SetLabelRuiText( lableOne, Localize("#MODE_SETTING_BAN_BOOST") )

  boost.boosts.append(createBoolAttributte($"rui/menu/boosts/boost_amped_weapons"))
  boost.boosts.append(createBoolAttributte($"rui/menu/boosts/boost_ticks"))
  boost.boosts.append(createBoolAttributte($"rui/menu/boosts/boost_antipersonnel_sentry"))
  boost.boosts.append(createBoolAttributte($"rui/menu/boosts/boost_map_hack"))
  boost.boosts.append(createBoolAttributte($"rui/menu/boosts/boost_battery"))
  boost.boosts.append(createBoolAttributte($"rui/menu/boosts/boost_radar_jammer"))
  boost.boosts.append(createBoolAttributte($"rui/menu/boosts/boost_antititan_sentry"))
  boost.boosts.append(createBoolAttributte($"rui/menu/boosts/boost_smart_pistol"))
  boost.boosts.append(createBoolAttributte($"rui/menu/boosts/boost_phase_rewind"))
  boost.boosts.append(createBoolAttributte($"rui/menu/boosts/boost_shield"))
  boost.boosts.append(createBoolAttributte($"rui/menu/boosts/boost_holo_pilots"))
  boost.boosts.append(createBoolAttributte($"rui/menu/boosts/boost_random"))

  foreach(var button in GetElementsByClassname( file.menu, "BoostLoadoutPanelButtonClass" ))
  {
    int buttonId = int( Hud_GetScriptID( button ) )

    RuiSetImage( Hud_GetRui( button  ), "buttonImage",  boost.boosts[buttonId].image)
    AddButtonEventHandler( button, UIE_CLICK, callBoostClick )
  }

  var rui = Hud_GetRui( Hud_GetChild( boost.loadoutDisplay, "BoostDetails" ) )

	RuiSetString( rui, "nameText", Localize("MODE_SETTING_BAN_BOOST_LBL_TITLE") )
	RuiSetString( rui, "descText", Localize("MODE_SETTING_BAN_BOOST_LBL_TEXT") )
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///Networking
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void function UpdateBanData()
{
	string data = ""
	data += GetCurrentPlaylistVarOrUseValue("BAN_DATA_0", "") + ""
	data += GetCurrentPlaylistVarOrUseValue("BAN_DATA_1", "") + ""
	data += GetCurrentPlaylistVarOrUseValue("BAN_DATA_2", "") + ""
  data += GetCurrentPlaylistVarOrUseValue("BAN_DATA_3", "") + ""
  importUIConfig(data)
}

void function sendPilotConfig()
{
  string dataToSend = ""

  for(int i = 0; i < file.pilot.attributes.len(); i++)
  {
    BoolAttributte structData = file.pilot.attributes[i]
    dataToSend += " ability|" + i + "|" + (structData.disabled ? "1" : "0")
  }

  ClientCommand("BanUiUpdateData " + dataToSend)
}

void function sendEquipmentConfig()
{
  string dataToSend = ""

  for(int i = 0; i < file.equipment.attributes.len(); i++)
  {
    BoolAttributte structData = file.equipment.attributes[i]
    dataToSend += " equipment|" + i + "|" + (structData.disabled ? "1" : "0")
  }

  ClientCommand("BanUiUpdateData " + dataToSend)
}

void function sendWeaponConfig()
{
  string dataToSend = ""
  for(int i = 0; i < file.weapon.categories.len();i++)
  {
      for(int j = 0; j < file.weapon.categories[i].loadouts.len(); j++)
      {
      Loadout weapon = file.weapon.categories[i].loadouts[j]

      dataToSend += " weapon|" + i + "|" + j +"|"
      dataToSend += (weapon.disabled ? "1" : "0")
      dataToSend += weapon.atr0.values[weapon.selectedAtr0]
      dataToSend += weapon.atr1.values[weapon.selectedAtr1]
      dataToSend += (i < 5) ? weapon.atr2.values[weapon.selectedAtr2] : "0"
      }
  }

  ClientCommand("BanUiUpdateData " + dataToSend)
}

void function sendTitanConfig()
{
  string dataToSend = ""
  for(int i = 0; i < file.titan.categories.len(); i++)
  {
    for(int j = 0; j < file.titan.categories[i].loadouts.len(); j++)
    {
      Loadout titan = file.titan.categories[i].loadouts[j]

      dataToSend += " titan|" + i + "|" + j +"|"
      dataToSend += (titan.disabled ? "1" : "0")
      dataToSend += titan.atr0.values[titan.selectedAtr0]
      dataToSend += titan.atr1.values[titan.selectedAtr1]
      dataToSend += titan.atr2.values[titan.selectedAtr2]
    }
  }

  ClientCommand("BanUiUpdateData " + dataToSend)
}

void function sendBoostConfig()
{
  string dataToSend = ""

  for(int i = 0; i < file.boost.boosts.len(); i++)
  {
    BoolAttributte structData = file.boost.boosts[i]
    dataToSend += " boost|" + i + "|" + (structData.disabled ? "1" : "0")
  }

  ClientCommand("BanUiUpdateData " + dataToSend)
}

void function SendChangesToServer(string typeToUpdate, int index, string data)
{
  string dataToSend = typeToUpdate + "|" + index + "|" + data

  ClientCommand("BanUiUpdateData " + dataToSend)
}

void function SendLoadoutChangesToServer(string typeToUpdate, int category ,int index, string data)
{
  string dataToSend = typeToUpdate + "|" + category + "|" + index + "|" + data

  ClientCommand("BanUiUpdateData " + dataToSend)
}

string function ParseLoadoutToDataString(Loadout loadout, int category)
{
  string dataToSend = ""
  dataToSend += (loadout.disabled ? "1" : "0")
  dataToSend += loadout.atr0.values[loadout.selectedAtr0]
  dataToSend += loadout.atr1.values[loadout.selectedAtr1]

  //Since Titans only have 3 categories I just ban the weapon categories
  if(category < 5) {
     dataToSend += loadout.atr2.values[loadout.selectedAtr2]
  }
  else
  {
    dataToSend += "0"
  }

  return dataToSend
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///Utility
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int function arrayContains(array<string> a, string toCheck)
{
  for(int i = 0; i < a.len(); i++)
  {
    if (toCheck == a[i]) {
      return i
    }
  }
  return -1
}

array<int> function parseImportData(string importData)
{
  array<int> importArray
  for(int i = 0; i < importData.len(); i++) {
    switch (importData[i]) {
      case 48:
        importArray.append(0)
        break
      case 49:
        importArray.append(1)
        break
      case 50:
        importArray.append(2)
        break
      case 51:
        importArray.append(3)
        break
      case 52:
        importArray.append(4)
        break
      case 53:
        importArray.append(5)
        break
      case 54:
        importArray.append(6)
        break
      case 55:
        importArray.append(7)
        break
      case 56:
        importArray.append(8)
        break
    }
  }
  return importArray
}