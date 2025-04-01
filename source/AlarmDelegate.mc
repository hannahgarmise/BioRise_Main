using Toybox.WatchUi as WatchUi;
using Toybox.System as System;

class AlarmDelegate extends WatchUi.InputDelegate {
    var _view as AlarmFlowView;
    var _model as AlarmDataModel;
    var _viewController as ViewController;

    public function initialize(view as AlarmFlowView, model as AlarmDataModel, viewController as ViewController) {
        _view = view;
        _model = model;
        _viewController = viewController;
        WatchUi.InputDelegate.initialize();
    }
/*
    public function onKey(key, down) {
        return _view.onKey(key, down);
    }
*/
    public function onTap(position) {
        return _view.onTap(position);
    }
}
