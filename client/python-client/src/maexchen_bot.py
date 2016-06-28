import signal
import sys
import socket
import random
from threading import Timer

from udp_kommunikator import UdpKommunikator


def random_bot_name():
    return "python-bot-" + str(random.randint(100, 999))


class MaexchenBot:
    def __init__(self, server_ip="127.0.0.1", server_port=9000, name=random_bot_name()):
        self.name = name
        self.watcher = None
        signal.signal(signal.SIGINT, self.signal_handler)
        self.kommunikator = UdpKommunikator(server_ip=server_ip, server_port=server_port)

    def warte_auf_nachricht(self):
        try:
            (nachricht, parameter) = self.kommunikator.warte_auf_nachricht()
        except socket.error:
            print("Der Server", self.kommunikator.server_adresse(), "antwortet nicht. Bot wird beendet.")
            sys.exit(-1)

        print("<---- ", nachricht, parameter)
        return (nachricht, parameter)

    def starte(self, automatisch_mitspielen=True, beobachte_herzschlag=True):
        if beobachte_herzschlag:
            self.restart_heartbeat_watcher()
        self.melde_dich_an(automatisch_mitspielen, beobachte_herzschlag)

    def restart_heartbeat_watcher(self):
        if self.watcher is not None:
            self.watcher.cancel()
        self.watcher = Timer(5.0, self.kein_server_herzschlag_mehr)
        self.watcher.start()

    def kein_server_herzschlag_mehr(self):
        self.kommunikator.close()

    def melde_dich_an(self, automatisch_mitspielen, beobachte_herzschlag):
        self.schicke_nachricht(Nachrichten.ANMELDEN, [self.name])
        (antwort, parameter) = self.warte_auf_nachricht()
        if (antwort == Nachrichten.ANGEMELDET):
            self.starte_spiel(automatisch_mitspielen, beobachte_herzschlag)
        else:
            print("Ich konnte mich nicht registrieren.", "Grund: " + antwort + str(parameter))

    def schicke_nachricht(self, nachricht, parameter=[]):
        print("----> ", nachricht, parameter)
        self.kommunikator.sende_nachricht(nachricht, parameter)

    def starte_spiel(self, automatisch_mitspielen, handle_heartbeat):
        while (True):
            nachricht, parameter = self.warte_auf_nachricht()
            if handle_heartbeat and nachricht == Nachrichten.SERVER_HERZSCHLAG:
                self.restart_heartbeat_watcher()
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
        self.schicke_nachricht(Nachrichten.ABMELDEN)

    def zerlege_wuerfel(self, wuerfel_string):
        list_of_wuerfel = wuerfel_string.split(',')
        return [int(augen) for augen in list_of_wuerfel]

    def fuege_wuerfel_zusammen(self, wuerfel):
        gewuerfelte_augen_als_strings = [str(wuerfel) for wuerfel in wuerfel]
        return ','.join(gewuerfelte_augen_als_strings)

    def ist_hoeher(self, wuerfel_1, wuerfel_2):
        if self.ist_maexchen(wuerfel_1):
            return True
        if self.ist_maexchen(wuerfel_2):
            return False

        if self.ist_pasch(wuerfel_1):
            if not self.ist_pasch(wuerfel_2):
                return True
        if self.ist_pasch(wuerfel_2):
            if not self.ist_pasch(wuerfel_1):
                return False

        return wuerfel_1 > wuerfel_2

    def ist_maexchen(self, wuerfel):
        return wuerfel == [2, 1]

    def ist_pasch(self, wuerfel):
        return wuerfel[0] == wuerfel[1]


class Nachrichten:
    ANMELDEN = "REGISTER"
    ANGEMELDET = "REGISTERED"
    ABMELDEN = "UNREGISTER"
    ABGEMELDET = "UNREGISTERED"

    NEUE_RUNDE = "ROUND STARTING"
    ICH_MACHE_MIT = "JOIN"
    DU_BIST_DRAN = "YOUR TURN"
    WUERFELN = "ROLL"
    GEWUERFELT = "ROLLED"
    ANSAGEN = "ANNOUNCE"
    SCHAUEN = "SEE"
    SPIELER_WUERFELT = "PLAYER ROLLS"
    SPIELER_SAGT_AN = "ANNOUNCED"
    SPIELER_VERLIERT = "PLAYER LOST"
    SPIELSTAND = "SCORE"

    SERVER_HERZSCHLAG = "HEARTBEAT"
