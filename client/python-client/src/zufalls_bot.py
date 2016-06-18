import random
from maexchen_bot import MaexchenBot, Nachrichten


class ZufallsBot(MaexchenBot):
    def reagiere_auf_nachricht(self, nachricht, parameter):

        if (nachricht == Nachrichten.DU_BIST_DRAN):
            token = parameter[-1]
            if random.random() < 0.8:
                self.schicke_nachricht(Nachrichten.WUERFELN, [token])
            else:
                self.schicke_nachricht(Nachrichten.SCHAUEN, [token])

        if (nachricht == Nachrichten.GEWUERFELT):
            gewuerfelte_augen = parameter[0]
            token = parameter[-1]
            self.schicke_nachricht(Nachrichten.ANSAGEN, [gewuerfelte_augen, token])


if __name__ == "__main__":
    bot = ZufallsBot(server_ip="127.0.0.1", name="random-python-bot")
    bot.starte(automatisch_mitspielen=True)
