public class TeamsPageCtrl {
    public static PageReference Back(){
        PageReference p = new PageReference('/apex/PokeStart');
       	p.setRedirect(true);
		return p;
    }

}