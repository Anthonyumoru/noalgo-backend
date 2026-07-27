-module(noalgo_root_handler).
-behaviour(cowboy_handler).

-export([init/2]).

init(Req0, State) ->
    Req = cowboy_req:reply(200,
        #{
            <<"content-type">> => <<"application/json">>,
            <<"access-control-allow-origin">> => <<"*">>, %% Allows Netlify to connect
            <<"access-control-allow-methods">> => <<"GET, POST, OPTIONS">>
        },
        <<"{\"status\": \"healthy\", \"text\": \"NOALGO Backend is running!\"}">>,
        Req0),
    {ok, Req, State}.
