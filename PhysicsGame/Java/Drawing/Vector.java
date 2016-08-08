package PhysicsGame.Java.Drawing;

import java.util.ArrayList;
import PhysicsGame.Java.Helper.ObjectConvertible;
import PhysicsGame.Java.Helper.Helper;

public class Vector implements ObjectConvertible {
	public double x;
	public double y;
	
	public Vector(double x, double y) {
		this.x = x;
		this.y = y;
	}
	
	public Vector copy() {
		return new Vector(x, y);
	}
	
	public Vector add(Vector vector) {
		return new Vector(this.x + vector.x, this.y + vector.y);
	}
	public Vector subtract(Vector vector) {
		return new Vector(this.x - vector.x, this.y - vector.y);
	}
	public Vector multiply(double scalar) {
		return new Vector(x * scalar, y * scalar);
	}
	public void addInPlace(Vector vector) {
		x += vector.x;
		y += vector.y;
	}
	public void subtractInPlace(Vector vector) {
		x -= vector.x;
		y -= vector.y;
	}
	
	// --- ObjectConvertible
	
	public void convertFromObject(Object object) throws IllegalArgumentException {
		ArrayList<String> list = Helper.castToArrayListOfStrings(object);
		// !!! can throw
		Helper.throwIllegalErgumentExceptionIfNull("list is null", list);
		
		if (list.size() != 2) {
			throw new IllegalArgumentException("list has not size == 2");
		}
		
		try {
			this.x = Double.parseDouble(list.get(0));
			this.y = Double.parseDouble(list.get(1));
		} catch (NumberFormatException e) {
			throw new IllegalArgumentException("could not parse numbers from String: " + list.get(0)+ " and " + list.get(1));
		}
	}
	
	public Object convertToObject() {
		ArrayList<String> list = new ArrayList<>();
		list.add(x + "");
		list.add(y + "");
		return list;
	}
	
}
