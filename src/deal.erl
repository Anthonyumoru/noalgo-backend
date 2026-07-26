-module(deal).
-export([create_deal/5, get_deals_by_business/1, get_active_deals/0]).

create_deal(BusinessId, Title, Discount, Price, Expires) ->
    DealId = erlang:unique_integer([positive]),
    Deal = #{id => DealId, business_id => BusinessId, title => Title, discount => Discount, price => Price, expires => Expires, created_at => erlang:system_time(second)},
    ets:insert(deals, {DealId, Deal}),
    {ok, DealId}.

get_deals_by_business(BusinessId) ->
    All = ets:tab2list(deals),
    [Deal || {_, Deal} <- All, maps:get(business_id, Deal) =:= BusinessId].

get_active_deals() ->
    Now = erlang:system_time(second),
    All = ets:tab2list(deals),
    [Deal || {_, Deal} <- All, maps:get(expires, Deal) > Now].
