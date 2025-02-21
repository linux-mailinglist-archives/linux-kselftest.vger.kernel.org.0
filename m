Return-Path: <linux-kselftest+bounces-27125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78791A3EAEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 03:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D907AB245
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 02:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8CF1DA60F;
	Fri, 21 Feb 2025 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH6wf84g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A881D9688;
	Fri, 21 Feb 2025 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740106308; cv=none; b=a5S6sT/cfiNefL+/ULX7lYch+yAgZ0bqoKYtOSq2JPX1iwA+S7xcSIq24feRGNybRd/98v9nNH6KaZWngiusVRtL0z7KZbO2wGP4p9fMLNZE4fVZo9wko5doM6u9IsdWtBGuIlQ6GYv3nZ3qcstsF/viWPNKBBdumDgB5M/186c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740106308; c=relaxed/simple;
	bh=t+St5HjA5Bqkcy1SBkbqDovCuONKT1cadgnYNcKioRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+VB53BB3174FfeTt6BfD1O4Aa13E9fgdCw1oF8i8zkJAnAfxaQ9fHetsZJdNFNVIBpLuKnpiB2Ee22zjBfy/af6JZzY1mz20LGmzwrsgU8GuqT35QvRs7R+X7H1hy6qE1JIj+bVS2U3DsWcDVfxL8oDXMejFq5Pr0nRcDoBKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH6wf84g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F54CC4CEE6;
	Fri, 21 Feb 2025 02:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740106307;
	bh=t+St5HjA5Bqkcy1SBkbqDovCuONKT1cadgnYNcKioRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pH6wf84g2elqF5/jbPdzfcPH6cpeFmLbdEb8/nC5Acmnym6hP6VX8f2+qOSAhOF4V
	 iova8C4AzfjhabouP2sf8n8FrXfmjIQX69n1qfpXcMYmVrYUI6A6/plaeeY1s9a2n9
	 QqbxLBk4TtVO7pxoziFUSAMKWlVFf48ehA9hdVj3e2zjXqa8LXEX0PbhLagt8Bd9xp
	 smtZQ6AKQPRVp7tT4X44cb6Hfjffyu4lo4RCJ+tEWmaYW9G83XcS9hVTv75KJsUfsQ
	 tONwV+RikF1ODp3WRDmZ8BoZs12r953eex9DKx8Ln2qlFLVs/4jRhI6epjh4GhvE+5
	 cUdgx2nlBZLcQ==
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
Subject: [PATCH net v2 2/2] selftests: drv-net: test XDP, HDS auto and the ioctl path
Date: Thu, 20 Feb 2025 18:51:41 -0800
Message-ID: <20250221025141.1132944-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221025141.1132944-1-kuba@kernel.org>
References: <20250221025141.1132944-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test XDP and HDS interaction. While at it add a test for using the IOCTL,
as that turned out to be the real culprit.

Testing bnxt:

  # NETIF=eth0 ./ksft-net-drv/drivers/net/hds.py
  KTAP version 1
  1..12
  ok 1 hds.get_hds
  ok 2 hds.get_hds_thresh
  ok 3 hds.set_hds_disable # SKIP disabling of HDS not supported by the device
  ok 4 hds.set_hds_enable
  ok 5 hds.set_hds_thresh_zero
  ok 6 hds.set_hds_thresh_max
  ok 7 hds.set_hds_thresh_gt
  ok 8 hds.set_xdp
  ok 9 hds.enabled_set_xdp
  ok 10 hds.ioctl
  ok 11 hds.ioctl_set_xdp
  ok 12 hds.ioctl_enabled_set_xdp
  # Totals: pass:11 fail:0 xfail:0 xpass:0 skip:1 error:0

and netdevsim:

  # ./ksft-net-drv/drivers/net/hds.py
  KTAP version 1
  1..12
  ok 1 hds.get_hds
  ok 2 hds.get_hds_thresh
  ok 3 hds.set_hds_disable
  ok 4 hds.set_hds_enable
  ok 5 hds.set_hds_thresh_zero
  ok 6 hds.set_hds_thresh_max
  ok 7 hds.set_hds_thresh_gt
  ok 8 hds.set_xdp
  ok 9 hds.enabled_set_xdp
  ok 10 hds.ioctl
  ok 11 hds.ioctl_set_xdp
  ok 12 hds.ioctl_enabled_set_xdp
  # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0

Netdevsim needs a sane default for tx/rx ring size.

ethtool 6.11 is needed for the --disable-netlink option.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Since this is targeting net there is no cfg.rpath(),
I'll follow up once in net-next.

v2:
 - add the ioctl tests
 - factor out some common logic

