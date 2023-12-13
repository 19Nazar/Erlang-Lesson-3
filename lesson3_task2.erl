-module(lesson3_task2).
-export([words/1]).

words(BinText) ->
    words(binary_to_list(BinText), []).

words([], Acc) ->
    lists:reverse(Acc);
words([H | T], Acc) when H =/= $  ->
    {Word, Rest} = extract_word([H | T], []),
    words(Rest, [Word | Acc]);
words([_H | T], Acc) ->
    words(T, Acc).

extract_word([], Acc) ->
    {list_to_binary(lists:reverse(Acc)), []};
extract_word([$  | T], Acc) ->
    {list_to_binary(lists:reverse(Acc)), T};
extract_word([H | T], Acc) ->
    extract_word(T, [H | Acc]).