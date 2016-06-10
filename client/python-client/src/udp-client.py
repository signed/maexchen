import socket


class Maexchen_Client:
    def __init__(self, server_ip="127.0.0.1", server_port=9000):
        self.server_port = server_port
        self.server_ip = server_ip

    def echo(self, nachricht):
        nachricht_kommando = "ECHO;" + nachricht
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.sendto(nachricht_kommando.encode('utf-8'), (self.server_ip, self.server_port))
        data, addr = sock.recvfrom(1024)
        return (data.decode('utf-8'))


normaler_client = Maexchen_Client()

print("Die Ausgabe:", normaler_client.echo("Hello World"))
