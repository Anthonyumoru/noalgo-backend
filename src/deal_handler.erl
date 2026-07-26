-module(deal_handler).
-behaviour(cowboy_handler).
-export([init/2]).

init(Req, State) ->
    Method = cowboy_req:method(Req),
    case Method of
        <<"GET">> -> get_deals(Req, State);
        <<"POST">> -> create_deal(Req, State)
    end.

get_deals(Req, State) ->
    Deals = deal:get_active_deals(),
    Body = jsx:encode(Deals),
    Req2 = cowboy_req:reply(200, #{<<"content-type">> => <<"application/json">>}, Body, Req),
    {ok, Req2, State}.

create_deal(Req, State) ->
    {ok, Body, Req2} = cowboy_req:read_body(Req),
    Data = jsx:decode(Body, [return_maps]),
    BId = maps:get(<<"business_id">>, Data),
    Title = maps:get(<<"title">>, Data),
    Disc = maps:get(<<"discount">>, Data),
    Price = maps:get(<<"price">>, Data),
    Exp = maps:get(<<"expires_at">>, Data),
    {ok, DealId} = deal:create_deal(BId, Title, Disc, Price, Exp),
    Resp = jsx:encode(#{status => ok, deal_id => DealId}),
    Req3 = cowboy_req:reply(201, #{<<"content-type">> => <<"application/json">>}, Resp, Req2),
    {ok, Req3, State}.
