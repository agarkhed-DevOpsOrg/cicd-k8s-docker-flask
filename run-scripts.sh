sudo docker kill $(docker ps -q)
sudo docker container rm $(sudo docker ps -a)
sudo docker rmi $(docker images -a -q)
sudo docker build -t ashwinpagarkhed/image:latest .
sudo docker push ashwinpagarkhed/image
sudo docker run -d -it -p 5002:5000 -t ashwinpagarkhed/image:latest