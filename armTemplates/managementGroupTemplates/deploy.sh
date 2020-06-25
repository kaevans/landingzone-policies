# ====== Root management group ==========
mg=root

az deployment mg create --location southcentralus --management-group-id $mg --template-file bcdrInitiative.json
initiativeId="/providers/Microsoft.Management/managementGroups/${mg}/providers/Microsoft.Authorization/policySetDefinitions/bcdr-initiative"
az policy assignment create --scope "/providers/Microsoft.Management/managementGroups/${mg}" --name "Audit BCDR" --policy-set-definition "${initiativeId}" --enforcement-mode 'DoNotEnforce' 

az deployment mg create --location southcentralus --management-group-id $mg --template-file identityInitiative.json
initiativeId="/providers/Microsoft.Management/managementGroups/${mg}/providers/Microsoft.Authorization/policySetDefinitions/subscription-owner-initiative"
az policy assignment create --scope "/providers/Microsoft.Management/managementGroups/${mg}" --name "Audit subscription owner" --policy-set-definition "${initiativeId}" --enforcement-mode 'DoNotEnforce' 

az deployment mg create --location southcentralus --management-group-id $mg --template-file loggingInitiative.json
initiativeId="/providers/Microsoft.Management/managementGroups/${mg}/providers/Microsoft.Authorization/policySetDefinitions/custom-logging-initiative"
az policy assignment create --scope "/providers/Microsoft.Management/managementGroups/${mg}" --name "Audit logging" --policy-set-definition "${initiativeId}" --enforcement-mode 'DoNotEnforce' 


# ====== Legacy management group ==========
mg=legacy

az deployment mg create --location southcentralus --management-group-id $mg --template-file legacy-taggingInitiative.json --parameters mgmtGroupId=$mg
initiativeId="/providers/Microsoft.Management/managementGroups/${mg}/providers/Microsoft.Authorization/policySetDefinitions/legacy-tagging"
az policy assignment create --scope "/providers/Microsoft.Management/managementGroups/${mg}" --name "Audit tagging" --policy-set-definition "${initiativeId}" -p '{ "tagName": { "value": "serviceName" } }' --assign-identity --identity-scope "/providers/Microsoft.Management/managementGroups/${mg}" --role "4a9ae827-6dc8-4573-8ac7-8239d42aa03f" --location "southcentralus" --enforcement-mode 'DoNotEnforce'


# ====== Enterprise management group ==========
mg=enterprise

az deployment mg create --location southcentralus --management-group-id $mg --template-file enterprise-taggingInitiative.json
initiativeId="/providers/Microsoft.Management/managementGroups/${mg}/providers/Microsoft.Authorization/policySetDefinitions/enterprise-tagging"
az policy assignment create --scope "/providers/Microsoft.Management/managementGroups/${mg}" --name "Audit ent tagging" --policy-set-definition "${initiativeId}" -p '{ "tagName": { "value": "serviceName" } }' --assign-identity --identity-scope "/providers/Microsoft.Management/managementGroups/${mg}" --role "4a9ae827-6dc8-4573-8ac7-8239d42aa03f" --location "southcentralus" --enforcement-mode 'DoNotEnforce'


# ====== Workloads management group ==========
mg=workloads

az deployment mg create --location southcentralus --management-group-id $mg --template-file networkSecurityInitiative.json
initiativeId="/providers/Microsoft.Management/managementGroups/${mg}/providers/Microsoft.Authorization/policySetDefinitions/network-security-initiative"
az policy assignment create --scope "/providers/Microsoft.Management/managementGroups/${mg}" --name "Enforce network security" --policy-set-definition "${initiativeId}" -p '{ "listOfResourceTypesNotAllowed": { "value": [ "microsoft.network/publicipaddresses", "microsoft.network/vpngateways", "microsoft.network/p2svpngateways", "microsoft.network/expressroutecircuits" ] } }' --enforcement-mode 'DoNotEnforce'