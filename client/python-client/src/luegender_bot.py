from maexchen_bot import MaexchenBot, Nachrichten


class LuegenderBot(MaexchenBot):
    def reagiere_auf_nachricht(self, nachricht, parameter):

        if (nachricht == Nachrichten.DU_BIST_DRAN):
            token = parameter[-1]
            self.schicke_nachricht(Nachrichten.WUERFELN, [token])

        if (nachricht == Nachrichten.GEWUERFELT):
            token = parameter[-1]
            self.schicke_nachricht(Nachrichten.ANSAGEN, ['6,6', token])


if __name__ == "__main__":
    bot = LuegenderBot(server_ip="127.0.0.1", name="luegender-python-bot")
    bot.starte(automatisch_mitspielen=True)
