-module(noalgo_backend_app).
-behaviour(application).
-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    ets:new(businesses, [named_table, set, public]),
    ets:new(follows, [named_table, set, public]),
    ets:new(messages, [named_table, bag, public]),
    ets:new(deals, [named_table, set, public]),
    noalgo_backend_sup:start_link().

stop(_State) -> ok.
