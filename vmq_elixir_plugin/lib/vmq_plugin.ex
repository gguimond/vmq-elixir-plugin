require Logger

defmodule VMQPlugin do
  @moduledoc """
  Documentation for `VMQPlugin`.
  """

  @doc """
  Callback function which is called after a client has been
  successfully authenticated.
  """
  def on_client_wakeup({mountpoint, clientid}) do
    Logger.info("on_client_wakeup")
    endpoint = Application.get_env(:vmq_elixir_plugin, :endpoint_on_client_wakeup)
    Logger.info("endpoint #{endpoint}")
    #headers = [{"hook", "on_client_wakeup"}]
    body = JSX.encode!(%{"mountpoint" => mountpoint, "clientid" => clientid})
    IO.inspect(body)
    #case HTTPoison.post(endpoint, body, headers) do
    #  {:ok, response} -> IO.inspect(response)
    #  {:error, reason} -> Logger.error("#{reason}")
    #end
    :ok
  end

  @doc """
  Callback function handling authentication when registering.
  """
  def auth_on_register_m5(_peer, {_mountpoint, clientid}, _username, _password, _cleanstart, properties) do
    Logger.info("auth_on_register_m5")
    endpoint = Application.get_env(:vmq_elixir_plugin, :endpoint_on_client_wakeup)
    Logger.info("endpoint #{endpoint}")
    headers = [{"hook", "auth_on_register_m5"}]
    cpeId = Enum.find_value(Map.get(properties, :p_user_property), '',
      fn
        { "cpeId", val } -> val
        _ -> false
      end
    )
    body = JSX.encode!(%{"cpeId" => cpeId, "clientid" => clientid})
    IO.inspect(body)
    case HTTPoison.post(endpoint, body, headers) do
      {:ok, response} ->
        case response.status_code do
          200 -> :ok
          _ -> :error
        end
      {:error, reason} ->
        Logger.error("#{reason}")
        :error
    end
  end
end
