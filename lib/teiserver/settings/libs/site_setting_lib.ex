defmodule Teiserver.Settings.SiteSettingLib do
  @moduledoc """
  Library of site_setting related functions.
  """
  use TeiserverMacros, :library
  alias Teiserver.Settings.{SiteSetting, SiteSettingQueries}

  @doc """
  Returns the list of site_settings.

  ## Examples

      iex> list_site_settings()
      [%SiteSetting{}, ...]

  """
  @spec list_site_settings(list) :: list
  def list_site_settings(query_args \\ []) do
    query_args
    |> SiteSettingQueries.query_site_settings()
    |> Teiserver.repo.all()
  end

  @doc """
  Gets a single site_setting.

  Raises `Ecto.NoResultsError` if the SiteSetting does not exist.

  ## Examples

      iex> get_site_setting!(123)
      %SiteSetting{}

      iex> get_site_setting!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_site_setting!(non_neg_integer()) :: SiteSetting.t()
  def get_site_setting!(site_setting_id, query_args \\ []) do
    (query_args ++ [id: site_setting_id])
    |> SiteSettingQueries.query_site_settings()
    |> Teiserver.repo.one!()
  end

  @doc """
  Gets a single site_setting.

  Returns nil if the SiteSetting does not exist.

  ## Examples

      iex> get_site_setting(123)
      %SiteSetting{}

      iex> get_site_setting(456)
      nil

  """
  @spec get_site_setting(non_neg_integer(), list) :: SiteSetting.t() | nil
  def get_site_setting(site_setting_id, query_args \\ []) do
    (query_args ++ [id: site_setting_id])
    |> SiteSettingQueries.query_site_settings()
    |> Teiserver.repo.one()
  end

  @doc """
  Creates a site_setting.

  ## Examples

      iex> create_site_setting(%{field: value})
      {:ok, %SiteSetting{}}

      iex> create_site_setting(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_site_setting(map) :: {:ok, SiteSetting.t()} | {:error, Ecto.Changeset.t()}
  def create_site_setting(attrs \\ %{}) do
    %SiteSetting{}
    |> SiteSetting.changeset(attrs)
    |> Teiserver.repo.insert()
  end

  @doc """
  Updates a site_setting.

  ## Examples

      iex> update_site_setting(site_setting, %{field: new_value})
      {:ok, %SiteSetting{}}

      iex> update_site_setting(site_setting, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_site_setting(SiteSetting.t(), map) ::
          {:ok, SiteSetting.t()} | {:error, Ecto.Changeset.t()}
  def update_site_setting(%SiteSetting{} = site_setting, attrs) do
    site_setting
    |> SiteSetting.changeset(attrs)
    |> Teiserver.repo.update()
  end

  @doc """
  Deletes a site_setting.

  ## Examples

      iex> delete_site_setting(site_setting)
      {:ok, %SiteSetting{}}

      iex> delete_site_setting(site_setting)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_site_setting(SiteSetting.t()) ::
          {:ok, SiteSetting.t()} | {:error, Ecto.Changeset.t()}
  def delete_site_setting(%SiteSetting{} = site_setting) do
    Teiserver.repo.delete(site_setting)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking site_setting changes.

  ## Examples

      iex> change_site_setting(site_setting)
      %Ecto.Changeset{data: %SiteSetting{}}

  """
  @spec change_site_setting(SiteSetting.t(), map) :: Ecto.Changeset
  def change_site_setting(%SiteSetting{} = site_setting, attrs \\ %{}) do
    SiteSetting.changeset(site_setting, attrs)
  end
end
