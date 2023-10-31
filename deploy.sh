RESOURCE_GROUP=ignite2023-resiliency-demo
ENVIRONMENT_NAME=ignite2023-resiliency-demo

az group create -n $RESOURCE_GROUP -l northcentralus

az containerapp env create -g $RESOURCE_GROUP -n $ENVIRONMENT_NAME -l northcentralusstage

cd src

az containerapp up -g $RESOURCE_GROUP -n album-api --environment $ENVIRONMENT_NAME --source .

az containerapp update -g $RESOURCE_GROUP -n album-api --min-replicas 1 --max-replicas 1 --set-env-vars API_FAILURES=3

cd ../../containerapps-albumui/src

az containerapp up -g $RESOURCE_GROUP -n music-store --environment $ENVIRONMENT_NAME --env-vars API_BASE_URL=http://album-api --source .
az containerapp update -g $RESOURCE_GROUP -n music-store --min-replicas 1 --max-replicas 1
