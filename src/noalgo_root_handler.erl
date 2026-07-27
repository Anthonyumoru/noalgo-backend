-module(noalgo_root_handler).
-behaviour(cowboy_handler).

-export([init/2]).

init(Req0, State) ->
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"application/json">>},
        <<"{\"status\": \"healthy\", \"text\": \"NOALGO Backend is running!\"}">>,
        Req0),
    {ok, Req, State}.
