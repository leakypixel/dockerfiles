FROM elixir AS build
# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force
RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get update && \
    apt-get install -y \
        nodejs \
        gcc \
        g++ \
        make \
        inotify-tools
FROM build
WORKDIR "/usr/src/app"
ENTRYPOINT ["bash", "-c"]
CMD ["/usr/src/app/start.sh"]
