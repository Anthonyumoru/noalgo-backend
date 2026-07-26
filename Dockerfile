FROM erlang:25

WORKDIR /app
COPY .

RUN rebar3 release

EXPOSE 4000
CMD ["_build/default/rel/noalgo_backend/bin/noalgo_backend", "foreground"]
