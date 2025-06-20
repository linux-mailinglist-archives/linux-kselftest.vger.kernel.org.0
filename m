Return-Path: <linux-kselftest+bounces-35451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B25AE1FDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 18:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AF23A5C8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD2A2E6108;
	Fri, 20 Jun 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSUHj1Ty"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629082E4241;
	Fri, 20 Jun 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435910; cv=none; b=Z64aKhOQlCp1fDv6aq9caIllGh9RPwEVUiYJZ/e2aMei/NS0qahstS7QGmnBjYxwFniD2S3bNE7pKB+1NxtlNtzgmX+JsGbLOp3eqCCCWPQeM0ft2gd+km+PAeeaCKRP+kAbD6KGoyJEZA2zmqnZKJZNVJMV77ooT81M2BxsLO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435910; c=relaxed/simple;
	bh=BGNRLJc7KhFgQv4ochvd6TM/msTLexbqxE2Pi4aQquE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2pQI7s1HPRPwetVbpC/9mn6Sn+sp3vhIzFC64D/YgAS0cghhtmMQ43KnbG/GJLsnPedaks88CeIdvadZ2JR2qsuU91xbHn/pGbjgCZdWk3YOADOCqOy4lFSZPy4yZ3bS4eFIC48U+6tXEJdhVY5J5c+p6bvugvhwJ4Ct/TkEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSUHj1Ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8801C4CEF2;
	Fri, 20 Jun 2025 16:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750435909;
	bh=BGNRLJc7KhFgQv4ochvd6TM/msTLexbqxE2Pi4aQquE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSUHj1TyTaU7+w800Bbp/DoD7e4xjrnU9obYaeAegzceVx+jW2y8zUpiLO7xgTk3X
	 3U37I9RiqhdPApg6yYe257so7gwLwLPbBfcQ+2OilHrKXitqmtT6CyiqKG7fNPS2i+
	 pp6sXDn7/ubwbcPr9j8V6SJsEctNcfBs0RURJhsdPSkcrbwYAUWEWf29OF1qnA7KhR
	 fixxOf7JdBCsSpB40WktuT3GB74NlaYz2Oq2DxrWXBqt+fN3akWL4zJQlsZLEw/jME
	 qf2LyoQl2v7Rdtb3rQaAsv79+rR893RMalniGUC8bfdxT6ykTTG1AjtMm608jhsrPX
	 N9DvAvh6dVUDA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] selftests: drv-net: stats: fix pylint issues
Date: Fri, 20 Jun 2025 09:11:08 -0700
Message-ID: <20250620161109.2146242-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620161109.2146242-1-kuba@kernel.org>
References: <20250620161109.2146242-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Small adjustments to make pylint happy.

One warning about unused argument remains because the test uses
global variables rather than attaching netlink sockets to cfg.
Fixing this would be too much of a change for a linter fix commit
like this one.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/stats.py | 45 +++++++++++++-------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index efcc1e10575b..00a85d6e54f9 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -1,12 +1,16 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+"""
+Tests related to standard netdevice statistics.
+"""
+
 import errno
 import subprocess
 import time
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_ge, ksft_eq, ksft_is, ksft_in, ksft_lt, ksft_true, ksft_raises
-from lib.py import KsftSkipEx, KsftXfailEx
+from lib.py import KsftSkipEx, KsftXfailEx, KsftFailEx
 from lib.py import ksft_disruptive
 from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
 from lib.py import NetDrvEnv
@@ -18,13 +22,16 @@ rtnl = RtnlFamily()
 
 
 def check_pause(cfg) -> None:
-    global ethnl
+    """
+    Check that drivers which support Pause config also report standard
+    pause stats.
+    """
 
     try:
         ethnl.pause_get({"header": {"dev-index": cfg.ifindex}})
     except NlError as e:
         if e.error == errno.EOPNOTSUPP:
