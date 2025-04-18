//
// Copyright 2018-2021 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

//! This delegate is for the main page of our application that pushes the menu
//! when the onMenu() behavior is received.
class Menu2TestDelegate extends WatchUi.Menu2InputDelegate {

    //! Constructor
    public function initialize() {
        Menu2InputDelegate.initialize();
    }

    //! Handle the menu event
    //! @return true if handled, false otherwise
    public function onMenu() as Boolean {
        // Generate a new Menu with a drawable Title
        var menu = new WatchUi.Menu2({:title=>"Wake Sequence"});
            
        // Add menu items for demonstrating toggles, checkbox and icon menu items
       // menu.addItem(new WatchUi.MenuItem("Toggles", "sublabel", "toggle", null));
        //menu.addItem(new WatchUi.MenuItem("Checkboxes", null, "check", null));
        //menu.addItem(new WatchUi.MenuItem("Icons", null, "icon", null));
        //menu.addItem(new WatchUi.MenuItem("Custom", null, "custom", null));
        // Add 3 sequence options
        menu.addItem(new WatchUi.MenuItem("Sequence 1", null, "sequence1", null));
        menu.addItem(new WatchUi.MenuItem("Sequence 2", null, "sequence2", null));
        menu.addItem(new WatchUi.MenuItem("Sequence 3", null, "sequence3", null));
        WatchUi.pushView(menu, new $.Menu2TestMenu2Delegate(), WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    //! Called when the user selects a menu item
    public function onSelect(item) {
        var selectedId = item.getId(); // Will be "sequence1", "sequence2", etc.

        // Save the selected sequence
        System.println("Selected: " + selectedId);
        Toybox.Application.Storage.setValue("selectedSequence", selectedId);

        // Close the menu and return to previous view
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

        WatchUi.pushView(new FinalSummaryView(), null, WatchUi.SLIDE_IMMEDIATE);

        return;
    }
}

//! This is the custom drawable we will use for our main menu title
class DrawableMenuTitle extends WatchUi.Drawable {

    //! Constructor
    public function initialize() {
        Drawable.initialize({});
    }

}
