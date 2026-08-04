class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.3.0/yeoul_0.3.0_darwin_arm64.tar.gz"
      sha256 "b5747ff7577cfbe582e74830f6582314b14d54f744ef72c9a134ce76bc12fdee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.3.0/yeoul_0.3.0_darwin_amd64.tar.gz"
      sha256 "1e23a8be7a7f889a339e882628e4bb0512802314000f967b4aa98ddaaf3d5097"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.3.0/yeoul_0.3.0_linux_arm64.tar.gz"
      sha256 "4c60291aa95cd1d9f8e218e920d172efe7e62d17f262a569041d514ec3c2faf8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.3.0/yeoul_0.3.0_linux_amd64.tar.gz"
      sha256 "a8eb08f1190b105ce727ff2d1e3ee1c1add9e2e9d068a0fa59ab0c047169bbfd"
    end
  end

  def install
    libexec.install Dir["*"]

    runtime_env = {}
    if OS.mac?
      runtime_env["DYLD_LIBRARY_PATH"] = libexec/"lib"
    elsif OS.linux?
      runtime_env["LD_LIBRARY_PATH"] = libexec/"lib"
    end

    (bin/"yeoul").write_env_script libexec/"bin/yeoul", runtime_env
    (bin/"yeould").write_env_script libexec/"bin/yeould", runtime_env
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/yeoul help")
  end
end
