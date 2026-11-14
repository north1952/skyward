# The NXP weaver behind the phone's secure element, with the libraries and the
# binder runtime the recovery carries, as the working YAPR recovery runs it.
export LD_LIBRARY_PATH=/skyward/lib64:/system/lib64:/vendor/lib64:/vendor/lib64/hw:/odm/lib64
export LD_PRELOAD=/skyward/lib64/libbinder.so
exec /skyward/hw/weaver-nxp
