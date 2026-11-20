# Byron installation dependency repair

Baseline: north1952/skyward, byron-a17, 76f35dc. Tested on a Byron running
OS4.0.4.0.XAFCNXM / Android 17, using the OS4.0.3.0-based recovery ramdisk.

## Observed problems and changes

The active modem device was writable (BLKROGET=0), but both firmware aliases
still mounted that physical device. Installation must release the dependency
even when the block device is already writable. Before vendor consumers start,
copy and byte-verify all 167772160 bytes in RAM, serve the copy through a
read-only loop device, and check that every mount namespace and process has
released the original. Reject installation if preparation or revalidation fails.

Service paths can change after detaching mounts. Recognize executable identity
by device/inode, pin actual handles, and release unpinned mappings before pinned
parents. On this Android 17 system, page-size compatibility exposes map_files
entries that return ENOENT. Collect every required device/inode from maps,
resolve available handles, and permit a process-root fallback only after exact
identity validation. Validate and pin the same open file descriptor.

The basename recovery previously ignored all CLI arguments and started the
service. A help query therefore re-entered USB initialization. Start the service
implicitly only without arguments; help and explicit subcommands use the CLI.

## Validation

- ARM64 release compilation; 3 firmware snapshot tests; 36 block and 16 VAB tests.
- Image comparison: 1074 ramdisk entries unchanged except system/bin/recovery.
- Candidate written to recovery A and full-partition SHA-256 read back.
- RAM loop read-only, physical modem writable, aliases point at the RAM copy.
- Three consecutive real installer-backend probes: script exits 0, 37, 0.
  Each reached the script, reported progress, read BootControl, and restored
  all 9 logical mounts. The probe archives do not write partition contents.
- Repeated after rebooting into the final recovery image.
- Credential unlock and shared-storage access passed. KeyMint, BootControl,
  health, gatekeeper and weaver answered.
- UI input navigation and MTP off/on passed; ADB returned in each mode.
- Android boot completed afterwards; root, SystemUI and launcher were present.
  Recovery B and the protected ABL/efisp partition hashes remained unchanged.
- Screen-off idle with MTP+ADB remained configured through observation.
  A long-idle disconnect has not been reproduced; this does not establish
  that every host suspend/resume configuration works.

The fixed runtime was tested with a local hash-restricted diagnostic command.
That test-only entry and private device logs are intentionally not part of this
production patch. No full Byron ROM rewrite or cross-version firmware upgrade
is claimed by these probes.
