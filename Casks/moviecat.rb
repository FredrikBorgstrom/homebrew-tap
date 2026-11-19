cask "moviecat" do
  version "1.2.0"
  sha256 "7a125b71cb3ed3f2a7cfe77779f62be924a6b687b1209a28657dc1825138765c"

  url "https://github.com/FredrikBorgstrom/moviecat/releases/download/v#{version}/MovieCat-macos.zip"
  name "MovieCat"
  desc "Movie and TV file library with posters, ratings and summaries"
  homepage "https://moviecat.org/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :monterey

  app "MovieCat.app"

  # The direct download is not notarised; let it open without the Gatekeeper prompt.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/MovieCat.app"],
        writable_paths: ["MovieCat.app"],
        writable_base:  :appdir
  end

  zap trash: [
    "~/Library/Application Support/com.abcx3.moviecat",
    "~/Library/Containers/com.abcx3.moviecat",
  ]
end
