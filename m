Return-Path: <linux-kselftest+bounces-7892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7795F8A38F0
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE913B232F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 23:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171DA152E18;
	Fri, 12 Apr 2024 23:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC8jA1KS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED8152E13;
	Fri, 12 Apr 2024 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712965039; cv=none; b=JMZtb9ZQL/F+yjPdFoM8+jhEhIhqAz3SW07taSQCcBjERoIY1gZbcyS58M6e0FoB9tFEPTPrayOmwdAkvGaY39npkAO6uNQGTvWwSrtxVvbBdR7t9sNGjnrrE0qdniQ5u5MDZmxGlamLqm5B3os/WL+xDVKjxREWEXlqI5ETLGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712965039; c=relaxed/simple;
	bh=K96RrE3a2mAuVx/wLyxJvrkYyRoHGL9Y3+Zqq4lXbE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xx0mF2JG06Cvzjeb8ry2xuBTe6CfgZthDOQ4+EHzTiEqjp65x6JWtT1ldNuLIx5eA8DxVGNCoT6IjdeFGMqfhveLqxK2eUKbn5RprFLcNpJXucP0Q0kiADAFAZXKRBBkm7sradmCyFjZKlx+d9eJdtLidixqqIgug8fbdyRJrT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC8jA1KS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28469C2BD10;
	Fri, 12 Apr 2024 23:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712965038;
	bh=K96RrE3a2mAuVx/wLyxJvrkYyRoHGL9Y3+Zqq4lXbE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QC8jA1KSnwazgzYlREm3bldZouYBH+b42653TVyqxgRTr+WFW/is42UNZOoW77Szt
	 EijnfMsu/TMNu5OcMPa52fyls5rn11micY37ogwjkWB27mAARQa338m0NfZgrn5YDG
	 F09x3lWYs7c7P9RgcW/7lXoFzBg3UEfgdZ5uozU/fC/r5tb+t/BNrzJL7ciAfdZdnC
	 N9qJCHOa5LMr2Rzw/k3NBdRJ8vdxIbZuqlMrUZthyrLQYyZXwskdqJXUhjizvV4rK0
	 iwljkmCfA7dxNP0slydJL0xzX5ZiYUWnW2ps02HufaEzYov/QvrQT2mEbRZVU0Ykzf
	 Np7aIk7WNUuuw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/5] selftests: drv-net: add a trivial ping test
Date: Fri, 12 Apr 2024 16:37:05 -0700
Message-ID: <20240412233705.1066444-6-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412233705.1066444-1-kuba@kernel.org>
References: <20240412233705.1066444-1-kuba@kernel.org>
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

 $ NETIF=virbr0 EP_TYPE=ssh EP_ARGS=root@192.168.122.123 \
    LOCAL_V4=192.168.122.1 EP_V4=192.168.122.123 \
    ./tools/testing/selftests/drivers/net/ping.py
 KTAP version 1
 1..2
 ok 1 ping.ping_v4
 ok 2 ping.ping_v6 # XFAIL
 # Totals: pass:1 fail:0 xfail:1 xpass:0 skip:0 error:0

Existing devices placed in netns (and using net.config):

 $ cat drivers/net/net.config
 NETIF=veth0
 EP_TYPE=netns
 EP_ARGS=red
 LOCAL_V4="192.168.1.1"
 EP_V4="192.168.1.2"

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
 tools/testing/selftests/drivers/net/Makefile |  4 ++-
 tools/testing/selftests/drivers/net/ping.py  | 32 ++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/ping.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 379cdb1960a7..713ab251cea9 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -2,6 +2,8 @@
 
 TEST_INCLUDES := $(wildcard lib/py/*.py)
 
-TEST_PROGS := stats.py
+TEST_PROGS := \
+	ping.py \
+	stats.py \
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
new file mode 100755
index 000000000000..df746543f5c3
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
+    cmd(f"ping -c 1 -W0.5 {cfg.ep_v4}")
+    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.endpoint)
+
+
+def ping_v6(cfg) -> None:
+    if not cfg.v6:
+        raise KsftXfailEx()
+
+    cmd(f"ping -c 1 -W0.5 {cfg.ep_v6}")
+    cmd(f"ping -c 1 -W0.5 {cfg.v6}", host=cfg.endpoint)
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


