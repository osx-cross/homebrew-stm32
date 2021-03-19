cask 'stm32cubeide' do
  version '1.6.0'
  sha256 '1e15227f860d1fcbb00c7b232feb6ba9cff879f0a2e942b7d6669bb13ec0a757'

  url "https://www.dropbox.com/s/0k8hu9kvb6egkag/en.stm32cubeide_v#{version}.dmg?dl=1"
  name 'STM32CubeIDE'
  homepage 'https://www.st.com/en/development-tools/stm32cubeide.html'

  auto_updates true

  uninstall quit: 'com.st.stm32cube.ide.mcu.rcp.product'

  pkg 'st-stlink-server.1.3.0-4.pkg'
  app 'STM32CubeIDE.app'

  caveats do
    depends_on_java
  end
end
