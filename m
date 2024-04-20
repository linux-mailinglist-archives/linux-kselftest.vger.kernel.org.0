Return-Path: <linux-kselftest+bounces-8530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DBD8AB917
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 04:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE63D1F219D4
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 02:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C1314AA8;
	Sat, 20 Apr 2024 02:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lrh9apGN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E61401B;
	Sat, 20 Apr 2024 02:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581564; cv=none; b=Moh6TqDTvW8tFicjszu9ca+fPGNODULBMcQu+wVmEWJzD6IEVu1Qx9UyuJjbHOAx96KR7Z7vXI8b05Fpc1m5huXz/7ko0qDoPkZlGg4t9SmrV/NeQ+HEiLaSSGtB5CC0v7oco0VPieiUI4/Ggj9cXh71LAGB2fnGI1qmg3O6Liw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581564; c=relaxed/simple;
	bh=5dhhMZJI18dkOS2vc7qce9DAK/+xJhsZ05bSHcLB3Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqOFygcLsXUHRuQC0hcdKsSdkdyXGk70HVUG6CGrtl49TJDD/1JtG/sh1LEtbHsBfCEmkfF34lgF+jRoH7fjtelBJSGDkU8LsDfm5ehIP5z2guy0YgOgmdzFkXFjcZ03+qHKvn4sgz2T4IVNL7XCAZQUV7O/B4YUz5iYTdxLRXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lrh9apGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086FCC32782;
	Sat, 20 Apr 2024 02:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713581564;
	bh=5dhhMZJI18dkOS2vc7qce9DAK/+xJhsZ05bSHcLB3Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lrh9apGNImbShnfa3swAuoWv6be4myOxlkcYXh8dCMpIKKPDEjSgEMRbeHa3D8tmD
	 3ttn2t/vsp9REQx1Gu5AJxAnjBGuNxLnjDPJBgnnAy4wBhX9TICmq6Tp0T4Gyj4efK
	 fKtA5cyhvdHzRch3QX4ChlA8lYYRj53d61pTZkcyZ2Lpt63443eDz2L1y28oH5bP5h
	 wKyWt9+dtMqNKU/B/jwM9nZyFokteCzHcAzxNLoYhbDF18QH/nSMQ8Ma9a4OlDm2fA
	 D7F7rzDeQA9vTsVdcFnjRTPfLRD2FYT/X62S8jYrM4sPqeyxb9tzstBotB6khEVra7
	 iIbr1INDuYCew==
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
Subject: [PATCH net-next v5 7/7] selftests: drv-net: add require_XYZ() helpers for validating env
Date: Fri, 19 Apr 2024 19:52:37 -0700
Message-ID: <20240420025237.3309296-8-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025237.3309296-1-kuba@kernel.org>
References: <20240420025237.3309296-1-kuba@kernel.org>
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
index dd5cb0226a31..a3db1bb1afeb 100644
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
 
@@ -118,6 +119,8 @@ from .remote import Remote
         self.ifname = self.dev['ifname']
         self.ifindex = self.dev['ifindex']
 
+        self._required_cmd = {}
+
     def create_local(self):
         self._netns = NetNS()
         self._ns = NetdevSimDev()
@@ -160,3 +163,27 @@ from .remote import Remote
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
index 4b49de59231c..eb83e7b48797 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -8,16 +8,22 @@ from lib.py import bkg, cmd, wait_port_listen, rand_port
 
 
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
     port = rand_port()
     listen_cmd = f"socat -{cfg.addr_ipver} -t 2 -u TCP-LISTEN:{port},reuseport STDOUT"
 
-- 
2.44.0


