Sample code to deploy the enterprise policy to a management group:

````
az deployment mg create --name billingTagDeploy1 --management-group-id production --location southcentralus --template-file enterprise-taggingInitiative.json --parameters mgmtGroupId='production' tagName='costCenter' 
````

Sample code to deploy the legacy policy to a management group:

````
az deployment mg create --name billingTagDeploy2 --management-group-id development --location southcentralus --template-file legacy-taggingInitiative.json --parameters mgmtGroupId='development' tagName='costCenter'
````