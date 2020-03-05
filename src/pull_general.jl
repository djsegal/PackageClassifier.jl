function pull_general()
  isdir("../tmp/General") || run(
    `git clone "https://github.com/JuliaRegistries/General" ../tmp/General`
  )

  cur_packages = []
  cur_owners = []

  for cur_char in 'A':'Z'
      for cur_package in readdir("../tmp/General/$(cur_char)")
          package_dict = Pkg.TOML.parsefile(
              "../tmp/General/$(cur_char)/$(cur_package)/Package.toml"
          )

          occursin("gitlab.com", package_dict["repo"]) && continue
          @assert occursin("github.com", package_dict["repo"])

          endswith(package_dict["repo"], ".jl.git") || continue

          package_dict["repo"] = replace(package_dict["repo"], ".jl.git" => "")
          cur_owner, cur_package = split(package_dict["repo"], "/")[end-1:end]

          ( package_dict["name"] != cur_package ) && continue

          ( cur_package in cur_packages ) && continue
          push!(cur_packages, cur_package)
          push!(cur_owners, cur_owner)
      end
  end

  general_db = DataFrame(package=cur_packages, owner=cur_owners)

  return general_db
end
