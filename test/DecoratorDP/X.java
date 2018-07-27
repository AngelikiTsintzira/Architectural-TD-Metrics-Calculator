class X extends D {
   	public X( I inner ) { super( inner ); }
   	public void doIt()  {
      	super.doIt();
      	doX();
   	}
   	private void doX() { 
		System.out.print( 'X' ); 
		doIt();
	}
}