@echo off
echo "Clean-up stale containers..."
docker ps -a
docker stop container-taf
docker rm --force container-taf
docker ps -a
echo "Clean-up stale images..."
docker images -a
docker rmi autotests-image
docker images -a
echo "Building image..."
docker build -t autotests-image .
echo "Running container for testing..."
docker run -dit --env ENCRYPTION_KEY= --name container-taf autotests-image 
echo "Run tests..."
docker exec container-taf sh -c "yarn test --tags '@tags' --environment='ENV_name' --parallel 5"
echo "Copying results..."
docker cp container-taf:/output ./docker-artifacts
echo "Removing container..."
docker ps -a
docker stop container-taf
docker rm --force container-taf
docker ps -a
echo "Removing image..."
docker images -a
docker rmi autotests-image
docker images -a
