defmodule Teiserver.Settings.UserSettingType do
  @moduledoc """
  # UserSettingType
  A user setting type is a structure for user settings to reference. The setting types are created at node startup.

  ### Attributes

  * `:key` - The string key of the setting, this is the internal name used for the setting
  * `:label` - The user-facing label used for the setting
  * `:section` - A string referencing how the setting should be grouped
  * `:type` - The type of value which should be parsed out, can be one of: `string`, `boolean`, `integer`

  ### Optional attributes
  * `:permissions` - A permission set (string or list of strings) used to check if a given user can edit this setting
  * `:choices` - A list of acceptable choices for `string` based types
  * `:default` - The default value for a setting if one is not set, defaults to `nil`
  * `:description` - A longer description which can be used to provide more information to users
  """

  use TypedStruct

  @type key :: String.t()

  @derive Jason.Encoder
  typedstruct do
    @typedoc "A user setting type"

    field(:key, key())
    field(:label, String.t())
    field(:section, String.t())
    field(:type, String.t())

    field(:permissions, String.t() | [String.t()] | nil, default: nil)
    field(:choices, [String.t()] | nil, default: nil)
    field(:default, String.t() | Integer.t() | boolean | nil, default: nil)
    field(:description, String.t() | nil, default: nil)
  end

  # @spec new(opts) :: __MODULE__.t()
  # def new(opts) do
  #   %__MODULE__{
  #     key: opts[:key],
  #   }
  # end
end
