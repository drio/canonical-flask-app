PRJ_NAME=canonical-flask-app

serve:
	python ./app.py

venv:
	virtualenv -p python3 venv
	echo "Now you can activate the env with: source venv/bin/activate"

# build and run image (remove container if exists)
run-docker:
	docker run --rm -it $$(docker build -q .)

freeze:
	pip freeze > requirements.txt 

install-requirements:
	pip3 install -r requirements.txt

# Docker helpers
#
run-py:
	docker-compose up $(PRJ_NAME)

rebuild-run-py:
	docker-compose up --build  --no-deps $(PRJ_NAME)

rebuild-run-py-force:
	docker-compose build --no-cache $(PRJ_NAME)
	docker-compose up --build --force-recreate --no-deps $(PRJ_NAME)

prune:
	docker container prune
	docker image prune
