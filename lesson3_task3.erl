-module(lesson3_task3).
-export([split/2]).

split(BinText, Delimiter) ->
    split(binary_to_list(BinText), Delimiter, []).

split([], _Delimiter, Acc) ->
    lists:reverse(Acc);
split(List, Delimiter, Acc) ->
    case starts_with_delimiter(List, Delimiter) of
        true ->
            split(drop_delimiter(List, Delimiter), Delimiter, Acc);
        false ->
            case extract_part(List, Delimiter) of
                {Part, Rest} ->
                    split(Rest, Delimiter, [Part | Acc])
            end
    end.

starts_with_delimiter(_, []) ->
    true;
starts_with_delimiter([], _Delimiter) ->
    false;
starts_with_delimiter([H | T], [DH | DT]) ->
    H =:= DH andalso starts_with_delimiter(T, DT).

drop_delimiter([], _Delimiter) -> [];
drop_delimiter(List, Delimiter) ->
    case starts_with_delimiter(List, Delimiter) of
        true ->
            drop_delimiter(tail(List, length(Delimiter)), Delimiter);
        false ->
            List
    end.

extract_part([], _Delimiter) ->
    {[], []};
extract_part(List, Delimiter) ->
    case starts_with_delimiter(List, Delimiter) of
        true ->
            {[], drop_delimiter(List, Delimiter)};
        false ->
            {First, Rest} = extract_part(tail(List, 1), Delimiter),
            {[hd(List) | First], Rest}
    end.

tail(List, Count) ->
    lists:nthtail(Count, List).