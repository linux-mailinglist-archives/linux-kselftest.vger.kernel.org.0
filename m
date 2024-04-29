Return-Path: <linux-kselftest+bounces-9029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070FC8B5BBB
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 16:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9562819A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F61881AA5;
	Mon, 29 Apr 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ozb+9x6H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96D781745;
	Mon, 29 Apr 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401875; cv=none; b=uqRihtv2FBQ+CcR1PE/HKwzYNKyQ+qy753nJ7SEJ+lZMGH2grbwCpGZsgTlt5yATYqJRMp9EdxmZJsPo93yBQDrLetN7Znsv3fQQjEYf+CfEeNFoLgLuNX6lylEDRPR7s1tn8BGuAEqMgP1l09jg0O2gqj2BNgjoZLVnJD/Hz+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401875; c=relaxed/simple;
	bh=SDllwCyBkau8KID+VjwwqBdxYX2WiKlosdaB+BB7p/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKdfjpbuy0Mq5F9HzVJEFVuBrBQ3uJGIrWr3MTLfi4X5FKWPTFMQ3iFWqO3g6iFQLkMYjRE8Azhe+SEV+KhOKn3MsZevjNIba7yMPKec8nYqPjfj7SnzbJhwMZfWvXLM0ca5hNs9R3VlCV6OuaWOrjiHx13ReU156hmCoyczKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ozb+9x6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1697AC4AF48;
	Mon, 29 Apr 2024 14:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714401875;
	bh=SDllwCyBkau8KID+VjwwqBdxYX2WiKlosdaB+BB7p/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ozb+9x6HnAzQG16hdeefNf56zilC9JvKfEzK5pOAl+oKkEArFfh7WPscf08oi9Fki
	 ADLUDcpEmyYWpicYIEreXOouiWxp4/NIA1F1jM7wY4GubKKr2VwpDhN/gtOM/hcm3s
	 9fUSVxVVt6e/qoIhiGY1gV/FwBX5uXQB4ulK8Y370Ic9Cvw+OjAGOHKMG80ico/qTN
	 fwBN2myeDsG7xxZqwQ3qlMgiMPK5jsc0U6teiMq0GSjLB0QHR0vxqtseJIGC/c0/T0
	 Ct82LM5RWIP2QG2rEcmSA+h4OFl/Ppo4qVC6ODdc53qNQc9Rza1GENMVg8C8IOHT7v
	 TAgODWs1WNN5Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 6/6] selftests: drv-net-hw: add test for memory allocation failures with page pool
Date: Mon, 29 Apr 2024 07:44:26 -0700
Message-ID: <20240429144426.743476-7-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429144426.743476-1-kuba@kernel.org>
References: <20240429144426.743476-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bugs in memory allocation failure paths are quite common.
Add a test exercising those paths based on qstat and page pool
failure hook.

Running on bnxt:

  # ./drivers/net/hw/pp_alloc_fail.py
  KTAP version 1
  1..1
  # ethtool -G change retval: success
  ok 1 pp_alloc_fail.test_pp_alloc
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

