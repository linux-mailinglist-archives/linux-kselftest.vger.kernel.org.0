Return-Path: <linux-kselftest+bounces-17542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77F59721F5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDC91F249AF
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A59189F59;
	Mon,  9 Sep 2024 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VpO41KD6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8B189BAA;
	Mon,  9 Sep 2024 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907104; cv=none; b=qwTc6s83cIl5o7+Cm/RQgCAcedIf/jukL9hevmvivhJ22dsuAju45Rm7XqN+C9qalEH/JGksmmmuWCdS211ncREIrlnvdeXGy05tu6Fo7bD7eD7e4gSQSRVIZSJDOb1TEfbE33SZpiGX4jWbjd3Iv3WmSeNpFWXXrs3UK7/8KZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907104; c=relaxed/simple;
	bh=06a+4+u7GgI0QOGqHjtSNwrz0XvKnxfVsRzsa0GxZXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VoxzQp42VfqOUviAhrl36LXueFvbrM29/wcv2E8rI+/VQE49uChAAxlMm1OwxJcsJIwQe5tqppIqaKXc2Ytfkt7xm5Y9nU0caB3mhE4KqcgsQ0qI3j2zKTzzr3Ne9TeoHSXI1rrDlASKtCY0OKFEsuo45uwgfEl0DmBgaoFUJoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VpO41KD6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725907100;
	bh=06a+4+u7GgI0QOGqHjtSNwrz0XvKnxfVsRzsa0GxZXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VpO41KD6gqD1fnD/XmWiO/f9v/wYAB7kZzmGbisUcBxy8NsZbKkfSvao9jsKWT9fZ
	 ZIKN+L5pq03dlswz3a760hJF7mmvKLXPVoDcjh6BAsJyo5pGlQfxWB7yGWDnhA8QRL
	 OxgjItYSkoJt5i4YbXbhUJNZfae6AjQQ6SLBV27E6Efg1FaRX+K2dhgiA1wGnyG0f+
	 7glAFNub8F75u6FM6NpyfZ887qKLrCSkOL2m0CTQoaajUdQwo1eEsFNFH4bcJPvRtA
	 fpvdWwICebJtMlZVUgD/ciJnUrexoSsgyyXEauSuD9fmejysE6yZhhTXeqckSYWyAd
	 cm1AqwQQZsukw==
Received: from [192.168.1.95] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6937217E35FB;
	Mon,  9 Sep 2024 20:38:18 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 09 Sep 2024 14:37:34 -0400
Subject: [PATCH RFC 3/3] selftest: gpio: Add a new set-get config test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240909-kselftest-gpio-set-get-config-v1-3-16a065afc3c1@collabora.com>
References: <20240909-kselftest-gpio-set-get-config-v1-0-16a065afc3c1@collabora.com>
In-Reply-To: <20240909-kselftest-gpio-set-get-config-v1-0-16a065afc3c1@collabora.com>
To: Sean Wang <sean.wang@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bamvor Jian Zhang <bamv2005@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mediatek@lists.infradead.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 kernelci@lists.linux.dev, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.1

Add a new kselftest that sets a configuration to a GPIO line and then
gets it back to verify that it was correctly carried out by the driver.

Setting a configuration is done through the GPIO uAPI, but retrieving it
is done through the debugfs interface since that is the only place where
it can be retrieved from userspace.

The test reads the test plan from a YAML file, which includes the chips
and pin settings to set and validate.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 tools/testing/selftests/gpio/Makefile              |   2 +-
 .../gpio-set-get-config-example-test-plan.yaml     |  15 ++
 .../testing/selftests/gpio/gpio-set-get-config.py  | 183 +++++++++++++++++++++
 3 files changed, 199 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index e0884390447d..bdfeb0c9aadd 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-TEST_PROGS := gpio-mockup.sh gpio-sim.sh
+TEST_PROGS := gpio-mockup.sh gpio-sim.sh gpio-set-get-config.py
 TEST_FILES := gpio-mockup-sysfs.sh
 TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev gpio-chip-info gpio-line-name
 CFLAGS += -O2 -g -Wall $(KHDR_INCLUDES)
