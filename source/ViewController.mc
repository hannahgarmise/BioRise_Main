//
// Copyright 2019-2021 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

//controls the view on the watch

import Toybox.BluetoothLowEnergy;
import Toybox.Lang;
import Toybox.WatchUi;

class ViewController {
    private var _modelFactory as DataModelFactory;

    //! Constructor
    //! @param modelFactory Factory to create models
    public function initialize(modelFactory as DataModelFactory) {
        _modelFactory = modelFactory;
    }

    //! Return the initial views for the app
    //! @return Array Pair [View, InputDelegate]
    
    public function getInitialView() as [Views, InputDelegates] {

        return [new TimePicker(), new TimePickerDelegate()];
        /*
    var model = new $.AlarmDataModel();
    var view = new $.AlarmFlowView(model);
    var delegate = new $.AlarmDelegate(model, self);
    return [view, delegate];

    */
    /*
    var AlarmDataModel = _modelFactory.getAlarmDataModel();
    return [new $.AlarmFlowView(AlarmDataModel), new $.AlarmDelegate(AlarmFlowView, AlarmDataModel, self)];
    */
    }

    //! Push the scan menu view (hold menu button to push this view)
    public function pushScanMenu() as Void {
        WatchUi.pushView(new $.Rez.Menus.MainMenu(), new $.ScanMenuDelegate(), WatchUi.SLIDE_UP);
    }

    //! Push the device view
    //! @param scanResult The scan result for the device view to push
    public function pushDeviceView(scanResult as ScanResult) as Void {
        var deviceDataModel = _modelFactory.getDeviceDataModel(scanResult);
        var deviceView = new $.DeviceView(deviceDataModel);
        _modelFactory.GetPhoneCommunication().setDeviceView(deviceView);

        WatchUi.pushView(deviceView, new $.DeviceDelegate(deviceDataModel, deviceView), WatchUi.SLIDE_UP);
    }

    public function pushAlarmFlow() as Void {
        var alarmModel = _modelFactory.getAlarmDataModel();
        var alarmView = new AlarmFlowView(alarmModel);
        var alarmDelegate = new AlarmDelegate(alarmView, alarmModel, self);
        WatchUi.pushView(alarmView, alarmDelegate, WatchUi.SLIDE_UP);
    }

    public function pushTimePicker() as Void {
        WatchUi.pushView(new TimePicker(), new TimePickerDelegate(), WatchUi.SLIDE_UP);
    }
}
