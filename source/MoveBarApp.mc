using Toybox.Application;

class MoveBarApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();        
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new MoveBarView() ];
    }

(:glance)    
	function getGlanceView() {
        return [ new MoveBarGlanceView() ];
    }     

}