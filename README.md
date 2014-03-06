# dhcomposer

shell script to automate Composer install on shared DreamHost account

## installation

1. ssh into your account and clone dhcomposer repository:

   ````
   git clone https://github.com/kminek/dhcomposer
   ````

2. run the script:

   ````
   cd dhcomposer
   chmod u+x dhcomposer.sh
   source dhcomposer.sh
   ````

3. verify Composer install:

   ````
   composer --version
   ````

4. enjoy

## credits

- [Installing Composer on Dreamhost | Geekality](http://www.geekality.net/2013/02/01/dreamhost-composer/)
- [Installing Composer on a shared Dreamhost Server](https://github.com/Braunson/dreamhost-composer-install)
