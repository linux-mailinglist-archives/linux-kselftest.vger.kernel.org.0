Return-Path: <linux-kselftest+bounces-46682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 616C5C9074D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 01:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DF3F4E03A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 00:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934641D9346;
	Fri, 28 Nov 2025 00:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGQu2dtU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EBB20B22;
	Fri, 28 Nov 2025 00:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764291171; cv=none; b=bG1dOACKEa+UoB1lL9/PUSTQlrpDoEIXkqSH9owffxc1bzHxZLOT2JqdpZa/3P/9aCVpu/kna4YogBRdFl5oJ9LRM1fGZDE66OM17kQbfcLMIp02Tn0nq3CBfGe7uxeTlECDWwj9gnnUgzSwlRkslAMtE2CYlwKlc0Sagn8WJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764291171; c=relaxed/simple;
	bh=ZHbef+W2XSDsRZ4a91ykQZm0XJMuRpw2zHXySuPkKqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQqbTlXpdiH9RaraFGg2wgIwHmE1TOUxAj93FRUik3l5c/GaFIETvzAPIDJpNjjRhjL3MwIeNJf0VJRHcC9S0U/hKkx5mJt6ExfGkYF4TdrHh0zLyThTMtrM4y/CN3/9Ps0W3mA0KzACHhIE1nHkaP68L9w0juq+a0KvjBVQzx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGQu2dtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76B1C4CEF8;
	Fri, 28 Nov 2025 00:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764291171;
	bh=ZHbef+W2XSDsRZ4a91ykQZm0XJMuRpw2zHXySuPkKqQ=;
	h=From:To:Cc:Subject:Date:From;
	b=mGQu2dtUzyaRm3f7elSXC5kOC78ZajEfyCIPanD6NUFzJynJ1hS+DnKD/4CCise0M
	 Ns+7xhc3h6IweBHdJP8UyvShV2ghb8i+hEXpuo/RiDFOtYZaZ0g/DYgIIKcN5ROK21
	 HLFzkElIz4co/merHCIXN9E31WJNs/K9eJXuJ07RRIre4uj+EUiKK25o7uhdZPxq+w
	 LsIT12lxdApOSCwgOHtgHMKUK0gH4m29H1pUU5eIR6hhbthViKAhB6RViWTxtFwvrI
	 LjutPjCqjKrqZYk5CsFQr33zVBO2Z3lu6wJXObIusuVFoNV2Q1vp1aNoKNV0oEtlT8
	 KS2o1lY0U64qQ==
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/2] selftests: drv-net: gro: improve feature config
Date: Thu, 27 Nov 2025 16:52:41 -0800
Message-ID: <20251128005242.2604732-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
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
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/gro.py | 38 ++++++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index ba83713bf7b5..6d633bdc7e67 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -20,7 +20,7 @@ coalescing behavior.
 import os
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import NetDrvEpEnv, KsftXfailEx
-from lib.py import cmd, defer, bkg, ip
+from lib.py import cmd, defer, bkg, ethtool, ip
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
+        old += [name, s2n[not state]]
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
2.51.1


