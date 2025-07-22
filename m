Return-Path: <linux-kselftest+bounces-37793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9783B0CF4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 03:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CBAC7A5222
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 01:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103671DF25C;
	Tue, 22 Jul 2025 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjmbqdhE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1431DEFE7;
	Tue, 22 Jul 2025 01:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148977; cv=none; b=nxFb73Hdx6rsnEYd0Meaa4MrHs3+bmMBKmTZ/6JerJukI9gpE4pwiMWAyBdXSrId3+MCqWvIKgguUsCEbXqCPnJJIWnCXopgW8KhCvfufe0CUA59nPJBDczhmnh/AoG/euwvKCbySJGZqEWm/E89+5wHvaVQFlYLIEEXEk+K31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148977; c=relaxed/simple;
	bh=gZrr2/TXUrDgtGvyBBgOtJ1IlIj07JowaDCMipkaHVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgncyhqUsG8TtSYECknnLFWm5HU180IGupEubOZtcv1sOpOzO+wk6GQ5+ZejOMjZWQEYPduHzSv0Ni4InUabWrP1XRyWXVEBAkAXrvn9uznlMvj6FtTGH0p7i8CnoTGCfYa/d6TSF4hIhBKMof2kHSaNpf7xZZNTBwwqiT9RI3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjmbqdhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54DCC4CEF6;
	Tue, 22 Jul 2025 01:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753148974;
	bh=gZrr2/TXUrDgtGvyBBgOtJ1IlIj07JowaDCMipkaHVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjmbqdhEwwRj5eH5FT3iuDMkr+z2BYJqyRwHJc+lI3BzwPsWuPSs9t8g57/A0Rrbl
	 /XOr7aVFq7rcE8AyqoW2+LZYRLWUl72ww9O4/JjxzJVG2J6ogTdtuZZB8+5+yHyL9N
	 yt3LOMhzR/4KvQljj64qKWERwrIcIw7oSmDQcjcrrXrw3o9Gbo64ykmnOETjr4i0tq
	 vQOS0+L3wJ3ej7c+ppWCc0aSx9LALr9Cq5oLeYYAoq1sIIyCpiTAm18LB0J9WSpfa5
	 o1XHdfyFfmijCVZEHVwJZe4GX26YBIKR/uYiixubXJIkk61T+Wl699GEzZY9D9fLJ8
	 dQ/QA1RSepEzg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	gal@nvidia.com,
	andrew@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 4/4] selftests: drv-net: add test for RSS on flow label
Date: Mon, 21 Jul 2025 18:49:15 -0700
Message-ID: <20250722014915.3365370-5-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722014915.3365370-1-kuba@kernel.org>
References: <20250722014915.3365370-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple test for checking that RSS on flow label works,
and that its rejected for IPv4 flows.

 # ./tools/testing/selftests/drivers/net/hw/rss_flow_label.py
 TAP version 13
 1..2
 ok 1 rss_flow_label.test_rss_flow_label
 ok 2 rss_flow_label.test_rss_flow_label_6only
 # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: sdf@fomichev.me
CC: linux-kselftest@vger.kernel.org
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/rss_flow_label.py          | 151 ++++++++++++++++++
 2 files changed, 152 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_flow_label.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index fdc97355588c..5159fd34cb33 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -18,6 +18,7 @@ TEST_PROGS = \
 	pp_alloc_fail.py \
 	rss_api.py \
 	rss_ctx.py \
+	rss_flow_label.py \
 	rss_input_xfrm.py \
 	tso.py \
 	xsk_reconfig.py \
