public class EncryptedCustomField {

    public String name { get; set; }

    public boolean isEncrypted { get; set; }
    
    public boolean isCustom { get; set; }

    public String type { get; set; }
    
    public String objName { get; set; }

    public EncryptedCustomField(String name, boolean isEncrypted, String type, String objName, boolean isCustom) {
        this.name = name;
        this.isEncrypted = isEncrypted;
        this.type = type;
        this.objName = objName;
        this.isCustom = isCustom;
    }
}