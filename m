Return-Path: <linux-kselftest+bounces-6968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFF489489A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 03:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760311F22AC2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 01:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E223EEDE;
	Tue,  2 Apr 2024 01:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTkj8xdq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455DFFBE8;
	Tue,  2 Apr 2024 01:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712019944; cv=none; b=AxwYwCs8QHyuTubp13wRHkRXWxRWV5Qzzo0/8uuqmPZX35tE6NqdWCbFeQjxIjJiziFsJCqXNQ3pNuqrB0nkC62UsleVH8pr3fo2sGm+rcPvk+8YduFzZHURpep2eqX27mPjd9BcpGodihB20G9DWvicRYtSktK1S5zeC/2YpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712019944; c=relaxed/simple;
	bh=Y71nP2zwtbVSLu5riks8Otndx5/nVc0R0gnKxEK2tWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQLP43HcNYr46etSG73ApQD//cvHlMtvPqz76Ssg3S+UvtZ66msOOmkfTQrJSoZjjR6Ysp69ucDRi39QYEeTpKaWcQsSyBGO+33PeGrTD54cT5lV/kpAM0AJZxm2HOxz2xrrp0PflRp3CA0T88RZjSPwzouSgoy8XV+MSutIoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTkj8xdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C95CC433C7;
	Tue,  2 Apr 2024 01:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712019943;
	bh=Y71nP2zwtbVSLu5riks8Otndx5/nVc0R0gnKxEK2tWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTkj8xdq7COZKzT3990rY8X67gBnDEg9Xc4A/GWfqB/XFwbIhQurlG34TNAuds5eM
	 XDNBx+6j2C1FX5+pwEsvu0uW68YR1WyOz+L+yD1HquHCddmvAI2U3OvtrcTR3UcJDc
	 2h1aZR7DsB2JW/n5mYueSFXCPper2Al8zjAXh3kplUIIv/7NjHjRULpgwT5Ca9Tgne
	 Z1T+INAKNB0ejtyeXGUcdXHph1VcqBBOTIxBRzraPpy3ymmYvn28KkhbpWrVphRzG6
	 svtRwaCEH32wlSCWGD3C6z6VVZnvRsIupA9RseaiBAI9o4jevmyikUBiwKrwtNULRH
	 8NUQg+4CGWx2A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	sdf@google.com,
	donald.hunter@gmail.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 7/7] testing: net-drv: add a driver test for stats reporting
Date: Mon,  1 Apr 2024 18:05:19 -0700
Message-ID: <20240402010520.1209517-8-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402010520.1209517-1-kuba@kernel.org>
References: <20240402010520.1209517-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a very simple test to make sure drivers report expected
stats. Drivers which implement FEC or pause configuration
should report relevant stats. Qstats must be reported,
at least packet and byte counts, and they must match
total device stats.

Tested with netdevsim, bnxt, in-tree and installed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/stats.py | 85 ++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/stats.py

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
new file mode 100755
index 000000000000..751cca2869b8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -0,0 +1,85 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_in, ksft_true, KsftSkipEx, KsftXfailEx
+from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
+from lib.py import NetDrvEnv
+
+cfg = None
+ethnl = EthtoolFamily()
+netfam = NetdevFamily()
+rtnl = RtnlFamily()
+
+
+def check_pause() -> None:
+    global cfg, ethnl
+
+    try:
+        ethnl.pause_get({"header": {"dev-index": cfg.ifindex}})
+    except NlError as e:
+        if e.error == 95:
+            raise KsftXfailEx("pause not supported by the device")
+        raise
+
+    data = ethnl.pause_get({"header": {"dev-index": cfg.ifindex,
+                                       "flags": {'stats'}}})
+    ksft_true(data['stats'], "driver does not report stats")
+
+
+def check_fec() -> None:
+    global ethnl
+
+    try:
+        ethnl.fec_get({"header": {"dev-index": cfg.ifindex}})
+    except NlError as e:
+        if e.error == 95:
+            raise KsftXfailEx("FEC not supported by the device")
+        raise
+
+    data = ethnl.fec_get({"header": {"dev-index": cfg.ifindex,
+                                     "flags": {'stats'}}})
+    ksft_true(data['stats'], "driver does not report stats")
+
+
+def pkt_byte_sum() -> None:
+    global cfg, netfam, rtnl
+
+    def get_qstat(test):
+        global netfam
+        stats = netfam.qstats_get({}, dump=True)
+        if stats:
+            for qs in stats:
+                if qs["ifindex"]== test.ifindex:
+                    return qs
+
+    qstat = get_qstat(cfg)
+    if qstat is None:
+        raise KsftSkipEx("qstats not supported by the device")
+
+    for key in ['tx-packets', 'tx-bytes', 'rx-packets', 'rx-bytes']:
+        ksft_in(key, qstat, "Drivers should always report basic keys")
+
+    # Compare stats, rtnl stats and qstats must match,
+    # but the interface may be up, so do a series of dumps
+    # each time the more "recent" stats must be higher or same.
+    def stat_cmp(rstat, qstat):
+        for key in ['tx-packets', 'tx-bytes', 'rx-packets', 'rx-bytes']:
+            if rstat[key] != qstat[key]:
+                return rstat[key] - qstat[key]
+        return 0
+
+    for _ in range(10):
+        rtstat = rtnl.getlink({"ifi-index": cfg.ifindex})['stats']
+        if stat_cmp(rtstat, qstat) < 0:
+            raise Exception("RTNL stats are lower, fetched later")
+        qstat = get_qstat(cfg)
+        if stat_cmp(rtstat, qstat) > 0:
+            raise Exception("Qstats are lower, fetched later")
+
+
+if __name__ == "__main__":
+    cfg = NetDrvEnv(__file__)
+    try:
+        ksft_run([check_pause, check_fec, pkt_byte_sum])
+    finally:
+        del cfg
-- 
2.44.0


