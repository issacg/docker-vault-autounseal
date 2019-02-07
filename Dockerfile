FROM vault
MAINTAINER margol@beamartyr.net

COPY unseal.sh  /usr/local/bin/unseal.sh

ENTRYPOINT ["unseal.sh"]
CMD ["server", "-dev"]

