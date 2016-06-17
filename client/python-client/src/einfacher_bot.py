from maexchen_bot import MaexchenBot, Nachrichten


class EinfacherBot(MaexchenBot):
    def reagiere_auf_nachricht(self, nachricht, parameter):

        if (nachricht == Nachrichten.DU_BIST_DRAN):
            token = parameter[-1]
            self.schicke_nachricht(Nachrichten.WUERFELN, [token])

        if (nachricht == Nachrichten.GEWUERFELT):
            gewuerfelte_augen = parameter[0]
            token = parameter[-1]
            self.schicke_nachricht(Nachrichten.ANSAGEN, [gewuerfelte_augen, token])


if __name__ == "__main__":
    bot = EinfacherBot(server_ip="127.0.0.1", name="simple-python-bot")
    bot.starte(automatisch_mitspielen=True)
