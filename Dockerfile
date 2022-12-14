FROM python:3.9

COPY . /app
WORKDIR /app

COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ENTRYPOINT ["python"]
CMD ["app.py"]
