capbash
=======

A simple infrastructure tool that uses capistrano and bash to manage remote servers.

This project is meant to change very little, and delegates most of its work to a bootstrap project, shown below:
https://github.com/aforward/capbash-bootstrap

This allows you to clone the project, make it your own and still stay up on the current version.

# How to Install #

You will want to clone the project, and then bootstrap it.

```
git clone https://github.com/aforward/capbash YOUR_REPO_ROOT
cd YOUR_REPO_ROOT
./bootstrap
```

# Deploy to Remote Server #

If working on a local VM, you might need to install SSH before you can bootstrap it.

```
apt-get install openssh-server openssh-client
```

To push the helloworld script to your server, all you need if the IP or hostname of your server (e.g. 192.167.0.48) and your root password.

```
./capbash deploy <IP>
```

For example,

```
./capbash deploy 127.0.0.1
```

# Adding Submodules #

Install scripts are written in bash, and can be added to your project. First you will want to list our available submodules.

```
./capbash ls
```

Now, you can install any submodule, e.g. docker

```
./capbash install docker
```

We are working on more submodules, as well as a registry to support third party modules.

# How to update capbash and all submodules #

This is pull all submodules, including capbash itself.

```
./capbash update
```
