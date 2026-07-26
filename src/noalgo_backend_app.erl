-module(noalgo_backend_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    % 1. GET PORT from internet, or use 8080 locally
    Port = case os:getenv("PORT") of
        false -> 8080;
        PortStr -> list_to_integer(PortStr)
    end,

    % 2. SET UP ROUTES
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/api/deals", deal_handler, []},
            {"/api/businesses", business_handler, []}
        ]}
    ]),

    % 3. START COWBOY SERVER
    {ok, _} = cowboy:start_clear(http,
        [{port, Port}],
        #{env => #{dispatch => Dispatch}}
    ),

    io:format("NOALGO Backend running on port ~p~n", [Port]),
    noalgo_backend_sup:start_link().

stop(_State) ->
    ok.
