package android;

import android.FlxVirtualPad;
import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.math.FlxPoint;

class ControlMode 
{
	var save:FlxSave;

	public function new() 
	{
		save = new FlxSave();
		save.bind("saveconrtol");
	}

	public function camSave(value:Float):Float {
		if (save.data.cam == null) save.data.cam = 0.06;
		
		save.data.cam = value;
		save.flush();
		return save.data.cam;
	}

	public function camLoad():Float {
		if (save.data.cam != null) {
			return save.data.cam;
		}
		else {
			return 0.06;
		}
	}

	public function getcontrolmode():Int {
		// load control mode num from FlxSave
		if (save.data.buttonsmode != null) return save.data.buttonsmode[0];
		return 0;
	}

	public function setcontrolmode(mode:Int = 0):Int {
		// save control mode num from FlxSave
		if (save.data.buttonsmode == null) save.data.buttonsmode = new Array();
		save.data.buttonsmode[0] = mode;
		save.flush();

		return save.data.buttonsmode[0];
	}

	public function savecustom(_pad:FlxVirtualPad) {
		trace("saved");

		if (save.data.buttons == null)
		{
			save.data.buttons = new Array();

			for (buttons in _pad)
			{
				save.data.buttons.push(FlxPoint.get(buttons.x, buttons.y));
			}
		}else
		{
			var tempCount:Int = 0;
			for (buttons in _pad)
			{
				save.data.buttons[tempCount] = FlxPoint.get(buttons.x, buttons.y);
				tempCount++;
			}
		}
		save.flush();
	}

	public function loadcustom(_pad:FlxVirtualPad):FlxVirtualPad {
		//load pad
		if (save.data.buttons == null) return _pad;
		var tempCount:Int = 0;

		for(buttons in _pad)
		{
			buttons.x = save.data.buttons[tempCount].x;
			buttons.y = save.data.buttons[tempCount].y;
			tempCount++;
		}	
		return _pad;
	}
}