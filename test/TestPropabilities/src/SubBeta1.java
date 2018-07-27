
public class SubBeta1 extends Beta {
	
	private int counter;
	
	public void deposit(double amount) {
		super.deposit(amount);
		counter++;
	}

}
