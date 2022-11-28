FROM python:3.9

RUN apt-get install python3

COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ADD . /app
WORKDIR /app

ENTRYPOINT ["/usr/bin/python", "./app.py"]
