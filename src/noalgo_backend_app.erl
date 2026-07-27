-module(noalgo_backend_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    {ok, _} = application:ensure_all_started(cowboy),

    %% Safe port extraction for Render's environment variables
    Port = case os:getenv("PORT") of
        false -> 10000;
        "" -> 10000;
        PortStr -> erlang:list_to_integer(PortStr)
    end,

    Dispatch = cowboy_router:compile([
        {'_', [
            {"/api/deals", deal_handler, []},
            {"/api/businesses", business_handler, []}
        ]}
    ]),

    {ok, _} = cowboy:start_clear(http,
        [{port, Port}, {ip, {0, 0, 0, 0}}],
        #{env => #{dispatch => Dispatch}}
    ),

    io:format("NOALGO Backend running on port ~p~n", [Port]),
    noalgo_backend_sup:start_link().

stop(_State) ->
    ok.
