using Toybox.WatchUi as WatchUi;
using Toybox.Lang as Lang;
using Toybox.System as System;

// Import AlarmState (make sure it's defined in its own file like AlarmState.mc)
using AlarmState;

class AlarmPickerDelegate extends WatchUi.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    // This method is called when the user confirms the picker selection
    function onSelect(values) {
        var hour = values[0];   // First picker value
        var minute = values[2]; // Third picker value (skipping the ":" divider)

        AlarmState.lowerHour = hour;
        AlarmState.lowerMinute = minute;

        System.println("Alarm set to: " + hour + ":" + minute);

        // Return to the previous screen
        //WatchUi.popView();
    }
}
