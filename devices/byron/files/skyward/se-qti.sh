#!/system/bin/sh
# The secure element HAL of the phone's vendor, with the libraries a
# recovery's own vendor partition leaves out. Runs as root in nfc, as the
# recovery that decrypts this phone runs it.
export LD_LIBRARY_PATH=/skyward/lib64:/vendor/lib64:/vendor/lib64/hw:/system/lib64:/odm/lib64
export LD_PRELOAD=/skyward/lib64/libbinder.so
exec /skyward/hw/se-qti
