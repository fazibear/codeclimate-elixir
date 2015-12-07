FROM ubuntu:15.10

MAINTAINER Michał Kalbarczyk

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo "deb http://packages.erlang-solutions.com/ubuntu trusty contrib" >> /etc/apt/sources.list
RUN apt-key adv --fetch-keys http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc
RUN apt-get -qq update
RUN apt-get install -y git unzip
RUN apt-get install -y erlang=1:18.1
RUN apt-get install -y elixir=1.1.1-2
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN adduser --uid 9000 app

WORKDIR /usr/src/app
RUN chown app:app /usr/src/app

USER app

RUN mix local.hex --force

COPY . /usr/src/app

RUN mix deps.get
RUN mix compile

CMD ["mix", "codeclimate", "/code"]
