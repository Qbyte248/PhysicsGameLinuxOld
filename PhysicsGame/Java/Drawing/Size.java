package PhysicsGame.Java.Drawing;

import PhysicsGame.Java.Helper.ObjectConvertible;

public class Size implements ObjectConvertible {
	public double width;
	public double height;
	
	public Size(double width, double height) {
		this.width = width;
		this.height = height;
	}
	
	public Size copy() {
		return new Size(width, height);
	}
	
	// --- ObjectConvertible
	
	public void convertFromObject(Object object) throws IllegalArgumentException {
		Vector v = new Vector(0,0);
		// !!! can throw
		v.convertFromObject(object);
		width = v.x;
		height = v.y;
	}
	
	public Object convertToObject() {
		return new Vector(width, height).convertToObject();
	}
}
