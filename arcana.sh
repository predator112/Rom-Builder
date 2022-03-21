# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/projectarcana-aosp/manifest -b 12.x -g default,-mips,-darwin,-notdefault
git clone https://github.com/NFS-projects/local_manifest --depth 1 -b arcana-12 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_rosy-userdebug
export TZ=Asia/Jakarta
export USE_NFSparts=true
export USE_ARCANA_PACKAGE=yes
curl -s -X POST "https://api.telegram.org/bot${tg_token}/sendMessage" -d chat_id="${tg_id}" -d "disable_web_page_preview=true" -d "parse_mode=html" -d text="================================%0A$device Starting Building Rom%0A<b>     $rom_name</b>%0A$(echo "${var_cache_report_config}")"
make bacon -j8

# end
