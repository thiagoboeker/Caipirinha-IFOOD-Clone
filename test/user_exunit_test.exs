defmodule UserTest do
    
    use ExUnit.Case 
    require Mock

    setup_all do
        Mock.defaults
        {:ok, user} = User.start_link(state)
        {:ok, %{user: user, order: order}}
    end

    test "User Orders", st do
        close = GenServer.call(st[:user], {:close_order}) # Close the default orer
        open = GenServer.call(st[:user], {:open_order, st[:order]}) # Put a new order
        user_orders = GenServer.call(st[:user], {:get_orders}) # Get all the order from the user
        assert st[:order] == user_orders[:open]
        assert close == :ok
        assert open == :ok
    end
end