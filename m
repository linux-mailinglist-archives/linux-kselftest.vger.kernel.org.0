Return-Path: <linux-kselftest+bounces-8522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A738AB8CE
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 04:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841D3B20E56
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 02:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DD6D534;
	Sat, 20 Apr 2024 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVKlXjLy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC60D52A;
	Sat, 20 Apr 2024 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713580559; cv=none; b=T/tr5n/c+iVL5HD7pQsZ1SJQdH0/6TgKmHR8/Oikft2SqcODXiF4l+MHZvJE9PjY+Sq775IxE3X9+zmsuE3a/gjEsJhyHjgRS82MP+3hzsfWalrBnyuGzrBEjroUGVA/7VFbmF/RAa3MtbmaGrTWyCExv1u8yaXNMVLhm19yaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713580559; c=relaxed/simple;
	bh=/zBdyd1Mme/sptQ9EdUM8tqm9YYlq4wrqQG/3XLLSTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIHnH0oJsCKCSZRQGUz818fy3qTV65sbMlKib/OYfRdJTLkPchdLayli2onVkh9BHkYgUcjFUJkSJji28iIDLJmsLOEf2jtV++S+CfEFXXhI+C9Z1qYsewUATT7qOsbio1B9sAf4fpX9vy+WvROAA8XvlGUmn/OaCvE+MiOor2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVKlXjLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CCBC4AF13;
	Sat, 20 Apr 2024 02:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713580558;
	bh=/zBdyd1Mme/sptQ9EdUM8tqm9YYlq4wrqQG/3XLLSTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VVKlXjLysBxetKKCeViYq+D7ULAM6S9HHnuHei7l5rvo6dbW7J1/VAy+VH9LuSC0R
	 wBZ9lKW/xLJMBSiwBRr5FrtBwJ8jwc3ioGkX80xUSDMQsYP9KpmHFmhAfVEsgats+3
	 cCP/zms7oNLHufTLRQeJZ4cWNvkFomiMVVw3fYXb+/mjUqhXBcfCd96Ku8F0k4wM78
	 t51JCykEoIg6CXb2jO0Cu9PEn3q8PzNXEtdmbi65bQrJJm74YHIm+N8l8fAoiQf1LT
	 F2z4LiIFAILUgXnVqbnTWYsaidZoJqWt/62YtZNrIGayakCSNSI795mzI78LAo7cj5
	 drS2D2A19ou2g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	sdf@google.com,
	amritha.nambiar@intel.com,
	linux-kselftest@vger.kernel.org,
	dsahern@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/4] selftests: drv-net: test dumping qstats per device
Date: Fri, 19 Apr 2024 19:35:42 -0700
Message-ID: <20240420023543.3300306-5-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420023543.3300306-1-kuba@kernel.org>
References: <20240420023543.3300306-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for dumping qstats device by device.

ksft framework grows a ksft_raises() helper, to be used
under with, which should be familiar to unittest users.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/stats.py | 62 +++++++++++++++++++-
 tools/testing/selftests/net/lib/py/ksft.py   | 18 ++++++
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index 947df3eb681f..7a7b16b180e2 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -1,8 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
-from lib.py import ksft_run, ksft_exit
-from lib.py import ksft_in, ksft_true, KsftSkipEx, KsftXfailEx
+from lib.py import ksft_run, ksft_exit, ksft_pr
+from lib.py import ksft_ge, ksft_eq, ksft_in, ksft_true, ksft_raises, KsftSkipEx, KsftXfailEx
 from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
 from lib.py import NetDrvEnv
 
@@ -77,9 +77,65 @@ rtnl = RtnlFamily()
             raise Exception("Qstats are lower, fetched later")
 
 
+def qstat_by_ifindex(cfg) -> None:
+    global netfam
+    global rtnl
+
+    # Construct a map ifindex -> [dump, by-index, dump]
+    ifindexes = {}
+    stats = netfam.qstats_get({}, dump=True)
+    for entry in stats:
+        ifindexes[entry['ifindex']] = [entry, None, None]
+
+    for ifindex in ifindexes.keys():
+        entry = netfam.qstats_get({"ifindex": ifindex}, dump=True)
+        ksft_eq(len(entry), 1)
+        ifindexes[entry[0]['ifindex']][1] = entry[0]
+
+    stats = netfam.qstats_get({}, dump=True)
+    for entry in stats:
+        ifindexes[entry['ifindex']][2] = entry
+
+    if len(ifindexes) == 0:
+        raise KsftSkipEx("No ifindex supports qstats")
+
+    # Now make sure the stats match/make sense
+    for ifindex, triple in ifindexes.items():
+        all_keys = triple[0].keys() | triple[1].keys() | triple[2].keys()
+
+        for key in all_keys:
+            ksft_ge(triple[1][key], triple[0][key], comment="bad key: " + key)
+            ksft_ge(triple[2][key], triple[1][key], comment="bad key: " + key)
+
+    # Test invalid dumps
+    # 0 is invalid
+    with ksft_raises(NlError) as cm:
+        netfam.qstats_get({"ifindex": 0}, dump=True)
+    ksft_eq(cm.exception.nl_msg.error, -34)
+    ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')
+
+    # loopback has no stats
+    with ksft_raises(NlError) as cm:
+        netfam.qstats_get({"ifindex": 1}, dump=True)
+    ksft_eq(cm.exception.nl_msg.error, -95)
+    ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')
+
+    # Try to get stats for lowest unused ifindex but not 0
+    devs = rtnl.getlink({}, dump=True)
+    all_ifindexes = set([dev["ifi-index"] for dev in devs])
+    lowest = 2
+    while lowest in all_ifindexes:
+        lowest += 1
+
+    with ksft_raises(NlError) as cm:
+        netfam.qstats_get({"ifindex": lowest}, dump=True)
+    ksft_eq(cm.exception.nl_msg.error, -19)
+    ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')
+
+
 def main() -> None:
     with NetDrvEnv(__file__) as cfg:
-        ksft_run([check_pause, check_fec, pkt_byte_sum],
+        ksft_run([check_pause, check_fec, pkt_byte_sum, qstat_by_ifindex],
                  args=(cfg, ))
     ksft_exit()
 
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 25f2572fa540..e7f79f6185b0 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -53,6 +53,24 @@ KSFT_RESULT_ALL = True
         _fail("Check failed", a, "<", b, comment)
 
 
+class ksft_raises:
+    def __init__(self, expected_type):
+        self.exception = None
+        self.expected_type = expected_type
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, exc_type, exc_val, exc_tb):
+        if exc_type is None:
+            _fail(f"Expected exception {str(self.expected_type.__name__)}, none raised")
+        elif self.expected_type != exc_type:
+            _fail(f"Expected exception {str(self.expected_type.__name__)}, raised {str(exc_type.__name__)}")
+        self.exception = exc_val
+        # Suppress the exception if its the expected one
+        return self.expected_type == exc_type
+
+
 def ksft_busy_wait(cond, sleep=0.005, deadline=1, comment=""):
     end = time.monotonic() + deadline
     while True:
-- 
2.44.0