CC: shuah@kernel.org
CC: hawk@kernel.org
CC: petrm@nvidia.com
CC: willemb@google.com
CC: jstancek@redhat.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/lib/Makefile      |   3 +
 drivers/net/netdevsim/ethtool.c               |   2 +
 .../testing/selftests/net/lib/xdp_dummy.bpf.c |  13 ++
 tools/testing/selftests/drivers/net/hds.py    | 145 +++++++++++++++++-
 4 files changed, 160 insertions(+), 3 deletions(-)
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
diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 5c80fbee7913..7ab358616e03 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -184,9 +184,11 @@ static const struct ethtool_ops nsim_ethtool_ops = {
 
 static void nsim_ethtool_ring_init(struct netdevsim *ns)
 {
+	ns->ethtool.ring.rx_pending = 512;
 	ns->ethtool.ring.rx_max_pending = 4096;
 	ns->ethtool.ring.rx_jumbo_max_pending = 4096;
 	ns->ethtool.ring.rx_mini_max_pending = 4096;
+	ns->ethtool.ring.tx_pending = 512;
 	ns->ethtool.ring.tx_max_pending = 4096;
 }
 
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
index 394971b25c0b..90807b21a6eb 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -2,17 +2,54 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import errno
+import os
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, KsftSkipEx
-from lib.py import EthtoolFamily, NlError
+from lib.py import CmdExitFailure, EthtoolFamily, NlError
 from lib.py import NetDrvEnv
+from lib.py import defer, ethtool, ip
 
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
+def _xdp_onoff(cfg):
+    test_dir = os.path.dirname(os.path.realpath(__file__))
+    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
+    ip(f"link set dev %s xdp obj %s sec xdp" %
+        (cfg.ifname, prog))
+    ip(f"link set dev %s xdp off" % cfg.ifname)
+
+
+def _ioctl_ringparam_modify(cfg, netnl) -> None:
+    """
+    Helper for performing a hopefully unimportant IOCTL SET.
+    IOCTL does not support HDS, so it should not affect the HDS config.
+    """
+    try:
+        rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    except NlError as e:
+        raise KsftSkipEx('ring-get not supported by device')
+
+    if 'tx' not in rings:
+        raise KsftSkipEx('setting Tx ring size not supported')
+
+    try:
+        ethtool(f"--disable-netlink -G {cfg.ifname} tx {rings['tx'] // 2}")
+    except CmdExitFailure as e:
+        ethtool(f"--disable-netlink -G {cfg.ifname} tx {rings['tx'] * 2}")
+    defer(ethtool, f"-G {cfg.ifname} tx {rings['tx']}")
+
+
+def get_hds(cfg, netnl) -> None:
+    _get_hds_mode(cfg, netnl)
+
 
 def get_hds_thresh(cfg, netnl) -> None:
     try:
@@ -104,6 +141,103 @@ from lib.py import NetDrvEnv
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
+    _xdp_onoff(cfg)
+
+
+def enabled_set_xdp(cfg, netnl) -> None:
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
+    with ksft_raises(CmdExitFailure) as e:
+        _xdp_onoff(cfg)
+
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
+    _xdp_onoff(cfg)
+
+
+def enabled_set_xdp(cfg, netnl) -> None:
+    """
+    Enable single-buffer XDP on the device.
+    When HDS is in "enabled" mode, XDP installation should not work.
+    """
+    _get_hds_mode(cfg, netnl)  # Trigger skip if not supported
+
+    netnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                     'tcp-data-split': 'enabled'})
+    defer(netnl.rings_set, {'header': {'dev-index': cfg.ifindex},
+                            'tcp-data-split': 'unknown'})
+
+    with ksft_raises(CmdExitFailure) as e:
+        _xdp_onoff(cfg)
+
+
+def ioctl(cfg, netnl) -> None:
+    mode1 = _get_hds_mode(cfg, netnl)
+    _ioctl_ringparam_modify(cfg, netnl)
+    mode2 = _get_hds_mode(cfg, netnl)
+
+    ksft_eq(mode1, mode2)
+
+
+def ioctl_set_xdp(cfg, netnl) -> None:
+    """
+    Like set_xdp(), but we perturb the settings via the legacy ioctl.
+    """
+    mode = _get_hds_mode(cfg, netnl)
+    if mode == 'enabled':
+        netnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                         'tcp-data-split': 'unknown'})
+
+    _ioctl_ringparam_modify(cfg, netnl)
+
+    _xdp_onoff(cfg)
+
+
+def ioctl_enabled_set_xdp(cfg, netnl) -> None:
+    """
+    Enable single-buffer XDP on the device.
+    When HDS is in "enabled" mode, XDP installation should not work.
+    """
+    _get_hds_mode(cfg, netnl)  # Trigger skip if not supported
+
+    netnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                     'tcp-data-split': 'enabled'})
+    defer(netnl.rings_set, {'header': {'dev-index': cfg.ifindex},
+                            'tcp-data-split': 'unknown'})
+
+    with ksft_raises(CmdExitFailure) as e:
+        _xdp_onoff(cfg)
+
+
 def main() -> None:
     with NetDrvEnv(__file__, queue_count=3) as cfg:
         ksft_run([get_hds,
@@ -112,7 +246,12 @@ from lib.py import NetDrvEnv
                   set_hds_enable,
                   set_hds_thresh_zero,
                   set_hds_thresh_max,
-                  set_hds_thresh_gt],
+                  set_hds_thresh_gt,
+                  set_xdp,
+                  enabled_set_xdp,
+                  ioctl,
+                  ioctl_set_xdp,
+                  ioctl_enabled_set_xdp],
                  args=(cfg, EthtoolFamily()))
     ksft_exit()
 
-- 
2.48.1


