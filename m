Return-Path: <linux-kselftest+bounces-27021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1848FA3CE43
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 01:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9435172A60
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 00:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6894433C0;
	Thu, 20 Feb 2025 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQCtl7WG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB15D2FB;
	Thu, 20 Feb 2025 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740012820; cv=none; b=fTWfg/50bruofYxqKldd1FUTFgVKv4kwAybKdERLJWznZh6DZ+5+UTHM1UIoync23gZCRNZYrwkhlS5hMafYAe74eyVwkyd7PxfOTZf14adBSQi9I7dmEe3/142LVHmvKhAEH/tLWgMdKK8RvCTxTHZolJTGKZ6jRBfE11zatqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740012820; c=relaxed/simple;
	bh=6IIF0p9YPSPV5dX53lG7qDn/1akDl51Vw9zyNsDOCBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1Qbsw5Yl3FiZOx0CNLzhCeVOVlEYGKZDb9l/8QOYeCFEki4kpv8ArmX8T5gjrZK3V+dwYnq/BzbDjaNhOcr1/i3FtN89I1VAQp9XWSiT00aPCx4ojlSYvmqTpSZrPhKdCNjPYgXsbtr9ZXEZjEPJsDgbJS+jP7MqYN8lKx/zQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQCtl7WG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292A7C4AF09;
	Thu, 20 Feb 2025 00:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740012820;
	bh=6IIF0p9YPSPV5dX53lG7qDn/1akDl51Vw9zyNsDOCBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQCtl7WGegWhC5WdClWu5DHLfMouKPQ9S9ZPZQJPbfxPR1ga+JpfY69KByBV1KYil
	 vAAqUOIKgtH1pvujtXe8JgTs/BTcBBkroN0T6KuPKn5dHp14fbrwfGAjnIbnuUXF9V
	 cD0xk4YzC3WcXTZZ779ORjEqCT60QnX2FQkbfXbEAu8jdWiYvRTOABLkTbvolHaDn5
	 T797dgeBi8oV5L4klrROaipbwpBCh2hC3p6UBbeX32ao3pSTQOeGof4c++KXEn+oBx
	 5aRdCqWOP3272NabmFuVKNIe5efEAuTj/sctcypyTGqQooNknmu/hqYjQ69JTID/Zg
	 M4+21xO6qEHcQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dxu@dxuuu.xyz,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	hawk@kernel.org,
	petrm@nvidia.com,
	willemb@google.com,
	jstancek@redhat.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 2/2] selftests: drv-net: test installing XDP with HDS set to auto
Date: Wed, 19 Feb 2025 16:53:18 -0800
Message-ID: <20250220005318.560733-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220005318.560733-1-kuba@kernel.org>
References: <20250220005318.560733-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing bnxt:

  # NETIF=eth0  ./ksft-net-drv/drivers/net/hds.py
  KTAP version 1
  1..9
  ok 1 hds.get_hds
  ok 2 hds.get_hds_thresh
  ok 3 hds.set_hds_disable # SKIP disabling of HDS not supported by the device
  ok 4 hds.set_hds_enable
  ok 5 hds.set_hds_thresh_zero
  ok 6 hds.set_hds_thresh_max
  ok 7 hds.set_hds_thresh_gt
  ok 8 hds.set_xdp
  ok 9 hds.set_xdp_enabled
  # Totals: pass:8 fail:0 xfail:0 xpass:0 skip:1 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: hawk@kernel.org
CC: petrm@nvidia.com
CC: willemb@google.com
CC: jstancek@redhat.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/lib/Makefile      |  3 +
 .../testing/selftests/net/lib/xdp_dummy.bpf.c | 13 +++++
 tools/testing/selftests/drivers/net/hds.py    | 55 ++++++++++++++++++-
 3 files changed, 68 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib/xdp_dummy.bpf.c

diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index bc6b6762baf3..c22623b9a2a5 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -9,7 +9,10 @@ TEST_FILES := ../../../../../Documentation/netlink/specs
 TEST_FILES += ../../../../net/ynl
 
 TEST_GEN_FILES += csum
+TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
 
 TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)
 
 include ../../lib.mk
+
+include ../bpf.mk
diff --git a/tools/testing/selftests/net/lib/xdp_dummy.bpf.c b/tools/testing/selftests/net/lib/xdp_dummy.bpf.c
new file mode 100644
index 000000000000..d988b2e0cee8
--- /dev/null
+++ b/tools/testing/selftests/net/lib/xdp_dummy.bpf.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define KBUILD_MODNAME "xdp_dummy"
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("xdp")
+int xdp_dummy_prog(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index 394971b25c0b..cd1a0eea39a8 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -2,17 +2,26 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import errno
+import os
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, KsftSkipEx
-from lib.py import EthtoolFamily, NlError
+from lib.py import CmdExitFailure, EthtoolFamily, NlError
 from lib.py import NetDrvEnv
+from lib.py import defer, ip
 
-def get_hds(cfg, netnl) -> None:
+
+def _get_hds_mode(cfg, netnl) -> str:
     try:
         rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
     except NlError as e:
         raise KsftSkipEx('ring-get not supported by device')
     if 'tcp-data-split' not in rings:
         raise KsftSkipEx('tcp-data-split not supported by device')
+    return rings['tcp-data-split']
+
+
+def get_hds(cfg, netnl) -> None:
+    _get_hds_mode(cfg, netnl)
+
 
 def get_hds_thresh(cfg, netnl) -> None:
     try:
@@ -104,6 +113,44 @@ from lib.py import NetDrvEnv
         netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'hds-thresh': hds_gt})
     ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
 
+
+def set_xdp(cfg, netnl) -> None:
+    """
+    Enable single-buffer XDP on the device.
+    When HDS is in "auto" / UNKNOWN mode, XDP installation should work.
+    """
+    mode = _get_hds_mode(cfg, netnl)
+    if mode == 'enabled':
+        netnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                         'tcp-data-split': 'unknown'})
+
+    test_dir = os.path.dirname(os.path.realpath(__file__))
+    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
+    ip(f"link set dev %s xdp obj %s sec xdp" %
+        (cfg.ifname, prog))
+    ip(f"link set dev %s xdp off" % cfg.ifname)
+
+
+def set_xdp_enabled(cfg, netnl) -> None:
+    """
+    Enable single-buffer XDP on the device.
+    When HDS is in "enabled" mode, XDP installation should not work.
+    """
+    _get_hds_mode(cfg, netnl)
+    netnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                     'tcp-data-split': 'enabled'})
+
+    defer(netnl.rings_set, {'header': {'dev-index': cfg.ifindex},
+                            'tcp-data-split': 'unknown'})
+
+    test_dir = os.path.dirname(os.path.realpath(__file__))
+    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
+    with ksft_raises(CmdExitFailure) as e:
+        ip(f"link set dev %s xdp obj %s sec xdp" %
+            (cfg.ifname, prog))
+        ip(f"link set dev %s xdp off" % cfg.ifname)
+
+
 def main() -> None:
     with NetDrvEnv(__file__, queue_count=3) as cfg:
         ksft_run([get_hds,
@@ -112,7 +159,9 @@ from lib.py import NetDrvEnv
                   set_hds_enable,
                   set_hds_thresh_zero,
                   set_hds_thresh_max,
-                  set_hds_thresh_gt],
+                  set_hds_thresh_gt,
+                  set_xdp,
+                  set_xdp_enabled],
                  args=(cfg, EthtoolFamily()))
     ksft_exit()
 
-- 
2.48.1


