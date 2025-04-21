import Toybox.BluetoothLowEnergy;
import Toybox.Lang;
import Toybox.WatchUi;

class AlarmDataModel {
    var lowerHour = 7;
    var lowerMinute = 0;
    var upperHour = 7;
    var upperMinute = 30;
    var selectedSequence = 1;

    public function initialize() {
        System.println("AlarmDataModel::initialize");
    }

    
}
