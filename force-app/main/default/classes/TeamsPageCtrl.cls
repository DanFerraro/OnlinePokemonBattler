public class TeamsPageCtrl {

    public static PageReference Back(){
        PageReference p = new PageReference('/apex/PokeStart');
       	p.setRedirect(true);
		return p;
    }

    /*
     * In order to avoid querying the Pokemon too many times, they are
     * assigned to a static Map (by their Ids) and accessed via a getter
     * that only queries them when they aren't already on hand.
     */
    private static Map<Id, Pokemon__c> PokemonMap;
    public static Map<Id, Pokemon__c> getPokemonMap() { 
        if (PokemonMap == null){
            PokemonMap = new Map<Id, Pokemon__c>([SELECT Id, Name, pokeId__c FROM Pokemon__c]);
        }
        return PokemonMap;
    }

    // Stores the list of Pokemon selection options. This is used to make picklists.
    private final List<SelectOption> PokemonPicklistOptions;
    public List<SelectOption> getPokemonPicklistOptions(){
        return PokemonPicklistOptions;
    }

    /*
     * Instantiates the controller for the Teams page.
     */
    public TeamsPageCtrl(){
        PokemonPicklistOptions = new List<SelectOption>();
        // All of the different Pokemon are looked up and added to the picklist options.
        // The value of each option is the Pokemon's Id. The Pokemon's names are the labels.
        for(Pokemon__c p : getPokemonMap().values()){
            PokemonPicklistOptions.add(new SelectOption(p.Id,p.Name));
        }
    }

    /*
     * Looks up all of the existing teams for the User, makes a TeamView for each one, and
     * returns a list of those TeamViews.
     */
    public List<TeamView> getTeamViews(){
        List<TeamView> Results = new List<TeamView>();
        for (Team__c Team : [SELECT Name, OwnerId, (SELECT Id, Pokemon__c FROM TeamPokemon__r) FROM Team__c WHERE OwnerId = :UserInfo.getUserId()]){
            Results.add(new TeamView(Team));
        }
        return Results;
    }

    /*
     * This helper class is used to display Teams of Pokemon. It has a series of converted
     * getter and setter methods that allow Visualforce to more easily display and change 
     * the TeamPokemon records associated with a particular Team, as well as automatic
     * database updates for changes made.
     */
    public class TeamView {

        private final Team__c Team;
        private List<TeamPokemon__c> Pokemon;

        /* 
         * When creating a TeamView, make sure the Team has subqueried its child
         * TeamPokemon records. If you forget, these records will not be properly
         * updated.
         */
        public TeamView(Team__c t){
            // If a team doesn't have enough TeamPokemon records (6), more will be made.
            List<TeamPokemon__c> creations = new List<TeamPokemon__c>();
            Team = t;
            for (Integer i = 0; i < 6; i++){
                // Checks to see if a new TeamPokemon record must be made, or if there's an existing one to use.
                if (t.TeamPokemon__r == null || t.TeamPokemon__r.size() < i){
                    TeamPokemon__c creation = new TeamPokemon__c();
                    // New TeamPokemon records will be junctions of this team and the first Pokemon record, initially.
                    creation.Team__c = t.Id;
                    creation.Pokemon__c = getPokemonMap().values()[0].Id;
                    Pokemon[i] = creation;
                } else {
                    Pokemon[i] = t.TeamPokemon__r[i];
                }
            }
            // If any new TeamPokemon records were made, now is the time to insert them into the database.
            if (creations.size() > 0) insert creations;
        }

        // This lets the TeamView expose its team for display purposes. No need to modify the Team, since it's just an auto-number.
        public Team__c getTeam(){
            return Team;
        }

        // Indexed Pokemon getters and setters.
        public Id getPokemon(Integer i){
            if (i < 0 || i > 5) throw new IllegalArgumentException('Out of bounds. You can only get Pokemon 0 - 5 from a TeamView.');
            return Pokemon[i].Pokemon__c;
        }
        public void setPokemon(Id p, Integer i){
            if (i < 0 || i > 5) throw new IllegalArgumentException('Out of bounds. You can only get Pokemon 0 - 5 from a TeamView.');
            Pokemon[i].Pokemon__c = p;
            update Pokemon[i];
        }

        // Individual Pokemon getters and setters. Visualforce action binding doesn't play nice with indices or parameters, after all.
        public Id getPokemon0(){
            return getPokemon(0);
        }
        public void setPokemon0(Id p){
            setPokemon(p, 0);
        }

        public Id getPokemon1(){
            return getPokemon(1);
        }
        public void setPokemon1(Id p){
            setPokemon(p, 1);
        }

        public Id getPokemon2(){
            return getPokemon(2);
        }
        public void setPokemon2(Id p){
            setPokemon(p, 2);
        }

        public Id getPokemon3(){
            return getPokemon(3);
        }
        public void setPokemon3(Id p){
            setPokemon(p, 3);
        }

        public Id getPokemon4(){
            return getPokemon(4);
        }
        public void setPokemon4(Id p){
            setPokemon(p, 4);
        }

        public Id getPokemon5(){
            return getPokemon(5);
        }
        public void setPokemon5(Id p){
            setPokemon(p, 5);
        }

    }

}