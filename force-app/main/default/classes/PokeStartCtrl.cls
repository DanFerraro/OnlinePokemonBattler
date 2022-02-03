public class PokeStartCtrl {
    public static PageReference Battle(){
        PageReference p = new PageReference('/apex/PreBattle');
       	p.setRedirect(true);
		return p;
    }
    public static PageReference BattleRecord(){
        PageReference p = new PageReference('/apex/BattleRecord');
       	p.setRedirect(true);
		return p;
    }
    public static PageReference Teams(){
        PageReference p = new PageReference('/apex/TeamsPage');
       	p.setRedirect(true);
		return p;
    }
    public static PageReference Dex(){
        PageReference p = new PageReference('/apex/PokeDexPage');
       	p.setRedirect(true);
		return p;
    }
}