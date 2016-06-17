import signal
import sys
import socket
import random

from udp_kommunikator import UDP_Kommunikator


def random_bot_name():
    return "python-bot-" + str(random.randint(100, 999))


class Maexchen_Bot:

    def __init__(self, server_ip="127.0.0.1", server_port=9000, name=random_bot_name()):
        self.name = name
        signal.signal(signal.SIGINT, self.signal_handler)
        self.kommunikator = UDP_Kommunikator(server_ip=server_ip, server_port=server_port)

    def warte_auf_nachricht(self):
        try:
            (nachricht, parameter) = self.kommunikator.warte_auf_nachricht()
            print("<---- ", nachricht, parameter)
            return (nachricht, parameter)
        except socket.timeout:
            print("Der Server", self.kommunikator.server_adresse(), "reagiert nicht. Bot wird beendet.")
            self.reagiere_auf_stopp()
            sys.exit()

    def starte(self, automatisch_mitspielen=True):
        self.schicke_nachricht(Nachrichten.ANMELDEN, [self.name])
        (antwort, parameter) = self.warte_auf_nachricht()
        if (antwort == Nachrichten.ANGEMELDET):
            self.starte_spiel(automatisch_mitspielen)
        else:
            print("Ich konnte mich nicht registrieren.", "Grund: " + antwort + str(parameter))

    def schicke_nachricht(self, nachricht, parameter):
        print("----> ", nachricht, parameter)
        self.kommunikator.sende_nachricht(nachricht, parameter)

    def starte_spiel(self, automatisch_mitspielen=True):
        while (True):
            nachricht, parameter = self.warte_auf_nachricht()
            if automatisch_mitspielen:
                if (nachricht == Nachrichten.NEUE_RUNDE):
                    token = parameter[-1]
                    self.schicke_nachricht(Nachrichten.ICH_MACHE_MIT, [token])
                else:
                    self.reagiere_auf_nachricht(nachricht, parameter)
            else:
                self.reagiere_auf_nachricht(nachricht, parameter)

    def reagiere_auf_nachricht(self, kommando, parameter):
        pass

    def signal_handler(self, signal, frame):
        self.reagiere_auf_stopp()
        sys.exit()

    def reagiere_auf_stopp(self):
        self.schicke_nachricht(Nachrichten.ABMELDEN, [self.name])


class Nachrichten:
    ANMELDEN = "REGISTER"
    ANGEMELDET = "REGISTERED"
    NEUE_RUNDE = "ROUND STARTING"
    ICH_MACHE_MIT = "JOIN"
    DU_BIST_DRAN = "YOUR TURN"
    WUERFELN = "ROLL"
    GEWUERFELT = "ROLLED"
    ANSAGEN = "ANNOUNCE"
    SCHAUEN = "SEE"
    ABMELDEN = "UNREGISTER"
    SPIELER_WUERFELT = "PLAYER ROLLS"
    SPIELER_SAGT_AN ="ANNOUNCED"
    SPIELER_VERLIERT ="PLAYER LOST"
    SPIELSTAND = "SCORE"
