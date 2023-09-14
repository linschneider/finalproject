from flask import Flask, render_template
from pymongo import MongoClient

app = Flask(__name__)


@app.route('/')
def index():
    try:
        # Connect to the MongoDB database and collection
        client = MongoClient('mongodb://localhost:27017')
        db = client.finalprojectapp
        collection = db.dbapp
        status = "Connected to MongoDB"
        # client.close()
    except Exception as e:
        status = f"Failed to connect to MongoDB: {str(e)}"

    return render_template('app_front.html', status=status)


if __name__ == '__main__':
    app.run(debug=True)
