Return-Path: <linux-kselftest+bounces-8386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3338AA5ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 01:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02091F2189D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 23:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12CE7C0A6;
	Thu, 18 Apr 2024 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5RRVIXw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99137C08D;
	Thu, 18 Apr 2024 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483532; cv=none; b=MzGKxOYJWIz/dtvJ3b5U2TZLNAZ1ePDq1BAhTPIJDWl3OiMIIh5Ee+9WlAi0D4hsrizWure9QGONL0bMeo1Hg6CzqPK7jr17MbuZwC6T/wMLTiLHSCNtQTO6L7TYo0ns0ubLV6dwdCmxTNWdAl+h2C9pFs0mXe4u7bogs4QfOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483532; c=relaxed/simple;
	bh=Xcg/4YWNTZU4GPQmaDdLsBXVgUTYXSPrMsnia87nxsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMrkkmU7LrYTG6hLwCrR0BP1YbylMeX3QNAnxVLsPMnhJHRbF8kgcx1aEVERHVNZN80f0ifxNBqEs4YJ3ogABA2SMITkLxdzfCjnsmTS6oQa80SGoC8oFOztLPZ+W7XYbuYLoZi4vy8cKYZ/jMtBjOSQbBVthCevuPs7/jyPY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5RRVIXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011F9C32781;
	Thu, 18 Apr 2024 23:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713483532;
	bh=Xcg/4YWNTZU4GPQmaDdLsBXVgUTYXSPrMsnia87nxsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5RRVIXwDTVvjr2y5c8cDdIXV6TOjgZcRWbTKs6QNhqv1FSL4oLsDYZEhQBwdWcQO
	 eiXuMovgK/7dlZC0SC58rPPB64vplgjbEXbNKSYrEIQJwGaY+QXYvO/udxsE8l5+a9
	 esH6J0nhcIsrGlaa2EyE8eeohhE6grJCW5e1L1M9YMp1gaICagYh5iqLE34VMD3AYr
	 P+GTt/OEWGM6jSnK3s5Phq9UUO06eUYfsCC/O5JMwUoR2bwo5tKg8zDu7jGDq4JDPl
	 sziYaJvdmpXaunwe/6YzkpqxMRAj82fM5KaGhxo/an2MxlPPc/7ByN5X9PlfYPVatv
	 IR1hjmqiDLAWw==
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
Subject: [PATCH net-next v4 4/7] selftests: drv-net: add a trivial ping test
Date: Thu, 18 Apr 2024 16:38:41 -0700
Message-ID: <20240418233844.2762396-5-kuba@kernel.org>
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

Add a very simple test for testing with a remote system.
Both IPv4 and IPv6 connectivity is optional, later change
will add checks to skip tests based on available addresses.

Using netdevsim:

 $ ./run_kselftest.sh -t drivers/net:ping.py
 TAP version 13
 1..1
 # timeout set to 45
 # selftests: drivers/net: ping.py
 # KTAP version 1
 # 1..2
 # ok 1 ping.test_v4
 # ok 2 ping.test_v6
 # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 1 selftests: drivers/net: ping.py

Command line SSH:

 $ NETIF=virbr0 REMOTE_TYPE=ssh REMOTE_ARGS=root@192.168.122.123 \
    LOCAL_V4=192.168.122.1 REMOTE_V4=192.168.122.123 \
    ./tools/testing/selftests/drivers/net/ping.py
 KTAP version 1
 1..2
 ok 1 ping.test_v4
 ok 2 ping.test_v6 # SKIP Test requires IPv6 connectivity
 # Totals: pass:1 fail:0 xfail:1 xpass:0 skip:0 error:0

Existing devices placed in netns (and using net.config):

 $ cat drivers/net/net.config
 NETIF=veth0
 REMOTE_TYPE=netns
 REMOTE_ARGS=red
 LOCAL_V4="192.168.1.1"
 REMOTE_V4="192.168.1.2"

 $ ./run_kselftest.sh -t drivers/net:ping.py
 TAP version 13
 1..1
 # timeout set to 45
 # selftests: drivers/net: ping.py
 # KTAP version 1
 # 1..2
 # ok 1 ping.test_v4
 # ok 2 ping.test_v6 # SKIP Test requires IPv6 connectivity
 # # Totals: pass:1 fail:0 xfail:1 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v4:
 - move adding the "require_XYZ()" checks to last patch
---
 tools/testing/selftests/drivers/net/Makefile |  5 +++-
 tools/testing/selftests/drivers/net/ping.py  | 27 ++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/ping.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 379cdb1960a7..754ec643768a 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -2,6 +2,9 @@
 
 TEST_INCLUDES := $(wildcard lib/py/*.py)
 
-TEST_PROGS := stats.py
+TEST_PROGS := \
+	ping.py \
+	stats.py \
+# end of TEST_PROGS
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
new file mode 100755
index 000000000000..e75908d7c558
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -0,0 +1,27 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import NetDrvEpEnv
+from lib.py import cmd
+
+
+def test_v4(cfg) -> None:
+    cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
+    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
+
+
+def test_v6(cfg) -> None:
+    cmd(f"ping -c 1 -W0.5 {cfg.remote_v6}")
+    cmd(f"ping -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([test_v4, test_v6],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.44.0


