from flask import Flask

app = Flask(__name__)  # This correctly initializes the Flask app

@app.route('/')
def home():
    return "Hello from Flask app running through Jenkins!"
