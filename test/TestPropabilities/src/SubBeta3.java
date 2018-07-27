
public class SubBeta3 extends Beta {
	
	public void startNew() {
		System.out.println("New account");
		deposit(100);
	}
	
	public void deposit(double amount) {
		balance = balance + amount - 5;
	}

}
