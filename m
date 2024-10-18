Return-Path: <linux-kselftest+bounces-20129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 108B99A3B14
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 12:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9656F1F21BFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4F201033;
	Fri, 18 Oct 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="E78oKcep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC74188A18;
	Fri, 18 Oct 2024 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246474; cv=pass; b=cOa8k4W5Zj5qvCbxU4EuhvPszg/zH7F75x/vNhUxVukfvQmPnMB/l52NxBoY6is70SwLvdYJVEgQZ9TwbEjaQbUxjdcbYhwfW583f4w06CaaOmKmg99raC6GFp1j8cAF49umdqdDKkh0myIsr2cJR68OOI9Z/+zeGzUxlYH61w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246474; c=relaxed/simple;
	bh=NYvOUxpVgYoK3sYkpSJnOD/N7FKJJHg08DiKJLhL9UU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bz7dYisfL+mcZQG4Lf7bCPi0YxuhMj6ZYQE0SaS8T1Vdtv5bXQAL4Ghd8feckOZM8Am1REnySFvps5URQQV3YWAkvm7VX+m8G6cwohIneCEpM/y4DttajsWCZbtUewWTYASCDkM4VrF1guJCAJ3BPOrvoUKb1h8oC54k7ioqcKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=E78oKcep; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729246456; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gMGzn/9eEyiJVQ1DsuOobKU1bbqK4wzcv55WxSJVsJDSf0fw8M2MXWty4QoAdH0CETVvH8dzlmUCmQxshCuN3vD7JQnVtQ3QBpNybWGNWnsr+6sKoq6PBiwG7LzzOBj9FynnwTuFLKRP6AKZLNbnBTCG5fdgc/ufind1bFd/k2M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729246456; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UhMDyqiYC37BE8WnfdqPMkYIHUHA3WhURp8QKOLssWg=; 
	b=eX67o5OyuUbUSuNdbDO+0ItyM0zzp6fiL1Q5Bfyn1MGt0goj82iGGZsDOnpKxGIfrMNxV2pB9DUQSGbfRuo/EJWbIR8xNaKWSFFTbObEeDHaezGrd0mSzg3dd+BfNQVZpMJxiDT1B5ppR2w5XRzkpGAyFko7nfuFB1pu0upfOCw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729246456;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=UhMDyqiYC37BE8WnfdqPMkYIHUHA3WhURp8QKOLssWg=;
	b=E78oKcepe44F2PW4Y7UriCg5ZbjRyqqDssSEj1UkWGGBFci/B+vhSWg6nvDj3tdF
	OQN79d+0m9Y6yXof83SsPp76Q1UTwm24iH8+MwdttiGTpw59Frbky+1ljUAa21yy7N9
	Rq2ZKxrFGIGv7GBuqPsew49zy8opXhQnbhoqc5m0=
Received: by mx.zohomail.com with SMTPS id 1729246455946654.0125228174601;
	Fri, 18 Oct 2024 03:14:15 -0700 (PDT)
From: Laura Nao <laura.nao@collabora.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel@collabora.com,
	kernelci@lists.linux.dev,
	tim.bird@sony.com,
	mhiramat@kernel.org,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v2] kselftests: Add test to detect boot event slowdowns
Date: Fri, 18 Oct 2024 12:14:39 +0200
Message-Id: <20241018101439.20849-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Introduce a new kselftest to identify slowdowns in key boot events.
This test uses ftrace to monitor the start and end times, as well as
the durations of all initcalls, and compares these timings to reference
values to identify significant slowdowns.
The script functions in two modes: the 'generate' mode allows to create
a JSON file containing initial reference timings for all initcalls from
a known stable kernel. The 'test' mode can be used during subsequent
boots to assess current timings against the reference values and
determine if there are any significant differences.
The test ships with a bootconfig file for setting up ftrace and a
configuration fragment for the necessary kernel configs.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
Hello,

This v2 is a follow-up to RFCv1[1] and includes changes based on feedback
from the LPC 2024 session [2], along with some other fixes.

[1] https://lore.kernel.org/all/20240725110622.96301-1-laura.nao@collabora.com/
[2] https://www.youtube.com/watch?v=rWhW2-Vzi40

After reviewing other available tests and considering the feedback from
discussions at Plumbers, I decided to stick with the bootconfig file
approach but extend it to track all initcalls instead of a fixed set of
functions or events. The bootconfig file can be expanded and adapted to
track additional functions if needed for specific use cases.

I also defined a synthetic event to calculate initcall durations, while
still tracking their start and end times. Users are then allowed to choose
whether to compare start times, end times, or durations. Support for
specifying different rules for different initcalls has also been added.

