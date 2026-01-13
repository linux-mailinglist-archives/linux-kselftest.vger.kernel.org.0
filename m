Return-Path: <linux-kselftest+bounces-48803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CC2D15EED
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E393830119A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AB21C861A;
	Tue, 13 Jan 2026 00:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPB/GCTj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA93187346;
	Tue, 13 Jan 2026 00:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768262870; cv=none; b=aIUQNkrSFbLlDeUkNhNLAhdvdGx0hE6OUBaVykZdG1DRRcZc3T8cDlIovZHY95CTMPCrXCML40RuJ/9xvAe1g28RhJSqbK5MP6ZY0Oj42K0dBp3wGZPhqGnlsowF+r/dX2a8u4785vPmeoIJ99s1emkVGxjH/YTioo29huJvPtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768262870; c=relaxed/simple;
	bh=fgERdrcP2bnCmPApJN6cfYGyqInKroEEJ1OAoQysGVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNYQwIN8rUQTOqhoOmM1ZguTYvHfoWeQAemHxGfa15T5Yopjt+CwssMbqHxUB3HstVMIKL/7RbUyGoC7H0kQ6O/yrR1Nq/I+tfpbz4n64DQeLe1jKGklX4hn7mJP+g1pQJsOrH8bbAgy0GthKf7NGDhFoMkF5Cn54Zamv/bq14k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPB/GCTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F5BC19423;
	Tue, 13 Jan 2026 00:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768262870;
	bh=fgERdrcP2bnCmPApJN6cfYGyqInKroEEJ1OAoQysGVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rPB/GCTjn0wOJtksnGxpXaq4hSuqaNVxCbtSidMQ+CXDDvOi3Gai+fhG0PtdUo0ib
	 Kaa6tb0zjaJaIddJoDe5Nbp7eXrR0ChGNs3EpPPazMm3qiUJKGDsxxSkGar0CtEQuP
	 l2RegiFRPlxz/t20VmAc8N7XGvpFkoSC1+8ykHpEdMTsvvXH264wKvSi7XLUtUf437
	 ALV0Pjhpjw2yT+b8aJeKz7WJS/HDx/iUB5wggZ9JEaYcty/pqXnN/w1Z5Jv12bn3ym
	 rcR6+nlEqmVsk9Ria+ficWxjoDTS4t7turioAl1FNmHeJd0BrbS72BLlmfpangkK42
	 UekwamwPkVBmw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net-next v3 5/6] selftests: drv-net: gro: run the test against HW GRO and LRO
Date: Mon, 12 Jan 2026 16:07:39 -0800
Message-ID: <20260113000740.255360-6-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113000740.255360-1-kuba@kernel.org>
References: <20260113000740.255360-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run the test against HW GRO and LRO. NICs I have pass the base cases.
Interestingly all are happy to build GROs larger than 64k.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - explicitly skip LRO on netdevsim, it lies about support
v2: https://lore.kernel.org/20260110005121.3561437-6-kuba@kernel.org
 - apply the generic XDP hack selectively (print a msg when it happens)
 - print ethtool -K (setting) output if any, output means that
   kernel reported that something didn't go according to plan
   (features we wanted were not actually enabled)
v1: https://lore.kernel.org/20251128005242.2604732-2-kuba@kernel.org

CC: willemdebruijn.kernel@gmail.com
CC: shuah@kernel.org
CC: sdf@fomichev.me
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/gro.py    | 68 +++++++++++++++----
 .../selftests/drivers/net/lib/py/env.py       |  7 +-
 2 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 3c30749ead39..1ab85590c439 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -87,11 +87,15 @@ from lib.py import ksft_variants
     if no_change:
         return
 
-    ethtool(" ".join(new), host=host)
+    eth_cmd = ethtool(" ".join(new), host=host)
     defer(ethtool, " ".join(old), host=host)
 
+    # If ethtool printed something kernel must have modified some features
+    if eth_cmd.stdout:
+        ksft_pr(eth_cmd)
 
-def _setup(cfg, test_name):
+
+def _setup(cfg, mode, test_name):
     """ Setup hardware loopback mode for GRO testing. """
 
     if not hasattr(cfg, "bin_remote"):
@@ -108,16 +112,49 @@ from lib.py import ksft_variants
         _set_mtu_restore(cfg.dev, 4096, None)
         _set_mtu_restore(cfg.remote_dev, 4096, cfg.remote)
 
