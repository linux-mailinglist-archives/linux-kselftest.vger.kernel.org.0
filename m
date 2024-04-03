Return-Path: <linux-kselftest+bounces-7041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81044896290
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 04:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23241B232B7
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 02:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ECD3D575;
	Wed,  3 Apr 2024 02:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAgtCQ+s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA90C3C6A4;
	Wed,  3 Apr 2024 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712111676; cv=none; b=KPdo3pFrItCjOd5LATUPC3W8mEXh+4X3Do0zFXUxy6Y0Ql8TEHC060OwLpW76izMawb8uueLWJnnitxKkNQLJF59k2uhYTWvkK3blRJ0aGHZ+mQtW3dJk1cZLopF+JjXD+/itlm2jTjUpYvUu2V2LbxpSd7WgE/HyulHOwdbZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712111676; c=relaxed/simple;
	bh=8hIRahLfJ1A+yfucAwb1LVgvvKA1r+H9v75vdhnDdgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQtCCBIo/4hfmcY5SR/BG6wp4tE2Xx7masC5ouoZqagkqO9RQ1kJOi0hj4ZD/iJVYCZscY7CzXH+XPRpJ+OGy4d3lxDBk5MAAce94FJldDsDhXpKHxluLqfFfu+fm9dWgxtzNdFGo3aXHYsWw/EucWinx8luKYDfDZh3ES4KfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAgtCQ+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379F1C433F1;
	Wed,  3 Apr 2024 02:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712111676;
	bh=8hIRahLfJ1A+yfucAwb1LVgvvKA1r+H9v75vdhnDdgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YAgtCQ+sYOsHPnwF7BZZqZwccxYs49hBwJDd5+xj59Uuh4SBPfo+ERxG7glR5Y6Cj
	 ETHfBjHrvlHYtPOrxgBgN619kx43CKU9C6FtkV4VhDtbenm1cgAxMyrdhmM/2IfFRC
	 wncBe4xM20xT/CwBNkYUcnWrDcGHIM4XwZS6lRhWM83AsGJMPfhxRS/WiakosExh0Q
	 lshJo5iXlsEruCFwcMTzntWmNhZ6IdWcc6dg95ooRTlDYSZqe46gK0BnBkbwEhZ41T
	 XZDjU++ZHfVWZHVq4GP/FaYrfAQxrUrwRSld6nQK1+7M0pAclOPwUCGkyRRfHUxxi5
	 GjA6Nn8grSGzw==
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
Subject: [PATCH net-next v2 7/7] testing: net-drv: add a driver test for stats reporting
Date: Tue,  2 Apr 2024 19:34:26 -0700
Message-ID: <20240403023426.1762996-8-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403023426.1762996-1-kuba@kernel.org>
References: <20240403023426.1762996-1-kuba@kernel.org>
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
v2:
 - pass cfg as argument
 - use with
---
 tools/testing/selftests/drivers/net/stats.py | 86 ++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/stats.py

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
new file mode 100755
index 000000000000..5a9d4e56b28b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -0,0 +1,86 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_in, ksft_true, KsftSkipEx, KsftXfailEx
+from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
+from lib.py import NetDrvEnv
+
+ethnl = EthtoolFamily()
+netfam = NetdevFamily()
+rtnl = RtnlFamily()
+
+
+def check_pause(cfg) -> None:
+    global ethnl
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
+def check_fec(cfg) -> None:
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
+def pkt_byte_sum(cfg) -> None:
+    global netfam, rtnl
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
+def main() -> None:
+    with NetDrvEnv(__file__) as cfg:
+        ksft_run([check_pause, check_fec, pkt_byte_sum],
+                 args=(cfg, ))
+
+
+if __name__ == "__main__":
+    main()
-- 
2.44.0


