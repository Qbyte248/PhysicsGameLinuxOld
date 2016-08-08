package PhysicsGame.Java.Drawing;

import java.util.ArrayList;

import PhysicsGame.Java.Helper.ObjectConvertible;
import PhysicsGame.Java.Helper.Helper;

public class Line implements DrawableObject {
	public Vector start;
	public Vector end;
	
	public Line(Vector start, Vector end) {
		this.start = start;
		this.end = end;
	}
	
	public Line(double startX, double startY, double endX, double endY) {
		start = new Vector(startX, startY);
		end = new Vector(startX, startY);
	}
	
	public Line copy() {
		return new Line(start.copy(), end.copy());
	}
	
	public Line moved(Vector dv) {
		return new Line(start.add(dv), end.add(dv));
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
		this.start.convertFromObject(list.get(0));
		// !!! can throw
		this.end.convertFromObject(list.get(1));
	}
	
	public Object convertToObject() {
		ArrayList<Object> list = new ArrayList<>();
		list.add(start.convertToObject());
		list.add(end.convertToObject());
		return list;
	}
	
	// - Helper
	
	public static Line fromObject(Object obj) throws IllegalArgumentException {
		Line line = new Line(new Vector(0,0), new Vector(0,0));
		// !!! can throw
		line.convertFromObject(obj);
		return line;
	}
	
	// --- Drawable
	
	public MyColor getColor() { return null; }
	public Line getLine() { return this; }
	public Rectangle getRectangle() { return null; }
	public Polygon getPolygon() { return null; }
	public MyImage getImage() { return null; }
}
