-module(zeus_hub_app).

-behaviour(application).

%% Include files

%% Exported functions

-export([
    start/2,
    stop/1
]).

%% API

start(_StartType, _StartArgs) ->
    zeus_hub_sup:start_link().

stop(_State) ->
    ok.

%% Local functions
