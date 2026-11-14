#!/system/bin/sh
# The secure element HAL of the phone's vendor, with the libraries a
# recovery's own vendor partition leaves out. It calls QSEECom_start_app,
# so it keeps trying until qseecomd answers and it stays up.
export LD_LIBRARY_PATH=/skyward/lib64:/vendor/lib64:/vendor/lib64/hw:/system/lib64:/odm/lib64
export LD_PRELOAD=/skyward/lib64/libbinder.so
i=0
while [ $i -lt 900 ]; do
    /skyward/hw/se-qti && exit 0
    i=$((i + 1))
    sleep 2
done
exit 1
