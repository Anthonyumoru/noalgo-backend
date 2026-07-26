-module(business_handler).
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
    Req1 = cowboy_req:set_resp_headers(Headers, Req0),

    case Method of
        <<"OPTIONS">> ->
            Req2 = cowboy_req:reply(204, #{}, <<>>, Req1),
            {ok, Req2, State};
        <<"GET">> ->
            Businesses = [
                #{id => 1, name => <<"Dominos Abuja">>, category => <<"Food">>},
                #{id => 2, name => <<"Cutting Edge Salon">>, category => <<"Beauty">>}
            ],
            Json = jsx:encode(Businesses),
            Req2 = cowboy_req:reply(200, #{}, Json, Req1),
            {ok, Req2, State};
        _ ->
            Req2 = cowboy_req:reply(405, #{}, <<"Method Not Allowed">>, Req1),
            {ok, Req2, State}
    end.
