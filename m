Return-Path: <linux-kselftest+bounces-13262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AF5928F92
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 01:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6891B228FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 23:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE86D176246;
	Fri,  5 Jul 2024 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vwFNqutu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382516D9A4;
	Fri,  5 Jul 2024 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720222215; cv=none; b=NEY0yxVxDy9IYpm/0UMIsfpjXu31kWt1UkTplNEPsoJMrcdSO1n2aYMRH2lbOsjBOYNtcRO2bSDCSyQVadEoTQSssvtewBjscXdDFtpWHSnHlaQLtw3PsLTlGAzJkoGd6E92dnx2CFscXfe9d3h5JBBNvW0O6CJkN1bqeXBatRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720222215; c=relaxed/simple;
	bh=KXP1PLG22gD+T352YnjlF9j1bB/6aJs9Gs0doHGBIBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pwpiavXhdH70n70zX/rzoKc6FD0cXjS3WBd1VIfU7wAU4LfEzSiJKfe0gLj2HplkpucvZb0d95hgNRpOox2vEAi92JPDN4OMvpScn8Z1Pk0T+7DHsjEQJbPzOkIP+Gc3JaWwwB3PC3bWcQoiztXcWNgHogbWe07S+vB0lYHBHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vwFNqutu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720222212;
	bh=KXP1PLG22gD+T352YnjlF9j1bB/6aJs9Gs0doHGBIBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vwFNqutux5y24gRoxK0SDzXPLfO2NV0mnnzrQ08yf9jLPyduLHJq/B8pVras50ETx
	 zmhs8pKPYY9wE+YUbeMVQNvt43aDNnzTKGBEn6HXmUvlV08zsK10HskltkI0SU6ifN
	 bWBSs1CabS/wJDBfUfUNq2i8projBbAMJA5kgSLpjWkOeHfuyQnPziBkapPVuDJcWA
	 zMRsjvNQkxXI3zhkRBTkQVyhLqJpS9pwoPxNIJ5f++lp/nlY7PPKDCIbso00mg+sns
	 kvD8awMfqFsihSqSgaeSO+8XhQu+acww1MgdDQGtEg6zJo5TUQB2BZVwK6wKH5GNQr
	 nULjpENvksHbA==
Received: from [192.168.1.238] (tango.collaboradmins.com [167.235.144.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 42F3137821FE;
	Fri,  5 Jul 2024 23:30:11 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 05 Jul 2024 19:29:56 -0400
Subject: [PATCH v2 3/3] kselftest: devices: Add test to detect device error
 logs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240705-dev-err-log-selftest-v2-3-163b9cd7b3c1@collabora.com>
References: <20240705-dev-err-log-selftest-v2-0-163b9cd7b3c1@collabora.com>
In-Reply-To: <20240705-dev-err-log-selftest-v2-0-163b9cd7b3c1@collabora.com>
To: Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernelci@lists.linux.dev, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.0

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
index 7bd78b9f5cdd..c4937c87df22 100644
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
2.45.2


