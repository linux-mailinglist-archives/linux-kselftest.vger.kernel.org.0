Return-Path: <linux-kselftest+bounces-42552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9952ABA649E
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 00:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D4B97A9F45
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 22:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F562494ED;
	Sat, 27 Sep 2025 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqO4bI1H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C21248F62;
	Sat, 27 Sep 2025 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759013674; cv=none; b=mXzYxlqYlrVrnnzROAkYI1+6DcIwQCwIApNrPH5Gp9zmwm0GmkBlivEzkI0mVmeZQpb2hJnVOH7/MBntzT4CxQElW6bJTlJNDs5JALlC1VKSL0CHQYVEk3z2KLo/PsFH77pFPKRkRbo+PrcNdnteMYoztA/QcozdNHkbXXu7BVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759013674; c=relaxed/simple;
	bh=wsvtmvrm+Bf3iWDitRFLQogO0ltVeNT/0G/YA1PF/Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvZ+jz9x38+HoTHmzbCrsFBFMberJMdVz9kMuPcT5BKVxt9Y0blCO0rx6MtIcJQbPOB5XKchrE5z31Ma9/RvhbXVgzDlKdkeFi4CmjKysn4xWDnXYKZ8iEV9HcfbHFP+unwZeGT7DVqiZVMMrerFd78kRJep6diMfjoANChlw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqO4bI1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8F2C4CEF5;
	Sat, 27 Sep 2025 22:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759013673;
	bh=wsvtmvrm+Bf3iWDitRFLQogO0ltVeNT/0G/YA1PF/Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jqO4bI1Hn//y0sBzAXNcAdPAU0uj//dgkQj+Hb2VIqhtIwkju753+//pmAgjtdFkf
	 zZUzjjFUO6kdvPCxbvBCRQjEu5YRA60Hid9xkSlfzC0gIejbgi2hu6gZdDDkcMB1WB
	 7CanCmH3cG9j4Cd0YXOEJpVn9kjwvbfAHarR4XOsMnA9XDpiPPAyyLgXurkFKvBRlN
	 /rdy16/fW+guzmGLvKtPl+G1Mw8FysY+ouLXEjFfi6sKCKmwUG6+p5APu84LniODNd
	 cwsiokYvB6K4vAuBd0TwgyhihN8+5469SGbgLqtyihMqqm7CTtAVOSuYFqBplxeM+s
	 dlx5KnDZRhG5Q==
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
Subject: [PATCH net-next v3 8/8] selftests: drv-net: psp: add tests for destroying devices
Date: Sat, 27 Sep 2025 15:54:20 -0700
Message-ID: <20250927225420.1443468-9-kuba@kernel.org>
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

Add tests for making sure device can disappear while associations
exist. This is netdevsim-only since destroying real devices is
more tricky.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 .../drivers/net/hw/lib/py/__init__.py         |  2 +-
 .../selftests/drivers/net/lib/py/__init__.py  |  2 +-
 .../selftests/drivers/net/lib/py/env.py       |  4 ++
 tools/testing/selftests/drivers/net/psp.py    | 58 ++++++++++++++++++-
 tools/testing/selftests/net/lib/py/ksft.py    |  5 ++
 5 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 1c631f3c81f1..0ceb297e7757 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -22,7 +22,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
-        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt
+        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from net.lib.py import NetNSEnter
     from drivers.net.lib.py import GenerateTraffic
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 8a795eeb5051..2a645415c4ca 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -21,7 +21,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
-        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt
+        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `net` library from kernel sources")
     ksft_pr(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index c1f3b608c6d8..01be3d9b9720 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -245,6 +245,10 @@ from .remote import Remote
         if not self.addr_v[ipver] or not self.remote_addr_v[ipver]:
             raise KsftSkipEx(f"Test requires IPv{ipver} connectivity")
 
+    def require_nsim(self):
+        if self._ns is None:
+            raise KsftXfailEx("Test only works on netdevsim")
+
     def _require_cmd(self, comm, key, host=None):
         cached = self._required_cmd.get(comm, {})
         if cached.get(key) is None:
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 37953838abf8..4ae7a785ff10 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -13,6 +13,7 @@ import time
 from lib.py import defer
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises
+from lib.py import ksft_not_none
 from lib.py import KsftSkipEx
 from lib.py import NetDrvEpEnv, PSPFamily, NlError
 from lib.py import bkg, rand_port, wait_port_listen
@@ -500,6 +501,61 @@ from lib.py import bkg, rand_port, wait_port_listen
         _close_psp_conn(cfg, s)
 
 
+def __nsim_psp_rereg(cfg):
+    # The PSP dev ID will change, remember what was there before
+    before = set([x['id'] for x in cfg.pspnl.dev_get({}, dump=True)])
+
+    cfg._ns.nsims[0].dfs_write('psp_rereg', '1')
+
+    after = set([x['id'] for x in cfg.pspnl.dev_get({}, dump=True)])
+
+    new_devs = list(after - before)
+    ksft_eq(len(new_devs), 1)
+    cfg.psp_dev_id = list(after - before)[0]
+
+
+def removal_device_rx(cfg):
+    """ Test removing a netdev / PSD with active Rx assoc """
+
+    # We could technically devlink reload real devices, too
+    # but that kills the control socket. So test this on
+    # netdevsim only for now
+    cfg.require_nsim()
+
+    s = _make_clr_conn(cfg)
+    try:
+        rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                       "dev-id": cfg.psp_dev_id,
+                                       "sock-fd": s.fileno()})
+        ksft_not_none(rx_assoc)
+
+        __nsim_psp_rereg(cfg)
+    finally:
+        _close_conn(cfg, s)
+
+
+def removal_device_bi(cfg):
+    """ Test removing a netdev / PSD with active Rx/Tx assoc """
+
+    # We could technically devlink reload real devices, too
+    # but that kills the control socket. So test this on
+    # netdevsim only for now
+    cfg.require_nsim()
+
+    s = _make_clr_conn(cfg)
+    try:
+        rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                       "dev-id": cfg.psp_dev_id,
+                                       "sock-fd": s.fileno()})
+        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                            "version": 0,
+                            "tx-key": rx_assoc['rx-key'],
+                            "sock-fd": s.fileno()})
+        __nsim_psp_rereg(cfg)
+    finally:
+        _close_conn(cfg, s)
+
+
 def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
     """Build test cases for each combo of PSP version and IP version"""
     def test_case(cfg):
@@ -551,7 +607,7 @@ from lib.py import bkg, rand_port, wait_port_listen
                 ]
 
                 ksft_run(cases=cases, globs=globals(),
-                         case_pfx={"dev_", "data_", "assoc_"},
+                         case_pfx={"dev_", "data_", "assoc_", "removal_"},
                          args=(cfg, ))
 
                 cfg.comm_sock.send(b"exit\0")
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 72cddd6abae8..83b1574f7719 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -72,6 +72,11 @@ KSFT_DISRUPTIVE = True
         _fail("Check failed", a, "does not eval to True", comment)
 
 
+def ksft_not_none(a, comment=""):
+    if a is None:
+        _fail("Check failed", a, "is None", comment)
+
+
 def ksft_in(a, b, comment=""):
     if a not in b:
         _fail("Check failed", a, "not in", b, comment)
-- 
2.51.0


