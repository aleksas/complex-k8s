docker build -t aleksaspielikis/multi-client:latest -t aleksaspielikis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aleksaspielikis/multi-server:latest -t aleksaspielikis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aleksaspielikis/multi-worker:latest -t aleksaspielikis/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aleksaspielikis/multi-client:latest
docker push aleksaspielikis/multi-server:latest
docker push aleksaspielikis/multi-worker:latest

docker push aleksaspielikis/multi-client:$SHA
docker push aleksaspielikis/multi-server:$SHA
docker push aleksaspielikis/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=aleksaspielikis/multi-client:$SHA
kubectl set image deployments/server-deployment server=aleksaspielikis/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=aleksaspielikis/multi-worker:$SHA