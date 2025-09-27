Return-Path: <linux-kselftest+bounces-42546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C15BBA647D
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 00:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F861899918
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 22:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C723F422;
	Sat, 27 Sep 2025 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBkDaIpN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C21623E359;
	Sat, 27 Sep 2025 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759013670; cv=none; b=kDRA0xX5rApF2eI4qVMOZCBCoaUzZ76SKbWn5X5xtrRiTqgIXBKCCSFwwpqYuoPPIkKAZPkKnkiZpAFmm8GIwJ61HU9jEQp91Xyym/yjACypgP7z9bLbE2veJO1ZxUbn/P4vTNc+TMYjwMW5IDflghwnPamkiOOU4M+WiZij7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759013670; c=relaxed/simple;
	bh=63G6s/hIuEISccWu35llqXFFzTCXdAcE6zfMKa3/f9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e874K25+fFyLjhDpkYEsHQJS2JCpdAgym1PJ+tPAcoG9hs4viBPpFG6+ft+Kfy6vdItr8ivytDzI/JEXFUZUVsXIsBaFEIbwLA9YHHH3SiekaYinyog5idwxw3rPJMCq1a+Q6vW29MzVn3NIXzED4+3/M3BIKaviBMkJe+24dQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBkDaIpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28572C113D0;
	Sat, 27 Sep 2025 22:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759013669;
	bh=63G6s/hIuEISccWu35llqXFFzTCXdAcE6zfMKa3/f9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBkDaIpNjsrzwW0nl7P4Kwu1TvS7yLOYisIM0278l9JY7gXXfeY/GRBXs16nwYKJH
	 Qz3BhOccjBZpu2dU5hRwaIFfxaY27BW1mPelEDtVHXnERd7hCBAOmHsTph3XyK6Gwt
	 CuqzqkoccVMMdrIzPhXiayPCDgwrOPJUkJNj+9t/DSBrCQuhs1407fLCiPadPlQXQw
	 leAkfR/SKx/OwEDSutj6qQwMLsc+AzxsBTTN0C5aggZPPNeg/3ftTuezGwExJX5oyO
	 4oMTa0BwNkyHQ+bY0qNuibggH/WCu503cJcmPPcZvIQj7FYxkjOjgHFh6rBP8zM+jI
	 CHrdIRkSRfqDQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	petrm@nvidia.com,
	willemb@google.com,
	shuah@kernel.org,
	daniel.zahka@gmail.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 2/8] selftests: drv-net: base device access API test
Date: Sat, 27 Sep 2025 15:54:14 -0700
Message-ID: <20250927225420.1443468-3-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250927225420.1443468-1-kuba@kernel.org>
References: <20250927225420.1443468-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simple PSP test to getting info about PSP devices.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
v3:
 - rework the skipping logic, move to a helper run in each test
---
 tools/testing/selftests/drivers/net/Makefile  |  1 +
 tools/testing/selftests/drivers/net/config    |  1 +
 .../drivers/net/hw/lib/py/__init__.py         |  2 +-
 .../selftests/drivers/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/drivers/net/psp.py    | 83 +++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/net/lib/py/ynl.py     |  5 ++
 7 files changed, 93 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/psp.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 984ece05f7f9..102cfb36846c 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -19,6 +19,7 @@ TEST_PROGS := \
 	netcons_sysdata.sh \
 	netpoll_basic.py \
 	ping.py \
+	psp.py \
 	queues.py \
 	stats.py \
 	shaper.py \
diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index f51b77cd0219..601431248d5b 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -1,6 +1,7 @@
 CONFIG_CONFIGFS_FS=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_BTF_MODULES=n
+CONFIG_INET_PSP=y
 CONFIG_IPV6=y
 CONFIG_NETDEVSIM=m
 CONFIG_NETCONSOLE=m
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 1462a339a74b..559c572e296a 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -13,7 +13,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
 
     # Import one by one to avoid pylint false positives
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
-        NlError, RtnlFamily, DevlinkFamily
+        NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, defer, ethtool, fd_read_timeout, ip, \
         rand_port, tool, wait_port_listen
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index a07b56a75c8a..31ecc618050c 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -12,7 +12,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
 
     # Import one by one to avoid pylint false positives
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
-        NlError, RtnlFamily, DevlinkFamily
+        NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
         fd_read_timeout, ip, rand_port, tool, wait_port_listen, wait_file
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
new file mode 100755
index 000000000000..5910222a43ef
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -0,0 +1,83 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Test suite for PSP capable drivers."""
+
+import errno
+
+from lib.py import defer
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_true, ksft_eq
+from lib.py import KsftSkipEx
+from lib.py import NetDrvEpEnv, PSPFamily, NlError
+
+#
+# Test case boiler plate
+#
+
+def _init_psp_dev(cfg):
+    if not hasattr(cfg, 'psp_dev_id'):
+        # Figure out which local device we are testing against
+        for dev in cfg.pspnl.dev_get({}, dump=True):
+            if dev['ifindex'] == cfg.ifindex:
+                cfg.psp_info = dev
+                cfg.psp_dev_id = cfg.psp_info['id']
+                break
+        else:
+            raise KsftSkipEx("No PSP devices found")
+
+    # Enable PSP if necessary
+    cap = cfg.psp_info['psp-versions-cap']
+    ena = cfg.psp_info['psp-versions-ena']
+    if cap != ena:
+        cfg.pspnl.dev_set({'id': cfg.psp_dev_id, 'psp-versions-ena': cap})
+        defer(cfg.pspnl.dev_set, {'id': cfg.psp_dev_id,
+                                  'psp-versions-ena': ena })
+
+#
+# Test cases
+#
+
+def dev_list_devices(cfg):
+    """ Dump all devices """
+    _init_psp_dev(cfg)
+
+    devices = cfg.pspnl.dev_get({}, dump=True)
+
+    found = False
+    for dev in devices:
+        found |= dev['id'] == cfg.psp_dev_id
+    ksft_true(found)
+
+
+def dev_get_device(cfg):
+    """ Get the device we intend to use """
+    _init_psp_dev(cfg)
+
+    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    ksft_eq(dev['id'], cfg.psp_dev_id)
+
+
+def dev_get_device_bad(cfg):
+    """ Test getting device which doesn't exist """
+    raised = False
+    try:
+        cfg.pspnl.dev_get({'id': 1234567})
+    except NlError as e:
+        ksft_eq(e.nl_msg.error, -errno.ENODEV)
+        raised = True
+    ksft_true(raised)
+
+
+def main() -> None:
+    """ Ksft boiler plate main """
+
+    with NetDrvEpEnv(__file__) as cfg:
+        cfg.pspnl = PSPFamily()
+
+        ksft_run(globs=globals(), case_pfx={"dev_",}, args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 02be28dcc089..997b85cc216a 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -6,4 +6,4 @@ from .netns import NetNS, NetNSEnter
 from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
-from .ynl import NetshaperFamily, DevlinkFamily
+from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index 2b3a61ea3bfa..32c223e93b2c 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -61,3 +61,8 @@ from .ksft import ksft_pr, ktap_result
     def __init__(self, recv_size=0):
         super().__init__((SPEC_PATH / Path('devlink.yaml')).as_posix(),
                          schema='', recv_size=recv_size)
+
+class PSPFamily(YnlFamily):
+    def __init__(self, recv_size=0):
+        super().__init__((SPEC_PATH / Path('psp.yaml')).as_posix(),
+                         schema='', recv_size=recv_size)
-- 
2.51.0


