from udp_client import Maexchen_Client

udp_ip = "127.0.0.1"
udp_port = 9000
message = "Hello, World!"

maexchen = Maexchen_Client(server_ip=udp_ip, server_port=udp_port)

answer = maexchen.echo(message)

print("Message received:", answer)
