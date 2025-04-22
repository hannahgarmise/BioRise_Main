import Toybox.BluetoothLowEnergy;
import Toybox.Lang;
import Toybox.WatchUi;

class DeviceDataModel {
    private var _scanResult as ScanResult;
    private var _device as Device?;
    private var _environmentProfile as EnvironmentProfileModel?;
    private var _dataModelFactory as DataModelFactory;

    public function initialize(bleDelegate as BluetoothDelegate, dataModelFactory as DataModelFactory, scanResult as ScanResult) {
        _scanResult = scanResult;
        _dataModelFactory = dataModelFactory;

        bleDelegate.notifyConnection(self);

        _device = null;
        _environmentProfile = null;
    }

    public function getDataModelFactory() as DataModelFactory{
        return _dataModelFactory;
    }

    public function procConnection(device as Device) as Void {
        _device = device;

        if (device.isConnected()) {
            procDeviceConnected();
        }

        WatchUi.requestUpdate();
    }


    public function pair() as Void {
        BluetoothLowEnergy.setScanState(BluetoothLowEnergy.SCAN_STATE_OFF);
        _device = BluetoothLowEnergy.pairDevice(_scanResult);

    }

    public function unpair() as Void {
        if (_device != null) {
            BluetoothLowEnergy.unpairDevice(_device);
        }
        _device = null;
    }

    public function getActiveProfile() as EnvironmentProfileModel? {
        if (_device != null) {
            return null;
        }
        return _environmentProfile;
    }

    public function isConnected() as Boolean {
        return (_device != null) && _device.isConnected();
    }

    private function procDeviceConnected() as Void {
        
        if (_device != null) {
            _environmentProfile = _dataModelFactory.getEnvironmentModel(_device);

            var vc = _dataModelFactory.getViewController();
            vc.pushTimePicker();
        
        }
    }
}
