Return-Path: <linux-kselftest+bounces-16459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAAE96180C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 21:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F540284907
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C9B1CDFC3;
	Tue, 27 Aug 2024 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT5tBWc4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4131C6F56;
	Tue, 27 Aug 2024 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724787265; cv=none; b=gdEzFajek56jTK1AtcBUIaw7Y7yec9Ob2tYL6U0RNj/t6me482iIHZdLmTCMlrH2I48JVdBb+kLbG0uFeM5HZafTwbs05PixXAf4cNOy6aePHE5bS/VMqMk2G7g/PpeyDFq6U2BUtVMmHNjklNQsqUM623QHqw+DbUrqjuB1BXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724787265; c=relaxed/simple;
	bh=kbgHFTSgJjCrFxxVA04pn1VXnLedoDxt7vSM3JlRZYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjE70NgZXozWsy1yi5Pzjy0IzDwkdLsCrxnA52ekgP/HvrQFHSzQi+HLb5+po4ZZjivEBMHVkna7bgufV7s79dT+xhl6qqqv3w1871AQLiI3g2CeEblU4zEPa5mNJMlbuBubpMhnlhaFYn/2dxgLEQ7jLETFjnXFJSiymq5kUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT5tBWc4; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d608060241so4713434eaf.1;
        Tue, 27 Aug 2024 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724787262; x=1725392062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYX9SMycj+S24+El20L+75nTPcABWUD0xdcCguemDmE=;
        b=ZT5tBWc4T+OSL3PL8ZsRxy+fzUbMT+41kfZxsFoYQzWb4KCBhurH2CdgsRFLrGnD1L
         KOgSvjPoQNzlgKGD7zFxikIP4Si10GlCgg4UEY8Rid94Yk5FX1OcagCahTk0wHPrOv2Q
         4LmSFnzLmM/WlVEIoIxKeocauvqTKVq1pme3CyXpaWPfozBMxtTbA75WBTN3bcZGbBtL
         JcLYZ4tGORhxeHaWTejge2KHGd0vLlQrzXCt3XfM2ItnrIFVqaxsd2Hs70jEJM2DwE93
         TeYR+I920XYZMCtMpGPOGqvozLVffZetEAj+QcZH500nHOpjXLNbHIx/12zW5s1lRC0o
         z2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724787262; x=1725392062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYX9SMycj+S24+El20L+75nTPcABWUD0xdcCguemDmE=;
        b=PykjgGcGeS7o0ETrwZkdR0L/v5+oQP6L3C3iYOu6g+tV5Y2V3y0gRdKOxnt1IoTMDt
         IIhqzDkZ01L1nGLLwIBKNN7Bs6G5ANibyXy83K8KGrBr0c4PyEcwo/hYdbFhM4Q7FGuh
         7mJGG3X+JNZe3szeoWKPGkvXCU6xWtfmLXQFgCTRcmbgVgbkWRlYYSBE9vccxSrc+8rs
         3oPig16jhLyjAN67dJsIRDHOwpTzpjeUCS5fkRPb2RHamgiZ3+9mbg0UDxn+/RsMOzvV
         r1t7RoCVhD9mnUOECdGw6Fsugz27m6Khjdh9PF5uTHGpZ9A+JkqkDVk96jceLjNNYEd5
         Z8yg==
X-Forwarded-Encrypted: i=1; AJvYcCVJlIbWeqF3QGdqPg8GXiiWKv173cKzfXbqqtJKNFKwUN0uUUb/F7K+4nNvIxrDETNZXeotDsX3BL/9gsni6Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVP3S4VBRn7L1dolz3y4j2qw73OEFrgIWPq1/Q/v+QXznJ4fZr
	arl+aHlRJCroB7JRHkdFxk3Avf68YHkN50lqBs0soR5Oczct/zaUb2soAA==
X-Google-Smtp-Source: AGHT+IEomU+mO2BlBlPLF39PG8r1B3e4hYATdQyH1Gc0Y0jMT4mXg5sHE7sByFE9mXd+htXw8gl3Xw==
X-Received: by 2002:a05:6358:63a6:b0:1ac:f323:ea18 with SMTP id e5c5f4694b2df-1b5ebf28b16mr499580655d.8.1724787262037;
        Tue, 27 Aug 2024 12:34:22 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f31b2d5sm580271085a.12.2024.08.27.12.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:34:21 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ncardwell@google.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	fw@strlen.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next RFC] selftests/net: integrate packetdrill with ksft
