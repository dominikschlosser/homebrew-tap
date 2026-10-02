# typed: strict
# frozen_string_literal: true

# Homebrew formula for eudi-dev, published to the dominikschlosser/homebrew-tap
# repository by the release workflow. 2.5.0 (without the leading v) and
# 81be345d2fb33503f105bad0d9336f4cbc770bc0fb37afd610640af82ba911a4 are filled in per release.
class EudiDev < Formula
  desc "Developer toolkit for the EUDI and OpenID4VC ecosystem"
  homepage "https://github.com/dominikschlosser/eudi-dev"
  url "https://github.com/dominikschlosser/eudi-dev/archive/refs/tags/v2.5.0.tar.gz"
  sha256 "81be345d2fb33503f105bad0d9336f4cbc770bc0fb37afd610640af82ba911a4"
  license "Apache-2.0"
  head "https://github.com/dominikschlosser/eudi-dev.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/dominikschlosser/eudi-dev/v2/cmd.Version=v#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"eudi")
    # Legacy command name keeps working for the time being
    bin.install_symlink "eudi" => "oid4vc-dev"
    generate_completions_from_executable(bin/"eudi", "completion")
  end

  test do
    assert_match "eudi", shell_output("#{bin}/eudi version")
    assert_match "german-pid-sdjwt", shell_output("#{bin}/eudi templates list --wallet-dir #{testpath}")
  end
end
