defmodule Mock do
    defmacro defaults do
        quote do
            alias EventStore.System.User.User
            alias EventStore.System.User.State
            alias EventStore.Schema.Orders 
            var!(state) = %State{
                uid: "123123", 
                name: "Thiago",
                cpf: "13206867703",
                current_order: %Orders{
                    uid: "123123",
                    business_id: 1,
                    user_id: 1,
                    open: true
                },
                previous_orders: %Orders{}
            }
            var!(order) = %Orders{
                uid: "123123",
                business_id: 1,
                user_id: 1,
                open: true
            }
        end
    end
end

ExUnit.start()
