FROM texlive/texlive:latest

# Install fonts
RUN sed -i 's/testing/stable/g' /etc/apt/sources.list \
    && echo "deb http://deb.debian.org/debian stable contrib" >> /etc/apt/sources.list \
    && apt update \
    && apt install ttf-mscorefonts-installer fonts-noto-cjk -y \
    && apt clean

COPY . /opt/template
RUN chmod +x /opt/template/entrypoint.sh
ENV TEXINPUTS=/opt/template//:

VOLUME [ "/data" ]
WORKDIR /data
ENTRYPOINT [ "/opt/template/entrypoint.sh" ]