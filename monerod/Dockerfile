FROM alekzonder/archlinux-yaourt:latest AS build

USER yaourt
RUN yaourt -S monero-bin --noconfirm --needed &&\
	yaourt -Scc --noconfirm &&\
	yaourt -Rns --noconfirm $(yaourt -Qttdq);\
	exit 0
FROM build
ENTRYPOINT ["/usr/bin/monerod", "--non-interactive"]

