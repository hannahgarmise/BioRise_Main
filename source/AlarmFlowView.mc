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

    public function onUpdate(dc) {
        dc.clear();
        System.println("testing drawing");

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLUE);

        var hour = 7;     // example hour
        var minute = 5;   // example minute

        var timeStr = ((hour < 10) ? "0" + hour : hour) + ":" + ((minute < 10) ? "0" + minute : minute);

        dc.drawText(200, 150, Graphics.FONT_SMALL, "Set Lower Alarm", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(200, 200, Graphics.FONT_SMALL, timeStr, Graphics.TEXT_JUSTIFY_CENTER);

}

        /*
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLUE);
        dc.drawText(150, 150, Graphics.FONT_LARGE, "heyyyy", Graphics.TEXT_JUSTIFY_CENTER);
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        if (step < 2) {
            var title = (step == 0) ? "Set Lower Alarm" : "Set Upper Alarm";
            var timeStr = ((hour < 10) ? "0" + hour : hour) + ":" + ((minute < 10) ? "0" + minute : minute);

            dc.drawText(20, 60, Graphics.FONT_LARGE, title, Graphics.TEXT_JUSTIFY_LEFT);
            dc.drawText(20, 100, Graphics.FONT_LARGE, timeStr, Graphics.TEXT_JUSTIFY_LEFT);
        } else if (step == 2) {
            dc.drawText(20, 60, Graphics.FONT_LARGE, "Pick Sequence", Graphics.TEXT_JUSTIFY_LEFT);
            dc.drawText(20, 100, Graphics.FONT_LARGE, "1: Calm", Graphics.TEXT_JUSTIFY_LEFT);
            dc.drawText(20, 130, Graphics.FONT_LARGE, "2: Sunrise", Graphics.TEXT_JUSTIFY_LEFT);
            dc.drawText(20, 160, Graphics.FONT_LARGE, "3: Energy", Graphics.TEXT_JUSTIFY_LEFT);
        } else if (step == 3) {
            dc.drawText(20, 120, Graphics.FONT_LARGE, "Alarm Set!", Graphics.TEXT_JUSTIFY_LEFT);
        }
        */
        
    

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
        return true;
    }


    public function onTap(position) {
        if (step == 2) {
            System.println("Alarm Configured: " + _model.lowerHour + ":" + _model.lowerMinute +
                " to " + _model.upperHour + ":" + _model.upperMinute + ", Seq: " + _model.selectedSequence);
            step = 3;
            WatchUi.requestUpdate();
        }
        return true;
    }
}
