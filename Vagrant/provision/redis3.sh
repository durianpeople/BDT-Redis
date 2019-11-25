sudo cp /vagrant/sources/hosts /etc/hosts
sudo cp '/vagrant/sources/sources.list' '/etc/apt/'

sudo apt update -y

sudo apt-get install build-essential tcl libjemalloc-dev -y

curl -O http://download.redis.io/redis-stable.tar.gz
tar xzvf redis-stable.tar.gz
cd redis-stable
make
# make test
sudo make install

sudo mkdir /etc/redis

sudo cp /vagrant/config/redis3.conf /etc/redis/redis.conf
sudo cp /vagrant/config/sentinel3.conf /etc/redis-sentinel.conf

sudo cp /vagrant/service/redis.service /etc/systemd/system/redis.service
sudo cp /vagrant/service/redis-sentinel.service /etc/systemd/system/redis-sentinel.service

sudo adduser --system --group --no-create-home redis
sudo mkdir /var/lib/redis
sudo chown redis:redis /var/lib/redis
sudo chmod 770 /var/lib/redis

sudo systemctl enable redis
sudo systemctl start redis

sudo chmod 777 /etc/redis-sentinel.conf
sudo systemctl enable redis-sentinel
sudo systemctl start redis-sentinel

sudo chmod -R 777 /etc/redis
sudo systemctl restart redis
