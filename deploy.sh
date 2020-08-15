docker build -t sergerodriguezequisoft/multi-client:latest -t sergerodriguezequisoft/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sergerodriguezequisoft/multi-server:latest -t sergerodriguezequisoft/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sergerodriguezequisoft/multi-worker:latest -t sergerodriguezequisoft/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sergerodriguezequisoft/multi-client:latest
docker push sergerodriguezequisoft/multi-server:latest
docker push sergerodriguezequisoft/multi-worker:latest

docker push sergerodriguezequisoft/multi-client:$SHA
docker push sergerodriguezequisoft/multi-server:$SHA
docker push sergerodriguezequisoft/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=sergerodriguezequisoft/multi-server:$SHA
kubectl set image deployments/client-deployment client=sergerodriguezequisoft/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sergerodriguezequisoft/multi-worker:$SHA