In RFCv1, there was some discussion about using existing tools like
bootgraph.py. However, the output from these tools is mainly for manual
inspection (e.g., HTML visual output), whereas this test is designed to run
in automated CI environments too. The kselftest proposed here combines the
process of generating reference data and running tests into a single script
with two modes, making it easy to integrate into automated workflows.

Many of the features in this v2 (e.g., generating a JSON reference file,
comparing timings, and reporting results in KTAP format) could potentially
be integrated into bootgraph.py with some effort.
However, since this test is intended for automated execution rather than
manual use, I've decided to keep it separate for now and explore the
options suggested at LPC, such as using ftrace histograms for initcall
latencies. I'm open to revisiting this decision and working toward
integrating the changes into bootgraph.py if there's a strong preference
for unifying the tools.

Let me know your thoughts.

A comprehensive changelog is reported below.

Thanks,

Laura
---
Changes in v2:
- Updated ftrace configuration to track all initcall start times, end
  times, and durations, and generate a histogram.
- Modified test logic to compare initcall durations by default, with the
  option to compare start or end times if needed.
- Added warnings if the initcalls in the reference file differ from those
  detected in the running system.
- Combined the scripts into a single script with two modes: one for
  generating the reference file and one for running the test.
- Added support for specifying different rules for individual initcalls.
- Switched the reference format from YAML to JSON.
- Added metadata to the reference file, including kernel version, kernel
  configuration, and cmdline.
- Link to v1: https://lore.kernel.org/all/20240725110622.96301-1-laura.nao@collabora.com/
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/boot-time/Makefile    |  16 ++
 tools/testing/selftests/boot-time/bootconfig  |  15 +
 tools/testing/selftests/boot-time/config      |   6 +
 .../selftests/boot-time/test_boot_time.py     | 265 ++++++++++++++++++
 5 files changed, 303 insertions(+)
 create mode 100644 tools/testing/selftests/boot-time/Makefile
 create mode 100644 tools/testing/selftests/boot-time/bootconfig
 create mode 100644 tools/testing/selftests/boot-time/config
 create mode 100755 tools/testing/selftests/boot-time/test_boot_time.py

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b38199965f99..1bb20d1e3854 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -3,6 +3,7 @@ TARGETS += acct
 TARGETS += alsa
 TARGETS += amd-pstate
 TARGETS += arm64
+TARGETS += boot-time
 TARGETS += bpf
 TARGETS += breakpoints
 TARGETS += cachestat
