package app;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
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



public class Recommendation extends JFrame implements ActionListener{
	
	private static final long serialVersionUID = 1L;
	
	JLabel [] label = new JLabel [3];
	JTextArea [] txt = new JTextArea [3];
	JButton close = new JButton("Close");
	String []kata = new String[3];
	JScrollPane pane = new JScrollPane();
	JPanel pane2 = new JPanel();
	
	private Rete engine;
	
	public static void main(String[] args) {
		new Recommendation();
	}
	
	public void startEngine() {
		engine = new Rete();
		try {
			engine.batch("app/main4.clp");
		} catch (JessException e) {
			e.printStackTrace();
		}
	}
	
	public void query() {
		try {
			System.out.println("\nQuerying!\n");
			QueryResult queryRes = engine.runQueryStar("get_recommended_food", new ValueVector());
			while(queryRes.next()) {
				System.out.println("Query Result : ");
				System.out.println(queryRes.getString("a"));
				System.out.println(queryRes.getString("b"));
				System.out.println(queryRes.getString("c"));
				System.out.println(queryRes.getString("d"));
				System.out.println("------------------------------");
			}
		} catch (JessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	public Recommendation(){
		startEngine();
		query();
		kata[0] = "Motherboard : ";
		kata[1] = "Processor : ";
		kata[2] = "Total recommended price : ";
		
		
		setTitle("The Result of Simulation");
		setSize(500, 200);
		pane.setLayout(new ScrollPaneLayout());
		pane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		pane2.setLayout(new BoxLayout(pane2, BoxLayout.Y_AXIS));

		for(int i=0;i<3;i++)
		{
			txt[i] = new JTextArea();
			txt[i].setLineWrap(true);
			txt[i].setWrapStyleWord(true);
			txt[i].setEditable(false);
			txt[i].setAlignmentX(CENTER_ALIGNMENT);
			label[i] = new JLabel("",JLabel.CENTER);
			label[i].setText(kata[i]);
		}
		
		
		//Code in here
		
		
		
		for(int i=0;i<3;i++)
		{
			pane2.add(label[i]);
			pane2.add(txt[i]);
		}
		add(pane);
		pane.getViewport().add(pane2);
		add(close,"South");
		close.addActionListener(this);
		setLocationRelativeTo(null);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setVisible(true);
		
	}

	public void actionPerformed(ActionEvent arg0) {
		if(arg0.getSource()==close)
			this.dispose();
	}
	
}
