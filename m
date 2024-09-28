Return-Path: <linux-kselftest+bounces-18528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A981989061
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 18:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005901F21DA1
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4049D1386D7;
	Sat, 28 Sep 2024 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Bodw8jI3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25638762E0;
	Sat, 28 Sep 2024 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540562; cv=none; b=X6r+Yu37JfwiYQP/zbYDMgTesu/WUzIu0WymScA5x/wCm8qlQyorb3mfJZVH+kG40O9Tp+3daTHvXFHVKsRLrF0QufP93HZ512OAW0qan3+2B4veBKnh2yC0l7K8GLx/Rar7jHADr4EnEuj/4YyVgkQl0bBTPCa/CmA3F2QvDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540562; c=relaxed/simple;
	bh=kgiynLnhtrr2WxoojwDAjHAQ9smBnd8Au2vMXMmnwoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=twLfmkouxpgENvV09uhZ2FzmF9E33EqkGOd3yxyH3MQGbrKD7Ol/tiZwcmcg0s37tONwqHroOtcrih8Q+xlSYd9pxIQecBS7R6WKtY8ic9ur5Hvf+yJfsp0/T1DWF8QlScdZKOXvUGP0jVQMSeuVItdqKNoYdATaCSytrh8P3PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Bodw8jI3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727540550;
	bh=kgiynLnhtrr2WxoojwDAjHAQ9smBnd8Au2vMXMmnwoQ=;
	h=From:Date:Subject:To:Cc:From;
	b=Bodw8jI3UWHm7/k4u+1ZwKj8oOQKSMM0vVbBJr7r4IZLsmGOiOcyTak4gi1mraZcx
	 4K8vJUJhjHygSiE6tMAgpe+8+zO2kOGt1Ki/H4w8n2IzIQLpL3FPkutPEFShxvtyEi
	 LKk4yViIiPJ6OPzaMbyCOTFqUcKK7N9tmi5uTSuBs6GtSN305jnm7qSbuwDBj77NVB
	 utxPyZh3OmH7j+hQzp7InsBtJugxCpPtvd0VdDYUt+F+tvRNouWdg5X8WQz+UFgdbw
	 EZGugIBrf4urX6e3K7wTStjOEY7aaSifUYMPO34HwT2IdlizbWhJz5WyAR9wdk4ptm
	 0sHukQ+eIumwQ==
Received: from [192.168.1.4] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4278617E3608;
	Sat, 28 Sep 2024 18:22:29 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Sat, 28 Sep 2024 12:22:27 -0400
Subject: [PATCH v2] kselftest: devices: Add test to detect missing devices
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240928-kselftest-dev-exist-v2-1-fab07de6b80b@collabora.com>
X-B4-Tracking: v=1; b=H4sIAEIt+GYC/32NTQ7CIBCFr9LMWkwh9EdX3sN0wdDBEmsx0JCah
 rs79gDu3vfyfnZIFD0luFY7RMo++bAwqFMFdjLLg4QfmUHVSted0uKZaHYrpVWMlAVtnhWiROv
 6XreNBm6+Izm/Hav3gXniUIif4yTLn/t/L0shxQWtksZ0rcTmZsM8GwzRnG14wVBK+QJLnEiGu
 gAAAA==
To: Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Bird, Tim" <Tim.Bird@sony.com>, Laura Nao <laura.nao@collabora.com>, 
 Saravana Kannan <saravanak@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 daniel.thompson@linaro.org, kernel@collabora.com, kernelci@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.1

Introduce a new test to identify regressions causing devices to go
missing on the system.

For each bus and class on the system the test checks the number of
devices present against a reference file, which needs to have been
generated by the program at a previous point on a known-good kernel, and
if there are missing devices they are reported.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Hi,

For details about the test, please see the README.rst included in the
patch.

This v2 contains changes addressing feedback received on the RFCv1
series, during the session at plumbers [1] and a few other things I
noticed along the way.

[1] https://www.youtube.com/live/kcr8NXEbzcg?si=QWBvJAOjj7tg264o&t=11283

