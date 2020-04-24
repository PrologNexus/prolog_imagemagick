:- use_module(library(plunit)).

:- use_module(library(imagemagick)).

:- begin_tests(imagemagick).

test(is_image) :-
  is_image('test/triply.png').

:- end_tests(imagemagick).
