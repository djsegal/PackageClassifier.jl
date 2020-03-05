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

  decibans_db = pull_decibans()
  general_db = pull_general()

end
