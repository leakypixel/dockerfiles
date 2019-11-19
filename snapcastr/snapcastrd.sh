cd /root/snapcastr/
sed -i "s/server_addr='innocence'/server_addr='$SNAPCAST_HOST'/g" snapcastr/snapcastr.py
PYTHONPATH=. python ./bin/snapcastrd --bind=0.0.0.0 --port=5011
