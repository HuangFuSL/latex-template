FROM texlive/texlive:latest

# Install fonts
RUN sed -i 's/testing/stable/g' /etc/apt/sources.list \
    && echo "deb http://deb.debian.org/debian stable contrib" >> /etc/apt/sources.list \
    && apt update \
    && apt install ttf-mscorefonts-installer fonts-noto-cjk -y \
    && apt clean

COPY . /template
RUN chmod +x /template/entrypoint.sh
ENV TEXINPUTS=/template//:

VOLUME [ "/data" ]
WORKDIR /data
ENTRYPOINT [ "/template/entrypoint.sh" ]