import Config

if config_env() != :test do
  shopify_api_key = System.get_env("SHOPIFY_API_KEY")
  shopify_api_secret = System.get_env("SHOPIFY_API_SECRET")
  shopify_api_scopes = System.get_env("SCOPES")

  confs = %{
    "SHOPIFY_API_KEY" => shopify_api_key,
    "SHOPIFY_API_SECRET" => shopify_api_secret,
    "SCOPES" => shopify_api_scopes
  }

  for {conf_key, conf_value} <- confs do
    if is_nil(conf_value) do
      Logger.warning("""
      environment variable #{conf_key} is missing.
      In development this is automatically set when running `shopify app dev`
      """)
    end
  end

  # <https://github.com/ericdude4/shopifex>
  config :shopifex,
    api_key: shopify_api_key,
    secret: shopify_api_secret,
    scopes: shopify_api_scopes
end

if host = System.get_env("HOST") do
  # Support proxy URLs `HOST` is set by the Shopify CLI when running the dev command
  {:ok, host_uri} = URI.new(host)

  # <https://github.com/ericdude4/shopifex>
  config :shopifex,
    redirect_uri: host_uri |> URI.append_path("/auth/callback") |> URI.to_string(),
    reinstall_uri: host_uri |> URI.append_path("/auth/calback") |> URI.to_string(),
    webhook_uri: host_uri |> URI.append_path("/shopify/webhooks") |> URI.to_string(),
    payment_redirect_uri: host_uri |> URI.append_path("/shopify/payments") |> URI.to_string()
end
