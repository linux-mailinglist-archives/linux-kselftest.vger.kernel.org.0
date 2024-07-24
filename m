Return-Path: <linux-kselftest+bounces-14185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DF693B8BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 23:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41ECE1C211B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 21:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E2F13BC11;
	Wed, 24 Jul 2024 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="r5J+uoIP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8431B134DE;
	Wed, 24 Jul 2024 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721857249; cv=none; b=E2w22v1p2FTCtqk0cbO6VUTsmEMwy6FEQedV4rkGd0lhOU8Bs5owEm7cc7T2aVhhlEC7R/Lx8eLsM7gEFFno3Jfra+4mpDceu1AMhIxFvGe209lLL2jxXlSoaJ8k1GPGCR8hp50Ge5UGxTgNVRyVBoYds8GmzxrVzQiM54L43as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721857249; c=relaxed/simple;
	bh=KLkBXKWN3Xo1+VCP4LbzIF5m/qy0hXW32uXWVmTNOzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hJJzXGn9G+V5spTfWs0h8DHHCaDCkB60pmD2KjMjMawNEHs79Rh7CUr1TyazvhKsHRLshiw97KtYiI8hRCZYfUVvAkuiV+7B/dYHHh+Ysw+laiiR2oHwbyFyAs3TZwpeD+4vDmTx2KC8PmrhuLudcHt7SGuE8+midcWuT7l79KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=r5J+uoIP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721857245;
	bh=KLkBXKWN3Xo1+VCP4LbzIF5m/qy0hXW32uXWVmTNOzU=;
	h=From:Date:Subject:To:Cc:From;
	b=r5J+uoIPWdJQ2kfk+IUSRhy0/1Zfky+jo56/S2Ti3y+4csBlV3yO5bliZF/v864ka
	 DklXwTf03RUPoxwW0QQoffbpd3XWCyMrkt6HvUic3QrN9NuJhrp5aDGSB0RVLuzQ5y
	 gurb/KQHxIvKwDdZWB8g8RXxdxpF1wFMpn5q/4fwcxTq3GPSs1QaW/ZPF7FQUMk8of
	 0AVPRn35uNjUUXzbhoAoffT0egTruafMMqBmq5JbB6v09yCXhD6M0p1gmZG6rax6Mu
	 2jlgR8UK290mShkqpQoqpUUPf/mc+H3J3vVG26O6ETdx/df/mrektR8f/sI4lCOW4X
	 PhNJrEtwHEPZQ==
Received: from [192.168.1.251] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EDD4E3780520;
	Wed, 24 Jul 2024 21:40:42 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 24 Jul 2024 17:40:00 -0400
Subject: [PATCH RFC] kselftest: devices: Add test to detect missing devices
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240724-kselftest-dev-exist-v1-1-9bc21aa761b5@collabora.com>
X-B4-Tracking: v=1; b=H4sIAK90oWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyMT3ezi1Jy0ktTiEt2U1DLd1IpMICspyTApOc3CwsTM1EQJqLOgKDU
 tswJsarRSkJuzUmxtLQDLQt8LagAAAA==
To: Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Bird, Tim" <Tim.Bird@sony.com>, Laura Nao <laura.nao@collabora.com>, 
 Saravana Kannan <saravanak@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 kernel@collabora.com, kernelci@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.0

Introduce a new test to identify regressions causing devices to go
missing on the system.

For each bus and class on the system the test checks the number of
devices present against a reference file, which needs to have been
generated by the program at a previous point on a known-good kernel, and
if there are missing devices they are reported.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Hi,

Key points about this test:
* Goal: Identify regressions causing devices to go missing on the system
* Focus:
  * Ease of maintenance: the reference file is generated programatically
  * Minimum of false-positives: the script makes as few assumptions as possible
    about the stability of device identifiers to ensure renames/refactors don't
    trigger false-positives
