import random
from flask import Flask, render_template, jsonify
from flask.wrappers import Response
from prometheus_client import Counter, Gauge, generate_latest
import os

CONTENT_TYPE_LATEST = str('text/plain; version=0.0.4; charset=utf-8')

app = Flask(__name__)


number_of_requests = Counter(
    'number_of_requests',
    'The number of requests, its a counter so the value can increase or reset to zero.'
)

current_memory_usage = Gauge(
    'current_memory_usage_locally',
    'The current value of memory usage, its a gauge so it can go up or down.',
    ['server_name']
)

@app.route('/')
def hello():
    return render_template('index.html')

@app.route('/data')
def data():
    number_of_requests.inc()
    data= {
        "number" : random.randint(1, 10000000)
    }
    return jsonify(data)

@app.route('/metrics', methods=['GET'])
def get_data():
    """Returns all data as plaintext."""
    current_memory_usage.labels('server-a').set(random.randint(1000,90000))
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)


if __name__ == "__main__":
    port=os.environ.get('PY_SERVER_PORT', '')
    if port != "":
        app.run(debug=True, host='0.0.0.0', port=int(port))
    else:
        print("Need a port to run. Bailing out")
