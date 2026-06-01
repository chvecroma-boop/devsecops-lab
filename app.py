from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def index():
    return jsonify(message="DevSecOps lab is running", status="ok")


@app.route("/health")
def health():
    return jsonify(status="healthy")


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000)