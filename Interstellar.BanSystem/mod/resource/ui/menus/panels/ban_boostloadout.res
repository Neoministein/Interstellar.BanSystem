"resource/ui/menus/panels/ban_boostloadout.res"
{
    BoostName
	{
        ControlName				RuiPanel
        InheritProperties       RuiLoadoutLabel
        ypos                    78
	}

	ButtonAmpedWeapons
    {
		ControlName				RuiButton
		InheritProperties		SuitButton
        classname				BoostLoadoutPanelButtonClass
        scriptID				0
        tabPosition				1

        navUp					RenameEditBox
        navDown					ButtonPrimary
        navLeft                 ButtonGender
        navRight                ButtonOrdnance

        pin_to_sibling			BoostName
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonTick
    {
		ControlName				RuiButton
		InheritProperties		SuitButton
        classname				BoostLoadoutPanelButtonClass
        scriptID				1
        xpos					-235

        navUp					RenameEditBox
        navDown					ButtonPrimary
        navLeft                 ButtonGender
        navRight                ButtonOrdnance

        pin_to_sibling			BoostName
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonSentry
    {
		ControlName				RuiButton
        InheritProperties		SuitButton
		InheritProperties		LoadoutButtonLarge
        classname				BoostLoadoutPanelButtonClass
        scriptID				2
        ypos					10

        navUp					ButtonSuit
        navDown					ButtonSecondary
        navLeft 				ButtonPrimarySkin
        navRight 				ButtonPrimaryMod1

        pin_to_sibling			ButtonAmpedWeapons
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonMapHack
    {
		ControlName				RuiButton
        InheritProperties		SuitButton
		InheritProperties		LoadoutButtonLarge
        classname				BoostLoadoutPanelButtonClass
        scriptID				3
        ypos					10

        navUp					ButtonSuit
        navDown					ButtonSecondary
        navLeft 				ButtonPrimarySkin
        navRight 				ButtonPrimaryMod1

        pin_to_sibling			ButtonTick
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonBattery
    {
		ControlName				RuiButton
        InheritProperties		SuitButton
		InheritProperties		LoadoutButtonLarge
        classname				BoostLoadoutPanelButtonClass
        scriptID				4
        ypos					10

        navUp					ButtonPrimary
        navDown					ButtonWeapon3
        navLeft                 ButtonSecondarySkin
        navRight                ButtonSecondaryMod1

        pin_to_sibling			ButtonSentry
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonRadarJammer
    {
		ControlName				RuiButton
        InheritProperties		SuitButton
		InheritProperties		LoadoutButtonLarge
        classname				BoostLoadoutPanelButtonClass
        scriptID				5
        ypos					10

        navUp					ButtonPrimary
        navDown					ButtonWeapon3
        navLeft                 ButtonSecondarySkin
        navRight                ButtonSecondaryMod1

        pin_to_sibling			ButtonMapHack
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonTitanSentry
    {
		ControlName				RuiButton
        InheritProperties		SuitButton
		InheritProperties		LoadoutButtonLarge
        classname				BoostLoadoutPanelButtonClass
        scriptID				6
        ypos					10

        navUp					ButtonSecondary
        navDown					ButtonKit1
        navLeft                 ButtonWeapon3Skin
        navRight                ButtonWeapon3Mod1

        pin_to_sibling			ButtonBattery
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonTitanSmartPistol
    {
		ControlName				RuiButton
        InheritProperties		SuitButton
		InheritProperties		LoadoutButtonLarge
        classname				BoostLoadoutPanelButtonClass
        scriptID				7
        ypos					10

        navUp					ButtonSecondary
        navDown					ButtonKit1
        navLeft                 ButtonWeapon3Skin
        navRight                ButtonWeapon3Mod1

        pin_to_sibling			ButtonRadarJammer
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonPhaseRewind
    {
		ControlName				RuiButton
        InheritProperties		SuitButton
		InheritProperties		LoadoutButtonLarge
        classname				BoostLoadoutPanelButtonClass
        scriptID				8
        ypos					10

        navUp					ButtonSecondary
        navDown					ButtonKit1
        navLeft                 ButtonWeapon3Skin
        navRight                ButtonWeapon3Mod1

        pin_to_sibling			ButtonTitanSentry
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonHardCover
    {
		ControlName				RuiButton
        InheritProperties		SuitButton
		InheritProperties		LoadoutButtonLarge
        classname				BoostLoadoutPanelButtonClass
        scriptID				9
        ypos					10

        navUp					ButtonSecondary
        navDown					ButtonKit1
        navLeft                 ButtonWeapon3Skin
        navRight                ButtonWeapon3Mod1

        pin_to_sibling			ButtonTitanSmartPistol
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonHoloPilotNova
    {
		ControlName				RuiButton
        InheritProperties		SuitButton
		InheritProperties		LoadoutButtonLarge
        classname				BoostLoadoutPanelButtonClass
        scriptID				10
        ypos					10

        navUp					ButtonSecondary
        navDown					ButtonKit1
        navLeft                 ButtonWeapon3Skin
        navRight                ButtonWeapon3Mod1

        pin_to_sibling			ButtonPhaseRewind
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonDiceRole
    {
		ControlName				RuiButton
        InheritProperties		SuitButton
		InheritProperties		LoadoutButtonLarge
        classname				BoostLoadoutPanelButtonClass
        scriptID				11
        ypos					11

        navUp					ButtonSecondary
        navDown					ButtonKit1
        navLeft                 ButtonWeapon3Skin
        navRight                ButtonWeapon3Mod1

        pin_to_sibling			ButtonHardCover
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    BoostDetails
    {
        ControlName				RuiPanel
        InheritProperties		ItemDetails
	    xpos					600
    	ypos                    700
		zpos					10
    }
}