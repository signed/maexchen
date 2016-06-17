import socket


class UdpKommunikator:
    def __init__(self, server_ip, server_port):
        self.server_port = server_port
        self.server_ip = server_ip
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    def sende_nachricht(self, kommando, parameter):
        nachricht = kommando + ";" + ";".join(parameter)
        self.sock.sendto(nachricht.encode('utf-8'), (self.server_ip, self.server_port))

    def warte_auf_data(self):
        data, addr = self.sock.recvfrom(1024)
        return data.decode('utf-8')

    def warte_auf_nachricht(self):
        data = self.warte_auf_data()
        if data is None:
            return (None, None)
        nachrichtenteile = data.split(";")
        return (nachrichtenteile[0], nachrichtenteile[1:])

    def server_adresse(self):
        return self.server_ip + ":" + str(self.server_port)

    def close(self):
        return self.sock.close()
