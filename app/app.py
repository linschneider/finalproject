from flask import Flask, render_template
import pymongo

app = Flask(__name__,template_folder='templates')

# Step 2: Establish a connection to MongoDB
client = pymongo.MongoClient("mongodb://root:3yGWpZ7jeS@34.78.116.136:27017/")  # Change the connection string as needed

# Step 3: Access the collection
db = client["lin_db"]  # Replace with your database name
collection = db["dbapp"]  # Replace with your collection name

# Step 4: Collect data from the collection
# For example, let's retrieve all documents from the collection
documents = collection.find()

# Create a list to store the documents
document_list = []

# Iterate over the documents and append them to the list
for document in documents:
    document_list.append(document)

# Close the MongoDB connection
client.close()


@app.route('/')
def index():
    return render_template('index.html', collection=document_list)


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=9101, debug=True)