-    flush_path = f"/sys/class/net/{cfg.ifname}/gro_flush_timeout"
-    irq_path = f"/sys/class/net/{cfg.ifname}/napi_defer_hard_irqs"
+    if mode == "sw":
+        flush_path = f"/sys/class/net/{cfg.ifname}/gro_flush_timeout"
+        irq_path = f"/sys/class/net/{cfg.ifname}/napi_defer_hard_irqs"
 
-    _write_defer_restore(cfg, flush_path, "200000", defer_undo=True)
-    _write_defer_restore(cfg, irq_path, "10", defer_undo=True)
+        _write_defer_restore(cfg, flush_path, "200000", defer_undo=True)
+        _write_defer_restore(cfg, irq_path, "10", defer_undo=True)
 
-    _set_ethtool_feat(cfg.ifname, cfg.feat,
-                      {"generic-receive-offload": True,
-                       "rx-gro-hw": False,
-                       "large-receive-offload": False})
+        _set_ethtool_feat(cfg.ifname, cfg.feat,
+                          {"generic-receive-offload": True,
+                           "rx-gro-hw": False,
+                           "large-receive-offload": False})
+    elif mode == "hw":
+        _set_ethtool_feat(cfg.ifname, cfg.feat,
+                          {"generic-receive-offload": False,
+                           "rx-gro-hw": True,
+                           "large-receive-offload": False})
+
+        # Some NICs treat HW GRO as a GRO sub-feature so disabling GRO
+        # will also clear HW GRO. Use a hack of installing XDP generic
+        # to skip SW GRO, even when enabled.
+        feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
+        if not feat["rx-gro-hw"]["active"]:
+            ksft_pr("Driver clears HW GRO and SW GRO is cleared, using generic XDP workaround")
+            prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
+            ip(f"link set dev {cfg.ifname} xdpgeneric obj {prog} sec xdp")
+            defer(ip, f"link set dev {cfg.ifname} xdpgeneric off")
+
+            # Attaching XDP may change features, fetch the latest state
+            feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
+
+            _set_ethtool_feat(cfg.ifname, feat,
+                              {"generic-receive-offload": True,
+                               "rx-gro-hw": True,
+                               "large-receive-offload": False})
+    elif mode == "lro":
+        # netdevsim advertises LRO for feature inheritance testing with
+        # bonding/team tests but it doesn't actually perform the offload
+        cfg.require_nsim(nsim_test=False)
+
+        _set_ethtool_feat(cfg.ifname, cfg.feat,
+                          {"generic-receive-offload": False,
+                           "rx-gro-hw": False,
+                           "large-receive-offload": True})
 
     try:
         # Disable TSO for local tests
@@ -133,19 +170,20 @@ from lib.py import ksft_variants
 def _gro_variants():
     """Generator that yields all combinations of protocol and test types."""
 
-    for protocol in ["ipv4", "ipv6", "ipip"]:
-        for test_name in ["data", "ack", "flags", "tcp", "ip", "large"]:
-            yield protocol, test_name
+    for mode in ["sw", "hw", "lro"]:
+        for protocol in ["ipv4", "ipv6", "ipip"]:
+            for test_name in ["data", "ack", "flags", "tcp", "ip", "large"]:
+                yield mode, protocol, test_name
 
 
 @ksft_variants(_gro_variants())
-def test(cfg, protocol, test_name):
+def test(cfg, mode, protocol, test_name):
     """Run a single GRO test with retries."""
 
     ipver = "6" if protocol[-1] == "6" else "4"
     cfg.require_ipver(ipver)
 
-    _setup(cfg, test_name)
+    _setup(cfg, mode, test_name)
 
     base_cmd_args = [
         f"--{protocol}",
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 63495376e654..41cc248ac848 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -248,9 +248,12 @@ from .remote import Remote
         if not self.addr_v[ipver] or not self.remote_addr_v[ipver]:
             raise KsftSkipEx(f"Test requires IPv{ipver} connectivity")
 
-    def require_nsim(self):
-        if self._ns is None:
+    def require_nsim(self, nsim_test=True):
+        """Require or exclude netdevsim for this test"""
+        if nsim_test and self._ns is None:
             raise KsftXfailEx("Test only works on netdevsim")
+        if nsim_test is False and self._ns is not None:
+            raise KsftXfailEx("Test does not work on netdevsim")
 
     def _require_cmd(self, comm, key, host=None):
         cached = self._required_cmd.get(comm, {})
-- 
2.52.0


