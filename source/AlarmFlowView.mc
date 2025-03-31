// AlarmFlowView.mc
// Garmin Connect IQ app view for setting smart alarm parameters
// Step 1: Set lower alarm time
// Step 2: Set upper alarm time
// Step 3: Choose wake-up sequence
// Inputs: Top button = hour++, Bottom button = minute++, Middle = save/next, Tap = confirm

using Toybox.WatchUi as WatchUi;
using Toybox.Lang as Lang;
using Toybox.System as System;
using Toybox.Graphics as Graphics;

// Shared state to store alarm settings between screens
class AlarmState {
    static var lowerHour = 7;
    static var lowerMinute = 0;
    static var upperHour = 7;
    static var upperMinute = 30;
    static var selectedSequence = 1;
}


// Main view for the 3-step alarm setup flow
class AlarmFlowView extends WatchUi.View {
    function initialize() {
        WatchUi.View.initialize();
    }

    var step = 0; // Tracks which screen we're on (0: lower, 1: upper, 2: sequence, 3: confirmation)
    var hour = 7; // Local working hour value
    var minute = 0; // Local working minute value

    // Called when view is first shown
    function onShow() {
        WatchUi.View.onShow();

        // Initialize hour/minute for current step
        if (step == 0) {
            hour = AlarmState.lowerHour;
            minute = AlarmState.lowerMinute;
        } else if (step == 1) {
            hour = AlarmState.upperHour;
            minute = AlarmState.upperMinute;
        }

        WatchUi.requestUpdate(); // Force screen update
    }

    // Draw screen contents based on step
    function onUpdate(dc) {
        System.println("onUpdate called — current step: " + step);
        dc.clear();

        if (step < 2) {
            var title = (step == 0) ? "Set Lower Alarm" : "Set Upper Alarm";
            var timeStr = ((hour < 10) ? "0" + hour : "" + hour) + ":" + ((minute < 10) ? "0" + minute : "" + minute);

            dc.drawText(10, 40, Graphics.FONT_MEDIUM, title, Graphics.TEXT_JUSTIFY_LEFT);
            dc.drawText(10, 80, Graphics.FONT_LARGE, timeStr, Graphics.TEXT_JUSTIFY_LEFT);
        } else if (step == 2) {
            dc.drawText(10, 40, Graphics.FONT_MEDIUM, "Pick Sequence", Graphics.TEXT_JUSTIFY_LEFT);
            dc.drawText(10, 80, Graphics.FONT_LARGE, "1: Calm", Graphics.TEXT_JUSTIFY_LEFT);
            dc.drawText(10, 110, Graphics.FONT_LARGE, "2: Sunrise", Graphics.TEXT_JUSTIFY_LEFT);
            dc.drawText(10, 140, Graphics.FONT_LARGE, "3: Energy", Graphics.TEXT_JUSTIFY_LEFT);
        } else if (step == 3) {
            dc.drawText(10, 100, Graphics.FONT_MEDIUM, "Alarm Set!", Graphics.TEXT_JUSTIFY_LEFT);
        }
    }

    // Handle button presses
    function onKey(key, down) {
        if (!down) {
            return true;
        }

        if (step < 2) {
            if (key == WatchUi.KEY_UP) {
                hour = (hour + 1) % 24;
            }
            if (key == WatchUi.KEY_DOWN) {
                minute = (minute + 1) % 60;
            }

            if (key == WatchUi.KEY_ENTER) {
                if (step == 0) {
                    AlarmState.lowerHour = hour;
                    AlarmState.lowerMinute = minute;
                } else if (step == 1) {
                    AlarmState.upperHour = hour;
                    AlarmState.upperMinute = minute;
                }
                step += 1;
            }
        } else if (step == 2) {
            if (key == WatchUi.KEY_UP) {
                AlarmState.selectedSequence = 1;
            }
            if (key == WatchUi.KEY_ENTER) {
                AlarmState.selectedSequence = 2;
            }
            if (key == WatchUi.KEY_DOWN) {
                AlarmState.selectedSequence = 3;
            }
        }

        WatchUi.requestUpdate();
        return true;
    }

    // Handle screen tap (final confirmation)
    function onTap(position) {
        if (step == 2) {
            System.println("Alarm Configured: " + AlarmState.lowerHour + ":" + AlarmState.lowerMinute +
                " to " + AlarmState.upperHour + ":" + AlarmState.upperMinute +
                ", Seq: " + AlarmState.selectedSequence);

            step = 3;
            WatchUi.requestUpdate();
        }
        return true;
    }
}