* How it works: For each bus and class on the system the test checks the number
  of devices present against a reference file, which needs to have been
  generated by the program at a previous point on a known-good kernel, and if
  there are missing devices they are reported.
* Comparison to other tests: It might be possible(*) to replace the discoverable
  devices test [1] with this. The benefits of this test is that it's easier
  to setup and maintain and has wider coverage of devices.

Additional detail:
* Having more devices on the running system than the reference does not cause a
  failure, but a warning is printed in that case to suggest that the reference
  be updated.
* Missing devices are detected per bus/class based on the number of devices.
  When the test fails, the known metadata for each of the expected and detected
  devices is printed and some simple similitarity comparison is done to suggest
  the devices that are the most likely to be missing.
* The proposed place to store the generated reference files is the
  'platform-test-parameters' repository in KernelCI [2].

Example output: This is an example of a failing test case when one of the two
devices in the nvmem bus went missing:

  # Missing devices for subsystem 'nvmem': 1 (Expected 2, found 1)
  # =================
  # Devices expected:
  #
  #   uevent:
  #     OF_NAME=efuse
  #     OF_FULLNAME=/soc/efuse@11c10000
  #     OF_COMPATIBLE_0=mediatek,mt8195-efuse
  #     OF_COMPATIBLE_1=mediatek,efuse
  #     OF_COMPATIBLE_N=2
  #
  #   uevent:
  #     OF_NAME=flash
  #     OF_FULLNAME=/soc/spi@1132c000/flash@0
  #     OF_COMPATIBLE_0=jedec,spi-nor
  #     OF_COMPATIBLE_N=1
  #
  # -----------------
  # Devices found:
  #
  #   uevent:
  #     OF_NAME=efuse
  #     OF_FULLNAME=/soc/efuse@11c10000
  #     OF_COMPATIBLE_0=mediatek,mt8195-efuse
  #     OF_COMPATIBLE_1=mediatek,efuse
  #     OF_COMPATIBLE_N=2
  #
  # -----------------
  # Devices missing (best guess):
  #
  #   uevent:
  #     OF_NAME=flash
  #     OF_FULLNAME=/soc/spi@1132c000/flash@0
  #     OF_COMPATIBLE_0=jedec,spi-nor
  #     OF_COMPATIBLE_N=1
  #
  # =================
  not ok 19 bus.nvmem

Example of how the data for these devices is encoded in the reference file:

  bus:
  ...
    nvmem:
      count: 2
      devices:
      - info:
          uevent: 'OF_NAME=efuse
  
            OF_FULLNAME=/soc/efuse@11c10000
  
            OF_COMPATIBLE_0=mediatek,mt8195-efuse
  
            OF_COMPATIBLE_1=mediatek,efuse
  
            OF_COMPATIBLE_N=2
  
            '
      - info:
          uevent: 'OF_NAME=flash
  
            OF_FULLNAME=/soc/spi@1132c000/flash@0
  
            OF_COMPATIBLE_0=jedec,spi-nor
  
            OF_COMPATIBLE_N=1
  
            '