For the open questions I posted in v1, the v2 changelog below should
make it clear what was decided. A few clarifications are needed though:
* I've decided to leave driver probe out of this test to keep it simple
  and avoid potential false-positives
* The reference file now includes the full kernel config as part of its
  metadata (Example at [2]). This is clunky but seems worth it for the
  purposes of reproducibility, and potentially (in the future) choosing
  the reference that best matches the running system

[2] https://github.com/kernelci/platform-test-parameters/pull/3/files

Let me know your thoughts.

Thanks,
Nícolas
---
Changes in v2:
- Switched reference format from YAML to JSON
- Introduced metadata to reference file, it includes: kernel version,
  kernel configuration and platform identifier
- Added -u flag to allow updating reference file in-place if it is a
  superset
- Added -f flag to allow specifying filename of the reference
- Added a few device properties (., device, firmware_node, driver)
- Un-ignored devlink device class
- Refactored code to improve legibility
- Added README.rst with documentation
- Renamed test from exist.py to test_dev_exist.py
- Link to v1: https://lore.kernel.org/r/20240724-kselftest-dev-exist-v1-1-9bc21aa761b5@collabora.com
---
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/devices/exist/Makefile     |   3 +
 tools/testing/selftests/devices/exist/README.rst   | 146 +++++++++
 .../selftests/devices/exist/test_dev_exist.py      | 357 +++++++++++++++++++++
 4 files changed, 507 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b38199965f99..eacf4b062f01 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -15,6 +15,7 @@ TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += damon
 TARGETS += devices/error_logs
