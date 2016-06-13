from udp_kommunikator import UDP_Kommunikator


class Maexchen_Bot:
    def __init__(self, server_ip="127.0.0.1", server_port=9000):
        self.kommunikator = UDP_Kommunikator(server_ip=server_ip, server_port=server_port)

    def warte_auf_nachricht(self):
        return self.kommunikator.warte_auf_kommando()

    def schicke_nachricht(self, nachricht, parameter):
        print("Nachricht geschickt:", nachricht, parameter)
        self.kommunikator.sende_kommando(nachricht, parameter)

    def starte_spiel(self):
        while (True):
            kommando, parameter = self.warte_auf_nachricht()
            self.reagiere_auf_kommando(kommando, parameter)

    def reagiere_auf_kommando(self, kommando, parameter):
        pass

    def registriere_mich(self, name):
        self.kommunikator.sende_kommando(Nachrichten.REGISTRIEREN, [name])
        return self.warte_auf_nachricht()


class Nachrichten:
    REGISTRIEREN = "REGISTER"
    REGISTRIERT = "REGISTERED"
    NEUE_RUNDE = "ROUND STARTING"
    ICH_MACHE_MIT = "JOIN"
    DU_BIST_DRAN = "YOUR TURN"
    WUERFELN = "ROLL"
    GEWUERFELT = "ROLLED"
    ANSAGEN = "ANNOUNCE"
    SCHAUEN = "SEE"
