import Toybox.BluetoothLowEnergy;
import Toybox.Lang;
import Toybox.WatchUi;

class DataModelFactory {
    // Dependencies
    private var _delegate as BluetoothDelegate;
    private var _profileManager as ProfileManager;
    private var _phoneCommunication as PhoneCommunication;
    private var _viewController as ViewController?;

    // Model Storage
    private var _scanDataModel as WeakReference?;
    private var _deviceDataModel as WeakReference?;
    private var _envModel as WeakReference?;
    private var _alarmDataModel as WeakReference?;

    
    public function initialize(delegate as BluetoothDelegate, profileManager as ProfileManager, phoneComm as PhoneCommunication, viewController as ViewController?) {
        _delegate = delegate;
        _profileManager = profileManager;
        _phoneCommunication = phoneComm;
        _viewController = viewController;
    }

    public function getViewController() as ViewController {
        return _viewController;
    }

    public function setViewController(viewController as ViewController) as Void {
        _viewController = viewController;
    }

    public function getScanDataModel() as ScanDataModel {
        var scanDataModel = _scanDataModel;
        if (scanDataModel != null && scanDataModel.stillAlive()) {
            return (scanDataModel.get() as ScanDataModel);
        }

        var dataModel = new $.ScanDataModel(_delegate);
        _scanDataModel = dataModel.weak();
        return dataModel;
    }

    public function getAlarmDataModel() as AlarmDataModel {
        var alarmDataModel = _alarmDataModel;
        if (alarmDataModel != null && alarmDataModel.stillAlive()) {
            return (alarmDataModel.get() as AlarmDataModel);
        }

        var dataModel = new $.AlarmDataModel();
        _alarmDataModel = dataModel.weak();
        return dataModel;
    }

    public function getDeviceDataModel(scanResult as ScanResult) as DeviceDataModel {
        var deviceDataModel = _deviceDataModel;
        if (deviceDataModel != null && deviceDataModel.stillAlive()) {
            return (deviceDataModel.get() as DeviceDataModel);
        }

        // FIXED VERSION BELOW:
        // TO DO: see if one of these is right and one is wrong
        var dataModel = new $.DeviceDataModel(_delegate, self, scanResult);

        _deviceDataModel = dataModel.weak();
        return dataModel;
    }

    public function getEnvironmentModel(device as Device) as EnvironmentProfileModel {
        var envModel = _envModel;
        if (envModel != null && envModel.stillAlive()) {
            return (envModel.get() as EnvironmentProfileModel);
        }

        var dataModel = new $.EnvironmentProfileModel(_delegate, _profileManager, device, _phoneCommunication);
        _envModel = dataModel.weak();
        return dataModel;
    }

    public function GetPhoneCommunication() as PhoneCommunication {
        return _phoneCommunication;
    }

    public function getDelegate() as BluetoothDelegate{
        return _delegate;
    }
}
