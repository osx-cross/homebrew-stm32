cask 'stm32cubemx' do
  version '5.6.1'
  sha256 'ff3ed237790529b2134f2254789220d7def05669857d5e0e1e60d387c17ab4bb'

  url "https://dl.bintray.com/osx-cross/casks-stm32/en.stm32cubemx_v#{version}.zip"
  name 'STM32CubeMX'
  homepage 'https://www.st.com/en/development-tools/stm32cubemx.html'

  auto_updates false

  installer script: {
    executable: 'java',
    args:       ['-jar', "#{staged_path}/SetupSTM32CubeMX-#{version}.exe"],
    must_succeed: true
	}

	version_suffix = '@5'

	cubemx_original_app_path = "#{appdir}/STMicroelectronics/STM32CubeMX.app"
	cubemx_final_app_path = "#{appdir}/STMicroelectronics/STM32CubeMX#{version_suffix}.app"

	usr_local_bin_file = "/usr/local/bin/stm32cubemx#{version_suffix}"
	cubemx_script_file = "#{cubemx_final_app_path}/Contents/MacOs/stm32cubemx.sh"

	postflight do
    unless version_suffix.empty? do
      ohai "Adding #{version_suffix} to STM32CubeMX.app filename"
      FileUtils.mv cubemx_original_app_path cubemx_final_app_path
		end

    File.open(cubemx_script_file, "w") { |f|
      f.write("#!/usr/bin/env bash\njava -jar #{cubemx_final_app_path}/Contents/MacOs/STM32CubeMX $@\n")
      f.close
    }

    FileUtils.chmod 0755, cubemx_script_file
    FileUtils.ln_sf cubemx_script_file, usr_local_bin_file
  end

  uninstall script: {
    executable: 'java',
    args:       ['-jar', '#{cubemx_final_app_path}/Contents/Resources/Uninstaller/uninstaller.jar'],
    must_succeed: true
  }

  uninstall_preflight do
    FileUtils.rm usr_local_bin_file, force: true
  end

  caveats do
    depends_on_java
  end
end
