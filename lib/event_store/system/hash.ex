defmodule EventStore.System.Hash do
    def hash(item) do
        :crypto.hash(:sha256, Kernel.inspect(item))
        |> Base.encode16()
        |> String.downcase()
    end
end 