Return-Path: <linux-kselftest+bounces-8710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 020718AE90A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 16:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10ED7B21EBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 14:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0257F13A251;
	Tue, 23 Apr 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yZoGbmAI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB980137920;
	Tue, 23 Apr 2024 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881063; cv=none; b=H12mORKgcGqaFMi+E8G3KrU2iUkanQDmd1JuV2rENuB6O0H36DmnJcli6nC8hZ9OQ2GBjA5IsopQZGhRvfwVHxcIWxatqpcbLNdGhLFd+2WAeflsAmpANSBlGYh8+EJeN0Rw9S7mY7YOzGgK4gWCO65av3ch/+qzndi73iWM2qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881063; c=relaxed/simple;
	bh=cdHQNL5UGWCPlqmYGniguXykrW/wjI0bsk8eLJVhSvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0o2OnyHAg7dPDnEiMkB8i8mNqfdlO0WqjJT9Nr4j8dbiXtXqlMDCtTGVoz/x8tRlAhA91CGhCWwP+fylEcjW0xZzeniZDXZgOf4qU65XnXVffyMiLKIDclfpDYJ9+7pCK9bNQWY7J/6kT8imPn4usE2ydPVCz8Y+/VwJ3NNGN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yZoGbmAI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713881055;
	bh=cdHQNL5UGWCPlqmYGniguXykrW/wjI0bsk8eLJVhSvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=yZoGbmAIvIvdPlFvIiZp2pDh/KgMxXpwHLK9JxCs9NObjBgOGrSEvIBuEv4fXzooi
	 d+2GX/+shjQjfTrCJvaMhd1NjK7vhqbgHPL5MtuyF1HIH7Czhq+3Xxz/UgeLTmKl0C
	 DQSYUPDKNFuu0Fik0gmrFi6RLgNlmOy2ZaG5BmJMcebjXeoAqpu0MvPS35WadQp+Tt
	 7xPYkjFxkTN+8CmmgkXP2BkXTgGuYMRaLNd8prM9GY4TIHS/tiPujxzU3+U7R69naf
	 LortnF5wx98C+3dbk/C99bG2J5gsyDUqdjlkBvKGjjaWcXs1bexqgvAT3b8CBZ+2Nb
	 bWqUruU/qvXgg==
Received: from [192.168.1.205] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ED5D53782144;
	Tue, 23 Apr 2024 14:04:14 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 23 Apr 2024 10:03:42 -0400
Subject: [PATCH 3/3] kselftest: devices: Add test to detect device error
 logs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-dev-err-log-selftest-v1-3-690c1741d68b@collabora.com>
References: <20240423-dev-err-log-selftest-v1-0-690c1741d68b@collabora.com>
In-Reply-To: <20240423-dev-err-log-selftest-v1-0-690c1741d68b@collabora.com>
To: Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Log errors are the most widely used mechanism for reporting issues in
the kernel. When an error is logged using the device helpers, eg
dev_err(), it gets metadata attached that identifies the subsystem and
device where the message is coming from. Introduce a new test that makes
use of that metadata to report which devices logged errors (or more
critical messages).

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 tools/testing/selftests/Makefile                   |  1 +
 .../testing/selftests/devices/error_logs/Makefile  |  3 +
 .../devices/error_logs/test_device_error_logs.py   | 85 ++++++++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index a07ef1f473b3..e74da5e6e499 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -13,6 +13,7 @@ TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += damon
+TARGETS += devices/error_logs
 TARGETS += devices/probe
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
diff --git a/tools/testing/selftests/devices/error_logs/Makefile b/tools/testing/selftests/devices/error_logs/Makefile
new file mode 100644
index 000000000000..d546c3fb0a7f
--- /dev/null
+++ b/tools/testing/selftests/devices/error_logs/Makefile
@@ -0,0 +1,3 @@
+TEST_PROGS := test_device_error_logs.py
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/devices/error_logs/test_device_error_logs.py b/tools/testing/selftests/devices/error_logs/test_device_error_logs.py
new file mode 100755
index 000000000000..3dd56c8ec92c
--- /dev/null
+++ b/tools/testing/selftests/devices/error_logs/test_device_error_logs.py
@@ -0,0 +1,85 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2024 Collabora Ltd
+#
+# This test checks for the presence of error (or more critical) log messages
+# coming from devices in the kernel log.
+#
+# One failed test case is reported for each device that has outputted error
+# logs. Devices with no errors do not produce a passing test case to avoid
+# polluting the results, therefore a successful run will list 0 tests run.
+#
+
+import glob
+import os
+import re
+import sys
+
+# Allow ksft module to be imported from different directory
+this_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.append(os.path.join(this_dir, "../../kselftest/"))
+
+import ksft
+
+kmsg = "/dev/kmsg"
+
+RE_log = re.compile(
+    r"(?P<prefix>[0-9]+),(?P<sequence>[0-9]+),(?P<timestamp>[0-9]+),(?P<flag>[^;]*)(,[^;]*)*;(?P<message>.*)"
+)
+RE_tag = re.compile(r" (?P<key>[^=]+)=(?P<value>.*)")
+
+PREFIX_ERROR = 3
+
+logs = []
+error_log_per_device = {}
+
+
+def parse_kmsg():
+    current_log = {}
+
+    with open(kmsg) as f:
+        os.set_blocking(f.fileno(), False)
+
+        for line in f:
+            tag_line = RE_tag.match(line)
+            log_line = RE_log.match(line)
+
+            if log_line:
+                if current_log:
+                    logs.append(current_log)  # Save last log
+
+                current_log = {
+                    "prefix": int(log_line.group("prefix")),
+                    "sequence": int(log_line.group("sequence")),
+                    "timestamp": int(log_line.group("timestamp")),
+                    "flag": log_line.group("flag"),
+                    "message": log_line.group("message"),
+                }
+            elif tag_line:
+                current_log[tag_line.group("key")] = tag_line.group("value")
+
+
+def generate_per_device_error_log():
+    for log in logs:
+        if log.get("DEVICE") and log["prefix"] <= PREFIX_ERROR:
+            if not error_log_per_device.get(log["DEVICE"]):
+                error_log_per_device[log["DEVICE"]] = []
+            error_log_per_device[log["DEVICE"]].append(log)
+
+
+parse_kmsg()
+
+generate_per_device_error_log()
+num_tests = len(error_log_per_device)
+
+ksft.print_header()
+ksft.set_plan(num_tests)
+
+for device in error_log_per_device:
+    for log in error_log_per_device[device]:
+        ksft.print_msg(log["message"])
+    ksft.test_result_fail(device)
+if num_tests == 0:
+    ksft.print_msg("No device error logs found")
+ksft.finished()

-- 
2.44.0


