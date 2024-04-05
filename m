Return-Path: <linux-kselftest+bounces-7251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAF0899350
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 04:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE801B21A90
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 02:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B505E1CF92;
	Fri,  5 Apr 2024 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czFwjkPg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0BE1CD18;
	Fri,  5 Apr 2024 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285136; cv=none; b=aBaanDZP6Vk15n0knSpMolp5cs5PIb2OxFzMU+QNLK6A84w0Wc+xp5129jNqEXCDsEzgQTIEuohlQPPbCp1kln5aYGNkVzcfvc3XqRtZ2xpQ/OP/2RbLBwQqqGMtbFuT7X+goLnE30CnNNQaZDBgEYaPzvy02O1UfRWaJxEUw5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285136; c=relaxed/simple;
	bh=8hIRahLfJ1A+yfucAwb1LVgvvKA1r+H9v75vdhnDdgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNKnR24UVVFid1k+pLL88XgVR4b16UdC4SNCPQ2Wi/iaVPdjj73SJDoRlSKkn63Pa6OYdS7taIFTPhmQWPCgG8k5b5t6W8xdj35Awe9t/ULan30g44Flu/32sGswN4JmAoxk+jo/GKzDmdiUSrY7Uj5QRTThx2i5f85kBfqRvfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czFwjkPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC862C43394;
	Fri,  5 Apr 2024 02:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712285136;
	bh=8hIRahLfJ1A+yfucAwb1LVgvvKA1r+H9v75vdhnDdgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=czFwjkPgkfZmbOiOckQHm5Tf1ewP9kYVCfsoSsjiVWxpuF3ou5dHDXQ1ewAJJQGKz
	 yk8Uc3St1DQkxR+PtiNlaHdWmMwHCZd2RfnQszy+aagifdAPpn4rFtRCTJ5qmas3sF
	 cOm6zSW9N8mD0QF11/hUNecaMovAUWiR7fffMIK/c5m/kMEIJU0tlwdV+tUtRBdezL
	 bFRv6oq3PT+yUnJmrnZpES6AquMMgaQBhl2HpPqWayj/rw1JiIzEWLrFjr2SiUxT7B
	 KLGMT8Ink2XcBVi/wIqIPKVoJ5bFpZhrWpfeRA4lcEDaOmAHWfn/Nebn1PLdlgHCkQ
	 IIc7wwELbUDJg==
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
Subject: [PATCH net-next v3 5/5] testing: net-drv: add a driver test for stats reporting
Date: Thu,  4 Apr 2024 19:45:26 -0700
Message-ID: <20240405024526.2752998-6-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405024526.2752998-1-kuba@kernel.org>
References: <20240405024526.2752998-1-kuba@kernel.org>
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


