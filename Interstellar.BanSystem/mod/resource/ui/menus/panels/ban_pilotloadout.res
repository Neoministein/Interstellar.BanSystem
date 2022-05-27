"resource/ui/menus/panels/ban_titanloadout.res"
{
	TacticalName
	{
        ControlName				RuiPanel
        InheritProperties       RuiLoadoutLabel
        ypos                    78
	}

    ButtonCloak
    {
		ControlName				RuiButton
		InheritProperties		SuitButton
        classname				PilotLoadoutPanelButtonClass
        scriptID				0
        tabPosition				1

        navUp					RenameEditBox
        navDown					ButtonPrimary
        navLeft                 ButtonGender
        navRight                ButtonOrdnance

        pin_to_sibling			TacticalName
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonPulse
    {
		ControlName				RuiButton
		InheritProperties		SuitButton
        classname				PilotLoadoutPanelButtonClass
        scriptID				1
        xpos					-235

        navUp					RenameEditBox
        navDown					ButtonPrimary
        navLeft                 ButtonGender
        navRight                ButtonOrdnance

        pin_to_sibling			TacticalName
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonGrapple
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonLarge
        classname				PilotLoadoutPanelButtonClass
        scriptID				2
        ypos					10

        navUp					ButtonSuit
        navDown					ButtonSecondary
        navLeft 				ButtonPrimarySkin
        navRight 				ButtonPrimaryMod1

        pin_to_sibling			ButtonCloak
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonStim
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonLarge
        classname				PilotLoadoutPanelButtonClass
        scriptID				3
        ypos					10

        navUp					ButtonSuit
        navDown					ButtonSecondary
        navLeft 				ButtonPrimarySkin
        navRight 				ButtonPrimaryMod1

        pin_to_sibling			ButtonPulse
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonAWall
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonLarge
        classname				PilotLoadoutPanelButtonClass
        scriptID				4
        ypos					10

        navUp					ButtonPrimary
        navDown					ButtonWeapon3
        navLeft                 ButtonSecondarySkin
        navRight                ButtonSecondaryMod1

        pin_to_sibling			ButtonGrapple
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonPhase
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonLarge
        classname				PilotLoadoutPanelButtonClass
        scriptID				5
        ypos					10

        navUp					ButtonPrimary
        navDown					ButtonWeapon3
        navLeft                 ButtonSecondarySkin
        navRight                ButtonSecondaryMod1

        pin_to_sibling			ButtonStim
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonHolo
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonLarge
        classname				PilotLoadoutPanelButtonClass
        scriptID				6
        ypos					10

        navUp					ButtonSecondary
        navDown					ButtonKit1
        navLeft                 ButtonWeapon3Skin
        navRight                ButtonWeapon3Mod1

        pin_to_sibling			ButtonAWall
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    OrdnanceName
	{
        ControlName				RuiPanel
        InheritProperties       RuiLoadoutLabel
        ypos                    78
        xpos					600
	}

    ButtonGrenade
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				PilotLoadoutPanelButtonClass
        scriptID				7

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			OrdnanceName
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonArcGerande
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				PilotLoadoutPanelButtonClass
        scriptID				8
        xpos					-105

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			OrdnanceName
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonFireStar
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				PilotLoadoutPanelButtonClass
        scriptID				9
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonGrenade
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonGravStar
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				PilotLoadoutPanelButtonClass
        scriptID				10
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonArcGerande
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonElectricSmoke
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				PilotLoadoutPanelButtonClass
        scriptID				11
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonFireStar
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonSatchel
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				PilotLoadoutPanelButtonClass
        scriptID				12
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonGravStar
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    PilotDetails
    {
        ControlName				RuiPanel
        InheritProperties		ItemDetails
	    xpos					600
    	ypos                    700
		zpos					10
    }
}