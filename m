Return-Path: <linux-kselftest+bounces-8389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D988AA5F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 01:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B6D1C20CAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 23:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7479D7E101;
	Thu, 18 Apr 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVp/OBpU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1707C08D;
	Thu, 18 Apr 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483534; cv=none; b=HkH3KkI6L84MRWgvo116d1OgISKiCd/wdarpvxYNLZZRaAQdUUzf3l4mgLKzApxc3So37cSd0LorOY36g+Tmlx4NdOA09cLsctmXh4IZX/XzZPbcXTg43Lw57ZhPdivoBg79bFtr4/0U1i1CAFuTo5upDuKocqI1Nhppkpt0sdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483534; c=relaxed/simple;
	bh=jbYvr0fYhhl4ZoloS4Czl6L/Y3rRVKWllDR1T9XXXrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFaLyn39/nrcw/OL3F4DqRgM956UTbqkPZ0FGn5Hx+VKVpKZ1ohnJc4S30eLGIQ+ZQG2biORULgCZ9DiQzE5VOMKKH3r/Ieixwf+L99kStEkVMhfkE34WlVthNYVPCEQos05DAa783ANPfck+zIzcKMO4hvsOxGr4TMJ+mtGXxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVp/OBpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA340C32781;
	Thu, 18 Apr 2024 23:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713483534;
	bh=jbYvr0fYhhl4ZoloS4Czl6L/Y3rRVKWllDR1T9XXXrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gVp/OBpUD5ZM36z7sz9GrRl44T/11Xhc4F3cSqKS+iCAKWrT9LhGFOXwbWnyCV72X
	 ULWmNGivWI/4kiZCqjTdWHMy0/5A1zC4zK8UaCiZGgIW7KPgPDgJWcK9090BFoLbbl
	 kDa4Xfs5Xo5NwTO6xyqxolPkvN69AuplAtAwjv8dytRwLCi1uz1MJJo1L2pID3tYak
	 N4YMxt9e4ozL9cRkuW52FGMQzpi13AG4VWWiWeRuMTG5L2+7rzzdKGkorDsAhq2pn3
	 JMrDBFjd0G5cNx9fmNIi20IOfZfLbucFptIBoU9SWWFOpjiFhYKOwbF+sQeKN9uFSH
	 uTPBJ/1fXhjjw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v4 7/7] selftests: drv-net: add require_XYZ() helpers for validating env
Date: Thu, 18 Apr 2024 16:38:44 -0700
Message-ID: <20240418233844.2762396-8-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418233844.2762396-1-kuba@kernel.org>
References: <20240418233844.2762396-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap typical checks like whether given command used by the test
is available in helpers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/lib/py/env.py       | 29 ++++++++++++++++++-
 tools/testing/selftests/drivers/net/ping.py   |  6 ++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 2f62270d59fa..619dd214c095 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -3,7 +3,8 @@
 import os
 import shlex
 from pathlib import Path
-from lib.py import ip
+from lib.py import KsftSkipEx
+from lib.py import cmd, ip
 from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
 
@@ -117,6 +118,8 @@ from .remote import Remote
         self.ifname = self.dev['ifname']
         self.ifindex = self.dev['ifindex']
 
+        self._required_cmd = {}
+
     def create_local(self):
         self._netns = NetNS()
         self._ns = NetdevSimDev()
@@ -159,3 +162,27 @@ from .remote import Remote
         if self.remote:
             del self.remote
             self.remote = None
+
+    def require_v4(self):
+        if not self.v4 or not self.remote_v4:
+            raise KsftSkipEx("Test requires IPv4 connectivity")
+
+    def require_v6(self):
+        if not self.v6 or not self.remote_v6:
+            raise KsftSkipEx("Test requires IPv6 connectivity")
+
+    def _require_cmd(self, comm, key, host=None):
+        cached = self._required_cmd.get(comm, {})
+        if cached.get(key) is None:
+            cached[key] = cmd("command -v -- " + comm, fail=False,
+                              shell=True, host=host).ret == 0
+        self._required_cmd[comm] = cached
+        return cached[key]
+
+    def require_cmd(self, comm, local=True, remote=False):
+        if local:
+            if not self._require_cmd(comm, "local"):
+                raise KsftSkipEx("Test requires command: " + comm)
+        if remote:
+            if not self._require_cmd(comm, "remote"):
+                raise KsftSkipEx("Test requires (remote) command: " + comm)
diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index 15a0bdcb46e2..a933a154b341 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -10,16 +10,22 @@ from lib.py import bkg, cmd, wait_port_listen
 
 
 def test_v4(cfg) -> None:
+    cfg.require_v4()
+
     cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
     cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
 
 
 def test_v6(cfg) -> None:
+    cfg.require_v6()
+
     cmd(f"ping -c 1 -W0.5 {cfg.remote_v6}")
     cmd(f"ping -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
 
 
 def test_tcp(cfg) -> None:
+    cfg.require_cmd("socat", remote=True)
+
     port = random.randrange(1024 + (1 << 15))
 
     with bkg(f"socat -t 2 -u TCP-LISTEN:{port} STDOUT", exit_wait=True) as nc:
-- 
2.44.0


