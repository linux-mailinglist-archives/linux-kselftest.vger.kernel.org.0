Return-Path: <linux-kselftest+bounces-2460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BD181EEF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 13:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 311B5B219C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CEA4503C;
	Wed, 27 Dec 2023 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T6IvVZYn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727744C90;
	Wed, 27 Dec 2023 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703680738;
	bh=cvceIOnjM/AGadzqVBMzm96qg/ZUaCHfmj74oiz3kOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6IvVZYnh8bb+q8g6l6puvhH2B64zdPo32A1Mv159yb64QnTsHzFmgg1D5kwUOk0G
	 cBLzaI3513kSpqRBhJdrPXXE/gzMA3xae0b0ZRLi4mi31ffdTSIgEC87Qun/FpRwp5
	 dQ69zMJgQTt8zlBb24yOYjT3t1GgtmcUCpx+6Sm9WoeXpg3LnjHUezD1m9EivKvPBa
	 UCk/VhHFIjQBd3vg6qNA1pzzgMZYjdOJno98IGuF4McJ0/9g+bkbgyhgG56imuZfeU
	 xK62IA1U29bTezESWQOne4ZBV+9tbuuCib9ZTcIzL65dfTeBc/Mn0zsYeJapUJw2dF
	 d0Hm9lKGfDtTw==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BEFEB3781F8C;
	Wed, 27 Dec 2023 12:38:52 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: kernelci@lists.linux.dev,
	kernel@collabora.com,
	Tim Bird <Tim.Bird@sony.com>,
	linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	linux-kselftest@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	linux-usb@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Guenter Roeck <groeck@chromium.org>,
	devicetree@vger.kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 1/3] kselftest: Add test to verify probe of devices from discoverable busses
Date: Wed, 27 Dec 2023 09:35:00 -0300
Message-ID: <20231227123643.52348-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231227123643.52348-1-nfraprado@collabora.com>
References: <20231227123643.52348-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new test to verify that a list of expected devices from
discoverable busses (ie USB, PCI) have been successfully instantiated
and probed by a driver.

The per-platform list of expected devices is selected from the ones
under the boards/ directory based on the DT compatible or the DMI IDs.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v3:
- Reverted approach of encoding stable device reference in test file
from device match fields (from modalias) back to HW topology (from v1)
- Changed board file description to YAML
- Rewrote test script in python to handle YAML and support x86 platforms

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/devices/Makefile      |   4 +
 tools/testing/selftests/devices/ksft.py       |  90 +++++
 .../devices/test_discoverable_devices.py      | 318 ++++++++++++++++++
 4 files changed, 413 insertions(+)
 create mode 100644 tools/testing/selftests/devices/Makefile
 create mode 100644 tools/testing/selftests/devices/ksft.py
 create mode 100755 tools/testing/selftests/devices/test_discoverable_devices.py

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 1107be84ea95..650fbc8a2c1f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -13,6 +13,7 @@ TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += damon
+TARGETS += devices
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
 TARGETS += drivers/s390x/uvdevice
