Public with sharing class SOSLController{
 Public List<Opportunity> optyList {get;set;}
 Public List<contact> conList{get;set;}
 Public List<account> accList{get;set;}
 public List<Child__c> childList {get;set;} 
  
 Public String searchStr{get;set;}
   Public SOSLController(){
   }
  
  Public void soslDemo_method(){ 
   optyList = New List<Opportunity>();
   conList = New List<contact>();
   accList = New List<account>();
   childList = new List<Child__c>(); 
    if(searchStr.length() > 1){
    String searchStr1 = '*'+searchStr+'*';
    String searchQuery = 'FIND \'' + searchStr1 + '\' IN ALL FIELDS RETURNING  Account (Id,Name,type, TAX_ID__c),Contact(Name,email, DLN__c, SSN__c),Opportunity(name,StageName), Child__c(Name,First_Name__c,Family_Name__c,NHS_Number__c,Birth_Date__c,Sex__c)';
    List<List <sObject>> searchList = search.query(searchQuery);
    //accList = ((List<Account>)searchList[0]);
    accList = (List<Account>)searchList[0];
    if(!accList.isEmpty())
        DynamicSort.sortList(accList, 'Name', 'asc',null);
   conList  = ((List<contact>)searchList[1]);
    if(!conList.isEmpty())
        DynamicSort.sortList(conList, 'Name', 'asc',null);
   optyList = ((List<Opportunity>)searchList[2]);
   childList= ((List<Child__c>)searchList[3]);
   if(accList.size() == 0 && conList.size() == 0 && optyList.size() == 0){
       apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Sorry, no results returned with matching string..'));
       return;
   }
   }
   else{
   apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Please enter at least two characters..'));
   return;
   }
  }

  public boolean getHasOpportunities(){
    return (optyList != null && optyList.size() > 0);
  }

  public boolean getHasContacts(){
    return (conList != null && conList.size() > 0);
  }
  public boolean getHasAccounts(){
    return (accList != null && accList.size() > 0);
  }
  public boolean getHasChildren(){
    return (childList != null && childList.size() > 0);
  }
}