+TARGETS += devices/exist
 TARGETS += devices/probe
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
diff --git a/tools/testing/selftests/devices/exist/Makefile b/tools/testing/selftests/devices/exist/Makefile
new file mode 100644
index 000000000000..df85f661aa99
--- /dev/null
+++ b/tools/testing/selftests/devices/exist/Makefile
@@ -0,0 +1,3 @@
+TEST_PROGS := test_dev_exist.py
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/devices/exist/README.rst b/tools/testing/selftests/devices/exist/README.rst
new file mode 100644
index 000000000000..1599204e355d
--- /dev/null
+++ b/tools/testing/selftests/devices/exist/README.rst
@@ -0,0 +1,146 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright (c) 2024 Collabora Ltd
+
+==========================
+Device existence kselftest
+==========================
+
+This test verifies whether all devices still exist on the system when compared
+to a reference run, allowing detection of regressions that cause devices to go
+missing.
+
+TL;DR
+=====
+
+Run ``./test_dev_exist.py -g``, then run ``./test_dev_exist.py``.
+
+Usage
+=====
+
+The test program can be found as ``test_dev_exist.py`` in this directory. Run it
+with the ``--help`` argument to get information for all available arguments.
+Detailed usage follows below.
+
+Reference generation
+--------------------
+
+Before running the test, it is necessary to generate a reference. To do that,
+run it with the ``--generate-reference`` argument. This will generate a JSON
+file encoding all the devices available, per subsystem (class or bus), in the
+running system, as well as metadata about the system (kernel version,
+configuration and system identifiers).
+
+By default, the file will be saved in the current directory and named based on
+the system identifier, but that can be changed through the use of the
+``--reference-dir`` and ``--reference-file`` flags.
+
+Running the test
+----------------
+
+To run the test, simply execute it **without** the ``--generate-reference``
+argument. By default, once again, the test will look for the reference file in
+the current directory and named as the system identifier, but that can be
+changed through the ``--reference-dir`` and ``--reference-file`` flags.
+
+Reading the results
+-------------------
+
+The test outputs in the KTAP format, with one result per subsystem. For each
+failure the output shows the devices that were expected by the reference file,
+the devices that were found in the running system, and a best-effort guess for
+the devices that are missing in the system. For each device, its main properties
+are printed out to help in identifying it.
+
+As an example, below is the snippet printed when one of the three devices in the
+media bus went missing::
+
+  # Missing devices for subsystem 'media': 1 (Expected 3, found 2)
+  # =================
+  # Devices expected:
+  #
+  #   .:
+  #     /sys/devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8.3/3-8.3.2/3-8.3.2:1.0/media2
+  #   uevent:
+  #     MAJOR=237
+  #     MINOR=2
+  #     DEVNAME=media2
+  #
+  #   .:
+  #     /sys/devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9:1.0/media0
+  #   uevent:
+  #     MAJOR=237
+  #     MINOR=0
+  #     DEVNAME=media0
+  #
+  #   .:
+  #     /sys/devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9:1.2/media1
+  #   uevent:
+  #     MAJOR=237
+  #     MINOR=1
+  #     DEVNAME=media1
+  #
+  # -----------------
+  # Devices found:
+  #
+  #   .:
+  #     /sys/devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9:1.0/media0
+  #   uevent:
+  #     MAJOR=237
+  #     MINOR=0
+  #     DEVNAME=media0
+  #
+  #   .:
+  #     /sys/devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9:1.2/media1
+  #   uevent:
+  #     MAJOR=237
+  #     MINOR=1
+  #     DEVNAME=media1
+  #
+  # -----------------
+  # Devices missing (best guess):
+  #
+  #   .:
+  #     /sys/devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8.3/3-8.3.2/3-8.3.2:1.0/media2
+  #   uevent:
+  #     MAJOR=237
+  #     MINOR=2
+  #     DEVNAME=media2
+  #
+  # =================
+  not ok 67 bus.media
+
+Updating the reference
+----------------------
+
+As time goes on, new devices might be introduced in the system. To replace a
+reference file with a more up-to-date one containing more devices, pass both
+``--generate-reference`` and ``--update-reference`` arguments. The program will
+refuse to replace the reference if the new one doesn't contain all the devices
+in the old reference, as that is usually not desirable.
+
+Caveats
+=======
+
+The test relies solely on the count of devices per subsystem to detect missing
+devices. [#f1]_ That means that it is possible for the test to fail to detect a
+missing device.
+
+For example, if the running system contains one extra device and one missing
+device on the same subsystem compared to the reference, no test will fail since
+the count is the same. To minimize the risk of this happening, it is recommended
+to keep the reference file as up-to-date as possible.
+
+.. [#f1] The reason for this is that there aren't any device properties that are
+  used for every device and that are guaranteed to uniquely identify them and be
+  stable across kernel releases, so any attempt to match devices based on their
+  properties would lead to false-positives.
+
+Pre-existing reference files
+============================
+
+Due to the per-platform nature of the reference files, it is not viable to keep
+them in-tree.
+
+To facilitate running the test, especially by CI systems, a collection of
+pre-existing reference files is kept at
+https://github.com/kernelci/platform-test-parameters.
diff --git a/tools/testing/selftests/devices/exist/test_dev_exist.py b/tools/testing/selftests/devices/exist/test_dev_exist.py
new file mode 100755
index 000000000000..58bff5ea99e7
--- /dev/null
+++ b/tools/testing/selftests/devices/exist/test_dev_exist.py
@@ -0,0 +1,357 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Collabora Ltd
+
+import os
+import sys
+import argparse
+import gzip
+import json
+
+# Allow ksft module to be imported from different directory
+this_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.append(os.path.join(this_dir, "../../kselftest/"))
+
+import ksft
+
+
+def generate_ref_metadata():
+    metadata = {}
+
+    config_file = "/proc/config.gz"
+    if os.path.isfile(config_file):
+        with gzip.open(config_file, "r") as f:
+            config = str(f.read())
+        metadata["config"] = config
+
+    metadata["version"] = os.uname().release
+
+    metadata["platform_ids"] = get_possible_ref_filenames()
+
+    return metadata
+
+
+def generate_dev_data():
+    data = {}
+
+    device_subsys_types = [
+        {
+            "type": "class",
+            "base_dir": "/sys/class",
+            "add_path": "",
+            "ignored": [],
+        },
+        {
+            "type": "bus",
+            "base_dir": "/sys/bus",
+            "add_path": "devices",
+            "ignored": [],
+        },
+    ]
+
+    properties = sorted(
+        [
+            ".",
+            "uevent",
+            "name",
+            "device",
+            "firmware_node",
+            "driver",
+            "device/uevent",
+            "firmware_node/uevent",
+        ]
+    )
+
+    for dev_subsys_type in device_subsys_types:
+        subsystems = {}
+        for subsys_name in sorted(os.listdir(dev_subsys_type["base_dir"])):
+            if subsys_name in dev_subsys_type["ignored"]:
+                continue
+
+            devs_path = os.path.join(
+                dev_subsys_type["base_dir"], subsys_name, dev_subsys_type["add_path"]
+            )
+            # Filter out non-symlinks as they're not devices
+            dev_dirs = [dev for dev in os.scandir(devs_path) if dev.is_symlink()]
+            devs_data = []
+            for dev_dir in dev_dirs:
+                dev_path = os.path.join(devs_path, dev_dir)
+                dev_data = {"info": {}}
+                for prop in properties:
+                    prop_path = os.path.join(dev_path, prop)
+                    if os.path.isfile(prop_path):
+                        with open(prop_path) as f:
+                            dev_data["info"][prop] = f.read()
+                    elif os.path.isdir(prop_path):
+                        dev_data["info"][prop] = os.path.realpath(prop_path)
+                devs_data.append(dev_data)
+            if len(dev_dirs):
+                subsystems[subsys_name] = {
+                    "count": len(dev_dirs),
+                    "devices": devs_data,
+                }
+        data[dev_subsys_type["type"]] = subsystems
+
+    return data
+
+
+def generate_reference():
+    return {"metadata": generate_ref_metadata(), "data": generate_dev_data()}
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
+def guess_missing_devices(cur_subsys_data, ref_subsys_data):
+    # Detect what devices on the current system are the most similar to devices
+    # on the reference one by one until the leftovers are the most dissimilar
+    # devices and therefore most likely the missing ones.
+    found_count = cur_subsys_data["count"]
+    expected_count = ref_subsys_data["count"]
+    missing_count = found_count - expected_count
+
+    diffs = []
+    for cur_d in cur_subsys_data["devices"]:
+        for ref_d in ref_subsys_data["devices"]:
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
+    for d in ref_subsys_data["devices"]:
+        if d not in assigned_ref_devs:
+            missing_devices.append(d)
+
+    return missing_devices
+
+
+def dump_devices_info(cur_subsys_data, ref_subsys_data):
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
+    for d in ref_subsys_data["devices"]:
+        dump_device_info(d)
+    ksft.print_msg("-----------------")
+    ksft.print_msg("Devices found:")
+    ksft.print_msg("")
+    for d in cur_subsys_data["devices"]:
+        dump_device_info(d)
+    ksft.print_msg("-----------------")
+    ksft.print_msg("Devices missing (best guess):")
+    ksft.print_msg("")
+    missing_devices = guess_missing_devices(cur_subsys_data, ref_subsys_data)
+    for d in missing_devices:
+        dump_device_info(d)
+    ksft.print_msg("=================")
+
+
+def load_reference(ref_filename):
+    with open(ref_filename) as f:
+        ref = json.load(f)
+    return ref
+
+
+def run_test(ref_filename):
+    ksft.print_msg(f"Using reference file: '{ref_filename}'")
+
+    ref_data = load_reference(ref_filename)["data"]
+
+    num_tests = 0
+    for subsys_type in ref_data.values():
+        num_tests += len(subsys_type)
+    ksft.set_plan(num_tests)
+
+    cur_data = generate_dev_data()
+
+    reference_outdated = False
+
+    for subsys_type_name, ref_subsys_type_data in ref_data.items():
+        for subsys_name, ref_subsys_data in ref_subsys_type_data.items():
+            test_name = f"{subsys_type_name}.{subsys_name}"
+            if not (
+                cur_data.get(subsys_type_name)
+                and cur_data.get(subsys_type_name).get(subsys_name)
+            ):
+                ksft.print_msg(f"Device subsystem '{subsys_name}' missing")
+                ksft.test_result_fail(test_name)
+                continue
+            cur_subsys_data = cur_data[subsys_type_name][subsys_name]
+
+            found_count = cur_subsys_data["count"]
+            expected_count = ref_subsys_data["count"]
+            if found_count < expected_count:
+                ksft.print_msg(
+                    f"Missing devices for subsystem '{subsys_name}': {expected_count - found_count} (Expected {expected_count}, found {found_count})"
+                )
+                dump_devices_info(cur_subsys_data, ref_subsys_data)
+                ksft.test_result_fail(test_name)
+            else:
+                ksft.test_result_pass(test_name)
+                if found_count > expected_count:
+                    reference_outdated = True
+
+        if len(cur_data[subsys_type_name]) > len(ref_subsys_type_data):
+            reference_outdated = True
+
+    if reference_outdated:
+        ksft.print_msg(
+            "Warning: The current system contains more devices and/or subsystems than the reference. Updating the reference is recommended."
+        )
+
+
+def ref_is_superset(new_ref_data, old_ref_data):
+    for subsys_type in old_ref_data:
+        for subsys in old_ref_data[subsys_type]:
+            if subsys not in new_ref_data[subsys_type]:
+                return False
+            if (
+                new_ref_data[subsys_type][subsys]["count"]
+                < old_ref_data[subsys_type][subsys]["count"]
+            ):
+                return False
+    return True
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
+def get_ref_filename(ref_dir, should_exist=True):
+    chosen_ref_filename = ""
+    full_ref_paths = [
+        os.path.join(ref_dir, f + ".json") for f in get_possible_ref_filenames()
+    ]
+    if not should_exist:
+        return full_ref_paths[0]
+
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
+    "--reference-dir",
+    "-d",
+    default=".",
+    help="Directory containing the reference files",
+)
+parser.add_argument(
+    "--reference-file", "-f", help="File name of the reference to read from or write to"
+)
+parser.add_argument(
+    "--generate-reference",
+    "-g",
+    action="store_true",
+    help="Generate a reference file with the devices on the running system",
+)
+parser.add_argument(
+    "--update-reference",
+    "-u",
+    action="store_true",
+    help="Allow overwriting the reference in-place if the existing reference is a subset of the new one",
+)
+args = parser.parse_args()
+
+if args.reference_file:
+    ref_filename = os.path.join(args.reference_dir, args.reference_file)
+    if not os.path.exists(ref_filename) and not args.generate_reference:
+        ksft.print_msg(f"Reference file not found: '{ref_filename}'")
+        ksft.exit_fail()
+else:
+    ref_filename = get_ref_filename(args.reference_dir, not args.generate_reference)
+
+if args.generate_reference:
+    if os.path.exists(ref_filename) and not args.update_reference:
+        print(
+            f"Reference file '{ref_filename}' already exists; won't overwrite; aborting"
+        )
+        sys.exit(1)
+
+    gen_ref = generate_reference()
+    if args.update_reference and os.path.exists(ref_filename):
+        loaded_ref = load_reference(ref_filename)
+        if not ref_is_superset(gen_ref["data"], loaded_ref["data"]):
+            print(
+                f"New reference is not a superset of the existing one; skipping update for '{ref_filename}'"
+            )
+            sys.exit(1)
+
+    with open(ref_filename, "w") as f:
+        json.dump(gen_ref, f, indent=4)
+    print(f"Reference generated to file '{ref_filename}'")
+    sys.exit(0)
+
+ksft.print_header()
+
+run_test(ref_filename)
+
+ksft.finished()

---
base-commit: 40e0c9d414f57d450e3ad03c12765e797fc3fede
change-id: 20240724-kselftest-dev-exist-bb1bcf884654

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


