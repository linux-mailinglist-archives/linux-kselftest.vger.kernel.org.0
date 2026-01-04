Return-Path: <linux-kselftest+bounces-48142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A0DCF1380
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 19:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BBF43000EBA
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 18:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423DF313E10;
	Sun,  4 Jan 2026 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbFS7+mZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16661313E0A;
	Sun,  4 Jan 2026 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767552371; cv=none; b=kFPIyJmsuUXNHWibHN6d7UENH9i+TMhcj3R5neO8GRb/5wKilvv+7+Rib0i2Bu19p1bDCtK8E2EvxfbSX6ySCLyd67iJglfV5fur3bE+R383fNKWO9RllbFlvfkQQZMrCDFJlAZQHMuhbE/nl+6DlPuErgnGAViPv2qA+Z33Dzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767552371; c=relaxed/simple;
	bh=DJRqWfjAnc68o32BNUsIZ4YkJ68XYVkr/l7dJC6cRuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCZG9dD8f9OHnBx8QIf/M10jXqzyjjVu9n71955CqcnvAFVlVkWzFV7A16ZdGQikGcWQa2R5CZycHKdJCCjBkgYYR/7jSbq9/W4l7s8ps+6e9mlzDX97sOOhNjxT5z5WNb3qIdiLbCrGipYIwrIj0KiJlsvsMhB41bM4rnXjh+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbFS7+mZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1481C4CEF7;
	Sun,  4 Jan 2026 18:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767552368;
	bh=DJRqWfjAnc68o32BNUsIZ4YkJ68XYVkr/l7dJC6cRuI=;
	h=From:To:Cc:Subject:Date:From;
	b=RbFS7+mZ8wIfBAL1hzmTnQq5T/MU1J5knRf44oDp3Tl67x6ftckLm6f797KbPgiTm
	 7mYlpMX4j3/GUb4Waap+uhEQnXSAvdjzvh1g9zQ1BGz+dFpZQGm9q54P/Ai3EYqV87
	 UeFGPdO74zgRv24Ddi80DKIb6twlHBAt1w7a6ESeBVWC9ZTCHfOMkOgurH2OZJV8A6
	 bNl1yEBIM6lmW33QSSzJ8pmDzsz0dTKVtxlP4FxtHLLhBz1ONpBFYR3Z04w8QiKEOn
	 cxQr8m6EJ4kkEX6AIvGneG2+pUiBBQkeLmGnCZta9Vd1k3yDYCXB4l2+Bcb8cZesLb
	 fhStqmwN8t1fw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	gal@nvidia.com,
	noren@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: hw-net: rss-input-xfrm: try to enable the xfrm at the start
Date: Sun,  4 Jan 2026 10:46:00 -0800
Message-ID: <20260104184600.795280-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test currently SKIPs if the symmetric RSS xfrm is not enabled
by default. This leads to spurious SKIPs in the Intel CI reporting
results to NIPA.

Testing on CX7:

 # ./drivers/net/hw/rss_input_xfrm.py
  TAP version 13
  1..2
  ok 1 rss_input_xfrm.test_rss_input_xfrm_ipv4 # SKIP Test requires IPv4 connectivity
  # Sym input xfrm already enabled: {'sym-or-xor'}
  ok 2 rss_input_xfrm.test_rss_input_xfrm_ipv6
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:1 error:0

 # ethtool -X eth0 xfrm none

 # ./drivers/net/hw/rss_input_xfrm.py
  TAP version 13
  1..2
  ok 1 rss_input_xfrm.test_rss_input_xfrm_ipv4 # SKIP Test requires IPv4 connectivity
  # Sym input xfrm configured: {'sym-or-xor'}
  ok 2 rss_input_xfrm.test_rss_input_xfrm_ipv6
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:1 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: gal@nvidia.com
CC: noren@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 .../drivers/net/hw/rss_input_xfrm.py          | 44 ++++++++++++++++---
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
index 72880e388478..503f1a2a2872 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
@@ -5,9 +5,9 @@ import multiprocessing
 import socket
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, cmd, fd_read_timeout
 from lib.py import NetDrvEpEnv
-from lib.py import EthtoolFamily, NetdevFamily
+from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import KsftSkipEx, KsftFailEx
-from lib.py import rand_port
+from lib.py import defer, ksft_pr, rand_port
 
 
 def traffic(cfg, local_port, remote_port, ipver):
@@ -21,6 +21,40 @@ from lib.py import rand_port
     return sock.getsockopt(socket.SOL_SOCKET, socket.SO_INCOMING_CPU)
 
 
+def _rss_input_xfrm_try_enable(cfg):
+    """
+    Check if symmetric input-xfrm is already enabled, if not try to enable it
+    and register a cleanup.
+    """
+    rss = cfg.ethnl.rss_get({'header': {'dev-name': cfg.ifname}})
+    orig_xfrm = rss.get('input-xfrm', set())
+    sym_xfrm = set(filter(lambda x: 'sym' in x, orig_xfrm))
+
+    if sym_xfrm:
+        ksft_pr("Sym input xfrm already enabled:", sym_xfrm)
+        return sym_xfrm
+
+    for xfrm in cfg.ethnl.consts["input-xfrm"].entries:
+        # Skip non-symmetric transforms
+        if "sym" not in xfrm:
+            continue
+
+        try_xfrm = {xfrm} | orig_xfrm
+        try:
+            cfg.ethnl.rss_set({"header": {"dev-index": cfg.ifindex},
+                               "input-xfrm": try_xfrm})
+        except NlError:
+            continue
+
+        ksft_pr("Sym input xfrm configured:", try_xfrm)
+        defer(cfg.ethnl.rss_set,
+              {"header": {"dev-index": cfg.ifindex},
+               "input-xfrm": orig_xfrm})
+        return {xfrm}
+
+    return set()
+
+
 def test_rss_input_xfrm(cfg, ipver):
     """
     Test symmetric input_xfrm.
@@ -37,12 +71,10 @@ from lib.py import rand_port
     if not hasattr(socket, "SO_INCOMING_CPU"):
         raise KsftSkipEx("socket.SO_INCOMING_CPU was added in Python 3.11")
 
-    rss = cfg.ethnl.rss_get({'header': {'dev-name': cfg.ifname}})
-    input_xfrm = set(filter(lambda x: 'sym' in x, rss.get('input-xfrm', {})))
-
     # Check for symmetric xor/or-xor
+    input_xfrm = _rss_input_xfrm_try_enable(cfg)
     if not input_xfrm:
-        raise KsftSkipEx("Symmetric RSS hash not requested")
+        raise KsftSkipEx("Symmetric RSS hash not supported by device")
 
     cpus = set()
     successful = 0
-- 
2.52.0


