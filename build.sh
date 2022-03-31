# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/NFS-projects/local_manifest --depth 1 -b PE-12 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
export NFS_BUILD_ROM_NAME=${rom_name}
source build/envsetup.sh
export TZ=Asia/Jakarta
export USE_NFSparts=false
export NFS_BUILD_VARIANT=normal
# export USE_ARCANA_PACKAGE=yes
lunch aosp_rosy-userdebug
curl -s -X POST "https://api.telegram.org/bot${tg_token}/sendMessage" -d chat_id="${tg_id}" -d "disable_web_page_preview=true" -d "parse_mode=html" -d text="===================================%0A<b>$device</b> Starting Building Rom%0A<b>ROM:</b>$rom_name%0A<b>Build Type:</b>$NFS_BUILD_VARIANT%0A$(echo "${var_cache_report_config}")"
mka bacon

# end