diff --git a/tools/testing/selftests/gpio/gpio-set-get-config-example-test-plan.yaml b/tools/testing/selftests/gpio/gpio-set-get-config-example-test-plan.yaml
new file mode 100644
index 000000000000..3b749be3c8dc
--- /dev/null
+++ b/tools/testing/selftests/gpio/gpio-set-get-config-example-test-plan.yaml
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+# Top-level contains a list of the GPIO chips that will be tested. Each one is
+# chosen based on the GPIO chip's info label.
+- label: "gpiochip_device_label"
+  # For each GPIO chip, multiple pin configurations can be tested, which are
+  # listed under 'tests'
+  tests:
+  # pin indicates the pin number to test
+  - pin: 34
+    # bias can be 'pull-up', 'pull-down', 'disabled'
+    bias: "pull-up"
+  - pin: 34
+    bias: "pull-down"
+  - pin: 34
+    bias: "disabled"
diff --git a/tools/testing/selftests/gpio/gpio-set-get-config.py b/tools/testing/selftests/gpio/gpio-set-get-config.py
new file mode 100755
index 000000000000..6f1444c8d46b
--- /dev/null
+++ b/tools/testing/selftests/gpio/gpio-set-get-config.py
@@ -0,0 +1,183 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Collabora Ltd
+
+#
+# This test validates GPIO pin configuration. It takes a test plan in YAML (see
+# gpio-set-get-config-example-test-plan.yaml) and sets and gets back each pin
+# configuration described in the plan and checks that they match in order to
+# validate that they are being applied correctly.
+#
+# When the file name for the test plan is not provided through --test-plan, it
+# will be guessed based on the platform ID (DT compatible or DMI).
+#
+
+import time
+import os
+import sys
+import argparse
+import re
+import subprocess
+import glob
+import signal
+
+import yaml
+
+# Allow ksft module to be imported from different directory
+this_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.append(os.path.join(this_dir, "../kselftest/"))
+
+import ksft
+
+
+def config_pin(chip_dev, pin_config):
+    flags = []
+    if pin_config.get("bias"):
+        flags += f"-b {pin_config['bias']}".split()
+    flags += ["-w", chip_dev, str(pin_config["pin"])]
+    gpio_mockup_cdev_path = os.path.join(this_dir, "gpio-mockup-cdev")
+    return subprocess.Popen([gpio_mockup_cdev_path] + flags)
+
+
+def get_bias_debugfs(chip_debugfs_path, pin):
+    with open(os.path.join(chip_debugfs_path, "pinconf-pins")) as f:
+        for l in f:
+            m = re.match(rf"pin {pin}.*bias (?P<bias>(pull )?\w+)", l)
+            if m:
+                return m.group("bias")
+
+
+def check_config_pin(chip, chip_debugfs_dir, pin_config):
+    test_passed = True
+
+    if pin_config.get("bias"):
+        bias = get_bias_debugfs(chip_debugfs_dir, pin_config["pin"])
+        # Convert "pull up" / "pull down" to "pull-up" / "pull-down"
+        bias = bias.replace(" ", "-")
+        if bias != pin_config["bias"]:
+            ksft.print_msg(
+                f"Bias doesn't match: Expected {pin_config['bias']}, read {bias}."
+            )
+            test_passed = False
+
+    ksft.test_result(
+        test_passed,
+        f"{chip['label']}.{pin_config['pin']}.{pin_config['bias']}",
+    )
+
+
+def get_devfs_chip_file(chip_dict):
+    gpio_chip_info_path = os.path.join(this_dir, 'gpio-chip-info')
+    for f in glob.glob("/dev/gpiochip*"):
+        proc = subprocess.run(
+            f"{gpio_chip_info_path} {f} label".split(), capture_output=True, text=True
+        )
+        if proc.returncode:
+            ksft.print_msg(f"Error opening gpio device {f}: {proc.returncode}")
+            ksft.exit_fail()
+
+        if chip_dict["label"] in proc.stdout:
+            return f
+
+
+def get_debugfs_chip_dir(chip):
+    pinctrl_debugfs = "/sys/kernel/debug/pinctrl/"
+
+    for name in os.listdir(pinctrl_debugfs):
+        if chip["label"] in name:
+            return os.path.join(pinctrl_debugfs, name)
+
+
+def run_test(test_plan_filename):
+    ksft.print_msg(f"Using test plan file: {test_plan_filename}")
+
+    with open(test_plan_filename) as f:
+        plan = yaml.safe_load(f)
+
+    num_tests = 0
+    for chip in plan:
+        num_tests += len(chip["tests"])
+
+    ksft.set_plan(num_tests)
+
+    for chip in plan:
+        chip_dev = get_devfs_chip_file(chip)
+        if not chip_dev:
+            ksft.print_msg("Couldn't find /dev file for GPIO chip")
+            ksft.exit_fail()
+        chip_debugfs_dir = get_debugfs_chip_dir(chip)
+        if not chip_debugfs_dir:
+            ksft.print_msg("Couldn't find pinctrl folder in debugfs for GPIO chip")
+            ksft.exit_fail()
+        for pin_config in chip["tests"]:
+            proc = config_pin(chip_dev, pin_config)
+            time.sleep(0.1)  # Give driver some time to update pin
+            check_config_pin(chip, chip_debugfs_dir, pin_config)
+            proc.send_signal(signal.SIGTERM)
+            proc.wait()
+
+
+def get_possible_test_plan_filenames():
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
+def get_test_plan_filename(test_plan_dir):
+    chosen_test_plan_filename = ""
+    full_test_plan_paths = [
+        os.path.join(test_plan_dir, f + ".yaml")
+        for f in get_possible_test_plan_filenames()
+    ]
+    for path in full_test_plan_paths:
+        if os.path.exists(path):
+            chosen_test_plan_filename = path
+            break
+
+    if not chosen_test_plan_filename:
+        tried_paths = ",".join(["'" + p + "'" for p in full_test_plan_paths])
+        ksft.print_msg(f"No matching test plan file found (tried {tried_paths})")
+        ksft.print_cnts()
+        sys.exit(4)
+
+    return chosen_test_plan_filename
+
+
+parser = argparse.ArgumentParser()
+parser.add_argument(
+    "--test-plan-dir", default=".", help="Directory containing the test plan files"
+)
+parser.add_argument("--test-plan", help="Test plan file to use")
+args = parser.parse_args()
+
+ksft.print_header()
+
+if args.test_plan:
+    test_plan_filename = os.path.join(args.test_plan_dir, args.test_plan)
+    if not os.path.exists(test_plan_filename):
+        ksft.print_msg(f"Test plan file not found: {test_plan_filename}")
+        ksft.exit_fail()
+else:
+    test_plan_filename = get_test_plan_filename(args.test_plan_dir)
+
+run_test(test_plan_filename)
+
+ksft.finished()

-- 
2.46.0


