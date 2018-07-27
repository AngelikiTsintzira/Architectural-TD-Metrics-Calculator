
public class Alpha {

	private Beta beta;
	private Gamma gamma;
	
	public void setBeta(Beta ref) {
		beta = ref;
	}
	
	public void method1() {
		beta.deposit(100);
	}
	
	public void method2() {
		gamma.m1();
		gamma.m2();
		gamma.m3();
		
	}
	
	public int method3() {
		gamma.m2();
		return 5;
	}

}
