public class PokeCallout 
{
	public static void myAPICallout()
    {
        List<Pokemon__c> existingPokemon = [SELECT Id FROM Pokemon__c];
        List<Pokemon__c> newPokemon = new List<Pokemon__c>();
        for(integer i = existingPokemon.size(); i < existingPokemon.size() + 100; i++){
        	HTTP http = new Http();
    		HttpRequest req = new HttpRequest();
    		HttpResponse res = new HttpResponse();
    		req.setEndpoint('https://pokeapi.co/api/v2/pokemon-form/' + (i+1));
    		req.setMethod('GET');
    		res = http.send(req);
        
        	if (res.getStatusCode() == 200)
        	{
            	Map<String, Object> resMap = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
           	 	Map<String, Object> spriteMap = (Map<String,Object>) resMap.get('sprites');
                String back_default = String.valueOf(spriteMap.get('back_default'));
                String front_default = String.valueOf(spriteMap.get('front_default'));
                String pokeName = String.valueOf(resMap.get('name'));
                String pokeId = String.valueOf(resMap.get('id'));
                List<Object> typeList = (List<Object>) resMap.get('types');
                Map<String, Object> firstSlot;
                Map<String, Object> secondSlot;
                Map<String, Object> firstSlotType;
                Map<String, Object> secondSlotType;
                String primaryType;
                String secondaryType;
            
                if(typeList.size() == 2)
                {
                    firstSlot = (Map<String,Object>) typeList.get(0);
                    secondSlot = (Map<String,Object>) typeList.get(1);
                    firstSlotType = (Map<String,Object>) firstSlot.get('type');
                    secondSlotType = (Map<String,Object>) secondSlot.get('type');
                    primaryType = String.valueOf(firstSlotType.get('name'));
                    secondaryType = String.valueOf(secondSlotType.get('name'));
                }
                
                else
                {
                    firstSlot = (Map<String,Object>) typeList.get(0);
                    firstSlotType = (Map<String,Object>) firstSlot.get('type');
                    primaryType = String.valueOf(firstSlotType.get('name'));
                    
                }
            
            
                //System.debug(firstSlot);
                //System.debug(secondSlot);
                //System.debug(firstSlotType);
                //System.debug(secondSlotType);
                //System.debug(primaryType);
                //System.debug(secondaryType);
                Pokemon__c pokemon = new Pokemon__c();
                pokemon.Name = pokeName;
                pokemon.PokeId__c = pokeId;
                pokemon.Back_Sprite__c = back_default;
                pokemon.Front_Sprite__c = front_default;
                if(typeList.size() == 2){
                    pokemon.Type_1__c = primaryType;
                    pokemon.Type_2__c = secondaryType;
                }
                else{
                    pokemon.Type_1__c = primaryType;
                }
                System.debug(pokemon);
               	newPokemon.add(pokemon);
                //System.debug(resMap);
                //System.debug(typeList.size());
                //System.debug(spriteMap);
                //System.debug(back_default);
                //System.debug(front_default);
            }
   	 	}
        insert newPokemon;
	}
}