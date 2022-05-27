FROM advantechiiot/imx-yocto-sdk:latest

COPY . /src/
WORKDIR /src
ENTRYPOINT ["/sdk_setenv.sh"]