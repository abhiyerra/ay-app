FROM boxcar/raring

RUN apt-get update
RUN apt-get install -y emacs24-nox git

RUN mkdir /webapp
RUN echo "hi" > /webapp/index.html

ADD . /ay-app

WORKDIR /ay-app

EXPOSE 8010:8010

CMD ["-nw", "--batch", "-l", "/ay-app/ay-app.el"]
ENTRYPOINT ["/usr/bin/emacs"]

# /usr/bin/emacs -nw --daemon -q -l ay-app.el