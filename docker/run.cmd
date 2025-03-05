@echo off

docker run -dt ^
    -p 30000:30000 ^
    -v %cd%/../.docker/db:/zeus/var/db ^
    -v %cd%/../.docker/log:/zeus/log ^
    --name zeus ^
    zeus
