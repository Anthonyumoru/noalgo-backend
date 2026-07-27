-module(deal_handler).
-behaviour(cowboy_handler).

-export([init/2]).

init(Req0, State) ->
    Method = cowboy_req:method(Req0),

    Headers = #{
        <<"access-control-allow-origin">> => <<"*">>,
        <<"access-control-allow-methods">> => <<"GET, OPTIONS">>,
        <<"access-control-allow-headers">> => <<"content-type">>,
        <<"content-type">> => <<"application/json">>
    },

    case Method of
        <<"OPTIONS">> ->
            Req2 = cowboy_req:reply(204, Headers, <<>>, Req0),
            {ok, Req2, State};
        <<"GET">> ->
            Deals = [
                #{id => 1, title => <<"50% off Pizza">>, discount => 50, price => 2500, expires_at => <<"2026-08-01">>},
                #{id => 2, title => <<"Buy 1 Get 1 Free Haircut">>, discount => 50, price => 2000, expires_at => <<"2026-08-05">>}
            ],
            Json = jsx:encode(Deals),
            Req2 = cowboy_req:reply(200, Headers, Json, Req0),
            {ok, Req2, State};
        _ ->
            Req2 = cowboy_req:reply(405, Headers, <<"Method Not Allowed">>, Req0),
            {ok, Req2, State}
    end.
