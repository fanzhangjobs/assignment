from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route("/status", methods=["GET"])
def status():
    return jsonify({"status": "backend running"}), 200

@app.route("/compute", methods=["POST"])
def compute():
    data = request.json
    result = data.get("value", 0) * 100 
    return jsonify({"result": result})

import time
import threading

@app.route("/stress", methods=["POST"])
def stress():
    data = request.json or {}
    duration = int(data.get("duration", 10))  # seconds
    threads = int(data.get("threads", 1))

    def cpu_busy_loop(seconds):
        end = time.time() + seconds
        while time.time() < end:
            pass  # busy-wait

    # Start threads to stress CPU
    for _ in range(threads):
        t = threading.Thread(target=cpu_busy_loop, args=(duration,))
        t.start()

    return jsonify({"status": f"CPU stress started for {duration}s with {threads} threads"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
