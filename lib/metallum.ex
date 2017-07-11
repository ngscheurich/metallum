defmodule Metallum do
  @moduledoc """
  TODO Write moduledoc.
  """

  alias Metallum.Encyclopaedia

  def main(args) do
    args
    |> parse_args
    |> run
  end

  defp parse_args(args) do
    {parsed, _, _} = OptionParser.parse(
      args,
      switches: [genre: :boolean,
                 url: :boolean]
    )

    parsed
  end

  defp run(args) do
    response = Encyclopaedia.get!(
      "/band/random",
      [],
      follow_redirect: true
    )

    response.body
    |> Floki.find("#band_info")
    |> output(args)
  end

  defp output(html, args) do
    try do
      IO.puts ""
      IO.puts name(html)
      if args[:genre], do: IO.puts genre(html)
      if args[:url], do: IO.puts url(html)
    rescue
      FunctionClauseError ->
        IO.puts error_message()
    end
  end

  defp name(html) do
    html
    |> Floki.find(".band_name a")
    |> Floki.text()
    |> prepend("💀  | ")
    |> String.upcase
  end

  defp genre(html) do
    html
    |> Floki.find("#band_stats .float_right dd")
    |> List.first
    |> Floki.text()
    |> prepend("📖  | ")
  end

  defp url(html) do
    html
    |> Floki.find(".band_name a")
    |> Floki.attribute("href")
    |> List.first
    |> prepend("🗝  | ")
  end

  defp prepend(string, addition) do
    addition <> string
  end

  defp error_message do
    """
    Alas, all recollection of the band was obscured
    by the fog of mortal ken.
    """
  end
end
