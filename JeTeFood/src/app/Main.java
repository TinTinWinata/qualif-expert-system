package app;

import jess.JessException;
import jess.QueryResult;
import jess.Rete;
import jess.ValueVector;
import model.Food;

public class Main {

	public static Rete engine;
	
	public Main() {
		startEngine();
	}
	
	public void startEngine() {
		engine = new Rete();
		try {
			engine.batch("app/jess.clp");
		} catch (JessException e) {
			e.printStackTrace();
		}
	}
	
	
	public static void main(String[] args) {
		new Main();
	}

}
