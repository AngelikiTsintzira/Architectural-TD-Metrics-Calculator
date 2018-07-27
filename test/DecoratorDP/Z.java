class Z extends D {
   	public Z( I inner ) { super( inner ); }
   	public void doIt()  {
   		super.doIt();
    	doZ();
   	}
   	private void doZ() { System.out.print( 'Z' ); }
}