Return-Path: <linux-kselftest+bounces-8042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4470B8A5F72
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 02:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0480282F51
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 00:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8051FC1F;
	Tue, 16 Apr 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK7vx2hu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B38F9E8;
	Tue, 16 Apr 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713228365; cv=none; b=tCz+qELX/z4HetbmGLHwzS3eTAG0kkaMTxw2aXI3n9P75thYry4vpVhIe0NdJbiTuZTbaomfLcu8bBhEX56iNVi8xIn84xI4t/5WcyD6qjDQW4iIh/wIzz/CJwxfHuJsSHGqyu4Rvl+LYjBg+XgN16OTUiq3fu5jcXNITN17KNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713228365; c=relaxed/simple;
	bh=y9sov6G1b9aY1nBElEZFBTccJq2jlrMvMtldou9HhZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+Ign38+sdA/FGco+GHh3CCydxbCo+tWuCX9EFVhcJXM6+4ykcSDmmypbzu2S26oZrQf+5KIpz5hdD7a9xtK1AcBeDBhPR/WrsmSD+hc/u8ME6tsToeJMKRa2OwBTkqfNx8+B5HSS0zL9mloTwnYoo0SWFwrTl/64VpABJAFcQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK7vx2hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8409C4AF0A;
	Tue, 16 Apr 2024 00:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713228365;
	bh=y9sov6G1b9aY1nBElEZFBTccJq2jlrMvMtldou9HhZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jK7vx2huxUkpe0ejXTzoWwg1Di4AzhlxmWPWVWTMRFZbMKwZE0GUvT8PRRtqV7T43
	 GT+R8R0HPAC+hPB9BwRjBiCr+QaLY/RZFYXhYvtVWgdBkBGkGrppgJomb5BLm8PZ4r
	 lx4D/FfGRmt5+2XpU++NXmNNlAbVRplBYjOtP2uIhfjc0jwHLCGCp4tsj+II8ygXxi
	 obHZXYavyERu+5GKHyeKv6FRbB1x4D7TztinRugxheNGR3OT1cYn/FrBt1p4yJwVFW
	 Ni2hirumzKhA7w4SURqpBFugRKxsbDdIr9mXgcOPfiZgrdmJaSKC+J8Z1FzSUEHSIY
	 0KmFuSADRwBxA==
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
Subject: [PATCH net-next v2 6/6] selftests: drv-net: add a trivial ping test
Date: Mon, 15 Apr 2024 17:45:56 -0700
Message-ID: <20240416004556.1618804-7-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416004556.1618804-1-kuba@kernel.org>
References: <20240416004556.1618804-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a very simple test for testing with a remote system.
Both IPv4 and IPv6 connectivity is optional so tests
will XFail is env doesn't define an address for the given
family.

Using netdevsim:

 $ ./run_kselftest.sh -t drivers/net:ping.py
 TAP version 13
 1..1
 # timeout set to 45
 # selftests: drivers/net: ping.py
 # KTAP version 1
 # 1..2
 # ok 1 ping.ping_v4
 # ok 2 ping.ping_v6
 # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 1 selftests: drivers/net: ping.py

Command line SSH:

 $ NETIF=virbr0 REMOTE_TYPE=ssh REMOTE_ARGS=root@192.168.122.123 \
    LOCAL_V4=192.168.122.1 REMOTE_V4=192.168.122.123 \
    ./tools/testing/selftests/drivers/net/ping.py
 KTAP version 1
 1..2
 ok 1 ping.ping_v4
 ok 2 ping.ping_v6 # XFAIL
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
 # ok 1 ping.ping_v4
 # ok 2 ping.ping_v6 # XFAIL
 # # Totals: pass:1 fail:0 xfail:1 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/Makefile |  5 ++-
 tools/testing/selftests/drivers/net/ping.py  | 32 ++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)
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
index 000000000000..2d74f15a52a0
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -0,0 +1,32 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, KsftXfailEx
+from lib.py import NetDrvEpEnv
+from lib.py import cmd
+
+
+def ping_v4(cfg) -> None:
+    if not cfg.v4:
+        raise KsftXfailEx()
+
+    cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
+    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
+
+
+def ping_v6(cfg) -> None:
+    if not cfg.v6:
+        raise KsftXfailEx()
+
+    cmd(f"ping -c 1 -W0.5 {cfg.remote_v6}")
+    cmd(f"ping -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([ping_v4, ping_v6],
+                 args=(cfg, ))
+
+
+if __name__ == "__main__":
+    main()
-- 
2.44.0


