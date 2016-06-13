from maexchen_bot import Maexchen_Bot


class Einfacher_Bot(Maexchen_Bot):
    def __init__(self, name, server_ip):
        super().__init__(server_ip=server_ip)
        self.name = name

    def starte(self):
        self.registriere_mich(self.name)
        (kommando, parameter) = self.warte_auf_kommando()
        if (kommando == "REGISTERED"):
            self.erwarte_spiel_kommandos()
        else:
            print("Ich konnte mich nicht registrieren.", "Grund: " + kommando + str(parameter))

    def reagiere_auf_kommando(self, kommando, parameter):
        print("Kommando empfangen: " + kommando, parameter)


if __name__ == "__main__":
    bot = Einfacher_Bot(name="simple-bot", server_ip="127.0.0.1")
    bot.starte()
