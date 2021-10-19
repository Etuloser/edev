NAME="edev"  
up:
	docker-compose up -d
down:
	docker-compose down -v
logs:
	docker logs -f ${NAME}
exec:
	docker exec -it ${NAME} tmux attach-session -t 0
build:
	docker build -t edev:1.0.0 .
test:
	docker run --init --rm -it --name edev edev:1.0.0
