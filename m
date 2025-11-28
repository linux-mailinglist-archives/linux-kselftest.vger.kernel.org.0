Return-Path: <linux-kselftest+bounces-46683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F14C90753
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 01:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24F444E1B70
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 00:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868E321B195;
	Fri, 28 Nov 2025 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGH3I33U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B71F2C45;
	Fri, 28 Nov 2025 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764291172; cv=none; b=nb2rNmyXP/jMdWPJx3tFqRfzbcJAudl09/v7G41LOfcrNAQ/54FT4PP5tU6oiHFUgfZHmKqhmkci2euXpfOyh2iaAJL9HgYsfITKlNnxlBMuop7zso/VzK0GSo3/uzRcBkLKfY3esBKuY3vKaHSt0dRmOUhqsLi/wlWUDvGTltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764291172; c=relaxed/simple;
	bh=VILH4vUCCrW+a7hbhx0d3jaKpCUhGW4XckyUTE/R9+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Drb+r9Y2sh/KEY1I7/+x5+E76zeT8gxSGwA2sNE1bKwHvd1tDNLV7AxIA3l/7UBGbUqwLgEsIaPV62+Vu/dgpomfGcOYmgS/QRMtwUr2KnASLwusZxx2dsaxNfyZ+sEBQco682p/9/Zy4OdsTiSzZHv82LTxgHtjHdh6X/Ydsto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGH3I33U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6009CC116C6;
	Fri, 28 Nov 2025 00:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764291171;
	bh=VILH4vUCCrW+a7hbhx0d3jaKpCUhGW4XckyUTE/R9+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGH3I33UySvfBPmxQ1puXfp2HQ9eTtB3V6fhUFrRXZB4zWvVURwaIjHV/tWxZm5u8
	 j7Ej4iPsM0MWk5rBJKWFzU83P2LG/rOHSiPk8TlETbO1558nmLHLHW3FIjEE75hUqU
	 U3s8KroewiC1/GGJ8LdPQj2lBQV8Mzk6YhQ19UT/vInTdZfGubrKszwNbaP5jqKpnx
	 FwEC2PGXDygIHXJbRAbV1WVxLErkWrGFR/MP9zvIQ9YlLHMcCSgq9irO4o7Zl1YPIl
	 ECX3UuZGurhAQaNuEjrFNJVrN80Skd3LAELJVQe+fC0QbvSjLTGfa+f27Mz2eIEw82
	 mP98rvM5asDHA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/2] selftests: drv-net: gro: run the test against HW GRO and LRO
Date: Thu, 27 Nov 2025 16:52:42 -0800
Message-ID: <20251128005242.2604732-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251128005242.2604732-1-kuba@kernel.org>
References: <20251128005242.2604732-1-kuba@kernel.org>
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
CC: shuah@kernel.org
CC: sdf@fomichev.me
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/gro.py | 50 ++++++++++++++++------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 6d633bdc7e67..ea7070b033d4 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -91,7 +91,7 @@ from lib.py import ksft_variants
     defer(ethtool, " ".join(old), host=host)
 
 
-def _setup(cfg, test_name):
+def _setup(cfg, mode, test_name):
     """ Setup hardware loopback mode for GRO testing. """
 
     if not hasattr(cfg, "bin_remote"):
@@ -108,16 +108,37 @@ from lib.py import ksft_variants
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
+        # The only way to get HW GRO but elide SW GRO is to install
+        # a dummy XDP generic program. Disabling SW GRO as a feature
+        # would also disable HW GRO.
+        prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
+        ip(f"link set dev {cfg.ifname} xdpgeneric obj {prog} sec xdp")
+        defer(ip, f"link set dev {cfg.ifname} xdpgeneric off")
+
+        # Attaching XDP may change features, fetch the latest state
+        feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
+
+        _set_ethtool_feat(cfg.ifname, feat,
+                          {"generic-receive-offload": True,
+                           "rx-gro-hw": True,
+                           "large-receive-offload": False})
+    elif mode == "lro":
+        _set_ethtool_feat(cfg.ifname, cfg.feat,
+                          {"generic-receive-offload": False,
+                           "rx-gro-hw": False,
+                           "large-receive-offload": True})
 
     try:
         # Disable TSO for local tests
@@ -132,19 +153,20 @@ from lib.py import ksft_variants
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
2.51.1


