public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [
            SELECT Id, Name, Rating, BillingCity, Industry, Phone, Revenue, NumberOfEmployees
            FROM Account
            LIMIT 100
        ];
    }

    @AuraEnabled
    public static Account getAccountById(String accountId) {
        return [
            SELECT Id, Name, Rating, BillingCity, Industry, Phone, Revenue, 
                   Website, NumberOfEmployees, Description, Type
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];
    }

    @AuraEnabled
    public static String createAccount(String name, String industry, String phone) {
        try {
            Account acc = new Account(
                Name = name,
                Industry = industry,
                Phone = phone
            );
            insert acc;
            return acc.Id;
        } catch (DmlException e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void updateAccount(String accountId, String name, String industry) {
        try {
            Account acc = new Account(
                Id = accountId,
                Name = name,
                Industry = industry
            );
            update acc;
        } catch (DmlException e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteAccount(String accountId) {
        try {
            delete new Account(Id = accountId);
        } catch (DmlException e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
