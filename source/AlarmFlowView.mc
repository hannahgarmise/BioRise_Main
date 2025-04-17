// AlarmFlowView.mc
// Garmin Connect IQ app view for setting smart alarm parameters

using Toybox.WatchUi as WatchUi;
using Toybox.System as System;
using Toybox.Graphics as Graphics;

class AlarmFlowView extends WatchUi.View {
    var _model; // Reference to the AlarmDataModel
    var step = 0;
    var hour = 7;
    var minute = 0;

    var alarmSet = false;


    public function initialize(model as AlarmDataModel) {
        View.initialize();
        _model = model;
    }


    public function onShow() {
        WatchUi.View.onShow();

        if (step == 0) {
            hour = _model.lowerHour;
            minute = _model.lowerMinute;
        } else if (step == 1) {
            hour = _model.upperHour;
            minute = _model.upperMinute;
        }

        WatchUi.requestUpdate();
    }

/*
    public function onUpdate(dc) {
        dc.clear();
        System.println("testing drawing");

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLUE);

        var hour = 7;     // example hour
        var minute = 5;   // example minute

        var timeStr = ((hour < 10) ? "0" + hour : hour) + ":" + ((minute < 10) ? "0" + minute : minute);

        dc.drawText(200, 150, Graphics.FONT_SMALL, "Set Lower Alarm", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(200, 200, Graphics.FONT_LARGE, timeStr, Graphics.TEXT_JUSTIFY_LEFT);

}
*/

public function onUpdate(dc as Graphics.Dc) {
    dc.clear(); // wipes the screen clean before drawing anything
    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_DK_BLUE);

    if (alarmSet) {
        // Optional: show confirmation message or leave blank
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_MEDIUM,
            "Alarm Set!", Graphics.TEXT_JUSTIFY_CENTER);
    }

    var centerX = dc.getWidth() / 2;

    // Header
    dc.drawText(centerX, 30, Graphics.FONT_SMALL, "TEST Set Lower Alarm:", Graphics.TEXT_JUSTIFY_CENTER);

    // Up arrow
    dc.drawText(centerX, 70, Graphics.FONT_LARGE, "▲", Graphics.TEXT_JUSTIFY_CENTER);

    // Format and display time
    var displayHour = hour % 12;
    if (displayHour == 0) {displayHour = 12;}

    var hourStr = (displayHour < 10) ? "0" + displayHour : displayHour.toString();
    var minuteStr = (minute < 10) ? "0" + minute : minute.toString();
    var ampmStr = (hour < 12) ? "AM" : "PM";

    // Coordinates for each part
    var timeY = 130;

    // Draw time elements spaced out horizontally
    dc.drawText(centerX - 100, timeY+100, Graphics.FONT_LARGE, hourStr, Graphics.TEXT_JUSTIFY_LEFT);
    dc.drawText(centerX - 25, timeY, Graphics.FONT_LARGE, ":", Graphics.TEXT_JUSTIFY_LEFT);
    dc.drawText(centerX + 25, timeY, Graphics.FONT_LARGE, minuteStr, Graphics.TEXT_JUSTIFY_LEFT);
    dc.drawText(centerX + 100, timeY, Graphics.FONT_LARGE, ampmStr, Graphics.TEXT_JUSTIFY_LEFT);

    // Down arrow
    dc.drawText(centerX, 180, Graphics.FONT_LARGE, "▼", Graphics.TEXT_JUSTIFY_CENTER);

    // OK button
    //dc.drawText(centerX + 80, 230, Graphics.FONT_MEDIUM, "OK", Graphics.TEXT_JUSTIFY_CENTER);
}





function formatTime(hour, minute) {
    var displayHour = hour % 12;
    if (displayHour == 0) { displayHour = 12; }
    var hourStr = (displayHour < 10) ? "0" + displayHour : displayHour;
    var minuteStr = (minute < 10) ? "0" + minute : minute;
    return hourStr + ":" + minuteStr;
}

        
    

    function onKey(key, state) {
        if (state == WatchUi.CLICK_TYPE_RELEASE) {
            if (key == WatchUi.KEY_UP) {
                System.println("BUTTON UP");
                minute = (minute + 1) % 60;
                if (minute == 0) {
                    hour = (hour + 1) % 24;
                }
                WatchUi.requestUpdate();
            } else if (key == WatchUi.KEY_DOWN) {
                minute = (minute - 1 + 60) % 60;
                if (minute == 59) {
                    hour = (hour - 1 + 24) % 24;
                }
                WatchUi.requestUpdate();
            }
        }
        System.println("Hour: " + hour + ", Minute: " + minute);
        return true;
    }


    public function onTap(position) {
    if (step == 2) {
        System.println("Alarm Configured: " + _model.lowerHour + ":" + _model.lowerMinute +
            " to " + _model.upperHour + ":" + _model.upperMinute + ", Seq: " + _model.selectedSequence);
        step = 3;
        alarmSet = true; // <<< Flag that we've set the alarm
        WatchUi.requestUpdate();
    }
    return true;
}

}
