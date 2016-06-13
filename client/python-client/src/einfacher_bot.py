from maexchen_bot import Maexchen_Bot, Nachrichten


class Einfacher_Bot(Maexchen_Bot):
    def __init__(self, name, server_ip):
        super().__init__(server_ip=server_ip)
        self.name = name

    def starte(self):
        (antwort, parameter) = self.registriere_mich(self.name)
        if (antwort == Nachrichten.REGISTRIERT):
            self.starte_spiel()
        else:
            print("Ich konnte mich nicht registrieren.", "Grund: " + antwort + str(parameter))

    def reagiere_auf_kommando(self, nachricht, parameter):
        print("Nachricht empfangen:", nachricht, parameter)

        if (nachricht == Nachrichten.NEUE_RUNDE):
            token = parameter[-1]
            self.schicke_nachricht(Nachrichten.ICH_MACHE_MIT, [token])

        if (nachricht == Nachrichten.DU_BIST_DRAN):
            token = parameter[-1]
            self.schicke_nachricht(Nachrichten.WUERFELN, [token])

        if (nachricht == Nachrichten.GEWUERFELT):
            augen = parameter[0]
            token = parameter[-1]
            self.schicke_nachricht(Nachrichten.ANSAGEN, [augen, token])

if __name__ == "__main__":
    bot = Einfacher_Bot(name="simple-python-bot", server_ip="127.0.0.1")
    bot.starte()
