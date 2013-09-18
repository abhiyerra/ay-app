FROM ubuntu/latest

RUN apt-get update
RUN apt-get install emacs24-nox
RUN apt-get install git

RUN mkdir /ay-app

WORKDIR /ay-app

RUN git clone git://orgmode.org/org-mode.git
RUN git clone git@github.com:nicferrier/elnode.git

EXPOSE 8080

# ENTRYPOINT emacs --batch foo.c -l hack-c -f save-buffer >& log
