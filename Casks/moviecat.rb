cask "moviecat" do
  version "1.1.0"
  sha256 "03b9cc46f25294cf3f951644f8a45a3669a829ab47e7b1cf851996774dbb62e9"

  url "https://github.com/FredrikBorgstrom/moviecat/releases/download/v#{version}/MovieCat-macos.zip"
  name "MovieCat"
  desc "Movie and TV file library with posters, ratings and summaries"
  homepage "https://moviecat.org/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "MovieCat.app"

  # The direct download is not notarised; let it open without the Gatekeeper prompt.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/MovieCat.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.abcx3.moviecat",
    "~/Library/Containers/com.abcx3.moviecat",
  ]
end
