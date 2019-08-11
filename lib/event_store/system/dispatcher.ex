defmodule EventStore.System.Dispatcher do
    def dispatch do
        [
            {:_,[
                {"/event/order/[...]", Plug.Cowboy.Handler, {EventStore.System.Routes, []}},
                {"/event/business/[...]", Plug.Cowboy.Handler, {EventStore.System.Business, []}},
                {"/business/ws", EventStore.System.BusinessSocket, []},
                {"/event/user/[...]", Plug.Cowboy.Handler, {EventStore.System.User, []}}
            ]}
        ]
    end
end