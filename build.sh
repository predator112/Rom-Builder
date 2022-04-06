# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/xdroid-CAF/xd_manifest -b eleven -g default,-mips,-darwin,-notdefault
git clone https://github.com/zacky46/local_manifest --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch xdroid_whyred-userdebug
curl -s -X POST "https://api.telegram.org/bot${tg_token}/sendMessage" -d chat_id="${tg_id}" -d "disable_web_page_preview=true" -d "parse_mode=html" -d text="===================================%0A<b>${device_model}</b> Starting Building Rom%0A<b>ROM:</b>$rom_name%0A<b>Build Type:</b>$NFS_BUILD_VARIANT%0A$(echo "${var_cache_report_config}")"
make xd -j8

# end
