FROM ubuntu

RUN apt-get update
RUN apt-get install emacs24-nox
RUN apt-get install git

RUN mkdir /ay-site

WORKDIR /ay-site

RUN git clone git://orgmode.org/org-mode.git
RUN git clone git@github.com:nicferrier/elnode.git

EXPOSE 8080

# CMD emacs --batch foo.c -l hack-c -f save-buffer >& log
