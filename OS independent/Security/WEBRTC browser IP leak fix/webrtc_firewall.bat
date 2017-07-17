@echo off
::Run this as administrator!
::then visit https://diafygi.github.io/webrtc-ips/ to verify
::no more public IP leaking :-D
:: Original by https://github.com/stunner all credits goes to him 
netsh advfirewall firewall add rule name="No STUN leak for j00!" dir=out action=block protocol=UDP localport=3478
netsh advfirewall firewall add rule name="No STUN leak for j00!" dir=out action=block protocol=UDP remoteport=3478
netsh advfirewall firewall add rule name="No STUN leak for j00!" dir=in action=block protocol=UDP localport=3478
netsh advfirewall firewall add rule name="No STUN leak for j00!" dir=in action=block protocol=UDP remoteport=3478
netsh advfirewall firewall add rule name="No STUN leak for j00!" dir=out action=block protocol=UDP localport=19302
netsh advfirewall firewall add rule name="No STUN leak for j00!" dir=out action=block protocol=UDP remoteport=19302
netsh advfirewall firewall add rule name="No STUN leak for j00!" dir=in action=block protocol=UDP localport=19302
netsh advfirewall firewall add rule name="No STUN leak for j00!" dir=in action=block protocol=UDP remoteport=19302

