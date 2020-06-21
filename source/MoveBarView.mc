using Toybox.WatchUi;
using Toybox.ActivityMonitor;

(:glance)
class MoveBarGlanceView extends WatchUi.GlanceView
{
 	var segmentHeight = 7;
 	var segmentVertOffset = 28;
 	
 	var firstWidth = 80;
 	var nextWidth = 20;
 	
 	var segmentMargin = 2;
 	var filledColor = Graphics.COLOR_RED;
 	var emptyColor = Graphics.COLOR_LT_GRAY;
 	var arrowWidth = 2;
 	var titleFont;
    var stepsBitmap;
    var floorsBitmap;
    
    var secondaryTextVertOffset = 37;
    
    function onLayout(dc) {
        titleFont = WatchUi.loadResource(Rez.Fonts.RobotoBold);
        stepsBitmap = WatchUi.loadResource(Rez.Drawables.StepsIcon);
        floorsBitmap = WatchUi.loadResource(Rez.Drawables.FloorsIcon);
    }
    
    function drawFirstSegment(dc, color, x, width) {
 		dc.setColor(color, color);
		var coords = [[x, segmentVertOffset], 
		              [x + width - arrowWidth, segmentVertOffset],
		              [x + width, segmentVertOffset + segmentHeight / 2],
		              [x + width - arrowWidth, segmentVertOffset + segmentHeight],
		              [x, segmentVertOffset + segmentHeight],
		              [x, segmentVertOffset]];
		dc.fillPolygon(coords);           
 	}
 	
 	function drawSegment(dc, color, x, width) {
 		dc.setColor(color, color);
		var coords = [[x, segmentVertOffset], 
		              [x + width - arrowWidth, segmentVertOffset],
		              [x + width, segmentVertOffset + segmentHeight / 2],
		              [x + width - arrowWidth, segmentVertOffset + segmentHeight],
		              [x, segmentVertOffset + segmentHeight],
		              [x + arrowWidth, segmentVertOffset + segmentHeight / 2],
		              [x, segmentVertOffset]];
		dc.fillPolygon(coords);           
 	}
 	
 	function drawSegments(dc, level) {
 		var color = emptyColor;
 		var width = firstWidth;
 		var x = 0;
 		for(var i = 0; i < 5; i++) {
 			if (level > i) {
 				color = filledColor;
 			} else {
 				color = emptyColor;
 			}
 			if(i == 0) {
 				drawFirstSegment(dc, color, x, width);
 			} else {
 				width = nextWidth;
 				drawSegment(dc, color, x, width);
 			}
 			
 			x += width + segmentMargin;
 		}
 	}
 	
    function initialize() {
        GlanceView.initialize();  
    }	
    
    function onUpdate(dc) {
    	var width = dc.getWidth();
    	firstWidth = width / 2 - segmentMargin;
    	nextWidth = width / 8 - segmentMargin;
    	
		dc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_BLACK);
		dc.clear();
		dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
		dc.drawText(0, 0, titleFont, "MOVE BAR" , Graphics.TEXT_JUSTIFY_LEFT);
		var info = ActivityMonitor.getInfo();
		drawSegments(dc, info.moveBarLevel);
		
		dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
		dc.drawBitmap(0, secondaryTextVertOffset + 7, stepsBitmap);
		dc.drawText(18, secondaryTextVertOffset, Graphics.FONT_TINY, info.steps.toString(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawBitmap(width / 2, secondaryTextVertOffset + 7, floorsBitmap);
		dc.drawText(width / 2 + 20, secondaryTextVertOffset, Graphics.FONT_TINY, info.floorsClimbed.toString(), Graphics.TEXT_JUSTIFY_LEFT);
    } 
}

class MoveBarView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
