public with sharing class BasicController {


	public List<Contact> contacts {get;set;}

	public BasicController() {

		if (ApexPages.currentPage() != null && ApexPages.currentPage().getParameters().get('reqType') == 'sosl') {

			runSosl();

		} else {

			runSoql();

		}
		
	}

	public void runSoql(){

		contacts = [select Id, FirstName,LastName,Email,Phone, DLN__c, SSN__c from Contact];

	}

	public void runSosl(){

		contacts = (List<Contact>) [FIND '*ba*' IN ALL FIELDS RETURNING Contact(Id,FirstName,LastName,Email,Phone,SSN__c,DLN__c)][0];

	}
}