diff --git a/tools/testing/selftests/drivers/net/hw/rss_flow_label.py b/tools/testing/selftests/drivers/net/hw/rss_flow_label.py
new file mode 100755
index 000000000000..e471e13160ae
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/rss_flow_label.py
@@ -0,0 +1,151 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Tests for RSS hashing on IPv6 Flow Label.
+"""
+
+import glob
+import socket
+from lib.py import CmdExitFailure
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, ksft_in, \
+    ksft_not_in, ksft_raises, KsftSkipEx
+from lib.py import bkg, cmd, defer, fd_read_timeout, rand_port
+from lib.py import NetDrvEpEnv
+
+
+def _ethtool_get_cfg(cfg, fl_type):
+    descr = cmd(f"ethtool -n {cfg.ifname} rx-flow-hash {fl_type}").stdout
+
+    converter = {
+        "IP SA": "s",
+        "IP DA": "d",
+        "L3 proto": "t",
+        "L4 bytes 0 & 1 [TCP/UDP src port]": "f",
+        "L4 bytes 2 & 3 [TCP/UDP dst port]": "n",
+        "IPv6 Flow Label": "l",
+    }
+
+    ret = ""
+    for line in descr.split("\n")[1:-2]:
+        # if this raises we probably need to add more keys to converter above
+        ret += converter[line]
+    return ret
+
+
+def _traffic(cfg, one_sock, one_cpu):
+    local_port  = rand_port(socket.SOCK_DGRAM)
+    remote_port = rand_port(socket.SOCK_DGRAM)
+
+    sock = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM)
+    sock.bind(("", local_port))
+    sock.connect((cfg.remote_addr_v["6"], 0))
+    if one_sock:
+        send = f"exec 5<>/dev/udp/{cfg.addr_v['6']}/{local_port}; " \
+                "for i in `seq 20`; do echo a >&5; sleep 0.02; done; exec 5>&-"
+    else:
+        send = "for i in `seq 20`; do echo a | socat -t0.02 - UDP6:" \
+              f"[{cfg.addr_v['6']}]:{local_port},sourceport={remote_port}; done"
+
+    cpus = set()
+    with bkg(send, shell=True, host=cfg.remote, exit_wait=True):
+        for _ in range(20):
+            fd_read_timeout(sock.fileno(), 1)
+            cpu = sock.getsockopt(socket.SOL_SOCKET, socket.SO_INCOMING_CPU)
+            cpus.add(cpu)
+
+    if one_cpu:
+        ksft_eq(len(cpus), 1,
+                f"{one_sock=} - expected one CPU, got traffic on: {cpus=}")
+    else:
+        ksft_ge(len(cpus), 2,
+                f"{one_sock=} - expected many CPUs, got traffic on: {cpus=}")
+
+
+def test_rss_flow_label(cfg):
+    """
+    Test hashing on IPv6 flow label. Send traffic over a single socket
+    and over multiple sockets. Depend on the remote having auto-label
+    enabled so that it randomizes the label per socket.
+    """
+
+    cfg.require_ipver("6")
+    cfg.require_cmd("socat", remote=True)
+    if not hasattr(socket, "SO_INCOMING_CPU"):
+        raise KsftSkipEx("socket.SO_INCOMING_CPU was added in Python 3.11")
+
+    # 1 is the default, if someone changed it we probably shouldn"t mess with it
+    af = cmd("cat /proc/sys/net/ipv6/auto_flowlabels", host=cfg.remote).stdout
+    if af.strip() != "1":
+        raise KsftSkipEx("Remote does not have auto_flowlabels enabled")
+
+    qcnt = len(glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*"))
+    if qcnt < 2:
+        raise KsftSkipEx(f"Local has only {qcnt} queues")
+
+    # Enable flow label hashing for UDP6
+    initial = _ethtool_get_cfg(cfg, "udp6")
+    no_lbl = initial.replace("l", "")
+    if "l" not in initial:
+        try:
+            cmd(f"ethtool -N {cfg.ifname} rx-flow-hash udp6 l{no_lbl}")
+        except CmdExitFailure as exc:
+            raise KsftSkipEx("Device doesn't support Flow Label for UDP6") from exc
+
+        defer(cmd, f"ethtool -N {cfg.ifname} rx-flow-hash udp6 {initial}")
+
+    _traffic(cfg, one_sock=True, one_cpu=True)
+    _traffic(cfg, one_sock=False, one_cpu=False)
+
+    # Disable it, we should see no hashing (reset was already defer()ed)
+    cmd(f"ethtool -N {cfg.ifname} rx-flow-hash udp6 {no_lbl}")
+
+    _traffic(cfg, one_sock=False, one_cpu=True)
+
+
+def _check_v4_flow_types(cfg):
+    for fl_type in ["tcp4", "udp4", "ah4", "esp4", "sctp4"]:
+        try:
+            cur = cmd(f"ethtool -n {cfg.ifname} rx-flow-hash {fl_type}").stdout
+            ksft_not_in("Flow Label", cur,
+                        comment=f"{fl_type=} has Flow Label:" + cur)
+        except CmdExitFailure:
+            # Probably does not support this flow type
+            pass
+
+
+def test_rss_flow_label_6only(cfg):
+    """
+    Test interactions with IPv4 flow types. It should not be possible to set
+    IPv6 Flow Label hashing for an IPv4 flow type. The Flow Label should also
+    not appear in the IPv4 "current config".
+    """
+
+    with ksft_raises(CmdExitFailure) as cm:
+        cmd(f"ethtool -N {cfg.ifname} rx-flow-hash tcp4 sdfnl")
+    ksft_in("Invalid argument", cm.exception.cmd.stderr)
+
+    _check_v4_flow_types(cfg)
+
+    # Try to enable Flow Labels and check again, in case it leaks thru
+    initial = _ethtool_get_cfg(cfg, "udp6")
+    changed = initial.replace("l", "") if "l" in initial else initial + "l"
+
+    cmd(f"ethtool -N {cfg.ifname} rx-flow-hash udp6 {changed}")
+    restore = defer(cmd, f"ethtool -N {cfg.ifname} rx-flow-hash udp6 {initial}")
+
+    _check_v4_flow_types(cfg)
+    restore.exec()
+    _check_v4_flow_types(cfg)
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        ksft_run([test_rss_flow_label,
+                  test_rss_flow_label_6only],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.50.1


