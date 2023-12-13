-module(lesson3_task4).
-export([decode/2]).

decode(Json, proplist) ->
    decode_proplist(jsx:json_to_term(Json));
decode(Json, map) ->
    decode_map(jsx:json_to_term(Json)).

decode_proplist({ObjType, Pairs}) when is_atom(ObjType), ObjType == object ->
    lists:map(fun({Key, Val}) -> {atom_to_list(Key), decode_proplist_val(Val)} end, Pairs);
decode_proplist(Array) when is_list(Array) ->
    lists:map(fun(Val) -> decode_proplist_val(Val) end, Array).

decode_proplist_val({ObjType, Pairs}) when is_atom(ObjType), ObjType == object ->
    decode_proplist({ObjType, Pairs});
decode_proplist_val(Array) when is_list(Array) ->
    decode_proplist(Array);
decode_proplist_val(Value) ->
    Value.

decode_map({ObjType, Pairs}) when is_atom(ObjType), ObjType == object ->
    maps:from_list(lists:map(fun({Key, Val}) -> {Key, decode_map_val(Val)} end, Pairs));
decode_map(Array) when is_list(Array) ->
    lists:map(fun(Val) -> decode_map_val(Val) end, Array).

decode_map_val({ObjType, Pairs}) when is_atom(ObjType), ObjType == object ->
    decode_map({ObjType, Pairs});
decode_map_val(Array) when is_list(Array) ->
    decode_map(Array);
decode_map_val(Value) ->
    Value.