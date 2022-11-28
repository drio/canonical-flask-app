FROM python:3.9
ADD . /app
WORKDIR /app
RUN apt-get install python3
RUN pip install -r requirements.txt
CMD "/usr/bin/python3 /app/app.py"
