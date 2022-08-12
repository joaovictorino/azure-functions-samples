# create project
func init fuctions-samples --javascript

# create http function
func new --name create-order --template "HTTP trigger" --authlevel "anonymous"
func new --name process-order --template "Azure Cosmos DB trigger"

# run local
func start

# Azure
az login

az group create --name rg-sample-function --location eastus

az storage account create --name sasampleazurefunction --location eastus --resource-group rg-sample-function --sku Standard_LRS

az functionapp create --resource-group rg-sample-function --consumption-plan-location eastus --runtime node --runtime-version 16 --functions-version 4 --name create-order-sample --storage-account sasampleazurefunction

# go to project azure functions root folder and deploy to Azure
func azure functionapp publish create-order-sample
