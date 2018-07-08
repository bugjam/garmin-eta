using Toybox.WatchUi as Ui;
using Toybox.Time;
using Toybox.Application;

class ETAView extends Ui.SimpleDataField {

    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();
        label = Ui.loadResource(Rez.Strings.Label);
    }

    // The given info object contains all the current workout
    // information. Calculate a value and return it in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
        // See Activity.Info in the documentation for available information.

        var targetDistance = Application.getApp().getProperty("targetDistanceKey");
        if(targetDistance == null) { return Ui.loadResource(Rez.Strings.TargetDistanceNotSet); }
        if(info.elapsedDistance == null || info.averageSpeed == null || info.averageSpeed == 0.0) { 
          return Ui.loadResource(Rez.Strings.ElapsedDistanceNotSet); 
        }
        var remainingDistance = 1000*targetDistance - info.elapsedDistance;
        if(remainingDistance <= 0.0) { return Ui.loadResource(Rez.Strings.TargetDistanceReached); }
        var remainingTime = remainingDistance / info.averageSpeed;
        var etaTime = Time.now().add(new Time.Duration(remainingTime));
        var etaInfo = Time.Gregorian.info(etaTime, Time.FORMAT_MEDIUM);
        return etaInfo.hour.format("%2d")+":"+etaInfo.min.format("%02d");
    }

}