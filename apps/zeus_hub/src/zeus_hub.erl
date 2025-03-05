-module(zeus_hub).

%% Include files

%% Exported functions

-export([
    start/0,
    stop/0
]).

-define(app, zeus_hub).

%% API

-spec start() -> 'ok' | {'error', Reason::term()}.

start() ->
    aplib:start_app_recursive(?app).

-spec stop() -> 'ok'.

stop() ->
    application:stop(?app).

%% Local functions
