using Toybox.WatchUi as WatchUi;
using Toybox.Graphics as Graphics;

class SweetDreamsView extends WatchUi.View {

    public function initialize() {
        View.initialize();
    }

    public function onUpdate(dc as Graphics.Dc) {
        dc.clear();
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLUE);

        var centerX = dc.getWidth() / 2;
        var centerY = dc.getHeight() / 2;

        dc.drawText(centerX, 120, Graphics.FONT_LARGE, "Sweet", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(centerX, 200, Graphics.FONT_LARGE, "Dreams!", Graphics.TEXT_JUSTIFY_CENTER);
    }
}
