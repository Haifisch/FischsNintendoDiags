from http.server import BaseHTTPRequestHandler,HTTPServer
import datetime

port = 8080

class myHandler(BaseHTTPRequestHandler):

    #Handler for the GET requests
    def do_GET(self):
        if self.path == '/nds':
            self.send_response(200)
            self.send_header('Content-type','text/plain;charset=UTF-8')
            self.end_headers()
            self.wfile.write(bytes(str(datetime.datetime.now()), 'utf-8'))
            self.wfile.write(bytes("\nTEST_PASSED", 'utf-8'))

server = HTTPServer(('', port), myHandler)
print('Started httpserver on port '+ str(port))

#Wait forever for incoming http requests
server.serve_forever()