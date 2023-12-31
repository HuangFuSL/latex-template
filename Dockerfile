FROM texlive/texlive:latest

# Install fonts
RUN echo "deb http://deb.debian.org/debian testing contrib" >> /etc/apt/sources.list \
    && echo "deb http://deb.debian.org/debian stable contrib" >> /etc/apt/sources.list \
    && apt update \
    && apt install ttf-mscorefonts-installer fonts-noto-cjk -y \
    && apt clean

COPY . /opt/template
ENV TEXINPUTS=/opt/template//:

VOLUME [ "/data" ]
WORKDIR /data
