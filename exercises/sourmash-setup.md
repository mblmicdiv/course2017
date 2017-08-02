# Spinning up multiple Jupyter Notebooks on AWS for a tutorial

(Setup instructions for [the sourmash tutorial](sourmash.md))

boot an `ubuntu/images-testing/hvm-ssd/ubuntu-yakkety-daily-amd64-server-20170201 (ami-008dd060)` image, with a ~50 GB local disk and with open ports 8000-9000.

Then, update software:

```
sudo apt-get -y update
```

and install docker:

```
wget -qO- https://get.docker.com/ | sudo sh
```

Also yourself to the `docker` group:

```
sudo usermod -aG docker ubuntu
```

and now log out and log back in.

----

Next, create a dockerfile that builds on `jupyter/datascience-notebook` to install the stuff that I want in my custom environment:

```
cd ~/
mkdir sourmash-nb
cd sourmash-nb
cat > Dockerfile <<EOF
FROM jupyter/datascience-notebook

RUN pip install -U https://github.com/dib-lab/sourmash/archive/master.zip
EOF
```

and run `docker build`:

```
docker build -t sourmash-nb .
```

While that's running, you can also download the sourmash database:

```
mkdir ~/sourmash-db
cd ~/sourmash-db
curl -O https://s3-us-west-1.amazonaws.com/spacegraphcats.ucdavis.edu/microbe-genbank-sbt-k31-2017.05.09.tar.gz
tar xzf microbe-genbank-sbt-k31-2017.05.09.tar.gz
```

----

Now run the notebook on port 8000, linking the large database into the container file system space as `/data/genbank` (and making it read-only) --
```
EXT=8000
docker run -d -v ~/sourmash-db:/data/genbank:ro -p ${EXT}:8888 sourmash-nb start-notebook.sh \
    --NotebookApp.password='sha1:5d813e5d59a7:b4e430cf6dbd1aad04838c6e9cf684f4d76e245c'
```

Voila, you should now be able to connect to port 8000!

To run more than one, use a for loop:

```
for EXT in 8000 8001 8002
do
docker run ...
done
```

See the [jupyter/datascience-notebook](https://hub.docker.com/r/jupyter/datascience-notebook/) docs for more info on command line arguments to the container.

To kill the docker container, locate its ID and use `docker kill <id>`.  (The ID is output by `docker run` when `-d` is used.) If you're running only one container, you can also replace `-d` with `-it` and it will run in interactive mode where you can use CTRL-C to quit out of it.