I initially wrote this test to validate commit be43b7489a3c ("net/mlx5e:
RX, Fix page_pool allocation failure recovery for striding rq") but mlx5
still doesn't have qstat. So I run it on bnxt, and while bnxt survives
I found the problem fixed in commit 730117730709 ("eth: bnxt: fix counting
packets discarded due to OOM and netpoll").

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/pp_alloc_fail.py | 129 ++++++++++++++++++
 tools/testing/selftests/net/lib/py/ksft.py    |   4 +
 3 files changed, 134 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 95f32158b095..1dd732855d76 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -9,6 +9,7 @@ TEST_PROGS = \
 	hw_stats_l3.sh \
 	hw_stats_l3_gre.sh \
 	loopback.sh \
+	pp_alloc_fail.py \
 	#
 
 TEST_FILES := \
diff --git a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
new file mode 100755
index 000000000000..026d98976c35
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
@@ -0,0 +1,129 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import time
+import os
+from lib.py import ksft_run, ksft_exit, ksft_pr
+from lib.py import KsftSkipEx, KsftFailEx
+from lib.py import NetdevFamily, NlError
+from lib.py import NetDrvEpEnv
+from lib.py import cmd, tool, GenerateTraffic
+
+
+def _write_fail_config(config):
+    for key, value in config.items():
+        with open("/sys/kernel/debug/fail_function/" + key, "w") as fp:
+            fp.write(str(value) + "\n")
+
+
+def _enable_pp_allocation_fail():
+    if not os.path.exists("/sys/kernel/debug/fail_function"):
+        raise KsftSkipEx("Kernel built without function error injection (or DebugFS)")
+
+    if not os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc_pages"):
+        with open("/sys/kernel/debug/fail_function/inject", "w") as fp:
+            fp.write("page_pool_alloc_pages\n")
+
+    _write_fail_config({
+        "verbose": 0,
+        "interval": 511,
+        "probability": 100,
+        "times": -1,
+    })
+
+
+def _disable_pp_allocation_fail():
+    if not os.path.exists("/sys/kernel/debug/fail_function"):
+        return
+
+    if os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc_pages"):
+        with open("/sys/kernel/debug/fail_function/inject", "w") as fp:
+            fp.write("\n")
+
+    _write_fail_config({
+        "probability": 0,
+        "times": 0,
+    })
+
+
+def test_pp_alloc(cfg, netdevnl):
+    def get_stats():
+        return netdevnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
+
+    def check_traffic_flowing():
+        stat1 = get_stats()
+        time.sleep(1)
+        stat2 = get_stats()
+        if stat2['rx-packets'] - stat1['rx-packets'] < 15000:
+            raise KsftFailEx("Traffic seems low:", stat2['rx-packets'] - stat1['rx-packets'])
+
+
+    try:
+        stats = get_stats()
+    except NlError as e:
+        if e.nl_msg.error == -95:
+            stats = {}
+        else:
+            raise
+    if 'rx-alloc-fail' not in stats:
+        raise KsftSkipEx("Driver does not report 'rx-alloc-fail' via qstats")
+
+    set_g = False
+    traffic = None
+    try:
+        traffic = GenerateTraffic(cfg)
+
+        check_traffic_flowing()
+
+        _enable_pp_allocation_fail()
+
+        s1 = get_stats()
+        time.sleep(3)
+        s2 = get_stats()
+
+        if s2['rx-alloc-fail'] - s1['rx-alloc-fail'] < 1:
+            raise KsftSkipEx("Allocation failures not increasing")
+        if s2['rx-alloc-fail'] - s1['rx-alloc-fail'] < 100:
+            raise KsftSkipEx("Allocation increasing too slowly", s2['rx-alloc-fail'] - s1['rx-alloc-fail'],
+                             "packets:", s2['rx-packets'] - s1['rx-packets'])
+
+        # Basic failures are fine, try to wobble some settings to catch extra failures
+        check_traffic_flowing()
+        g = tool("ethtool", "-g " + cfg.ifname, json=True)[0]
+        if 'rx' in g and g["rx"] * 2 <= g["rx-max"]:
+            new_g = g['rx'] * 2
+        elif 'rx' in g:
+            new_g = g['rx'] // 2
+        else:
+            new_g = None
+
+        if new_g:
+            set_g = cmd(f"ethtool -G {cfg.ifname} rx {new_g}", fail=False).ret == 0
+            if set_g:
+                ksft_pr("ethtool -G change retval: success")
+            else:
+                ksft_pr("ethtool -G change retval: did not succeed", new_g)
+        else:
+                ksft_pr("ethtool -G change retval: did not try")
+
+        time.sleep(0.1)
+        check_traffic_flowing()
+    finally:
+        _disable_pp_allocation_fail()
+        if traffic:
+            traffic.stop()
+        time.sleep(0.1)
+        if set_g:
+            cmd(f"ethtool -G {cfg.ifname} rx {g['rx']}")
+
+
+def main() -> None:
+    netdevnl = NetdevFamily()
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+
+        ksft_run([test_pp_alloc], args=(cfg, netdevnl, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index f84e9fdd0032..4769b4eb1ea1 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -11,6 +11,10 @@ KSFT_RESULT = None
 KSFT_RESULT_ALL = True
 
 
+class KsftFailEx(Exception):
+    pass
+
+
 class KsftSkipEx(Exception):
     pass
 
-- 
2.44.0