(Full reference file: http://0x0.st/Xp60.yaml;)

Caveat: Relying only on the count of devices in a subsystem makes the test
susceptible to false-negatives eg. if a device goes missing and another in the
same subsystem is added the count will be the same so this regression won't be
reported. In order to avoid this we may include properties that must match
individual devices, but we must be very careful (and it's why I haven't done it)
since matching against properties that aren't guaranteed to be stable will
introduce false-positives (ie. detecting false regressions) due to eventual
renames.

Some things to improve in the near future / gather feedback on:
* (*): Currently this test only checks for the existence of devices. We could
  extend it to also encode into the reference which devices are bound to drivers
  to be able to completely replace the discoverable devices probe kselftest [1].
* Expanding identifying properties: Currently the properties that are stored
  (when present) in the reference for each device to be used for identification
  in the result output are uevent, device/uevent, firmware_node/uevent and name.
  Suggestions of others properties to add are welcome.
* Adding more filtering to reduce noise:
  * Ignoring buses/classes: Currently the devlink class is ignored by the test
    since it seems like a kernel internal detail that userspace doesn't actually
    care about. We should add others that are similar.
  * Ignoring non-devices: There can be entries in /sys/class/ that aren't
    devices. For now we're filtering down to only symlinks, but there might be a
    better way.
* As mentioned in the caveat section above we may want to add actual matching
  of devices based on properties to avoid false-negatives if we identify
  suitable properties.
* It would be nice to have an option in the program to compare a newer reference
  to an older one to make it easier for the user to see the differences and
  decide if the new reference is ok.
* Since the reference file is not supposed to be manually edited, JSON might be
  a better choice than YAML since it is included in the python standard library.

Let me know your thoughts.

Thanks,
Nícolas

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/devices/probe/test_discoverable_devices.py?id=0debb20c5c812f8750c20c3406bc94a1e8ea4742
[2] https://github.com/kernelci/platform-test-parameters
---
 tools/testing/selftests/Makefile               |   1 +
 tools/testing/selftests/devices/exist/Makefile |   3 +
 tools/testing/selftests/devices/exist/exist.py | 268 +++++++++++++++++++++++++
 3 files changed, 272 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index bc8fe9e8f7f2..9c49b5ec5bef 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -14,6 +14,7 @@ TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += damon
 TARGETS += devices/error_logs
+TARGETS += devices/exist
 TARGETS += devices/probe
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
diff --git a/tools/testing/selftests/devices/exist/Makefile b/tools/testing/selftests/devices/exist/Makefile
new file mode 100644
index 000000000000..3075cac32092
--- /dev/null
+++ b/tools/testing/selftests/devices/exist/Makefile
@@ -0,0 +1,3 @@
+TEST_PROGS := exist.py
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/devices/exist/exist.py b/tools/testing/selftests/devices/exist/exist.py
new file mode 100755
index 000000000000..8241b2fabc8e
--- /dev/null
+++ b/tools/testing/selftests/devices/exist/exist.py
@@ -0,0 +1,268 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Collabora Ltd
+
+# * Goal: Identify regressions causing devices to go missing on the system
+# * Focus:
+#   * Ease of maintenance: the reference file is generated programatically
+#   * Minimum of false-positives: the script makes as few assumptions as
+#     possible about the stability of device identifiers to ensure
+#     renames/refactors don't trigger false-positives
+# * How it works: For each bus and class on the system the test checks the
+#   number of devices present against a reference file, which needs to have been
+#   generated by the program at a previous point on a known-good kernel, and if
+#   there are missing devices they are reported.
+
+import os
+import sys
+import argparse
+
+import yaml
+
+# Allow ksft module to be imported from different directory
+this_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.append(os.path.join(this_dir, "../../kselftest/"))
+
+import ksft
+
+
+def generate_devs_obj():
+    obj = {}
+
+    device_sources = [
+        {
+            "base_dir": "/sys/class",
+            "add_path": "",
+            "key_name": "class",
+            "ignored": ["devlink"],
+        },
+        {
+            "base_dir": "/sys/bus",
+            "add_path": "devices",
+            "key_name": "bus",
+            "ignored": [],
+        },
+    ]
+
+    properties = sorted(["uevent", "device/uevent", "firmware_node/uevent", "name"])
+
+    for source in device_sources:
+        source_subsystems = {}
+        for subsystem in sorted(os.listdir(source["base_dir"])):
+            if subsystem in source["ignored"]:
+                continue
+
+            devs_path = os.path.join(source["base_dir"], subsystem, source["add_path"])
+            dev_dirs = [dev for dev in os.scandir(devs_path) if dev.is_symlink()]
+            devs_data = []
+            for dev_dir in dev_dirs:
+                dev_path = os.path.join(devs_path, dev_dir)
+                dev_data = {"info": {}}
+                for prop in properties:
+                    if os.path.isfile(os.path.join(dev_path, prop)):
+                        with open(os.path.join(dev_path, prop)) as f:
+                            dev_data["info"][prop] = f.read()
+                devs_data.append(dev_data)
+            if len(dev_dirs):
+                source_subsystems[subsystem] = {
+                    "count": len(dev_dirs),
+                    "devices": devs_data,
+                }
+        obj[source["key_name"]] = source_subsystems
+
+    return obj
+
+
+def commented(s):
+    return s.replace("\n", "\n# ")
+
+
+def indented(s, n):
+    return " " * n + s.replace("\n", "\n" + " " * n)
+
+
+def stripped(s):
+    return s.strip("\n")
+
+
+def devices_difference(dev1, dev2):
+    difference = 0
+
+    for prop in dev1["info"].keys():
+        for l1, l2 in zip(
+            dev1["info"].get(prop, "").split("\n"),
+            dev2["info"].get(prop, "").split("\n"),
+        ):
+            if l1 != l2:
+                difference += 1
+    return difference
+
+
+def guess_missing_devices(cur_devs_subsystem, ref_devs_subsystem):
+    # Detect what devices on the current system are the most similar to devices
+    # on the reference one by one until the leftovers are the most dissimilar
+    # devices and therefore most likely the missing ones.
+    found_count = cur_devs_subsystem["count"]
+    expected_count = ref_devs_subsystem["count"]
+    missing_count = found_count - expected_count
+
+    diffs = []
+    for cur_d in cur_devs_subsystem["devices"]:
+        for ref_d in ref_devs_subsystem["devices"]:
+            diffs.append((devices_difference(cur_d, ref_d), cur_d, ref_d))
+
+    diffs.sort(key=lambda x: x[0])
+
+    assigned_ref_devs = []
+    assigned_cur_devs = []
+    for diff in diffs:
+        if len(assigned_ref_devs) >= expected_count - missing_count:
+            break
+        if diff[1] in assigned_cur_devs or diff[2] in assigned_ref_devs:
+            continue
+        assigned_cur_devs.append(diff[1])
+        assigned_ref_devs.append(diff[2])
+
+    missing_devices = []
+    for d in ref_devs_subsystem["devices"]:
+        if d not in assigned_ref_devs:
+            missing_devices.append(d)
+
+    return missing_devices
+
+
+def dump_devices_info(cur_devs_subsystem, ref_devs_subsystem):
+    def dump_device_info(dev):
+        for name, val in dev["info"].items():
+            ksft.print_msg(indented(name + ":", 2))
+            val = stripped(val)
+            if val:
+                ksft.print_msg(commented(indented(val, 4)))
+        ksft.print_msg("")
+
+    ksft.print_msg("=================")
+    ksft.print_msg("Devices expected:")
+    ksft.print_msg("")
+    for d in ref_devs_subsystem["devices"]:
+        dump_device_info(d)
+    ksft.print_msg("-----------------")
+    ksft.print_msg("Devices found:")
+    ksft.print_msg("")
+    for d in cur_devs_subsystem["devices"]:
+        dump_device_info(d)
+    ksft.print_msg("-----------------")
+    ksft.print_msg("Devices missing (best guess):")
+    ksft.print_msg("")
+    missing_devices = guess_missing_devices(cur_devs_subsystem, ref_devs_subsystem)
+    for d in missing_devices:
+        dump_device_info(d)
+    ksft.print_msg("=================")
+
+
+def run_test(ref_filename):
+    ksft.print_msg(f"Using reference file: {ref_filename}")
+
+    with open(ref_filename) as f:
+        ref_devs_obj = yaml.safe_load(f)
+
+    num_tests = 0
+    for dev_source in ref_devs_obj.values():
+        num_tests += len(dev_source)
+    ksft.set_plan(num_tests)
+
+    cur_devs_obj = generate_devs_obj()
+
+    reference_outdated = False
+
+    for source, ref_devs_source_obj in ref_devs_obj.items():
+        for subsystem, ref_devs_subsystem_obj in ref_devs_source_obj.items():
+            test_name = f"{source}.{subsystem}"
+            if not (
+                cur_devs_obj.get(source) and cur_devs_obj.get(source).get(subsystem)
+            ):
+                ksft.print_msg(f"Device subsystem '{subsystem}' missing")
+                ksft.test_result_fail(test_name)
+                continue
+            cur_devs_subsystem_obj = cur_devs_obj[source][subsystem]
+
+            found_count = cur_devs_subsystem_obj["count"]
+            expected_count = ref_devs_subsystem_obj["count"]
+            if found_count < expected_count:
+                ksft.print_msg(
+                    f"Missing devices for subsystem '{subsystem}': {expected_count - found_count} (Expected {expected_count}, found {found_count})"
+                )
+                dump_devices_info(cur_devs_subsystem_obj, ref_devs_subsystem_obj)
+                ksft.test_result_fail(test_name)
+            else:
+                ksft.test_result_pass(test_name)
+                if found_count > expected_count:
+                    reference_outdated = True
+
+        if len(cur_devs_obj[source]) > len(ref_devs_source_obj):
+            reference_outdated = True
+
+    if reference_outdated:
+        ksft.print_msg(
+            "Warning: The current system contains more devices and/or subsystems than the reference. Updating the reference is recommended."
+        )
+
+
+def get_possible_ref_filenames():
+    filenames = []
+
+    dt_board_compatible_file = "/proc/device-tree/compatible"
+    if os.path.exists(dt_board_compatible_file):
+        with open(dt_board_compatible_file) as f:
+            for line in f:
+                compatibles = [compat for compat in line.split("\0") if compat]
+                filenames.extend(compatibles)
+    else:
+        dmi_id_dir = "/sys/devices/virtual/dmi/id"
+        vendor_dmi_file = os.path.join(dmi_id_dir, "sys_vendor")
+        product_dmi_file = os.path.join(dmi_id_dir, "product_name")
+
+        with open(vendor_dmi_file) as f:
+            vendor = f.read().replace("\n", "")
+        with open(product_dmi_file) as f:
+            product = f.read().replace("\n", "")
+
+        filenames = [vendor + "," + product]
+
+    return filenames
+
+
+def get_ref_filename(ref_dir):
+    chosen_ref_filename = ""
+    full_ref_paths = [os.path.join(ref_dir, f + ".yaml") for f in get_possible_ref_filenames()]
+    for path in full_ref_paths:
+        if os.path.exists(path):
+            chosen_ref_filename = path
+            break
+
+    if not chosen_ref_filename:
+        tried_paths = ",".join(["'" + p + "'" for p in full_ref_paths])
+        ksft.print_msg(f"No matching reference file found (tried {tried_paths})")
+        ksft.exit_fail()
+
+    return chosen_ref_filename
+
+
+parser = argparse.ArgumentParser()
+parser.add_argument(
+    "--reference-dir", default=".", help="Directory containing the reference files"
+)
+parser.add_argument("--generate-reference", action="store_true", help="Generate a reference file with the devices on the running system")
+args = parser.parse_args()
+
+if args.generate_reference:
+    print(f"# Kernel version: {os.uname().release}")
+    print(yaml.dump(generate_devs_obj()))
+    sys.exit(0)
+
+ksft.print_header()
+
+ref_filename = get_ref_filename(args.reference_dir)
+
+run_test(ref_filename)
+
+ksft.finished()

---
base-commit: 73399b58e5e5a1b28a04baf42e321cfcfc663c2f
change-id: 20240724-kselftest-dev-exist-bb1bcf884654

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


