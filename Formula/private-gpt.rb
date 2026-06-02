class PrivateGpt < Formula
  desc "Private self-hosted AI API server"
  homepage "https://github.com/zylon-ai/private-gpt"
  url "https://github.com/zylon-ai/private-gpt/archive/refs/tags/v1.0.0-rc3.tar.gz"
  sha256 "fe6f222321235338a04a5a000a3bf6525d3c2467e8a6f3d77c67b2a9895af300"
  license "Apache-2.0"

  depends_on "python@3.11"
  depends_on "uv"

  def install
    (bin/"private-gpt").write <<~SH
      #!/bin/bash
      exec "#{Formula["uv"].opt_bin}/uv" tool run --python "#{Formula["python@3.11"].opt_bin}/python3.11" --find-links "https://wheels.privategpt.dev/private-gpt/packages/" --from "private-gpt[core]==1.0.0-rc3" private-gpt "$@"
    SH
  end

  test do
    script = (bin/"private-gpt").read
    assert_match "private-gpt[core]==1.0.0-rc3", script
    assert_match "https://wheels.privategpt.dev/private-gpt/packages/", script
    assert_match Formula["uv"].opt_bin.realpath.to_s, script
  end
end
