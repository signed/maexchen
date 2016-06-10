import socket

udp_ip = "127.0.0.1"
udp_port = 9000
message = "ECHO;Hello, World!"

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

print("Message sending:", message)

sock.sendto(message.encode('utf-8'), (udp_ip, udp_port))
data, addr = sock.recvfrom(1024)

print("Message received:", data.decode('utf-8'))
