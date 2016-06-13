from udp_kommunikator import UDP_Kommunikator

class Maexchen_Bot:
    def __init__(self, server_ip="127.0.0.1", server_port=9000):
        self.kommunikator = UDP_Kommunikator(server_ip=server_ip, server_port=server_port)

    def warte_auf_kommando(self):
        return self.kommunikator.warte_auf_kommando()

    def erwarte_spiel_kommandos(self):
        while(True):
            kommando, parameter = self.warte_auf_kommando()
            self.reagiere_auf_kommando(kommando, parameter)

    def reagiere_auf_kommando(self, kommando, parameter):
        pass

    def registriere_mich(self, name):
        self.kommunikator.sende_kommando("REGISTER", [name])

    # def wuerfeln(self):
    #     self.sende_kommando("ROLL;token")
    #     return self.warte_auf_nachricht()
    #
    # def ansagen(self, ansage):
    #     self.sende_kommando("ANNOUNCE;" + ansage + ";token")
    #
    # def schauen(self):
    #     self.sende_kommando("SEE;token")

