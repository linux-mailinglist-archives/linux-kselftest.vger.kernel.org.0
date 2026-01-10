Return-Path: <linux-kselftest+bounces-48644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A29D0CA9C
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 868FE306128A
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 00:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D10F21E087;
	Sat, 10 Jan 2026 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkF89My1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5441FF7C7;
	Sat, 10 Jan 2026 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768006301; cv=none; b=Zlm5CfX/GBVdmkb9yHCMsv91UxVMvx85d9Qr8DeY1DLPplQOkug0nh6nM6KhJ/4wu1A6er+x+1PAYLtLhShsLZdljfKid2jNTlXxsmwCXsEyt5zVVaTXRINYx2prRpkzrtHVhvp0pM66/Q9x/psIq2WueSvx+Qr8G07JEitd914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768006301; c=relaxed/simple;
	bh=cqShxWfYLMgJ2YU5goe7pZTLh+Xnb8RKO33BNC8ldf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u59oFR7ZTXIpQtWjqWifZcdEq39EhhgUAOyN56iRkBnorw2G+790F6DezhtKWHNFOgawASc2Ve5e9ToEUVE1P3b0k9Tv5xr/Xo9WgeT3RFrmmIsCoTSY6hKhbwzM6vCDVgEnyhCIu5bctwz/ENFacR96G4GfNiXPIIdzQhPopwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkF89My1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63858C19421;
	Sat, 10 Jan 2026 00:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768006300;
	bh=cqShxWfYLMgJ2YU5goe7pZTLh+Xnb8RKO33BNC8ldf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkF89My15bJYIG9Ekk8six5PBbcsht1l2me05ziXrCVf0Qr8D8wN21/DnRWea5RFW
	 AaYWU+U3zw9btZ1bHQCcSYzIyHj2ApgkgxR46Z0rJ7MQyGm4iRCSXgfG9GfWa+pYfI
	 S0/vA/0pi6X0RnQvSH9601PsSdeDp3VDB1fRxZC3RYYb+qUvoOHy1fDS3QfvMqHgxo
	 2Xglint7MOe82XYpVs8FPEKBKfN9aemvay0yF57BTa2jZAfQSS2gBlvwAaTYd38tl5
	 cIUG4z2NniZfoxDqfkRVnpeAPwe0Itkm1643e6MHExYzheS+fqvFTjscY9xyKu97pU
	 EOXqiuO8MTYhA==
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
Subject: [PATCH net-next v2 4/6] selftests: drv-net: gro: improve feature config
Date: Fri,  9 Jan 2026 16:51:19 -0800
Message-ID: <20260110005121.3561437-5-kuba@kernel.org>
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

We'll need to do a lot more feature handling to test HW-GRO and LRO.
Clean up the feature handling for SW GRO a bit to let the next commit
focus on the new test cases, only.

Make sure HW GRO-like features are not enabled for the SW tests.
Be more careful about changing features as "nothing changed"
situations may result in non-zero error code from ethtool.

Don't disable TSO on the local interface (receiver) when running over
netdevsim, we just want GSO to break up the segments on the sender.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - reoder the imports
 - fix restoring all features - don't assume all the features
   have to be flipped, some may have already been in desired state
v1: https://lore.kernel.org/20251128005242.2604732-1-kuba@kernel.org

CC: willemdebruijn.kernel@gmail.com
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/gro.py | 38 ++++++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 4e0fb19d1527..b72a1d756d72 100755
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
@@ -88,15 +114,21 @@ from lib.py import ksft_variants
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
+        _set_ethtool_feat(cfg.remote_ifname, cfg.remote_feat, {"tso": False},
+                          host=cfg.remote)
     except KsftXfailEx:
         pass
 
+
 def _gro_variants():
     """Generator that yields all combinations of protocol and test types."""
 
-- 
2.52.0


