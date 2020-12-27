# docker run -t -i -v $(pwd)/student0:/home/student0 cs162b /bin/bash
FROM alpine

COPY ./student0 /home/student0
COPY .bashrc /root/.bashrc
COPY vimrc /etc/vim/vimrc

WORKDIR /home/student0

RUN apk update &&  \
    apk upgrade && \
    addgroup student && adduser -D -G student notroot && \
    chown -R notroot:student /home  && \
    apk add --virtual build-dependencies && \
    apk add build-base && \
    apk add bash && \
    apk add curl && \
    apk add git  && \
    apk add gcc  && \
    apk add gdb  && \
    apk add vim

USER notroot

CMD ["bash", "-l"]

