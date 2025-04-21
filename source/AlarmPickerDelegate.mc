using Toybox.WatchUi as WatchUi;
using Toybox.Lang as Lang;
using Toybox.System as System;
import Toybox.Lang;

// Import AlarmState (make sure it's defined in its own file like AlarmState.mc)
using AlarmState;

class AlarmPickerDelegate extends WatchUi.PickerDelegate {
    private var _hourArrayLower = new[2] as Array;
    private var _minuteArrayLower = new[2] as Array;
    function initialize() {
        PickerDelegate.initialize();
    }

    // This method is called when the user confirms the picker selection
    function onSelect(values) {
        //var hour = values[0];   // First picker value
        //var minute = values[2]; // Third picker value (skipping the ":" divider)

        _hourArrayLower = values[0] as Array;
        _minuteArrayLower = values[2];

        AlarmState.lowerHour = _hourArrayLower;
        AlarmState.lowerMinute = _minuteArrayLower;

        System.println("Alarm set to: " + _hourArrayLower + ":" + _minuteArrayLower);

        // Return to the previous screen
        //WatchUi.popView();
    }
}
