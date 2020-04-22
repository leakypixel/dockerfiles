FROM archlinux
# Following taken from https://github.com/oblique/dockerfiles/blob/f993083f640dcebaa07132e77ad10bc6d36f22e2/archlinux-yay/Dockerfile#L3
# but not using for a base image so we can benefit from auto builds as base
# archlinux is pushed.
RUN echo '[multilib]' >> /etc/pacman.conf && \
    echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf && \
    pacman --noconfirm -Syyu && \
    pacman --noconfirm -S mopidy python-pip base-devel git && \
    useradd -m -r -s /bin/bash aur && \
    passwd -d aur && \
    echo 'aur ALL=(ALL) ALL' > /etc/sudoers.d/aur && \
    mkdir -p /home/aur/.gnupg && \
    echo 'standard-resolver' > /home/aur/.gnupg/dirmngr.conf && \
    chown -R aur:aur /home/aur && \
    mkdir /build && \
    chown -R aur:aur /build && \
    cd /build && \
    sudo -u aur git clone --depth 1 https://aur.archlinux.org/yay.git && \
    cd yay && \
    sudo -u aur makepkg --noconfirm -si && \
    sudo -u aur yay --afterclean --removemake --save && \
    pacman -Qtdq | xargs -r pacman --noconfirm -Rcns && \
    rm -rf /home/aur/.cache && \
    rm -rf /build
RUN sudo -u aur yay -S --noconfirm python-pyspotify
RUN pip install \
      Mopidy-Mobile \
      Mopidy-Podcast-iTunes \
      Mopidy-Podcast \
      Mopidy-GMusic \
      Mopidy-Moped \
      Mopidy-Iris \
      Mopidy-Spotify \
      Mopidy-Party \
      mopidy-musicbox-webclient \
      Mopidy-Local \
      Mopidy-MPD \
      Mopidy-Youtube
EXPOSE 6600 6680
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
