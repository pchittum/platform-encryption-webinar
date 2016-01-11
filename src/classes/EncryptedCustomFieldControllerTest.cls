@isTest
class EncryptedCustomFieldControllerTest {
    @isTest static void testController() {
        EncryptedCustomFieldController controller = new EncryptedCustomFieldController();
        System.assertNotEquals(null, controller.getFields());
    }
    
    @isTest static void testEncryptedCustomFields() {
        EncryptedCustomField field = new EncryptedCustomField('a', true, 'b', 'c', false);
        System.assertEquals('a', field.name);
        System.assertEquals(true, field.isEncrypted);
        System.assertEquals('b', field.type);
        System.assertEquals('c', field.objName);
        System.assertEquals(false, field.isCustom);
    }

}