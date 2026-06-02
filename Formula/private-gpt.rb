class PrivateGpt < Formula
  desc "Private self-hosted AI API server"
  homepage "https://github.com/zylon-ai/private-gpt"
  url "https://github.com/zylon-ai/private-gpt/archive/refs/tags/v1.0.0-rc1.tar.gz"
  sha256 "c13e24214464f036976d32ca653de48ae9a66de221e67825992128352117a40e"
  license "Apache-2.0"

  depends_on "python@3.11"
  depends_on "uv"

  def install
    (bin/"private-gpt").write <<~SH
      #!/bin/bash
      exec "#{Formula["uv"].opt_bin}/uv" tool run --python "#{Formula["python@3.11"].opt_bin}/python3.11" --find-links "https://zylon-ai.github.io/private-gpt/packages/" --from "private-gpt[core]==1.0.0-rc1" private-gpt "$@"
    SH
  end

  test do
    script = (bin/"private-gpt").read
    assert_match "private-gpt[core]==1.0.0-rc1", script
    assert_match "https://zylon-ai.github.io/private-gpt/packages/", script
    assert_match Formula["uv"].opt_bin.realpath.to_s, script
  end
end
