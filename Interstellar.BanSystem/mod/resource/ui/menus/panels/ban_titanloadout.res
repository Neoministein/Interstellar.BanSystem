"resource/ui/menus/panels/ban_titanloadout.res"
{
	TitanName
	{
        ControlName				RuiPanel
        InheritProperties       RuiLoadoutLabel
		xpos					200
        ypos                    78
	}

	ButtonStryder
    {
        ControlName				RuiButton
        InheritProperties		RuiLoadoutSelectionButton
		classname				BanTitanCategoryButton
        scriptID				0
        ypos                    78
		xpos					-50

        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
        navUp					ButtonLast
        navDown					Button1
        tabPosition             1
    }

    ButtonAtlas
    {
        ControlName				RuiButton
        InheritProperties		RuiLoadoutSelectionButton
		classname				BanTitanCategoryButton
        ypos                    8
        scriptID				1

        pin_to_sibling			ButtonStryder
       	pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
        navUp					Button0
        navDown					Button2
    }

    ButtonOgre
    {
        ControlName				RuiButton
        InheritProperties		RuiLoadoutSelectionButton
		classname				BanTitanCategoryButton
        ypos                    8
        scriptID				2

        pin_to_sibling			ButtonAtlas
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
        navUp					Button1
        navDown					Button3
    }

    Titan0
	{
		ControlName				CNestedPanel
		classname 				titanDisplay
		xpos					200
    	ypos                    0
		zpos					10
		wide					500
		tall					225
        scriptID				0

		enabled                 0
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
		controlSettingsFile		"resource/ui/menus/panels/ban_loadout.res"

		ButtonFrame
		{
			ControlName				RuiPanel
			ypos                    107
			wide					223
			tall					108
			rui                     "ui/basic_image.rpak"
			visible					1

			pin_to_sibling			TitanIon
			pin_corner_to_sibling	TOP_LEFT
        	pin_to_sibling_corner	TOP_LEFT
		}
	}

    Titan1
	{
		ControlName				CNestedPanel
		classname 				titanDisplay
		xpos					0
    	ypos                    -75
		zpos					10
		wide					500
		tall					225
		scriptID				1

        
		enabled                 0
        pin_to_sibling			Titan0
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
		controlSettingsFile		"resource/ui/menus/panels/ban_loadout.res"

		ButtonFrame
		{
			ControlName				RuiPanel
			ypos                    107
			wide					223
			tall					108
			rui                     "ui/basic_image.rpak"
			visible					1

			pin_to_sibling			TitanIon
			pin_corner_to_sibling	TOP_LEFT
        	pin_to_sibling_corner	TOP_LEFT
		}
	}

    Titan2
	{
		ControlName				CNestedPanel
		classname 				titanDisplay
		xpos					0
    	ypos                    -75
		zpos					10
		wide					500
		tall					225
		scriptID				2

        
		enabled                 0
        pin_to_sibling			Titan1
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
		controlSettingsFile		"resource/ui/menus/panels/ban_loadout.res"

		ButtonFrame
		{
			ControlName				RuiPanel
			ypos                    107
			wide					223
			tall					108
			rui                     "ui/basic_image.rpak"
			visible					1

			pin_to_sibling			TitanIon
			pin_corner_to_sibling	TOP_LEFT
        	pin_to_sibling_corner	TOP_LEFT
		}
	}

    Titan3
	{
		ControlName				CNestedPanel
		classname 				titanDisplay
		xpos					230
    	ypos                    -105
		zpos					10
		wide					500
		tall					225
		scriptID				3

		pin_to_sibling			Titan2
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
		controlSettingsFile		"resource/ui/menus/panels/ban_loadout.res"

		ButtonFrame
		{
			ControlName				RuiPanel
			ypos                    107
			wide					223
			tall					108
			rui                     "ui/basic_image.rpak"
			visible					1

			pin_to_sibling			TitanIon
			pin_corner_to_sibling	TOP_LEFT
        	pin_to_sibling_corner	TOP_LEFT
		}
	}


	TitanDetails
    {
        ControlName				RuiPanel
        InheritProperties		ItemDetails
	    xpos					600
    	ypos                    700
		zpos					10
    }
}