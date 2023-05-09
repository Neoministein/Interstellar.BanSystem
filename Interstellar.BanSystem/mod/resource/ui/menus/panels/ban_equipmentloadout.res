"resource/ui/menus/panels/ban_equipmentloadout.res"
{
	ExecutionName
	{
        ControlName				RuiPanel
        InheritProperties       RuiLoadoutLabel
        ypos                    78
	}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonNeckSnap
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				0

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ExecutionName
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonFaceStab
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				1
        xpos					-105

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ExecutionName
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonBackshot
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				2
        xpos					-210

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ExecutionName
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonCombo
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				3
        xpos					-315

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ExecutionName
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonKnockout
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				4
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonNeckSnap
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonInnerPieces
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				5
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonFaceStab
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonStraightBlast
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				6
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonBackshot
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonExGrapple
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				7
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonCombo
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonExPulse
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				8
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonKnockout
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonNowYouSeeMe
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				9
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonInnerPieces
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonExHolo
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				10
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonStraightBlast
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonExAmped
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				11
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonExGrapple
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonRandom
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				12
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonExPulse
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Kit1Name
	{
        ControlName				RuiPanel
        InheritProperties       RuiLoadoutLabel
        ypos                    78
        xpos					450
	}

    Kit2Name
	{
        ControlName				RuiPanel
        InheritProperties       RuiLoadoutLabel
        xpos					-235

        pin_to_sibling			Kit1Name
	}

    ButtonPowerCell
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				13

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			Kit1Name
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonFastRegen
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				14
        xpos					-105

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			Kit1Name
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonTactikill
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				17
        xpos					-235

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			Kit1Name
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonWallhang
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				18
        xpos					-340

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			Kit1Name
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonExplosivExpert
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				15
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonPowerCell
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonPhaseEmbark
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				16
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonFastRegen
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonHover
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				19
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonTactikill
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonSealth
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				20
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonWallhang
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ButtonTitanHunter
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				21
        ypos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			ButtonHover
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    MeleeName
	{
        ControlName				RuiPanel
        InheritProperties       RuiLoadoutLabel
        ypos                    78
        xpos					925
	}

    ButtonPilotMelee
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				22
        zpos					10

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			MeleeName
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonFrame0
	{
		ControlName				RuiPanel
		wide					90
		tall					90
        ypos					-5
		rui                     "ui/basic_image.rpak"
		visible					1

		pin_to_sibling			ButtonPilotMelee
		pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_LEFT
	}

    ButtonTitanMelee
    {
		ControlName				RuiButton
		InheritProperties		LoadoutButtonMedium
        classname				EquipmentLoadoutPanelButtonClass
        scriptID				23
        xpos					-105

        navUp					ButtonWeapon3
        navDown					RenameEditBox
        navLeft                 ButtonExecution
        navRight                ButtonKit2

        pin_to_sibling			MeleeName
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    ButtonFrame1
	{
		ControlName				RuiPanel
		wide					90
		tall					90
        ypos					-5
		rui                     "ui/basic_image.rpak"
		visible					1

		pin_to_sibling			ButtonTitanMelee
		pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_LEFT
	}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    EquipmentDetails
    {
        ControlName				RuiPanel
        InheritProperties		ItemDetails
	    xpos					600
    	ypos                    700
		zpos					10
    }
}