diff --git a/tools/testing/selftests/devices/Makefile b/tools/testing/selftests/devices/Makefile
new file mode 100644
index 000000000000..ca29249b30c3
--- /dev/null
+++ b/tools/testing/selftests/devices/Makefile
@@ -0,0 +1,4 @@
+TEST_PROGS := test_discoverable_devices.py
+TEST_FILES := boards ksft.py
+
+include ../lib.mk
diff --git a/tools/testing/selftests/devices/ksft.py b/tools/testing/selftests/devices/ksft.py
new file mode 100644
index 000000000000..cd89fb2bc10e
--- /dev/null
+++ b/tools/testing/selftests/devices/ksft.py
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2023 Collabora Ltd
+#
+# Kselftest helpers for outputting in KTAP format. Based on kselftest.h.
+#
+
+import sys
+
+ksft_cnt = {"pass": 0, "fail": 0, "skip": 0}
+ksft_num_tests = 0
+ksft_test_number = 1
+
+KSFT_PASS = 0
+KSFT_FAIL = 1
+KSFT_SKIP = 4
+
+
+def print_header():
+    print("TAP version 13")
+
+
+def set_plan(num_tests):
+    global ksft_num_tests
+    ksft_num_tests = num_tests
+    print("1..{}".format(num_tests))
+
+
+def print_cnts():
+    print(
+        f"# Totals: pass:{ksft_cnt['pass']} fail:{ksft_cnt['fail']} xfail:0 xpass:0 skip:{ksft_cnt['skip']} error:0"
+    )
+
+
+def print_msg(msg):
+    print(f"# {msg}")
+
+
+def _test_print(result, description, directive=None):
+    if directive:
+        directive_str = f"# {directive}"
+    else:
+        directive_str = ""
+
+    global ksft_test_number
+    print(f"{result} {ksft_test_number} {description} {directive_str}")
+    ksft_test_number += 1
+
+
+def test_result_pass(description):
+    _test_print("ok", description)
+    ksft_cnt["pass"] += 1
+
+
+def test_result_fail(description):
+    _test_print("not ok", description)
+    ksft_cnt["fail"] += 1
+
+
+def test_result_skip(description):
+    _test_print("ok", description, "SKIP")
+    ksft_cnt["skip"] += 1
+
+
+def test_result(condition, description=""):
+    if condition:
+        test_result_pass(description)
+    else:
+        test_result_fail(description)
+
+
+def finished():
+    if ksft_cnt["pass"] == ksft_num_tests:
+        exit_code = KSFT_PASS
+    else:
+        exit_code = KSFT_FAIL
+
+    print_cnts()
+
+    sys.exit(exit_code)
+
+
+def exit_fail():
+    print_cnts()
+    sys.exit(KSFT_FAIL)
+
+
+def exit_pass():
+    print_cnts()
+    sys.exit(KSFT_PASS)
diff --git a/tools/testing/selftests/devices/test_discoverable_devices.py b/tools/testing/selftests/devices/test_discoverable_devices.py
new file mode 100755
index 000000000000..6de96338b0ef
--- /dev/null
+++ b/tools/testing/selftests/devices/test_discoverable_devices.py
@@ -0,0 +1,318 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2023 Collabora Ltd
+#
+# This script tests for presence and driver binding of devices from discoverable
+# busses (ie USB, PCI).
+#
+# The per-platform YAML file defining the devices to be tested is stored inside
+# the boards/ directory and chosen based on DT compatible or DMI IDs (sys_vendor
+# and product_name).
+#
+# See boards/google,spherion.yaml and boards/'Dell Inc.,XPS 13 9300.yaml' for
+# the description and examples of the file structure and vocabulary.
+#
+
+import glob
+import ksft
+import os
+import re
+import sys
+import yaml
+
+pci_controllers = []
+usb_controllers = []
+
+sysfs_usb_devices = "/sys/bus/usb/devices/"
+
+
+def find_pci_controller_dirs():
+    sysfs_devices = "/sys/devices"
+    pci_controller_sysfs_dir = "pci[0-9a-f]{4}:[0-9a-f]{2}"
+
+    dir_regex = re.compile(pci_controller_sysfs_dir)
+    for path, dirs, _ in os.walk(sysfs_devices):
+        for d in dirs:
+            if dir_regex.match(d):
+                pci_controllers.append(os.path.join(path, d))
+
+
+def find_usb_controller_dirs():
+    usb_controller_sysfs_dir = "usb[\d]+"
+
+    dir_regex = re.compile(usb_controller_sysfs_dir)
+    for d in os.scandir(sysfs_usb_devices):
+        if dir_regex.match(d.name):
+            usb_controllers.append(os.path.realpath(d.path))
+
+
+def get_dt_mmio(sysfs_dev_dir):
+    re_dt_mmio = re.compile("OF_FULLNAME=.*@([0-9a-f]+)")
+    dt_mmio = None
+
+    # PCI controllers' sysfs don't have an of_node, so have to read it from the
+    # parent
+    while not dt_mmio:
+        try:
+            with open(os.path.join(sysfs_dev_dir, "uevent")) as f:
+                dt_mmio = re_dt_mmio.search(f.read()).group(1)
+                return dt_mmio
+        except:
+            pass
+        sysfs_dev_dir = os.path.dirname(sysfs_dev_dir)
+
+
+def get_acpi_uid(sysfs_dev_dir):
+    with open(os.path.join(sysfs_dev_dir, "firmware_node", "uid")) as f:
+        return f.read()
+
+
+def get_usb_version(sysfs_dev_dir):
+    re_usb_version = re.compile("PRODUCT=.*/(\d)/.*")
+    with open(os.path.join(sysfs_dev_dir, "uevent")) as f:
+        return int(re_usb_version.search(f.read()).group(1))
+
+
+def get_usb_busnum(sysfs_dev_dir):
+    re_busnum = re.compile("BUSNUM=(.*)")
+    with open(os.path.join(sysfs_dev_dir, "uevent")) as f:
+        return int(re_busnum.search(f.read()).group(1))
+
+
+def find_controller_in_sysfs(controller, parent_sysfs=None):
+    if controller["type"] == "pci-controller":
+        controllers = pci_controllers
+    elif controller["type"] == "usb-controller":
+        controllers = usb_controllers
+
+    result_controllers = []
+
+    for c in controllers:
+        if parent_sysfs and parent_sysfs not in c:
+            continue
+
+        if controller.get("dt-mmio"):
+            if str(controller["dt-mmio"]) != get_dt_mmio(c):
+                continue
+
+        if controller.get("usb-version"):
+            if controller["usb-version"] != get_usb_version(c):
+                continue
+
+        if controller.get("acpi-uid"):
+            if controller["acpi-uid"] != get_acpi_uid(c):
+                continue
+
+        result_controllers.append(c)
+
+    return result_controllers
+
+
+def is_controller(device):
+    return device.get("type") and "controller" in device.get("type")
+
+
+def path_to_dir(parent_sysfs, dev_type, path):
+    if dev_type == "usb-device":
+        usb_dev_sysfs_fmt = "{}-{}"
+        busnum = get_usb_busnum(parent_sysfs)
+        dirname = os.path.join(
+            sysfs_usb_devices, usb_dev_sysfs_fmt.format(busnum, path)
+        )
+        return [os.path.realpath(dirname)]
+    else:
+        pci_dev_sysfs_fmt = "????:??:{}"
+        path_glob = ""
+        for dev_func in path.split("/"):
+            dev_func = dev_func.zfill(4)
+            path_glob = os.path.join(path_glob, pci_dev_sysfs_fmt.format(dev_func))
+
+        dir_list = glob.glob(os.path.join(parent_sysfs, path_glob))
+
+        return dir_list
+
+
+def find_in_sysfs(device, parent_sysfs=None):
+    if parent_sysfs and device.get("path"):
+        pathdirs = path_to_dir(
+            parent_sysfs, device["meta"]["type"], str(device["path"])
+        )
+        if len(pathdirs) != 1:
+            # Early return to report error
+            return pathdirs
+        pathdir = pathdirs[0]
+        sysfs_path = os.path.join(parent_sysfs, pathdir)
+    else:
+        sysfs_path = parent_sysfs
+
+    if is_controller(device):
+        return find_controller_in_sysfs(device, sysfs_path)
+    else:
+        return [sysfs_path]
+
+
+def check_driver_presence(sysfs_dir, current_node):
+    if current_node["meta"]["type"] == "usb-device":
+        usb_intf_fmt = "*-*:*.{}"
+
+        interfaces = []
+        for i in current_node["interfaces"]:
+            interfaces.append((i, usb_intf_fmt.format(i)))
+
+        for intf_num, intf_dir_fmt in interfaces:
+            test_name = f"{current_node['meta']['pathname']}.{intf_num}.driver"
+
+            intf_dirs = glob.glob(os.path.join(sysfs_dir, intf_dir_fmt))
+            if len(intf_dirs) != 1:
+                ksft.test_result_fail(test_name)
+                continue
+            intf_dir = intf_dirs[0]
+
+            driver_link = os.path.join(sysfs_dir, intf_dir, "driver")
+            ksft.test_result(os.path.isdir(driver_link), test_name)
+    else:
+        driver_link = os.path.join(sysfs_dir, "driver")
+        test_name = current_node["meta"]["pathname"] + ".driver"
+        ksft.test_result(os.path.isdir(driver_link), test_name)
+
+
+def generate_pathname(device):
+    pathname = ""
+
+    if device.get("path"):
+        pathname = str(device["path"])
+
+    if device.get("type"):
+        dev_type = device["type"]
+        if device.get("usb-version"):
+            dev_type = dev_type.replace("usb", "usb" + str(device["usb-version"]))
+        if device.get("acpi-uid") is not None:
+            dev_type = dev_type.replace("pci", "pci" + str(device["acpi-uid"]))
+        pathname = pathname + "/" + dev_type
+
+    if device.get("dt-mmio"):
+        pathname += "@" + str(device["dt-mmio"])
+
+    if device.get("name"):
+        pathname = pathname + "/" + device["name"]
+
+    return pathname
+
+
+def fill_meta_keys(child, parent=None):
+    child["meta"] = {}
+
+    if parent:
+        child["meta"]["type"] = parent["type"].replace("controller", "device")
+
+    pathname = generate_pathname(child)
+    if parent:
+        pathname = parent["meta"]["pathname"] + "/" + pathname
+    child["meta"]["pathname"] = pathname
+
+
+def parse_device_tree_node(current_node, parent_sysfs=None):
+    if not parent_sysfs:
+        fill_meta_keys(current_node)
+
+    sysfs_dirs = find_in_sysfs(current_node, parent_sysfs)
+    if len(sysfs_dirs) != 1:
+        if len(sysfs_dirs) == 0:
+            ksft.test_result_fail(
+                f"Couldn't find in sysfs: {current_node['meta']['pathname']}"
+            )
+        else:
+            ksft.test_result_fail(
+                f"Found multiple sysfs entries for {current_node['meta']['pathname']}: {sysfs_dirs}"
+            )
+        return
+    sysfs_dir = sysfs_dirs[0]
+
+    if not is_controller(current_node):
+        ksft.test_result(
+            os.path.exists(sysfs_dir), current_node["meta"]["pathname"] + ".device"
+        )
+        check_driver_presence(sysfs_dir, current_node)
+    else:
+        for child_device in current_node["devices"]:
+            fill_meta_keys(child_device, current_node)
+            parse_device_tree_node(child_device, sysfs_dir)
+
+
+def count_tests(device_trees):
+    test_count = 0
+
+    def parse_node(device):
+        nonlocal test_count
+        if device.get("devices"):
+            for child in device["devices"]:
+                parse_node(child)
+        else:
+            if device.get("interfaces"):
+                test_count += len(device["interfaces"])
+            else:
+                test_count += 1
+            test_count += 1
+
+    for device_tree in device_trees:
+        parse_node(device_tree)
+
+    return test_count
+
+
+def get_board_filenames():
+    filenames = []
+
+    platform_compatible_file = "/proc/device-tree/compatible"
+    if os.path.exists(platform_compatible_file):
+        with open(platform_compatible_file) as f:
+            for line in f:
+                filenames.extend(line.split("\0"))
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
+def run_test(yaml_file):
+    ksft.print_msg(f"Using board file: {yaml_file}")
+
+    with open(yaml_file) as f:
+        device_trees = yaml.safe_load(f)
+
+    ksft.set_plan(count_tests(device_trees))
+
+    for device_tree in device_trees:
+        parse_device_tree_node(device_tree)
+
+
+find_pci_controller_dirs()
+find_usb_controller_dirs()
+
+ksft.print_header()
+
+board_file = ""
+for board_filename in get_board_filenames():
+    full_board_filename = os.path.join("boards", board_filename + ".yaml")
+
+    if os.path.exists(full_board_filename):
+        board_file = full_board_filename
+        break
+
+if not board_file:
+    ksft.print_msg("No matching board file found")
+    ksft.exit_fail()
+
+run_test(board_file)
+
+ksft.finished()
-- 
2.43.0


