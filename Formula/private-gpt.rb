class PrivateGpt < Formula
  desc "Private self-hosted AI API server"
  homepage "https://github.com/zylon-ai/private-gpt"
  url "https://github.com/zylon-ai/private-gpt/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "Apache-2.0"

  depends_on "python@3.11"
  depends_on "uv"

  def install
    (bin/"private-gpt").write <<~SH
      #!/bin/bash
      exec "#{Formula["uv"].opt_bin}/uv" tool run --python "#{Formula["python@3.11"].opt_bin}/python3.11" --from "private-gpt[lite]==0.6.2" private-gpt "$@"
    SH
  end

  test do
    script = (bin/"private-gpt").read
    assert_match "private-gpt[lite]==0.6.2", script
    assert_match Formula["uv"].opt_bin.realpath.to_s, script
  end
end
