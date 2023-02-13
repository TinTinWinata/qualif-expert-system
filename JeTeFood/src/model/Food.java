package model;

public class Food {

	private String name;
	private String price;
	private String type;
	private String based_calories;
	public Food(String name, String price, String type, String based_calories) {
		super();
		this.name = name;
		this.price = price;
		this.type = type;
		this.based_calories = based_calories;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getBased_calories() {
		return based_calories;
	}
	public void setBased_calories(String based_calories) {
		this.based_calories = based_calories;
	}
	
	
	
	

}
