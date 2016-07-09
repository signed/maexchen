import random
from maexchen_bot import MaexchenBot, Nachrichten


class RationalerBot(MaexchenBot):
    def __init__(self):
        MaexchenBot.__init__(self)
        self.angesagte_wuerfelzahl=[]

    def reagiere_auf_nachricht(self, nachricht, parameter):

        if (nachricht == Nachrichten.NEUE_RUNDE):
            self.angesagte_wuerfelzahl = [1, 0] # Niedrigster Würfelwert

        if (nachricht == Nachrichten.SPIELER_SAGT_AN):
            self.angesagte_wuerfelzahl = self.zerlege_wuerfel_string(parameter[-1])

        if (nachricht == Nachrichten.DU_BIST_DRAN):
            token = parameter[-1]
            erwartungswert_wuerfel = [5, 4]
            if self.ist_hoeher(self.angesagte_wuerfelzahl, erwartungswert_wuerfel):
                self.schicke_nachricht(Nachrichten.SCHAUEN, [token])
            else:
                self.schicke_nachricht(Nachrichten.WUERFELN, [token])

        if (nachricht == Nachrichten.GEWUERFELT):
            token = parameter[-1]
            gewuerfelte_augen = self.zerlege_wuerfel_string(parameter[0])
            if self.ist_hoeher(gewuerfelte_augen, self.angesagte_wuerfelzahl):
                self.sage_an(gewuerfelte_augen, token)
            else:
                self.luege(token)

    def luege(self, token):
        gelogenen_augen = self.hoeher_als_angesagt()
        self.sage_an(gelogenen_augen, token)

    def sage_an(self, gewuerfelte_augen, token):
        self.schicke_nachricht(Nachrichten.ANSAGEN, [self.fuege_wuerfel_zusammen(gewuerfelte_augen), token])

    def hoeher_als_angesagt(self):
        if self.ist_pasch(self.angesagte_wuerfelzahl):
            if self.angesagte_wuerfelzahl == [6, 6]:
                return [2, 1]
            else:
                return [wuerfel + 1 for wuerfel in self.angesagte_wuerfelzahl]
        else:
            return [1, 1]


if __name__ == "__main__":
    bot = RationalerBot(server_ip="127.0.0.1", name="rational-python-bot")
    bot.starte(automatisch_mitspielen=True)
