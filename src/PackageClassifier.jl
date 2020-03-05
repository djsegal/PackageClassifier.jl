module PackageClassifier

  using Pkg
  using Revise

  using CSV
  using HTTP
  using JSON

  using DataFrames
  using StatsBase

  using Gumbo
  using AbstractTrees

  using Languages
  using TextAnalysis

  include("custom_text.jl")

  include("pull_decibans.jl")
  include("pull_general.jl")

  include("combine_datasets.jl")

  decibans_db = pull_decibans()
  general_db = pull_general()

  decibans_db, general_db = combine_datasets(decibans_db, general_db)

  export decibans_db
  export general_db

end