Date: Tue, 27 Aug 2024 15:32:29 -0400
Message-ID: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Lay the groundwork to import into kselftests the over 150 packetdrill
TCP/IP conformance tests on github.com/google/packetdrill.

Florian recently added support for packetdrill tests in nf_conntrack,
in commit a8a388c2aae49 ("selftests: netfilter: add packetdrill based
conntrack tests").

This patch takes a slightly different implementation and reuses the
ksft python library for its KTAP, ksft, NetNS and other such tooling.

It also anticipates the large number of testcases, by creating a
separate kselftest for each feature (directory). It does this by
copying the template script packetdrill_ksft.py for each directory,
and putting those in TEST_CUSTOM_PROGS so that kselftests runs each.

To demonstrate the code with minimal patch size, initially import only
two features/directories from github. One with a single script, and
one with two. This was the only reason to pick tcp/inq and tcp/md5.

Any future imports of packetdrill tests should require no additional
coding. Just add the tcp/$FEATURE directory with *.pkt files.

Implementation notes:
- restore alphabetical order when adding the new directory to
  tools/testing/selftests/Makefile
- copied *.pkt files and support verbatim from the github project,
  except for
    - update common/defaults.sh path (there are two paths on github)
    - add SPDX headers
    - remove one author statement
    - Acknowledgment: drop an e (checkpatch)

Tested:
	make -C tools/testing/selftests/ \
	  TARGETS=net/packetdrill \
	  install INSTALL_PATH=$KSFT_INSTALL_PATH

	# in virtme-ng
	sudo ./run_kselftest.sh -c net/packetdrill
	sudo ./run_kselftest.sh -t net/packetdrill:tcp_inq.py

Result:
	kselftest: Running tests in net/packetdrill
	TAP version 13
	1..2
	# timeout set to 45
	# selftests: net/packetdrill: tcp_inq.py
	# KTAP version 1
	# 1..4
	# ok 1 tcp_inq.client-v4
	# ok 2 tcp_inq.client-v6
	# ok 3 tcp_inq.server-v4
	# ok 4 tcp_inq.server-v6
	# # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
	ok 1 selftests: net/packetdrill: tcp_inq.py
	# timeout set to 45
	# selftests: net/packetdrill: tcp_md5.py
	# KTAP version 1
	# 1..2
	# ok 1 tcp_md5.md5-only-on-client-ack-v4
	# ok 2 tcp_md5.md5-only-on-client-ack-v6
	# # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
	ok 2 selftests: net/packetdrill: tcp_md5.py

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

RFC points for discussion

ksft: the choice for this python framework introduces a dependency on
the YNL scripts, and some non-obvious code:
- to include the net/lib dep in tools/testing/selftests/Makefile
- a boilerplate lib/py/__init__.py that each user of ksft will need
It seems preferable to me to use ksft.py over reinventing the wheel,
e.g., to print KTAP output. But perhaps we can make it more obvious
for future ksft users, and make the dependency on YNL optional.

kselftest-per-directory: copying packetdrill_ksft.py to create a
separate script per dir is a bit of a hack. A single script is much
simpler, optionally with nested KTAP (not supported yet by ksft). But,
I'm afraid that running time without intermediate output will be very
long when we integrate all packetdrill scripts.

nf_conntrack: we can dedup the common.sh.

*pkt files: which of the 150+ scripts on github are candidates for
kselftests, all or a subset? To avoid change detector tests. And what
is the best way to eventually send up to 150 files, 7K LoC.
---
 tools/testing/selftests/Makefile              |  7 +-
 .../selftests/net/packetdrill/.gitignore      |  1 +
 .../selftests/net/packetdrill/Makefile        | 28 ++++++
 .../net/packetdrill/lib/py/__init__.py        | 15 ++++
 .../net/packetdrill/packetdrill_ksft.py       | 90 +++++++++++++++++++
 .../net/packetdrill/tcp/common/defaults.sh    | 63 +++++++++++++
 .../net/packetdrill/tcp/common/set_sysctls.py | 38 ++++++++
 .../net/packetdrill/tcp/inq/client.pkt        | 51 +++++++++++
 .../net/packetdrill/tcp/inq/server.pkt        | 51 +++++++++++
 .../tcp/md5/md5-only-on-client-ack.pkt        | 28 ++++++
 10 files changed, 369 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/.gitignore
 create mode 100644 tools/testing/selftests/net/packetdrill/Makefile
 create mode 100644 tools/testing/selftests/net/packetdrill/lib/py/__init__.py
 create mode 100755 tools/testing/selftests/net/packetdrill/packetdrill_ksft.py
 create mode 100755 tools/testing/selftests/net/packetdrill/tcp/common/defaults.sh
 create mode 100755 tools/testing/selftests/net/packetdrill/tcp/common/set_sysctls.py
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp/inq/client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp/inq/server.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp/md5/md5-only-on-client-ack.pkt

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index a5f1c0c27dff9..f03d6fee7ac54 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -65,10 +65,11 @@ TARGETS += net/af_unix
 TARGETS += net/forwarding
 TARGETS += net/hsr
 TARGETS += net/mptcp
-TARGETS += net/openvswitch
-TARGETS += net/tcp_ao
 TARGETS += net/netfilter
+TARGETS += net/openvswitch
+TARGETS += net/packetdrill
 TARGETS += net/rds
+TARGETS += net/tcp_ao
 TARGETS += nsfs
 TARGETS += perf_events
 TARGETS += pidfd
@@ -122,7 +123,7 @@ TARGETS_HOTPLUG = cpu-hotplug
 TARGETS_HOTPLUG += memory-hotplug
 
 # Networking tests want the net/lib target, include it automatically
-ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
+ifneq ($(filter net net/packetdrill drivers/net drivers/net/hw,$(TARGETS)),)
 ifeq ($(filter net/lib,$(TARGETS)),)
 	INSTALL_DEP_TARGETS := net/lib
 endif
diff --git a/tools/testing/selftests/net/packetdrill/.gitignore b/tools/testing/selftests/net/packetdrill/.gitignore
new file mode 100644
index 0000000000000..a40f1a600eb94
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/.gitignore
@@ -0,0 +1 @@
+tcp*sh
diff --git a/tools/testing/selftests/net/packetdrill/Makefile b/tools/testing/selftests/net/packetdrill/Makefile
new file mode 100644
index 0000000000000..d94c51098d1f0
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/Makefile
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# KSFT includes
+TEST_INCLUDES := $(wildcard lib/py/*.py ../lib/py/*.py)
+
+# Packetdrill support file(s)
+TEST_INCLUDES += tcp/common/defaults.sh
+TEST_INCLUDES += tcp/common/set_sysctls.py
+
+# Packetdrill scripts: all .pkt in subdirectories
+TEST_INCLUDES += $(wildcard tcp/**/*.pkt)
+
+# Create a separate ksft test for each subdirectory
+# Running all packetdrill tests in one go will take too long
+#
+# For each tcp/$subdir, create a test script tcp_$subdir.py
+# Exclude tcp/common, which is a helper directory
+TEST_DIRS := $(wildcard tcp/*)
+TEST_DIRS := $(filter-out tcp/common, $(TEST_DIRS))
+TEST_CUSTOM_PROGS := $(foreach dir,$(TEST_DIRS),$(subst /,_,$(dir)).py)
+
+$(TEST_CUSTOM_PROGS) : packetdrill_ksft.py
+	cp $< $@
+
+# Needed to generate all TEST_CUSTOM_PROGS
+all: $(TEST_CUSTOM_PROGS)
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/packetdrill/lib/py/__init__.py b/tools/testing/selftests/net/packetdrill/lib/py/__init__.py
new file mode 100644
index 0000000000000..51bb6dda43d65
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/lib/py/__init__.py
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import pathlib
+import sys
+
+KSFT_DIR = (pathlib.Path(__file__).parent / "../../../..").resolve()
+
+try:
+    sys.path.append(KSFT_DIR.as_posix())
+    from net.lib.py import *
+except ModuleNotFoundError as e:
+    ksft_pr("Failed importing `net` library from kernel sources")
+    ksft_pr(str(e))
+    ktap_result(True, comment="SKIP")
+    sys.exit(4)
diff --git a/tools/testing/selftests/net/packetdrill/packetdrill_ksft.py b/tools/testing/selftests/net/packetdrill/packetdrill_ksft.py
new file mode 100755
index 0000000000000..62572a5b8331c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/packetdrill_ksft.py
@@ -0,0 +1,90 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Run packetdrill tests in the ksft harness.
+
+   Run all packetdrill tests in a subdirectory.
+   Detect the relevant subdirectory from this script name.
+   (Because the script cannot be given arguments.)
+
+   Run each test, for both IPv4 and IPv6.
+   Return a separate ksft result for each test case.
+"""
+
+import glob
+import os
+import pathlib
+import shutil
+
+from lib.py import cmd, ksft_exit, ksft_run, KsftSkipEx, NetNS
+
+
+def test_func_builder(pktfile_path, ipv4):
+    """Create a function that can be passed to ksft_run."""
+
+    def f():
+        if ipv4:
+            args = ("--ip_version=ipv4 "
+                    "--local_ip=192.168.0.1 "
+                    "--gateway_ip=192.168.0.1 "
+                    "--netmask_ip=255.255.0.0 "
+                    "--remote_ip=192.0.2.1 "
+                    "-D CMSG_LEVEL_IP=SOL_IP "
+                    "-D CMSG_TYPE_RECVERR=IP_RECVERR "
+                    )
+        else:
+            args = ("--ip_version=ipv6 --mtu=1520 "
+                    "--local_ip=fd3d:0a0b:17d6::1 "
+                    "--gateway_ip=fd3d:0a0b:17d6:8888::1 "
+                    "--remote_ip=fd3d:fa7b:d17d::1 "
+                    "-D CMSG_LEVEL_IP=SOL_IPV6 "
+                    "-D CMSG_TYPE_RECVERR=IPV6_RECVERR"
+                    )
+
+        if not shutil.which("packetdrill"):
+            raise KsftSkipEx("Cannot find packetdrill")
+
+        netns = NetNS()
+
+        # Call packetdrill from the directory hosting the .pkt script,
+        # because scripts can have relative includes.
+        savedir = os.getcwd()
+        os.chdir(os.path.dirname(pktfile_path))
+        basename = os.path.basename(pktfile_path)
+        cmd(f"packetdrill {args} {basename}", ns=netns)
+        os.chdir(savedir)
+
+    if ipv4:
+        f.__name__ = pathlib.Path(pktfile_path).stem + "-v4"
+    else:
+        f.__name__ = pathlib.Path(pktfile_path).stem + "-v6"
+
+    return f
+
+
+def scriptname_to_testdir(filepath):
+    """Extract the directory to run from this filename."""
+
+    suffix = ".sh"
+
+    subdir = os.path.basename(filepath)
+    subdir = subdir[:-len(suffix)]
+    subdir = subdir.replace("_", "/")
+    return subdir
+
+
+def main() -> None:
+    subdir = scriptname_to_testdir(__file__)
+    files = glob.glob(f"{subdir}/**/*.pkt", recursive=True)
+
+    cases = []
+    for file in files:
+        for ipv4 in [True, False]:
+            cases.append(test_func_builder(file, ipv4=ipv4))
+
+    ksft_run(cases=cases)
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/packetdrill/tcp/common/defaults.sh b/tools/testing/selftests/net/packetdrill/tcp/common/defaults.sh
new file mode 100755
index 0000000000000..1095a7b22f44d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp/common/defaults.sh
@@ -0,0 +1,63 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Set standard production config values that relate to TCP behavior.
+
+# Flush old cached data (fastopen cookies).
+ip tcp_metrics flush all > /dev/null 2>&1
+
+# TCP min, default, and max receive and send buffer sizes.
+sysctl -q net.ipv4.tcp_rmem="4096 540000 $((15*1024*1024))"
+sysctl -q net.ipv4.tcp_wmem="4096 $((256*1024)) 4194304"
+
+# TCP timestamps.
+sysctl -q net.ipv4.tcp_timestamps=1
+
+# TCP SYN(ACK) retry thresholds
+sysctl -q net.ipv4.tcp_syn_retries=5
+sysctl -q net.ipv4.tcp_synack_retries=5
+
+# TCP Forward RTO-Recovery, RFC 5682.
+sysctl -q net.ipv4.tcp_frto=2
+
+# TCP Selective Acknowledgements (SACK)
+sysctl -q net.ipv4.tcp_sack=1
+
+# TCP Duplicate Selective Acknowledgements (DSACK)
+sysctl -q net.ipv4.tcp_dsack=1
+
+# TCP FACK (Forward Acknowldgement)
+sysctl -q net.ipv4.tcp_fack=0
+
+# TCP reordering degree ("dupthresh" threshold for entering Fast Recovery).
+sysctl -q net.ipv4.tcp_reordering=3
+
+# TCP congestion control.
+sysctl -q net.ipv4.tcp_congestion_control=cubic
+
+# TCP slow start after idle.
+sysctl -q net.ipv4.tcp_slow_start_after_idle=0
+
+# TCP RACK and TLP.
+sysctl -q net.ipv4.tcp_early_retrans=4 net.ipv4.tcp_recovery=1
+
+# TCP method for deciding when to defer sending to accumulate big TSO packets.
+sysctl -q net.ipv4.tcp_tso_win_divisor=3
+
+# TCP Explicit Congestion Notification (ECN)
+sysctl -q net.ipv4.tcp_ecn=0
+
+sysctl -q net.ipv4.tcp_pacing_ss_ratio=200
+sysctl -q net.ipv4.tcp_pacing_ca_ratio=120
+sysctl -q net.ipv4.tcp_notsent_lowat=4294967295 > /dev/null 2>&1
+
+sysctl -q net.ipv4.tcp_fastopen=0x70403
+sysctl -q net.ipv4.tcp_fastopen_key=a1a1a1a1-b2b2b2b2-c3c3c3c3-d4d4d4d4
+
+sysctl -q net.ipv4.tcp_syncookies=1
+
+# Override the default qdisc on the tun device.
+# Many tests fail with timing errors if the default
+# is FQ and that paces their flows.
+tc qdisc add dev tun0 root pfifo
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp/common/set_sysctls.py b/tools/testing/selftests/net/packetdrill/tcp/common/set_sysctls.py
new file mode 100755
index 0000000000000..5ddf456ae973a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp/common/set_sysctls.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Sets sysctl values and writes a file that restores them.
+
+The arguments are of the form "<proc-file>=<val>" separated by spaces.
+The program first reads the current value of the proc-file and creates
+a shell script named "/tmp/sysctl_restore_${PACKETDRILL_PID}.sh" which
+restores the values when executed. It then sets the new values.
+
+PACKETDRILL_PID is set by packetdrill to the pid of itself, so a .pkt
+file could restore sysctls by running `/tmp/sysctl_restore_${PPID}.sh`
+at the end.
+"""
+
+import os
+import subprocess
+import sys
+
+filename = '/tmp/sysctl_restore_%s.sh' % os.environ['PACKETDRILL_PID']
+
+# Open file for restoring sysctl values
+restore_file = open(filename, 'w')
+print('#!/bin/bash', file=restore_file)
+
+for a in sys.argv[1:]:
+  sysctl = a.split('=')
+  # sysctl[0] contains the proc-file name, sysctl[1] the new value
+
+  # read current value and add restore command to file
+  cur_val = subprocess.check_output(['cat', sysctl[0]], universal_newlines=True)
+  print('echo "%s" > %s' % (cur_val.strip(), sysctl[0]), file=restore_file)
+
+  # set new value
+  cmd = 'echo "%s" > %s' % (sysctl[1], sysctl[0])
+  os.system(cmd)
+
+os.system('chmod u+x %s' % filename)
diff --git a/tools/testing/selftests/net/packetdrill/tcp/inq/client.pkt b/tools/testing/selftests/net/packetdrill/tcp/inq/client.pkt
new file mode 100644
index 0000000000000..8cc7798c7808f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp/inq/client.pkt
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test TCP_INQ and TCP_CM_INQ on the client side.
+`../common/defaults.sh
+`
+
+// Create a socket and set it to non-blocking.
+    0	socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0	fcntl(3, F_GETFL) = 0x2 (flags O_RDWR)
+   +0	fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+
+// Connect to the server and enable TCP_INQ.
+   +0	connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+   +0	setsockopt(3, SOL_TCP, TCP_INQ, [1], 4) = 0
+
+   +0	> S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+ +.01	< S. 0:0(0) ack 1 win 5792 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 7>
+   +0	> . 1:1(0) ack 1 <nop,nop,TS val 200 ecr 700>
+
+// Now we have 10K of data ready on the socket.
+   +0	< . 1:10001(10000) ack 1 win 514
+   +0	> . 1:1(0) ack 10001 <nop,nop,TS val 200 ecr 700>
+
+// We read 1K and we should have 9K ready to read.
+   +0	recvmsg(3, {msg_name(...)=...,
+		    msg_iov(1)=[{..., 1000}],
+		    msg_flags=0,
+		    msg_control=[{cmsg_level=SOL_TCP,
+				  cmsg_type=TCP_CM_INQ,
+				  cmsg_data=9000}]}, 0) = 1000
+// We read 9K and we should have no further data ready to read.
+   +0	recvmsg(3, {msg_name(...)=...,
+		    msg_iov(1)=[{..., 9000}],
+		    msg_flags=0,
+		    msg_control=[{cmsg_level=SOL_TCP,
+				  cmsg_type=TCP_CM_INQ,
+				  cmsg_data=0}]}, 0) = 9000
+
+// Server sends more data and closes the connections.
+   +0	< F. 10001:20001(10000) ack 1 win 514
+   +0	> . 1:1(0) ack 20002 <nop,nop,TS val 200 ecr 700>
+
+// We read 10K and we should have one "fake" byte because the connection is
+// closed.
+   +0	recvmsg(3, {msg_name(...)=...,
+		    msg_iov(1)=[{..., 10000}],
+		    msg_flags=0,
+		    msg_control=[{cmsg_level=SOL_TCP,
+				  cmsg_type=TCP_CM_INQ,
+				  cmsg_data=1}]}, 0) = 10000
+// Now, receive EOF.
+   +0	read(3, ..., 2000) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp/inq/server.pkt b/tools/testing/selftests/net/packetdrill/tcp/inq/server.pkt
new file mode 100644
index 0000000000000..fd78609087b91
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp/inq/server.pkt
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test TCP_INQ and TCP_CM_INQ on the server side.
+`../common/defaults.sh
+`
+
+// Initialize connection
+    0	socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0	setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0	bind(3, ..., ...) = 0
+   +0	listen(3, 1) = 0
+
+   +0	< S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 10>
+   +0	> S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+ +.01	< . 1:1(0) ack 1 win 514
+
+// Accept the connection and enable TCP_INQ.
+   +0	accept(3, ..., ...) = 4
+   +0	setsockopt(4, SOL_TCP, TCP_INQ, [1], 4) = 0
+
+// Now we have 10K of data ready on the socket.
+   +0	< . 1:10001(10000) ack 1 win 514
+   +0	> . 1:1(0) ack 10001
+
+// We read 2K and we should have 8K ready to read.
+   +0	recvmsg(4, {msg_name(...)=...,
+		    msg_iov(1)=[{..., 2000}],
+		    msg_flags=0,
+		    msg_control=[{cmsg_level=SOL_TCP,
+				  cmsg_type=TCP_CM_INQ,
+				  cmsg_data=8000}]}, 0) = 2000
+// We read 8K and we should have no further data ready to read.
+   +0	recvmsg(4, {msg_name(...)=...,
+		    msg_iov(1)=[{..., 8000}],
+		    msg_flags=0,
+		    msg_control=[{cmsg_level=SOL_TCP,
+				  cmsg_type=TCP_CM_INQ,
+				  cmsg_data=0}]}, 0) = 8000
+// Client sends more data and closes the connections.
+   +0	< F. 10001:20001(10000) ack 1 win 514
+   +0	> . 1:1(0) ack 20002
+
+// We read 10K and we should have one "fake" byte because the connection is
+// closed.
+   +0	recvmsg(4, {msg_name(...)=...,
+		    msg_iov(1)=[{..., 10000}],
+		    msg_flags=0,
+		    msg_control=[{cmsg_level=SOL_TCP,
+				  cmsg_type=TCP_CM_INQ,
+				  cmsg_data=1}]}, 0) = 10000
+// Now, receive error.
+   +0	read(3, ..., 2000) = -1 ENOTCONN (Transport endpoint is not connected)
diff --git a/tools/testing/selftests/net/packetdrill/tcp/md5/md5-only-on-client-ack.pkt b/tools/testing/selftests/net/packetdrill/tcp/md5/md5-only-on-client-ack.pkt
new file mode 100644
index 0000000000000..42b712e14e562
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp/md5/md5-only-on-client-ack.pkt
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test what happens when client does not provide MD5 on SYN,
+// but then does on the ACK that completes the three-way handshake.
+
+`../common/defaults.sh`
+
+// Establish a connection.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 10>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+// Ooh, weird: client provides MD5 option on the ACK:
+ +.01 < . 1:1(0) ack 1 win 514 <md5 000102030405060708090a0b0c0d0e0f,nop,nop>
+ +.01 < . 1:1(0) ack 1 win 514 <md5 000102030405060708090a0b0c0d0e0f,nop,nop>
+
+// The TCP listener refcount should be 2, but on buggy kernels it can be 0:
+   +0 `grep " 0A " /proc/net/tcp /proc/net/tcp6 | grep ":1F90"`
+
+// Now here comes the legit ACK:
+ +.01 < . 1:1(0) ack 1 win 514
+
+// Make sure the connection is OK:
+   +0 accept(3, ..., ...) = 4
+
+ +.01 write(4, ..., 1000) = 1000
-- 
2.46.0.469.g59c65b2a67-goog


