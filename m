Return-Path: <linux-kselftest+bounces-23914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3355CA017AB
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 02:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666631883EE8
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 01:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CD7481B3;
	Sun,  5 Jan 2025 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ath7H3MY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EFF43AA9;
	Sun,  5 Jan 2025 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736039739; cv=none; b=RVvSW5nbSkP+/Nn/qjY15gz8tXtNaNRQzIOUxQHPHM8KSK5nnn+xy5fU1C5Z1T3MvqPIfM9RoCyryJNLoutQCwaxTHrVepdoc5jaS2h31WQ24yLyHkuYz+b1MgFuGFqxwYNDED/amClbmnF8rbQktO7x9QPfdSrMBf7SBodmQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736039739; c=relaxed/simple;
	bh=vkgR1MygQk6r8sEA+qf0oBjWRT4+t7Ar6oNBpL2pnKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cwwM0VuWM5ox/IppFIvmSdH+z5Rs6kYwCF1v115ulG/DlENZWJnY65UF06d7L2sBuvaLP2H5QhKf2I/+fCOmrdYQwLAQySVl3wk4Bc374gIyR+qocH16r9drc6YJaf7NwcCmeeernMCi9KinQ5kld5OdtOT6+pokk4a76Xisnlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ath7H3MY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232C9C4CED1;
	Sun,  5 Jan 2025 01:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736039738;
	bh=vkgR1MygQk6r8sEA+qf0oBjWRT4+t7Ar6oNBpL2pnKI=;
	h=From:To:Cc:Subject:Date:From;
	b=Ath7H3MY02APj0mHRHFGBCpi2eOWkSyf1EddR+59PZUpc6e34greu5/Rz7LyUJgL5
	 B8PX0Rx12yR7jeXZkGhwPmPmXZX2blR1/OeZb6+BkE/9uapvixVah+fIXolf0sTj98
	 i4cDAYiG1x39uc/lFgJEuUXdL+jlcqGm0rG3ijOxoZlfFlEW6v6kDwb9dgfXwlkbNn
	 TqxzZdlweeQKse3/LSAKiT6BPttySbIevQ3gx8qCHZQbacWmc5dDEfXzJujP6OvYs4
	 OBb2u+LIw/4oIgfPMMi4egc4etZ2HAprInXLtEnkufgksYd2NMHKbdVCTIveZj7irs
	 jT9i6MGNe61DQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: test drivers sleeping in ndo_get_stats64
Date: Sat,  4 Jan 2025 17:15:25 -0800
Message-ID: <20250105011525.1718380-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of our tests use rtnetlink to read device stats, so they
don't expose the drivers much to paths in which device stats
are read under RCU. Add tests which hammer profcs reads to
make sure drivers:
 - don't sleep while reporting stats,
 - can handle parallel reads,
 - can handle device going down while reading.

Set ifname on the env class in NetDrvEnv, we already do that
in NetDrvEpEnv.

  KTAP version 1
  1..7
  ok 1 stats.check_pause
  ok 2 stats.check_fec
  ok 3 stats.pkt_byte_sum
  ok 4 stats.qstat_by_ifindex
  ok 5 stats.check_down
  ok 6 stats.procfs_hammer
  # completed up/down cycles: 6
  ok 7 stats.procfs_downup_hammer
  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: petrm@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/drivers/net/lib/py/env.py       |  1 +
 tools/testing/selftests/drivers/net/stats.py  | 94 ++++++++++++++++++-
 tools/testing/selftests/net/lib/py/ksft.py    |  5 +
 3 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index fea343f209ea..987e452d3a45 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -48,6 +48,7 @@ from .remote import Remote
         else:
             self._ns = NetdevSimDev(**kwargs)
             self.dev = self._ns.nsims[0].dev
+        self.ifname = self.dev['ifname']
         self.ifindex = self.dev['ifindex']
 
     def __enter__(self):
diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index 031ac9def6c0..55d647c006ed 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -2,12 +2,15 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import errno
+import subprocess
+import time
 from lib.py import ksft_run, ksft_exit, ksft_pr
-from lib.py import ksft_ge, ksft_eq, ksft_in, ksft_true, ksft_raises, KsftSkipEx, KsftXfailEx
+from lib.py import ksft_ge, ksft_eq, ksft_is, ksft_in, ksft_lt, ksft_true, ksft_raises
+from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_disruptive
 from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
 from lib.py import NetDrvEnv
-from lib.py import ip, defer
+from lib.py import cmd, ip, defer
 
 ethnl = EthtoolFamily()
 netfam = NetdevFamily()
