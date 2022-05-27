"resource/ui/menus/panels/ban_weapon_category.res"
{
	ButtonAssultRifle
    	{
        	ControlName				RuiButton
        	InheritProperties		RuiLoadoutSelectionButton
			classname				BanWeaponCategoryButton
        	scriptID				0
            ypos                    78
			xpos					-50

        	pin_corner_to_sibling	TOP_LEFT
        	pin_to_sibling_corner	BOTTOM_LEFT
        	navUp					ButtonLast
        	navDown					Button1
        	tabPosition             1
    	}

    ButtonSmg
    	{
        	ControlName				RuiButton
        	InheritProperties		RuiLoadoutSelectionButton
			classname				BanWeaponCategoryButton
        	ypos                    8
        	scriptID				1

        	pin_to_sibling			ButtonAssultRifle
       		pin_corner_to_sibling	TOP_LEFT
        	pin_to_sibling_corner	BOTTOM_LEFT
        	navUp					Button0
        	navDown					Button2
    	}

    ButtonLmg
    	{
        	ControlName				RuiButton
        	InheritProperties		RuiLoadoutSelectionButton
			classname				BanWeaponCategoryButton
        	ypos                    8
        	scriptID				2

        	pin_to_sibling			ButtonSmg
        	pin_corner_to_sibling	TOP_LEFT
        	pin_to_sibling_corner	BOTTOM_LEFT
        	navUp					Button1
        	navDown					Button3
    	}

    ButtonSniper
    	{
        	ControlName				RuiButton
        	InheritProperties		RuiLoadoutSelectionButton
			classname				BanWeaponCategoryButton
        	ypos                    8
        	scriptID				3

        	pin_to_sibling			ButtonLmg
        	pin_corner_to_sibling	TOP_LEFT
        	pin_to_sibling_corner	BOTTOM_LEFT
        	navUp					Button1
        	navDown					Button3
    	} 

    ButtonShotgun
    	{
        	ControlName				RuiButton
        	InheritProperties		RuiLoadoutSelectionButton
			classname				BanWeaponCategoryButton
        	ypos                    8
        	scriptID				4

        	pin_to_sibling			ButtonSniper
        	pin_corner_to_sibling	TOP_LEFT
        	pin_to_sibling_corner	BOTTOM_LEFT
        	navUp					Button1
        	navDown					Button3
    	} 
    ButtonGrenadier 
    	{
        	ControlName				RuiButton
        	InheritProperties		RuiLoadoutSelectionButton
			classname				BanWeaponCategoryButton
        	ypos                    8
        	scriptID				5

        	pin_to_sibling			ButtonShotgun
        	pin_corner_to_sibling	TOP_LEFT
        	pin_to_sibling_corner	BOTTOM_LEFT
        	navUp					Button1
        	navDown					Button3
    	} 
    ButtonPistol 
    	{
        	ControlName				RuiButton
        	InheritProperties		RuiLoadoutSelectionButton
			classname				BanWeaponCategoryButton
        	ypos                    8
        	scriptID				6

        	pin_to_sibling			ButtonGrenadier
        	pin_corner_to_sibling	TOP_LEFT
        	pin_to_sibling_corner	BOTTOM_LEFT
        	navUp					Button1
        	navDown					Button3
    	} 
    ButtonAntiTitan 
    	{
        	ControlName				RuiButton
        	InheritProperties		RuiLoadoutSelectionButton
			classname				BanWeaponCategoryButton
        	ypos                    8
        	scriptID				7
			
        	pin_to_sibling			ButtonPistol
        	pin_corner_to_sibling	TOP_LEFT
        	pin_to_sibling_corner	BOTTOM_LEFT
        	navUp					Button1
        	navDown					Button3
    	}
	
		Weapon0
	    {
		    ControlName				CNestedPanel
			classname 				weaponDisplay
		    xpos					200
    	    ypos                    0
		    zpos					10
			wide					500
			tall					225

			scriptID				0
		    visible					1
		    enabled                 0
		    controlSettingsFile		"resource/ui/menus/panels/ban_loadout.res"
	    }

		Weapon1
	    {
		    ControlName				CNestedPanel
			classname 				weaponDisplay
		    xpos					200
    	    ypos                    150
		    zpos					10
			wide					500
			tall					225

			scriptID				1
		    visible					1
		    enabled                 0
		    controlSettingsFile		"resource/ui/menus/panels/ban_loadout.res"
	    } 

		Weapon2
	    {
		    ControlName				CNestedPanel
			classname 				weaponDisplay
		    xpos					200
    	    ypos                    300
		    zpos					10
			wide					500
			tall					225

			scriptID				2
		    visible					1
		    enabled                 0
		    controlSettingsFile		"resource/ui/menus/panels/ban_loadout.res"
	    } 

		Weapon3
	    {
		    ControlName				CNestedPanel
			classname 				weaponDisplay
		    xpos					825
    	    ypos                    0
		    zpos					10
			wide					500
			tall					225

			scriptID				3
		    visible					1
		    enabled                 0
		    controlSettingsFile		"resource/ui/menus/panels/ban_loadout.res"
	    } 

		Weapon4
	    {
		    ControlName				CNestedPanel
			classname 				weaponDisplay
		    xpos					825
    	    ypos                    150
		    zpos					10
			wide					500
			tall					225

			scriptID				4
		    visible					1
		    enabled                 0
		    controlSettingsFile		"resource/ui/menus/panels/ban_loadout.res"
	    }

 	WeaponDetails
    {
        ControlName				RuiPanel
        InheritProperties		ItemDetails
	    xpos					600
    	ypos                    700
		zpos					10
    } 
}