diff --git a/tools/testing/selftests/boot-time/Makefile b/tools/testing/selftests/boot-time/Makefile
new file mode 100644
index 000000000000..cdcdc1bbe779
--- /dev/null
+++ b/tools/testing/selftests/boot-time/Makefile
@@ -0,0 +1,16 @@
+PY3 = $(shell which python3 2>/dev/null)
+
+ifneq ($(PY3),)
+
+TEST_PROGS := test_boot_time.py
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
index 000000000000..e4b89a33b7a3
--- /dev/null
+++ b/tools/testing/selftests/boot-time/bootconfig
@@ -0,0 +1,15 @@
+ftrace.event {
+    synthetic.initcall_latency {
+        # Synthetic event to record initcall latency, start, and end times
+        fields = "unsigned long func", "u64 lat", "u64 start", "u64 end"
+        actions = "hist:keys=func.sym,start,end:vals=lat:sort=lat"
+    }
+    initcall.initcall_start {
+        # Capture the start time (ts0) when initcall starts
+        actions = "hist:keys=func:ts0=common_timestamp.usecs"
+    }
+    initcall.initcall_finish {
+        # Capture the end time, calculate latency, and trigger synthetic event
+        actions = "hist:keys=func:lat=common_timestamp.usecs-$ts0:start=$ts0:end=common_timestamp.usecs:onmatch(initcall.initcall_start).initcall_latency(func,$lat,$start,$end)"
+    }
+}
\ No newline at end of file
diff --git a/tools/testing/selftests/boot-time/config b/tools/testing/selftests/boot-time/config
new file mode 100644
index 000000000000..bcb646ec3cd8
--- /dev/null
+++ b/tools/testing/selftests/boot-time/config
@@ -0,0 +1,6 @@
+CONFIG_TRACING=y
+CONFIG_BOOTTIME_TRACING=y
+CONFIG_BOOT_CONFIG_EMBED=y
+CONFIG_BOOT_CONFIG_EMBED_FILE="tools/testing/selftests/boot-time/bootconfig"
+CONFIG_SYNTH_EVENTS=y
+CONFIG_HIST_TRIGGERS=y
\ No newline at end of file
diff --git a/tools/testing/selftests/boot-time/test_boot_time.py b/tools/testing/selftests/boot-time/test_boot_time.py
new file mode 100755
index 000000000000..556dacf04b6d
--- /dev/null
+++ b/tools/testing/selftests/boot-time/test_boot_time.py
@@ -0,0 +1,265 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2024 Collabora Ltd
+#
+# This script reads the
+# /sys/kernel/debug/tracing/events/synthetic/initcall_latency/hist file,
+# extracts function names and timings, and compares them against reference
+# timings provided in an input JSON file to identify significant boot
+# slowdowns.
+# The script operates in two modes:
+# - Generate Mode: parses initcall timings from the current kernel's ftrace
+#   event histogram and generates a JSON reference file with function
+#   names, start times, end times, and latencies.
+# - Test Mode: compares current initcall timings against the reference
+#   file, allowing users to define a maximum allowed difference between the
+#   values (delta). Users can also apply custom delta thresholds for
+#   specific initcalls using regex-based overrides. The comparison can be
+#   done on latency, start, or end times.
+#
+
+import os
+import sys
+import argparse
+import gzip
+import json
+import re
+import subprocess
+
+this_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.append(os.path.join(this_dir, "../kselftest/"))
+
+import ksft
+
+def load_reference_from_json(file_path):
+    """
+    Load reference data from a JSON file and returns the parsed data.
+    @file_path: path to the JSON file.
+    """
+
+    try:
+        with open(file_path, 'r', encoding="utf-8") as file:
+            return json.load(file)
+    except FileNotFoundError:
+        ksft.print_msg(f"Error: File {file_path} not found.")
+        ksft.exit_fail()
+    except json.JSONDecodeError:
+        ksft.print_msg(f"Error: Failed to decode JSON from {file_path}.")
+        ksft.exit_fail()
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
+def ensure_unique_function_name(func, initcall_entries):
+    """
+    Ensure the function name is unique by appending a suffix if necessary.
+    @func: the original function name.
+    @initcall_entries: a dictionary containing parsed initcall entries.
+    """
+    i = 2
+    base_func = func
+    while func in initcall_entries:
+        func = f'{base_func}[{i}]'
+        i += 1
+    return func
+
+
+def parse_initcall_latency_hist():
+    """
+    Parse the ftrace histogram for the initcall_latency event, extracting
+    function names, start times, end times, and latencies. Return a
+    dictionary where each entry is structured as follows:
+    {
+        <function symbolic name>: {
+            "start": <start time>,
+            "end": <end time>,
+            "latency": <latency>
+        }
+    }
+    """
+
+    pattern = re.compile(r'\{ func: \[\w+\] ([\w_]+)\s*, start: *(\d+), end: *(\d+) \} hitcount: *\d+  lat: *(\d+)')
+    initcall_entries = {}
+
+    try:
+        with open('/sys/kernel/debug/tracing/events/synthetic/initcall_latency/hist', 'r', encoding="utf-8") as hist_file:
+            for line in hist_file:
+                match = pattern.search(line)
+                if match:
+                    func = match.group(1).strip()
+                    start = int(match.group(2))
+                    end = int(match.group(3))
+                    latency = int(match.group(4))
+
+                    # filter out unresolved names
+                    if not func.startswith("0x"):
+                        func = ensure_unique_function_name(func, initcall_entries)
+
+                        initcall_entries[func] = {
+                            "start": start,
+                            "end": end,
+                            "latency": latency
+                        }
+    except FileNotFoundError:
+        print("Error: Histogram file not found.")
+
+    return initcall_entries
+
+
+def compare_initcall_list(ref_initcall_entries, cur_initcall_entries):
+    """
+    Compare the current list of initcall functions against the reference
+    file. Print warnings if there are unique entries in either.
+    @ref_initcall_entries: reference initcall entries.
+    @cur_initcall_entries: current initcall entries.
+    """
+    ref_entries = set(ref_initcall_entries.keys())
+    cur_entries = set(cur_initcall_entries.keys())
+
+    unique_to_ref = ref_entries - cur_entries
+    unique_to_cur = cur_entries - ref_entries
+
+    if (unique_to_ref):
+        ksft.print_msg(
+            f"Warning: {list(unique_to_ref)} not found in current data. Consider updating reference file.")
+    if unique_to_cur:
+        ksft.print_msg(
+            f"Warning: {list(unique_to_cur)} not found in reference data. Consider updating reference file.")
+
+
+def run_test(ref_file_path, delta, overrides, mode):
+    """
+    Run the test comparing the current timings with the reference values.
+    @ref_file_path: path to the JSON file containing reference values.
+    @delta: default allowed difference between reference and current
+    values.
+    @overrides: override rules in the form of regex:threshold.
+    @mode: the comparison mode (either 'start', 'end', or 'latency').
+    """
+
+    ref_data = load_reference_from_json(ref_file_path)
+
+    ref_initcall_entries = ref_data['data']
+    cur_initcall_entries = parse_initcall_latency_hist()
+
+    compare_initcall_list(ref_initcall_entries, cur_initcall_entries)
+
+    ksft.set_plan(len(ref_initcall_entries))
+
+    for func_name in ref_initcall_entries:
+        effective_delta = delta
+        for regex, override_delta in overrides.items():
+            if re.match(regex, func_name):
+                effective_delta = override_delta
+                break
+        if (func_name in cur_initcall_entries):
+            ref_metric = ref_initcall_entries[func_name].get(mode)
+            cur_metric = cur_initcall_entries[func_name].get(mode)
+            if (cur_metric > ref_metric and (cur_metric - ref_metric) >= effective_delta):
+                ksft.test_result_fail(func_name)
+                ksft.print_msg(f"'{func_name}' {mode} differs by "
+                               f"{(cur_metric - ref_metric)} usecs.")
+            else:
+                ksft.test_result_pass(func_name)
+        else:
+            ksft.test_result_skip(func_name)
+
+
+def generate_reference_file(file_path):
+    """
+    Generate a reference file in JSON format, containing kernel metadata
+    and initcall timing data.
+    @file_path: output file path.
+    """
+    metadata = {}
+
+    config_file = "/proc/config.gz"
+    if os.path.isfile(config_file):
+        with gzip.open(config_file, "rt", encoding="utf-8") as f:
+            config = f.read()
+            metadata["config"] = config
+
+    metadata["version"] = os.uname().release
+
+    cmdline_file = "/proc/cmdline"
+    if os.path.isfile(cmdline_file):
+        with open(cmdline_file, "r", encoding="utf-8") as f:
+            cmdline = f.read().strip()
+            metadata["cmdline"] = cmdline
+
+    ref_data = {
+        "metadata": metadata,
+        "data": parse_initcall_latency_hist(),
+    }
+
+    with open(file_path, "w", encoding='utf-8') as f:
+        json.dump(ref_data, f, indent=4)
+        print(f"Generated {file_path}")
+
+
+if __name__ == "__main__":
+    parser = argparse.ArgumentParser(
+        description="")
+
+    subparsers = parser.add_subparsers(dest='mode', required=True, help='Choose between generate or test modes')
+
+    generate_parser = subparsers.add_parser('generate', help="Generate a reference file")
+    generate_parser.add_argument('out_ref_file', nargs='?', default='reference_initcall_timings.json',
+                                 help='Path to output JSON reference file (default: reference_initcall_timings.json)')
+
+    compare_parser = subparsers.add_parser('test', help='Test against a reference file')
+    compare_parser.add_argument('in_ref_file', help='Path to JSON reference file')
+    compare_parser.add_argument(
+        'delta', type=int, help='Maximum allowed delta between the current and the reference timings (usecs)')
+    compare_parser.add_argument('--override', '-o', action='append', type=str,
+                                help="Specify regex-based rules as regex:delta (e.g., '^acpi_.*:50')")
+    compare_parser.add_argument('--mode', '-m', default='latency', choices=[
+                                'start', 'end', 'latency'],
+                                help="Comparison mode: 'latency' (default) for latency, 'start' for start times, or 'end' for end times.")
+
+    args = parser.parse_args()
+
+    if args.mode == 'generate':
+        generate_reference_file(args.out_ref_file)
+        sys.exit(0)
+
+    # Process overrides
+    overrides = {}
+    if args.override:
+        for override in args.override:
+            try:
+                pattern, delta = override.split(":")
+                overrides[pattern] = int(delta)
+            except ValueError:
+                print(f"Invalid override format: {override}. Expected format is 'regex:delta'.")
+                sys.exit(1)
+
+    # Ensure debugfs is mounted
+    if not mount_debugfs("/sys/kernel/debug"):
+        ksft.exit_fail()
+
+    ksft.print_header()
+
+    run_test(args.in_ref_file, args.delta, overrides, args.mode)
+
+    ksft.finished()
-- 
2.30.2


