-module(lesson3_task1).
-export([first_word/1]).

first_word(BinText) ->
  first_word(BinText, <<>>).

first_word(<<>>, Acc) ->
  Acc;
first_word(<<Word, Rest/binary>>, Acc) when Word < 32 ->
  case Acc of
    <<>> -> first_word(Rest, Acc);
    _ -> Acc
  end;
first_word(<<Word, Rest/binary>>, Acc) ->
  case Acc of
    <<>> -> first_word(Rest, <<Word>>);
    _ -> first_word(Rest, <<Acc/binary, Word>>)
  end.