-            raise KsftXfailEx("pause not supported by the device")
+            raise KsftXfailEx("pause not supported by the device") from e
         raise
 
     data = ethnl.pause_get({"header": {"dev-index": cfg.ifindex,
@@ -33,13 +40,16 @@ rtnl = RtnlFamily()
 
 
 def check_fec(cfg) -> None:
-    global ethnl
+    """
+    Check that drivers which support FEC config also report standard
+    FEC stats.
+    """
 
     try:
         ethnl.fec_get({"header": {"dev-index": cfg.ifindex}})
     except NlError as e:
         if e.error == errno.EOPNOTSUPP:
-            raise KsftXfailEx("FEC not supported by the device")
+            raise KsftXfailEx("FEC not supported by the device") from e
         raise
 
     data = ethnl.fec_get({"header": {"dev-index": cfg.ifindex,
@@ -48,15 +58,17 @@ rtnl = RtnlFamily()
 
 
 def pkt_byte_sum(cfg) -> None:
-    global netfam, rtnl
+    """
+    Check that qstat and interface stats match in value.
+    """
 
     def get_qstat(test):
-        global netfam
         stats = netfam.qstats_get({}, dump=True)
         if stats:
             for qs in stats:
                 if qs["ifindex"]== test.ifindex:
                     return qs
+        return None
 
     qstat = get_qstat(cfg)
     if qstat is None:
@@ -77,15 +89,14 @@ rtnl = RtnlFamily()
     for _ in range(10):
         rtstat = rtnl.getlink({"ifi-index": cfg.ifindex})['stats64']
         if stat_cmp(rtstat, qstat) < 0:
-            raise Exception("RTNL stats are lower, fetched later")
+            raise KsftFailEx("RTNL stats are lower, fetched later")
         qstat = get_qstat(cfg)
         if stat_cmp(rtstat, qstat) > 0:
-            raise Exception("Qstats are lower, fetched later")
+            raise KsftFailEx("Qstats are lower, fetched later")
 
 
 def qstat_by_ifindex(cfg) -> None:
-    global netfam
-    global rtnl
+    """ Qstats Netlink API tests - querying by ifindex. """
 
     # Construct a map ifindex -> [dump, by-index, dump]
     ifindexes = {}
@@ -93,7 +104,7 @@ rtnl = RtnlFamily()
     for entry in stats:
         ifindexes[entry['ifindex']] = [entry, None, None]
 
-    for ifindex in ifindexes.keys():
+    for ifindex in ifindexes:
         entry = netfam.qstats_get({"ifindex": ifindex}, dump=True)
         ksft_eq(len(entry), 1)
         ifindexes[entry[0]['ifindex']][1] = entry[0]
@@ -145,7 +156,7 @@ rtnl = RtnlFamily()
 
     # Try to get stats for lowest unused ifindex but not 0
     devs = rtnl.getlink({}, dump=True)
-    all_ifindexes = set([dev["ifi-index"] for dev in devs])
+    all_ifindexes = set(dev["ifi-index"] for dev in devs)
     lowest = 2
     while lowest in all_ifindexes:
         lowest += 1
@@ -158,18 +169,20 @@ rtnl = RtnlFamily()
 
 @ksft_disruptive
 def check_down(cfg) -> None:
+    """ Test statistics (interface and qstat) are not impacted by ifdown """
+
     try:
         qstat = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
     except NlError as e:
         if e.error == errno.EOPNOTSUPP:
-            raise KsftSkipEx("qstats not supported by the device")
+            raise KsftSkipEx("qstats not supported by the device") from e
         raise
 
     ip(f"link set dev {cfg.dev['ifname']} down")
     defer(ip, f"link set dev {cfg.dev['ifname']} up")
 
     qstat2 = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
-    for k, v in qstat.items():
+    for k in qstat:
         ksft_ge(qstat2[k], qstat[k], comment=f"{k} went backwards on device down")
 
     # exercise per-queue API to make sure that "device down" state
@@ -263,6 +276,8 @@ rtnl = RtnlFamily()
 
 
 def main() -> None:
+    """ Ksft boiler plate main """
+
     with NetDrvEnv(__file__, queue_count=100) as cfg:
         ksft_run([check_pause, check_fec, pkt_byte_sum, qstat_by_ifindex,
                   check_down, procfs_hammer, procfs_downup_hammer],
-- 
2.49.0


