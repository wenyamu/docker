echo "one,two,three,four" | awk -F ',' '{print $NF}'


echo $(dpkg --print-architecture) | awk -F '-' '{print $NF}'


docker build --build-arg VERSION=0.58.1 --build-arg ARCH=amd64 --build-arg APP=frps -t ddd:123 .