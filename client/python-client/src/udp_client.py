import socket


class Maexchen_Client:
    def __init__(self, server_ip="127.0.0.1", server_port=9000):
        self.server_port = server_port
        self.server_ip = server_ip
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    def echo(self, nachricht):
        nachricht_kommando = "ECHO;" + nachricht
        return self.sende(nachricht_kommando)

    def beitreten(self,name):
        self.sende("REGISTER;"+name)
        if self.warte_auf_nachricht()=="ROUND STARTING;token":
            self.sende("JOIN;token")

    def warte_auf_nachricht(self):
        data, addr = self.sock.recvfrom(1024)
        return (data.decode('utf-8'))

    def sende(self,nachricht):
        self.sock.sendto(nachricht.encode('utf-8'), (self.server_ip, self.server_port))
        data, addr = self.sock.recvfrom(1024)
        return (data.decode('utf-8'))

    def würfeln(self):
        self.sende("ROLL;token")
        return self.warte_auf_nachricht()

    def ansagen(self,ansage):
        self.sende("ANNOUNCE;"+ansage+";token")

    def schauen(self):
        self.sende("SEE;token")

if __name__ == "__main__":
    normaler_client = Maexchen_Client(server_ip="127.0.0.1")

    print("Die Ausgabe:", normaler_client.echo("Hello World"))

    normaler_client.beitreten("Jannek")
    while True:
        print (normaler_client.warte_auf_nachricht())