using Toybox.WatchUi as WatchUi;
using Toybox.Graphics as Graphics;
using Toybox.Application.Storage;

class FinalSummaryView extends WatchUi.View {

    var _lowerHour, _lowerMinute;
    var _upperHour, _upperMinute;
    var _sequence;

    public function initialize() {
    View.initialize();

    var lowerTime = Storage.getValue("time");
    var upperTime = Storage.getValue("time2");
    var selected = Storage.getValue("selectedSequence");

    if (lowerTime != null && lowerTime.length() >= 7) {
        _lowerHour = lowerTime.substring(0, 2).toNumber();       // "07"
        _lowerMinute = lowerTime.substring(3, 5).toNumber();     // "45"
    }

    if (upperTime != null && upperTime.length() >= 7) {
        _upperHour = upperTime.substring(0, 2).toNumber();
        _upperMinute = upperTime.substring(3, 5).toNumber();
    }

    if (selected != null) {
        _sequence = selected;
    }

    WatchUi.requestUpdate();
}


    public function onShow() {
        WatchUi.View.onShow();
        BluetoothLowEnergy.setScanState(BluetoothLowEnergy.SCAN_STATE_SCANNING);
        // Optional: auto-close after 4 seconds

    }

    function exit() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    public function onUpdate(dc as Graphics.Dc) {
        dc.clear();
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLUE);

        var centerX = dc.getWidth() / 2;
        var y = 40;

        dc.drawText(centerX, y, Graphics.FONT_SMALL, "Alarm Set!", Graphics.TEXT_JUSTIFY_CENTER);
        y += 50;

        var timeStr = _formatTime(_lowerHour, _lowerMinute) + " - " + _formatTime(_upperHour, _upperMinute);
        dc.drawText(centerX, y, Graphics.FONT_TINY, timeStr, Graphics.TEXT_JUSTIFY_CENTER);
        y += 50;
        dc.drawText(centerX, y, Graphics.FONT_TINY, "Wake Sequence: ", Graphics.TEXT_JUSTIFY_CENTER);
        
        y += 50;
        dc.drawText(centerX, y, Graphics.FONT_TINY, _sequence, Graphics.TEXT_JUSTIFY_CENTER);
        y+=60;

        dc.drawText(centerX, y, Graphics.FONT_SMALL, "Sweet Dreams!", Graphics.TEXT_JUSTIFY_CENTER);
    }

    private function _formatTime(hour, minute) {
        var isPM = hour >= 12;
        var displayHour = hour % 12;
        if (displayHour == 0) { displayHour = 12; }

        var hourStr = (displayHour < 10) ? "0" + displayHour : displayHour.toString();
        var minStr = (minute < 10) ? "0" + minute : minute.toString();
        var ampmStr = isPM ? "PM" : "AM";
        return hourStr + ":" + minStr + " " + ampmStr;
    }
}
