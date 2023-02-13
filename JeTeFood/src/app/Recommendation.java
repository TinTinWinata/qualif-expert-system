package app;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Vector;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.ScrollPaneLayout;

import jess.JessException;
import jess.QueryResult;
import jess.Rete;
import jess.ValueVector;
import model.Food;

public class Recommendation extends JFrame implements ActionListener {

	private static final long serialVersionUID = 1L;
	private static final String QUERY_NAME = "search-recommended";

	JLabel[] label = new JLabel[3];
	JTextArea[] txt = new JTextArea[3];
	JButton close = new JButton("Close");
	String[] kata = new String[3];
	JScrollPane pane = new JScrollPane();
	JPanel pane2 = new JPanel();

	private Vector<Food> foodList = new Vector<>();

	public static void main(String[] args) {
		new Recommendation();
	}

	public void query() {
		try {
			QueryResult queryRes = Main.engine.runQueryStar(QUERY_NAME, new ValueVector());
			while (queryRes.next()) {
				String name = queryRes.getString("a");
				String price = queryRes.getString("b");
				String type = queryRes.getString("c");
				String based_calories = queryRes.getString("d");
				foodList.add(new Food(name, price, type, based_calories));
			}
		} catch (JessException e) {
			e.printStackTrace();
		}
	}

	public Recommendation() {
		query();
		kata[0] = "Food you can eat : ";
		kata[1] = "Price : ";
		kata[2] = "Based Calories : ";

		setTitle("Find Your Food");
		setSize(500, 200);
		pane.setLayout(new ScrollPaneLayout());
		pane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		pane2.setLayout(new BoxLayout(pane2, BoxLayout.Y_AXIS));

		for (int i = 0; i < 3; i++) {
			txt[i] = new JTextArea();
			txt[i].setLineWrap(true);
			txt[i].setWrapStyleWord(true);
			txt[i].setEditable(false);
			txt[i].setAlignmentX(CENTER_ALIGNMENT);
			label[i] = new JLabel("", JLabel.CENTER);
			label[i].setText(kata[i]);
		}

		// Code in here
		String name = "";
		String price = "";
		String calories = "";

		int idx = 0;
		for (Food food : foodList) {
			name += food.getName();
			price += food.getPrice();
			calories += food.getBased_calories();
			
			if(foodList.size() == 1) continue;
			name += ", ";
			price += ", ";
			calories += ", ";
		}

		txt[0].setText(name);
		txt[1].setText(price);
		txt[2].setText(calories);

		for (int i = 0; i < 3; i++) {
			pane2.add(label[i]);
			pane2.add(txt[i]);
		}
		add(pane);
		pane.getViewport().add(pane2);
		add(close, "South");
		close.addActionListener(this);
		setLocationRelativeTo(null);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setVisible(true);

	}

	public void actionPerformed(ActionEvent arg0) {
		if (arg0.getSource() == close)
			this.dispose();
	}

}
