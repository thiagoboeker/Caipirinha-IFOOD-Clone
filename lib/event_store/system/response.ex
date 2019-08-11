defmodule EventStore.System.Http do
    import Ecto.Changeset

    def case_success(op, fun) do
        with {:ok, result} <- op do
            fun.(result)
        else
            _ -> op
        end 
    end

    def parse_fields(op, fields) do
        with {:ok, r} <- op do
            {:ok, Map.take(r, fields)}
        else
            _ -> op
        end
    end

    def case_failure(op, fun) do
        with {:error, result} <- op do
            error_handling(result)
            |> fun.()
        end
    end

    def response({status, data}, fun) do
        fun.(status, data)
    end

    def error_handling(changeset) do
        errors = traverse_errors(changeset, fn {msg, opts} -> 
            Enum.reduce(opts, msg, fn {key, value}, acc ->
                    String.replace(acc, "%{#{key}}", to_string(value))
            end)
        end)
        %{success: false, errors: errors}
    end

    defmacro process_response(op, fields: fields, module: mod) do
        quote bind_quoted: [fields: fields, op: op, mod: mod] do
            op
            |> mod.parse_fields(fields)
            |> mod.case_success(fn demand -> { 200, demand } end)
            |> mod.case_failure(fn errors -> { 400, errors } end)
            |> mod.response(fn status, resp -> send_resp(var!(conn), status, Poison.encode!(resp)) end)
        end
    end
end