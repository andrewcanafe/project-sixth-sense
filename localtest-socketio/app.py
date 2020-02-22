from flask import Flask, flash, url_for, redirect, send_from_directory, request, render_template, make_response, session
from flask_socketio import SocketIO, join_room, leave_room, emit

# Flask constructor takes the name of
# current module (__name__) as argument.
app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins='*')
# The route() function of the Flask class is a decorator,
# which tells the application which URL should call
# the associated function.
@app.route('/test')
def hello_world():
    return 'Hello World'

@app.route('/')
def index():
    return send_from_directory('.','index.html')

@socketio.on('my event')
def test_message(message):
    print('LOOK HERE' + message['data'])
    emit('my response', {'data': message['data']})

@socketio.on('connect')
def test_connect():
    print('===CONNECTED=======')
    emit('my response', {'data': 'Connected'})

@socketio.on('disconnect')
def test_disconnect():
    print('===DISCONNECTED====')

# main driver function
if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0')