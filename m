Return-Path: <linux-kselftest+bounces-48802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3296BD15F03
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E74930559C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B056C1A9F97;
	Tue, 13 Jan 2026 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDKG0byH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1E15C158;
	Tue, 13 Jan 2026 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768262869; cv=none; b=RnnHqSaVoizHu/e1KBRU6fZ9QTGUUADCatED/HcyUXkqn2QDl5iqm2cDVoBq5Y/3MCtlSc3edGZFhRkRgcRhobpayA9Gzu9D5EteUPeE9ZDd+9uC7U3N+m3p8BvW741keKXk0bJaeXwkiID3krttXtJ53LsnGObPYlcgn3UqJtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768262869; c=relaxed/simple;
	bh=yqCk0mi0Jo7nyv1OHkf4vdge+WvCxmdddYSJUrYS5Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SB7z5ADECfMjF5tOYVWX5UzuvWo8I0hrtWaW3Lx7pxwRE/l6T/a+GtFKPmtqzggT08Y4n7rJaE0fdKcJH0slcC15Fo+xcAq1yKEINt0QW79sWxkIirANs/c8B5vYGMF/htNFMVBzjpuIrqD/vVoR/oHRK7canCYgOL2I0wcJliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDKG0byH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBF8C19421;
	Tue, 13 Jan 2026 00:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768262869;
	bh=yqCk0mi0Jo7nyv1OHkf4vdge+WvCxmdddYSJUrYS5Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDKG0byH+HHY+5I9RK+9ukcYfvvzYq+unLBeO6UujGai1x+UDwFWPNLp3qp5uwCGK
	 hOcEaoqLCbQ32RZ1FLmEm+f3ACJmhbHqtvNrQavPPjdY7xYoXwCl1SgAh8+pjaFVC4
	 GFf2Ex3J/p3zEUDqUb7L+QK0e/MUISV1q+gd+bTV1PGiF5g8Yn1zp336jU3pshg+Py
	 AO1+kJ+9+9aPjVZ1a36jR5Ei5zdq35osWR4nV1eBLKwBUXOG7y9zxbIKvNh/9yD36W
	 ZeYwrPG4La6hPdzAwAjooyjx1lsbILAllDw2w0FJ1Lf6Kn5aRP1yBFRPrQaMFqheHh
	 mJgxU4W2eVJhQ==
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
Subject: [PATCH net-next v3 4/6] selftests: drv-net: gro: improve feature config
Date: Mon, 12 Jan 2026 16:07:38 -0800
Message-ID: <20260113000740.255360-5-kuba@kernel.org>
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

We'll need to do a lot more feature handling to test HW-GRO and LRO.
Clean up the feature handling for SW GRO a bit to let the next commit
focus on the new test cases, only.

Make sure HW GRO-like features are not enabled for the SW tests.
Be more careful about changing features as "nothing changed"
situations may result in non-zero error code from ethtool.

Don't disable TSO on the local interface (receiver) when running over
netdevsim, we just want GSO to break up the segments on the sender.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - s/tso/tcp-segmentation-offload/ for ethtool feature names
v2: https://lore.kernel.org/20260110005121.3561437-5-kuba@kernel.org
 - reoder the imports
 - fix restoring all features - don't assume all the features
   have to be flipped, some may have already been in desired state
v1: https://lore.kernel.org/20251128005242.2604732-1-kuba@kernel.org

CC: willemdebruijn.kernel@gmail.com
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/gro.py | 39 ++++++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 4e0fb19d1527..3c30749ead39 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -20,7 +20,7 @@ coalescing behavior.
 import os
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import NetDrvEpEnv, KsftXfailEx
-from lib.py import cmd, defer, bkg, ip
+from lib.py import bkg, cmd, defer, ethtool, ip
 from lib.py import ksft_variants
 
 
@@ -70,6 +70,27 @@ from lib.py import ksft_variants
         defer(ip, f"link set dev {dev['ifname']} mtu {dev['mtu']}", host=host)
 
 
+def _set_ethtool_feat(dev, current, feats, host=None):
+    s2n = {True: "on", False: "off"}
+
+    new = ["-K", dev]
+    old = ["-K", dev]
+    no_change = True
+    for name, state in feats.items():
+        new += [name, s2n[state]]
+        old += [name, s2n[current[name]["active"]]]
+
+        if current[name]["active"] != state:
+            no_change = False
+            if current[name]["fixed"]:
+                raise KsftXfailEx(f"Device does not support {name}")
+    if no_change:
+        return
+
+    ethtool(" ".join(new), host=host)
+    defer(ethtool, " ".join(old), host=host)
+
+
 def _setup(cfg, test_name):
     """ Setup hardware loopback mode for GRO testing. """
 
@@ -77,6 +98,11 @@ from lib.py import ksft_variants
         cfg.bin_local = cfg.test_dir / "gro"
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
+    if not hasattr(cfg, "feat"):
+        cfg.feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
+        cfg.remote_feat = ethtool(f"-k {cfg.remote_ifname}",
+                                  host=cfg.remote, json=True)[0]
+
     # "large" test needs at least 4k MTU
     if test_name == "large":
         _set_mtu_restore(cfg.dev, 4096, None)
@@ -88,15 +114,22 @@ from lib.py import ksft_variants
     _write_defer_restore(cfg, flush_path, "200000", defer_undo=True)
     _write_defer_restore(cfg, irq_path, "10", defer_undo=True)
 
+    _set_ethtool_feat(cfg.ifname, cfg.feat,
+                      {"generic-receive-offload": True,
+                       "rx-gro-hw": False,
+                       "large-receive-offload": False})
+
     try:
         # Disable TSO for local tests
         cfg.require_nsim()  # will raise KsftXfailEx if not running on nsim
 
-        cmd(f"ethtool -K {cfg.ifname} gro on tso off")
-        cmd(f"ethtool -K {cfg.remote_ifname} gro on tso off", host=cfg.remote)
+        _set_ethtool_feat(cfg.remote_ifname, cfg.remote_feat,
+                          {"tcp-segmentation-offload": False},
+                          host=cfg.remote)
     except KsftXfailEx:
         pass
 
+
 def _gro_variants():
     """Generator that yields all combinations of protocol and test types."""
 
-- 
2.52.0