@@ -174,10 +177,95 @@ rtnl = RtnlFamily()
     netfam.qstats_get({"ifindex": cfg.ifindex, "scope": "queue"}, dump=True)
 
 
+def __run_inf_loop(body):
+    body = body.strip()
+    if body[-1] != ';':
+        body += ';'
+
+    return subprocess.Popen(f"while true; do {body} done", shell=True,
+                            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+
+
+def __stats_increase_sanely(old, new) -> None:
+    for k in old.keys():
+        ksft_ge(new[k], old[k])
+        ksft_lt(new[k] - old[k], 1 << 31, comment="likely wrapping error")
+
+
+def procfs_hammer(cfg) -> None:
+    """
+    Reading stats via procfs only holds the RCU lock, which is not an exclusive
+    lock, make sure drivers can handle parallel reads of stats.
+    """
+    one = __run_inf_loop("cat /proc/net/dev")
+    defer(one.kill)
+    two = __run_inf_loop("cat /proc/net/dev")
+    defer(two.kill)
+
+    time.sleep(1)
+    # Make sure the processes are running
+    ksft_is(one.poll(), None)
+    ksft_is(two.poll(), None)
+
+    rtstat1 = rtnl.getlink({"ifi-index": cfg.ifindex})['stats64']
+    time.sleep(2)
+    rtstat2 = rtnl.getlink({"ifi-index": cfg.ifindex})['stats64']
+    __stats_increase_sanely(rtstat1, rtstat2)
+    # defers will kill the loops
+
+
+@ksft_disruptive
+def procfs_downup_hammer(cfg) -> None:
+    """
+    Reading stats via procfs only holds the RCU lock, drivers often try
+    to sleep when reading the stats, or don't protect against races.
+    """
+    # Max out the queues, we'll flip between max an 1
+    channels = ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    if channels['combined-count'] == 0:
+        rx_type = 'rx'
+    else:
+        rx_type = 'combined'
+    cur_queue_cnt = channels[f'{rx_type}-count']
+    max_queue_cnt = channels[f'{rx_type}-max']
+
+    cmd(f"ethtool -L {cfg.ifname} {rx_type} {max_queue_cnt}")
+    defer(cmd, f"ethtool -L {cfg.ifname} {rx_type} {cur_queue_cnt}")
+
+    # Real test stats
+    stats = __run_inf_loop("cat /proc/net/dev")
+    defer(stats.kill)
+
+    ipset = f"ip link set dev {cfg.ifname}"
+    defer(ip, f"link set dev {cfg.ifname} up")
+    # The "echo -n 1" lets us count iterations below
+    updown = f"{ipset} down; sleep 0.05; {ipset} up; sleep 0.05; " + \
+             f"ethtool -L {cfg.ifname} {rx_type} 1; " + \
+             f"ethtool -L {cfg.ifname} {rx_type} {max_queue_cnt}; " + \
+              "echo -n 1"
+    updown = __run_inf_loop(updown)
+    kill_updown = defer(updown.kill)
+
+    time.sleep(1)
+    # Make sure the processes are running
+    ksft_is(stats.poll(), None)
+    ksft_is(updown.poll(), None)
+
+    rtstat1 = rtnl.getlink({"ifi-index": cfg.ifindex})['stats64']
+    # We're looking for crashes, give it extra time
+    time.sleep(9)
+    rtstat2 = rtnl.getlink({"ifi-index": cfg.ifindex})['stats64']
+    __stats_increase_sanely(rtstat1, rtstat2)
+
+    kill_updown.exec()
+    stdout, _ = updown.communicate(timeout=5)
+    ksft_pr("completed up/down cycles:", len(stdout.decode('utf-8')))
+
+
 def main() -> None:
     with NetDrvEnv(__file__, queue_count=100) as cfg:
         ksft_run([check_pause, check_fec, pkt_byte_sum, qstat_by_ifindex,
-                  check_down],
+                  check_down, procfs_hammer, procfs_downup_hammer],
                  args=(cfg, ))
     ksft_exit()
 
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 477ae76de93d..3efe005436cd 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -71,6 +71,11 @@ KSFT_DISRUPTIVE = True
         _fail("Check failed", a, "not in", b, comment)
 
 
+def ksft_is(a, b, comment=""):
+    if a is not b:
+        _fail("Check failed", a, "is not", b, comment)
+
+
 def ksft_ge(a, b, comment=""):
     if a < b:
         _fail("Check failed", a, "<", b, comment)
-- 
2.47.1


