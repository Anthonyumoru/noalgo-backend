-module(business).
-export([create_business/4, get_business/1]).

create_business(Name, Category, Area, City) ->
    BusinessId = erlang:unique_integer([positive]),
    Business = #{id => BusinessId, name => Name, category => Category, area => Area, city => City},
    ets:insert(businesses, {BusinessId, Business}),
    {ok, BusinessId}.

get_business(BusinessId) ->
    case ets:lookup(businesses, BusinessId) of
        [{_, Business}] -> {ok, Business};
        [] -> {error, not_found}
    end.
