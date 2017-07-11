defmodule Metallum.Encyclopaedia do
  @moduledoc """
  HTTP interface to The Encyclopaedia Metallum.
  """

  use HTTPoison.Base

  @doc """
  Returns the base URL to use for requests.

  Overrides HTTPoison.Base's implementation.
  """
  @spec process_url(binary) :: binary
  def process_url(url) do
    "https://www.metal-archives.com" <> url
  end
end
