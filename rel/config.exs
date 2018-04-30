Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
  default_release: :ewallet,
  default_environment: Mix.env

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :dev
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :prod
end

release :ewallet do
  set version: current_version(:ewallet)
  set vm_args: "rel/vm.args"
  set applications: [
    :runtime_tools,
    admin_api: :permanent,
    admin_panel: :permanent,
    ewallet: :permanent,
    ewallet_api: :permanent,
    ewallet_db: :permanent,
    local_ledger: :permanent,
    local_ledger_db: :permanent,
    url_dispatcher: :permanent
  ]

  set commands: [
    "initdb": "rel/commands/initdb.sh"
  ]
end