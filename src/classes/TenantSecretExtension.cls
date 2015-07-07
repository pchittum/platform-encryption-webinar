public with sharing class TenantSecretExtension {

	private final sObject mysObject;
    private List<TenantSecret> secrets; 

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public TenantSecretExtension(ApexPages.StandardController stdController) {
        this.mysObject = (sObject)stdController.getRecord();
    }

    public String getRecordName() {
        return 'Hello ' + (String)mysObject.get('name') + ' (' + (Id)mysObject.get('Id') + ')';
    }

    public List<TenantSecret> getLastTwoSecrets(){
        List<TenantSecret> fetchedSecrets = [SELECT Id, Description, Status, CreatedDate, Version FROM TenantSecret ORDER BY Version DESC LIMIT 2];
        return fetchedSecrets;
    }
    
    public TenantSecret activeSecret {
        get {
            if (secrets == null || secrets.size() == 0) {
                secrets = getLastTwoSecrets();
            }
            TenantSecret activeSecret = secrets.get(0);
            if (activeSecret.Description == null){
                activeSecret.Description = 'Rotated via Setup Menu';
            }
            return activeSecret;
        }
    }
    
    public TenantSecret previousSecret {
        get {
            if (secrets == null || secrets.size() == 0) {
                secrets = getLastTwoSecrets();
            }
            TenantSecret previousSecret = secrets.get(1);
            if (previousSecret.Description == null){
                previousSecret.Description = 'Rotated via Setup Menu';
            }
            return previousSecret;
        }
    }

    public void rotateKey(){
        TenantSecret newSecret = new TenantSecret(Description='New Secret from Visualforce Page.');
		secrets.clear();
        try {
            insert newSecret;
        } catch (Exception e){
            ApexPages.addMessages(e);
        }
    }
}