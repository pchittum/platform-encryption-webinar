/**
 * Controller for the encryptedCustomFields VF page
 *
 */
public with sharing class EncryptedCustomFieldController {

    /**
     * Returns a list of all the encrypted fields in the organization.
     */
    public List<EncryptedCustomField> getFields() {
    
        List<EncryptedCustomField> ret = new List<EncryptedCustomField>();
        
        // Do a global describe and walk through each sobejct
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
    
        for(Schema.SObjectType objType : globalDescribe.values()) {
            
            // Describe each object and walk through each field
            Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
            for (Schema.SObjectField f : objDescribe.fields.getMap().values()) {
                Schema.DescribeFieldResult field = f.getDescribe();
        
                // Keep treack of the fields that are encrypted.
                if(field.isEncrypted()){                   
                    ret.add(new EncryptedCustomField(field.getName(), field.isEncrypted(), 
                    field.getType().name(), objDescribe.getName(), field.isCustom()));
                }
            }
    
        }
        return ret;
    }
}