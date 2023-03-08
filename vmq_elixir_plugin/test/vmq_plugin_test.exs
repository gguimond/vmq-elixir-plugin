import Mock

defmodule VMQPluginTest do
  use ExUnit.Case
  doctest VMQPlugin

  test "auth_on_register_m5" do
    with_mock HTTPoison, [post: fn(_endpoint, _body, _headers) -> {:ok, %{status_code: 200}}  end] do
      assert VMQPlugin.auth_on_register_m5({}, {"mountpoint", "clientid"}, 'username', 'password', {}, %{p_user_property: [{"cpeId", "mycpeid"}]}) == :ok
      assert_called HTTPoison.post("http://10.193.203.242:1234", "{\"clientid\":\"clientid\",\"cpeId\":\"mycpeid\"}", [{"hook", "auth_on_register_m5"}])
    end
  end

  test "auth_on_register_m5 status error" do
    with_mock HTTPoison, [post: fn(_endpoint, _body, _headers) -> {:ok, %{status_code: 503}}  end] do
      assert VMQPlugin.auth_on_register_m5({}, {"mountpoint", "clientid"}, 'username', 'password', {}, %{p_user_property: [{"cpeId", "mycpeid"}]}) == :error
      assert_called HTTPoison.post("http://10.193.203.242:1234", "{\"clientid\":\"clientid\",\"cpeId\":\"mycpeid\"}", [{"hook", "auth_on_register_m5"}])
    end
  end

  test "auth_on_register_m5 post error" do
    with_mock HTTPoison, [post: fn(_endpoint, _body, _headers) -> {:error, "reason"}  end] do
      assert VMQPlugin.auth_on_register_m5({}, {"mountpoint", "clientid"}, 'username', 'password', {}, %{p_user_property: [{"cpeId", "mycpeid"}]}) == :error
      assert_called HTTPoison.post("http://10.193.203.242:1234", "{\"clientid\":\"clientid\",\"cpeId\":\"mycpeid\"}", [{"hook", "auth_on_register_m5"}])
    end
  end
end
