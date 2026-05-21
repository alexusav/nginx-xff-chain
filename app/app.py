from flask import Flask, request
import json

app = Flask(__name__)

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def catch_all(path):
    xff = request.headers.get('X-Forwarded-For', 'NOT PRESENT')
    
    response = {
        'path': f'/{path}',
        'X-Forwarded-For': xff,
        'Remote-Addr': request.remote_addr,
        'all_headers': dict(request.headers)
    }
    
    return json.dumps(response, indent=2), 200, {'Content-Type': 'application/json'}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
