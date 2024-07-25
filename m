Return-Path: <linux-kselftest+bounces-14225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA9193C08C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 13:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C2C1C210F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682B5199233;
	Thu, 25 Jul 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J7CpLmwO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ABB1991D8;
	Thu, 25 Jul 2024 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905572; cv=none; b=AzXC0GalM4yuEJQg4v5YJPjyEygPVQHb7ajT4bz+EBMx9xc++3NgjtNmytEKEVJRzwaG+KmeBAyR00qGf3DsNnzPv0tdF8NaRbU3T94X6nZRjWDHoxDao095yym5+uyUd3wBHYtBdifOAMHQ3ZqC7D04ugxpU67d0WxADIU9NXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905572; c=relaxed/simple;
	bh=yH00q3f5pDsV1kq/WYXp/qURVtWyWskhMIn8XHxgMkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zl3xSLbnPul3e4YoNcc2EfHUfJLMrqWrqIABeEXiRBZpJHxkuWCRjAFQsZgISh8E9P5iaCuZM7ngJ2JHcCSMLuIFghuaaYxNFXi/yhrq+27H6sDCYopD7fnLcB7otp/IsnKCN0c6h+QpRNQlfpVz/kAA4EzouNyQ7lNJZgZ3LP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J7CpLmwO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721905568;
	bh=yH00q3f5pDsV1kq/WYXp/qURVtWyWskhMIn8XHxgMkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7CpLmwOdWRjWo+OTSL3PTobpT7Bkt57xmUxUR8Vm7uQOGausgfr5POxiAcIEDS49
	 5u2cJLgH5BIbpaTR7mfpXDVX3keVOAjqMKHMqAReqPr5dRsGy8YgHu1uN+kxqainyQ
	 gTs3muEiGZicFX2J7JLJN3PlqaezoRbBKwQAPjTjIQVxffZ/hQbCJg/NMQLEGPwPqq
	 pe2H6hGnp/0hLG/fiMuy7Z8S+XtgWWu3TWHhNsEmCPETPQUpoW/+kBbWyI9DU72ybj
	 cy/b0WRLR95tm0OSd3XCAvzGbtiDberWo/AbLbjs8JgoQh+QRQj/Ta2D7lncZPuIfW
	 nfjRQ9hLIchOg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2E9953782171;
	Thu, 25 Jul 2024 11:06:07 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel@collabora.com,
	kernelci@lists.linux.dev,
	tim.bird@sony.com,
	mhiramat@kernel.org,
	Laura Nao <laura.nao@collabora.com>
Subject: [RFC PATCH 1/1] kselftests: Add test to detect boot event slowdowns
Date: Thu, 25 Jul 2024 13:06:22 +0200
Message-Id: <20240725110622.96301-2-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240725110622.96301-1-laura.nao@collabora.com>
References: <20240725110622.96301-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new kselftest to identify slowdowns in key boot events.
The test uses ftrace to track timings for specific boot events.
The kprobe_timestamps_to_yaml.py script can be run once to generate a
YAML file with the initial reference timestamps for these events.
The test_boot_time.py script can then be run on subsequent boots to
compare current timings against the reference values and check for
significant slowdowns over time.
The test ships with a bootconfig file for ftrace setup and a config
fragment for the necessary kernel configurations.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/boot-time/Makefile    | 17 ++++
 tools/testing/selftests/boot-time/bootconfig  |  8 ++
 tools/testing/selftests/boot-time/config      |  4 +
 .../boot-time/kprobe_timestamps_to_yaml.py    | 55 +++++++++++
 .../selftests/boot-time/test_boot_time.py     | 94 +++++++++++++++++++
 .../selftests/boot-time/trace_utils.py        | 63 +++++++++++++
 7 files changed, 242 insertions(+)
 create mode 100644 tools/testing/selftests/boot-time/Makefile
 create mode 100644 tools/testing/selftests/boot-time/bootconfig
 create mode 100644 tools/testing/selftests/boot-time/config
 create mode 100755 tools/testing/selftests/boot-time/kprobe_timestamps_to_yaml.py
 create mode 100755 tools/testing/selftests/boot-time/test_boot_time.py
 create mode 100644 tools/testing/selftests/boot-time/trace_utils.py

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index bc8fe9e8f7f2..1e675779322f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -2,6 +2,7 @@
 TARGETS += alsa
 TARGETS += amd-pstate
 TARGETS += arm64
+TARGETS += boot-time
 TARGETS += bpf
 TARGETS += breakpoints
 TARGETS += cachestat
