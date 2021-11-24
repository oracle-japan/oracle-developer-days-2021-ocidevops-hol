#!/bin/sh

#Get CompartmentID
oci iam compartment list | grep compartment-id > compartment-id.txt ; cut -f 2 -d ":" compartment-id.txt | tr -d ' ','"',',' | tee compartment-id.txt &>/dev/null ; compartment_id=`cat ./compartment-id.txt` ; rm -rf ./compartment-id.txt ; echo ${compartment_id}

#Create Dynamic-Group
oci iam dynamic-group create --name OCI_DevOps_Dynamic_Group --description OCI_DevOps_Dynamic_Group --matching-rule "Any {All {resource.type = 'devopsrepository', resource.compartment.id = '${compartment_id}'},All {resource.type = 'devopsbuildpipeline', resource.compartment.id = '${compartment_id}'},All {resource.type = 'devopsdeploypipeline', resource.compartment.id = '${compartment_id}'}"

#Create Policy
oci iam policy create --name OCI_DevOps_Policy --description OCI_DevOps_Policy --compartment-id "${compartment_id}" --statements '["Allow dynamic-group OCI_DevOps_Dynamic_Group to manage devops-family in compartment id '${compartment_id}'","Allow dynamic-group OCI_DevOps_Dynamic_Group to manage all-artifacts in compartment id '${compartment_id}'","Allow dynamic-group OCI_DevOps_Dynamic_Group to manage cluster-family in compartment id '${compartment_id}'","Allow dynamic-group OCI_DevOps_Dynamic_Group to use ons-topics in compartment id '${compartment_id}'"]'