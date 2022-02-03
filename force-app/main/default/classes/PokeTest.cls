@isTest
public class PokeTest {
    private static testMethod void pageTesting(){
        test.startTest();
        test.setCurrentPage(PokeDexCtrl.Back());
        test.setCurrentPage(PokeStartCtrl.Battle());
        test.setCurrentPage(PokeStartCtrl.BattleRecord());
        test.setCurrentPage(PokeStartCtrl.Teams());
        test.setCurrentPage(PokeStartCtrl.Dex());
        test.setCurrentPage(BattleRecordCtrl.Back());
        test.setCurrentPage(TeamsPageCtrl.Back());
        test.setCurrentPage(PreBattleCtrl.Back());
        test.stopTest();
    }
}