diff --git a/tools/testing/selftests/boot-time/Makefile b/tools/testing/selftests/boot-time/Makefile
new file mode 100644
index 000000000000..43ccd0a3b62e
--- /dev/null
+++ b/tools/testing/selftests/boot-time/Makefile
@@ -0,0 +1,17 @@
+PY3 = $(shell which python3 2>/dev/null)
+
+ifneq ($(PY3),)
+
+TEST_PROGS := test_boot_time.py
+TEST_FILES := trace_utils.py kprobe_timestamps_to_yaml.py
+
+include ../lib.mk
+
+else
+
+all: no_py3_warning
+
+no_py3_warning:
+	@echo "Missing python3. This test will be skipped."
+
+endif
\ No newline at end of file
diff --git a/tools/testing/selftests/boot-time/bootconfig b/tools/testing/selftests/boot-time/bootconfig
new file mode 100644
index 000000000000..2883f03e0766
--- /dev/null
+++ b/tools/testing/selftests/boot-time/bootconfig
@@ -0,0 +1,8 @@
+ftrace {
+    event.kprobes {
+        populate_rootfs_begin.probes = "populate_rootfs"
+        unpack_to_rootfs_begin.probes = "unpack_to_rootfs"
+        run_init_process_begin.probes = "run_init_process"
+        run_init_process_end.probes = "run_init_process%return"
+    }
+}
\ No newline at end of file
diff --git a/tools/testing/selftests/boot-time/config b/tools/testing/selftests/boot-time/config
new file mode 100644
index 000000000000..957b40b45bc0
--- /dev/null
+++ b/tools/testing/selftests/boot-time/config
@@ -0,0 +1,4 @@
+CONFIG_TRACING=y
+CONFIG_BOOTTIME_TRACING=y
+CONFIG_BOOT_CONFIG_EMBED=y
+CONFIG_BOOT_CONFIG_EMBED_FILE="tools/testing/selftests/boot-time/bootconfig"
\ No newline at end of file
diff --git a/tools/testing/selftests/boot-time/kprobe_timestamps_to_yaml.py b/tools/testing/selftests/boot-time/kprobe_timestamps_to_yaml.py
new file mode 100755
index 000000000000..43e742e0759d
--- /dev/null
+++ b/tools/testing/selftests/boot-time/kprobe_timestamps_to_yaml.py
@@ -0,0 +1,55 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2024 Collabora Ltd
+#
+#
+# This script reads the /sys/kernel/debug/tracing/trace file, extracts kprobe
+# event names and timestamps, and saves them to a YAML file.
+#
+# Example of the YAML content generated:
+#
+# - event: populate_rootfs_begin
+#   timestamp: 0.525161
+# - event: unpack_to_rootfs_begin
+#   timestamp: 0.525169
+#
+# Usage:
+#     ./kprobe_timestamps_to_yaml.py [output_file]
+#
+
+import sys
+import argparse
+import yaml
+
+from trace_utils import mount_debugfs, parse_kprobe_event_trace
+
+
+def write_trace_timestamps_to_yaml(output_file_path):
+    """
+    Parse /sys/kernel/debug/tracing/trace file to extract kprobe event
+    names and timestamps, and write them to a YAML file.
+    @output_file_path: the path for the output YAML file, defaults to
+    'kprobe-timestamps.yaml'.
+    """
+    trace_entries = parse_kprobe_event_trace("/sys/kernel/debug/tracing/trace")
+    filtered_entries = {entry['event']: entry['timestamp'] for entry in trace_entries}
+
+    with open(output_file_path, 'w', encoding="utf-8") as yaml_file:
+        yaml.dump(filtered_entries, yaml_file)
+
+    print(f"Generated {output_file_path}")
+
+
+if __name__ == "__main__":
+    parser = argparse.ArgumentParser(
+        description="Extract kprobe event names and timestamps from the \
+        /sys/kernel/debug/tracing/trace file and save them to a YAML file.")
+    parser.add_argument('output_file_path', nargs='?', default='kprobe-timestamps.yaml',
+                        help="path for the output YAML file")
+    args = parser.parse_args()
+
+    if not mount_debugfs("/sys/kernel/debug"):
+        sys.exit(1)
+
+    write_trace_timestamps_to_yaml(args.output_file_path)
diff --git a/tools/testing/selftests/boot-time/test_boot_time.py b/tools/testing/selftests/boot-time/test_boot_time.py
new file mode 100755
index 000000000000..8a8de28c485c
--- /dev/null
+++ b/tools/testing/selftests/boot-time/test_boot_time.py
@@ -0,0 +1,94 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2024 Collabora Ltd
+#
+# This script reads the /sys/kernel/debug/tracing/trace file, extracts kprobe
+# event names and timestamps, and compares them against reference timestamps
+# provided in an input YAML file to identify significant slowdowns in
+# the reference kprobe events.
+#
+# Usage:
+#     ./test_boot_time.py <kprobe_timestamps_file> <delta(seconds)>
+
+import os
+import sys
+import argparse
+import yaml
+from trace_utils import mount_debugfs, parse_kprobe_event_trace
+
+this_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.append(os.path.join(this_dir, "../kselftest/"))
+
+import ksft
+
+def load_kprobe_timestamps_from_yaml(file_path):
+    """
+    Load YAML file containing kprobe event timestamps. Return a dictionary
+    with event names as keys and the corresponding timestamps as values.
+    For example:
+        {'populate_rootfs_begin': 0.525161, 'unpack_to_rootfs_begin': 0.525169}
+    @file_path: path to a YAML file containing the kprobe event timestamps.
+    """
+    try:
+        with open(file_path, 'r', encoding="utf-8") as file:
+            return yaml.safe_load(file)
+    except FileNotFoundError:
+        ksft.print_msg(f"Error: File {file_path} not found.")
+        ksft.exit_fail()
+    except yaml.YAMLError as e:
+        ksft.print_msg(f"Error: Failed to parse YAML file {file_path}. Error: {e}")
+        ksft.exit_fail()
+
+
+def evaluate_kprobe_event_delays(ref_entries, delta):
+    """
+    Read the /sys/kernel/debug/tracing/trace file to extract kprobe event
+    names and timestamps, then compare these timestamps with the reference
+    values provided. Report a failure for each timestamp that deviates from
+    the reference by more than the specified delta.
+    @ref_entries: dictionary containing event names and their timestamps
+    @delta: maximum allowed difference in seconds between the current and
+    reference timestamps
+    """
+    ksft.set_plan(len(ref_entries))
+
+    trace_entries = {entry['event']: entry['timestamp']
+                     for entry in parse_kprobe_event_trace("/sys/kernel/debug/tracing/trace")}
+
+    for ref_event, ref_timestamp in ref_entries.items():
+        if ref_event in trace_entries:
+            timestamp = trace_entries[ref_event]
+            if timestamp >= ref_timestamp and (timestamp - ref_timestamp) >= delta:
+                ksft.print_msg(f"'{ref_event}' differs by "
+                               f"{(timestamp - ref_timestamp):.6f} seconds.")
+                ksft.test_result_fail(ref_event)
+            else:
+                ksft.test_result_pass(ref_event)
+        else:
+            ksft.print_msg(f"Reference event '{ref_event}' not found in trace.")
+            ksft.test_result_skip(ref_event)
+
+
+if __name__ == "__main__":
+    parser = argparse.ArgumentParser(
+        description="Read the /sys/kernel/debug/tracing/trace file, extract kprobe event names \
+        and timestamps, and compares them against reference timestamps provided in an input YAML \
+        file to report significant slowdowns in the reference kprobe events.")
+    parser.add_argument('kprobe_timestamps_file', help="path to YAML file containing \
+        kprobe timestamps")
+    parser.add_argument('delta', type=float, help="maximum allowed difference in seconds \
+        (float) between the current and reference timestamps")
+    args = parser.parse_args()
+
+    # Ensure debugfs is mounted
+    if not mount_debugfs("/sys/kernel/debug"):
+        ksft.exit_fail()
+
+    ksft.print_header()
+
+    ref_entries = load_kprobe_timestamps_from_yaml(args.kprobe_timestamps_file)
+
+    evaluate_kprobe_event_delays(ref_entries, args.delta)
+
+    ksft.finished()
diff --git a/tools/testing/selftests/boot-time/trace_utils.py b/tools/testing/selftests/boot-time/trace_utils.py
new file mode 100644
index 000000000000..c40cef2bf584
--- /dev/null
+++ b/tools/testing/selftests/boot-time/trace_utils.py
@@ -0,0 +1,63 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2024 Collabora Ltd
+#
+# Utility functions for parsing trace files and mounting debugfs.
+#
+
+import re
+import subprocess
+
+
+def mount_debugfs(path):
+    """
+    Mount debugfs at the specified path if it is not already mounted.
+    @path: path where debugfs should be mounted
+    """
+    # Check if debugfs is already mounted
+    with open('/proc/mounts', 'r', encoding="utf-8") as mounts:
+        for line in mounts:
+            if 'debugfs' in line and path in line:
+                print(f"debugfs is already mounted at {path}")
+                return True
+
+    # Mount debugfs
+    try:
+        subprocess.run(['mount', '-t', 'debugfs', 'none', path], check=True)
+        return True
+    except subprocess.CalledProcessError as e:
+        print(f"Failed to mount debugfs: {e.stderr}")
+        return False
+
+
+def parse_kprobe_event_trace(trace_file_path):
+    """
+    Parse a trace file containing kprobe events and return a list of
+    dictionaries, each representing a trace entry.
+
+    Example of trace entry:
+        {'task_pid': 'sh-1', 'timestamp': 0.256527, 'event': \\
+        'populate_rootfs_begin', 'function': 'populate_rootfs+0x4/0x50'}
+
+    @trace_file_path: path to the trace file
+    """
+    trace_pattern = r'^\s*(\S+)\s+\[.*\]\s+\S+\s+(\d+\.\d+):\s+(\S+):\s+\((.*)\)$'
+
+    trace_entries = []
+
+    # Read trace file and parse entries
+    with open(trace_file_path, 'r', encoding="utf-8") as trace_file:
+        for line in trace_file:
+            match = re.match(trace_pattern, line)
+            if match:
+                trace_entry = {
+                    'task_pid': match.group(1),
+                    'timestamp': float(match.group(2)),
+                    'event': match.group(3),
+                    'function': match.group(4)
+                }
+
+                trace_entries.append(trace_entry)
+
+    return trace_entries
-- 
2.30.2


