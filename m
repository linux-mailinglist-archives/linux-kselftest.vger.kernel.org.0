Return-Path: <linux-kselftest+bounces-48645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED18D0CA7E
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 229483016A9C
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 00:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EB71FF1C7;
	Sat, 10 Jan 2026 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJcTAyxB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3321DA0E1;
	Sat, 10 Jan 2026 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768006304; cv=none; b=fDT/bj1gcb3O7x21oE8Of4uulEovjT1+ZH3KzruUxi8eQVOJfkrHZXL0jEP1/AkQN5+FbtjOjY7OulzXlydGVaWPYvf+1y5KHVuMCbQZmpY12i2XKp7K4zCPYndiXGmVNNFdcdr5hUs4msWoA9T6PW/NLibCBW5EulxXI6xbFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768006304; c=relaxed/simple;
	bh=1LRFT51sN/ZHfdIPxUQPgkHlv20rK2kC6IxfJTc1ZsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucL+4pETyN9NLQCdsdUMJf89suqw8Qda6BQJxqvBrjsKSOSYgd5DqFj8jLNIIgD+cy/eCiNNwXKTlKRaPh+exWN3C6KOvF+j6NhcRjtF9a+stuj6TKLDDMLY+Wvm0kj5JD+J6kdcjo9LYVSn2cHNkgyWszKT6padRnjOSQuERDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJcTAyxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17771C4CEF1;
	Sat, 10 Jan 2026 00:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768006301;
	bh=1LRFT51sN/ZHfdIPxUQPgkHlv20rK2kC6IxfJTc1ZsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJcTAyxBPmX9OPsdmK6/wN8MdCXGOrFWrPWFSkMlLZQ+SllhlbjD47Q7ybrAnP2Ae
	 ooiWzefGdJcV3RqjUt3RDPNBziI+W6Zee+4Jm0hZnJD7yv6asts70Hr6lx9igAI+wr
	 XZouL2rBx9VBhyRi1dvKbz8lzPSQcE4GLCSkcQegZeFeuc80daeh3/LiWVDRMhS2nm
	 k7J1NIWNvigdAEwLhvL9EZv4i2qYWPdbz1OCXNRB2a8UdATPDDEWI7M2F75xkoew5I
	 CLrz5tyr82rvbTUUvVaG9fMCFVp4Cgpz3xQIFjtr+RG65iP+XKNrHucj2l/7y9Hsd6
	 heu4gQoGHp9rg==
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
Subject: [PATCH net-next v2 5/6] selftests: drv-net: gro: run the test against HW GRO and LRO
Date: Fri,  9 Jan 2026 16:51:20 -0800
Message-ID: <20260110005121.3561437-6-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110005121.3561437-1-kuba@kernel.org>
References: <20260110005121.3561437-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run the test against HW GRO and LRO. NICs I have pass the base cases.
Interestingly all are happy to build GROs larger than 64k.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
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
 tools/testing/selftests/drivers/net/gro.py | 64 +++++++++++++++++-----
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index b72a1d756d72..112560482d04 100755
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
@@ -108,16 +112,45 @@ from lib.py import ksft_variants
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
+        _set_ethtool_feat(cfg.ifname, cfg.feat,
+                          {"generic-receive-offload": False,
+                           "rx-gro-hw": False,
+                           "large-receive-offload": True})
 
     try:
         # Disable TSO for local tests
@@ -132,19 +165,20 @@ from lib.py import ksft_variants
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
-- 
2.52.0


