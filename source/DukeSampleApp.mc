import Toybox.Application;
import Toybox.BluetoothLowEnergy;
import Toybox.Lang;
import Toybox.WatchUi;

class DukeSampleApp extends Application.AppBase {
    private var _bleDelegate as BluetoothDelegate?;
    private var _profileManager as ProfileManager?;
    private var _modelFactory as DataModelFactory?;
    private var _viewController as ViewController?;
    var _phoneCommunication as PhoneCommunication;

    public function initialize() {
        AppBase.initialize();
        _phoneCommunication = new PhoneCommunication();
    }

    public function onStart(state as Dictionary?) as Void {
        _profileManager = new $.ProfileManager();
        _bleDelegate = new $.BluetoothDelegate(_profileManager as ProfileManager);
        _modelFactory = new $.DataModelFactory(_bleDelegate as BluetoothDelegate, _profileManager as ProfileManager, _phoneCommunication as PhoneCommunication);
        _viewController = new $.ViewController(_modelFactory as DataModelFactory);

        // NEW: Let modelFactory access view controller
        _modelFactory.setViewController(_viewController);

        BluetoothLowEnergy.setDelegate(_bleDelegate as BluetoothDelegate);

        if (_profileManager != null) {
            _profileManager.registerProfiles();
        }

        // Start scanning
        BluetoothLowEnergy.setScanState(BluetoothLowEnergy.SCAN_STATE_SCANNING);
        System.println("[BLE] Scan started using setScanState");
    }

    public function onStop(state as Dictionary?) as Void {
        _viewController = null;
        _modelFactory = null;
        _profileManager = null;
        _bleDelegate = null;
    }

    public function getInitialView() as [Views] or [Views, InputDelegates] {
        var scanDataModel = _modelFactory.getScanDataModel();
        var scanView = new ScanView(scanDataModel);
        var scanDelegate = new ScanDelegate(scanDataModel, _viewController, _modelFactory);
        return [scanView, scanDelegate];
    }
}
