package PhysicsGame.Java.Drawing;

import java.util.ArrayList;
import PhysicsGame.Java.Helper.ObjectConvertible;
import PhysicsGame.Java.Helper.Helper;

public class Rectangle implements DrawableObject {
	public Vector origin;
	public Size size;
	
	public Rectangle(Vector origin, Size size) {
		this.origin = origin;
		this.size = size;
	}
	
	public Rectangle(double x, double y, double width, double height) {
		origin = new Vector(x, y);
		size = new Size(width, height);
	}
	
	public Rectangle moved(Vector dv) {
		return new Rectangle(origin.add(dv), size.copy());
	}
	
	// --- ObjectConvertible
	
	public void convertFromObject(Object object) throws IllegalArgumentException {
		ArrayList<Object> list = Helper.castToArrayListOfObjects(object);
		// !!! can throw
		Helper.throwIllegalErgumentExceptionIfNull("list is null", list);
		
		if (list.size() != 2) {
			throw new IllegalArgumentException("list has not size == 2");
		}
		
		// !!! can throw
		this.origin.convertFromObject(list.get(0));
		// !!! can throw
		this.size.convertFromObject(list.get(1));
	}
	
	public Object convertToObject() {
		ArrayList<Object> list = new ArrayList<>();
		list.add(origin.convertToObject());
		list.add(size.convertToObject());
		return list;
	}
	
	// - Helper
	
	public static Rectangle fromObject(Object obj) throws IllegalArgumentException {
		Rectangle rect = new Rectangle(0,0,0,0);
		// !!! can throw
		rect.convertFromObject(obj);
		return rect;
	}
	
	// --- Drawable
	
	public MyColor getColor() { return null; }
	public Line getLine() { return null; }
	public Rectangle getRectangle() { return this; }
	public Polygon getPolygon() { return null; }
	public MyImage getImage() { return null; }
	
}
