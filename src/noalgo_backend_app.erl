-module(noalgo_backend_app).
-behaviour(application).
-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    ets:new(businesses, [named_table, set, public]),
    ets:new(deals, [named_table, set, public]),
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/api/deals", deal_handler, []},
            {"/api/business", business_handler, []}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(http, [{port, 8080}], #{env => #{dispatch => Dispatch}}),
    noalgo_backend_sup:start_link().

stop(_State) -> ok.
