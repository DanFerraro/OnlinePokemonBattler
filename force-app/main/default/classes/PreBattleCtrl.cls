public class PreBattleCtrl {
    
    String teamName1;
    String teamName2;
    
    public PageReference test() {
            return null;
        }
    
    public String getTeamName1(){
        return teamName1;
    }
    public void setTeamName1(String teamName1){
        this.teamName1 = teamName1;
    }
    
    public String getTeamName2(){
        return teamName2;
    }
    public void setTeamName2(String teamName2){
        this.teamName2 = teamName2;
    }
    public List<SelectOption> getTeamOptions(){
        List<Team__c> teams = [Select Name From Team__c];
        List<SelectOption> teamNames = new List<SelectOption>();
        for(Team__c t:teams){
            teamNames.add(new SelectOption(t.id,t.name));
        }
        return teamNames;
    }
    
    public static PageReference Back(){
        PageReference p = new PageReference('/apex/PokeStart');
       	p.setRedirect(true);
		return p;
    }
    
    /*change to battle page when made*/
    public PageReference startBattle(){
        List<Active_Team__c> actives = [Select id, Active_Player_Team__c, Active_Opponent_Team__c from Active_Team__c];
        List<Active_Team__c> newActives = new List<Active_Team__c>();
        if(actives.size() == 0){
            Active_Team__c newActive = new Active_Team__c();
            newActive.Active_Player_Team__c = this.teamName1;
            newActive.Active_Opponent_team__c = this.teamName2;
            newActives.add(newActive);
        }
        else{
            for(Active_Team__c AT: actives){
                AT.Active_Player_Team__c = this.teamName1;
            	AT.Active_Opponent_team__c = this.teamName2;
                newActives.add(AT);
            }            
        }
        upsert newActives;
        PageReference p = new PageReference('/apex/PokeStart');
       	p.setRedirect(true);
		return p;
    }

}
