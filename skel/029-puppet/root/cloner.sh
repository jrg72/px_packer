 (test -d /etc/unity && (cd /etc/unity && git fetch && git reset --hard origin/develop)) || git clone https://09d7c5b9789423e5585e35b735e2149ce8c605da@github.com/pwnieexpress/puppet_infrastructure -b develop /etc/unity
