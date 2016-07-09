from maexchen_bot import MaexchenBot, Nachrichten


class EinfacherBot(MaexchenBot):
    def __init__(self):
        MaexchenBot.__init__(self)
        self.angesagt = ("")
        self.vorherangesagt = ("")
    def reagiere_auf_nachricht(self, nachricht, parameter):

        if (nachricht==Nachrichten.SPIELER_SAGT_AN):
            self.vorherangesagt=self.angesagt
            self.angesagt=nachricht
            print (self.angesagt)

        if (nachricht == Nachrichten.DU_BIST_DRAN):
            token = parameter[-1]
            self.schicke_nachricht(Nachrichten.WUERFELN, [token])

        if (nachricht == Nachrichten.GEWUERFELT):
            gewuerfelte_augen = parameter[0]
            token = parameter[-1]
            self.schicke_nachricht(Nachrichten.ANSAGEN, [gewuerfelte_augen, token])


if __name__ == "__main__":
    bot = EinfacherBot(server_ip="127.0.0.1", name="janneks_bot")
    bot.starte(automatisch_mitspielen=True)
