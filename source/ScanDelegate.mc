//
// Copyright 2019-2021 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Lang;
import Toybox.WatchUi;

class ScanDelegate extends WatchUi.BehaviorDelegate {
    private var _scanDataModel as ScanDataModel;
    private var _viewController as ViewController;
    private var _modelFactory as DataModelFactory;

    public function initialize(scanDataModel as ScanDataModel, viewController as ViewController, modelFactory as DataModelFactory) {
        BehaviorDelegate.initialize();
        _scanDataModel = scanDataModel;
        _viewController = viewController;
        _modelFactory = modelFactory;
    }

    //! Handle menu button press
    //! @return true if handled, false otherwise
    public function onMenu() as Boolean {
        _viewController.pushScanMenu();
        return true;
    }

    //! Handle the select action
    //! @return true if handled, false otherwise
    public function onSelect() as Boolean {
        var displayResult = _scanDataModel.getDisplayResult();
        if (displayResult != null) {
            var deviceDataModel = _modelFactory.getDeviceDataModel(displayResult);
            _modelFactory.getDelegate().notifyConnection(deviceDataModel);
            deviceDataModel.pair(); // starts pairing
            //TO DO: change this to see if this changes next view
            //_viewController.pushTimePicker(); // push alarm view after pairing
        }
        return true;
    }

    //! Handle next page behavior
    //! @return true if handled, false otherwise
    public function onNextPage() as Boolean {
        _scanDataModel.nextResult();
        return true;
    }

    //! Handle previous page behavior
    //! @return true if handled, false otherwise
    public function onPreviousPage() as Boolean {
        _scanDataModel.previousResult();
        return true;
    }
}
