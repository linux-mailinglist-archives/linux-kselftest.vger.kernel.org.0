Return-Path: <linux-kselftest+bounces-38733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C732B2197F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 01:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A48E3AFC3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 23:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF2E263C90;
	Mon, 11 Aug 2025 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWn7KUXI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54847258CC4;
	Mon, 11 Aug 2025 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754955767; cv=none; b=PfqlYdjiGN3ls5YPDCC8I3aRTOk6Y7f9N72gF5Hw6MLx0oe1lNsl7XRS79iNpFau8f2yh0ghVampv9OpEaUWnQTpbxT6aW0gSoYTrnSJrfXmSimSrZggyNPbs+lDKFnxGqob8uEf54VemBJY1He3AwQIoAk7WFTsrfiDGfjH8eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754955767; c=relaxed/simple;
	bh=8a8yMmgkbck/tnMDbwgodSlBpHVqC3yTvdQ/JzCg0vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnAnV37bVTTCSHjoauq3BhgQyce+DWapwpi+8Qu6QuMpOJrhQu/0qVkDh/ekqxCVWSXuVwVvTPMDlxZFykklkxvAkc/FPyWX+HdGGdW1y4rB2ANA2Fx6rLwlX+jxfHoFZ/avzruUUvFBI/1gsBM25zLHABxzxjdZDAcpTxjPlY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWn7KUXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72486C4CEF6;
	Mon, 11 Aug 2025 23:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754955766;
	bh=8a8yMmgkbck/tnMDbwgodSlBpHVqC3yTvdQ/JzCg0vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWn7KUXITbz8eA6rC08r7Jg1yCL7M+D5nwzjkT3uXKWZWf1wC3EQgc5IAyC6g6N6p
	 khd6dtABKexYMaqq6ZV9fcrr+fOOE8hMgIXNHvm/mtc07CEMv5+F2DmgVwH/eiHem3
	 lJBmQCMj6R9/UhyHesDFdz0QaiS71tMPi6NVWgSGXpEObChWnzC2QgmAWJuc9/6oLx
	 kkH2h2SORJII3pUAfP2RBBbtRfXRsjsdhLpt0Fj+p4PciRRA8PPAtMAdBJp4iLisHC
	 qBntKQrOucW6rDAwMbOMdjtT+UM2fiyqKVV95Vzd07ZkKiDm2RVeI3Ttuu1opfDbUt
	 /262xPTJTujeQ==
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
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	shuah@kernel.org,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 4/4] selftests: drv-net: add test for RSS on flow label
Date: Mon, 11 Aug 2025 16:42:12 -0700
Message-ID: <20250811234212.580748-5-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811234212.580748-1-kuba@kernel.org>
References: <20250811234212.580748-1-kuba@kernel.org>
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

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - check for RPS / RFS
v1: https://lore.kernel.org/20250722014915.3365370-5-kuba@kernel.org

CC: shuah@kernel.org
CC: sdf@fomichev.me
CC: linux-kselftest@vger.kernel.org
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/rss_flow_label.py          | 167 ++++++++++++++++++
 2 files changed, 168 insertions(+)
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
index 000000000000..6fa95fe27c47
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/rss_flow_label.py
@@ -0,0 +1,167 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Tests for RSS hashing on IPv6 Flow Label.
+"""
+
+import glob
+import os
+import socket
+from lib.py import CmdExitFailure
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, ksft_in, \
+    ksft_not_in, ksft_raises, KsftSkipEx
+from lib.py import bkg, cmd, defer, fd_read_timeout, rand_port
+from lib.py import NetDrvEpEnv
+
+
+def _check_system(cfg):
+    if not hasattr(socket, "SO_INCOMING_CPU"):
+        raise KsftSkipEx("socket.SO_INCOMING_CPU was added in Python 3.11")
+
+    qcnt = len(glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*"))
+    if qcnt < 2:
+        raise KsftSkipEx(f"Local has only {qcnt} queues")
+
+    for f in [f"/sys/class/net/{cfg.ifname}/queues/rx-0/rps_flow_cnt",
+              f"/sys/class/net/{cfg.ifname}/queues/rx-0/rps_cpus"]:
+        try:
+            with open(f, 'r') as fp:
+                setting = fp.read().strip()
+                # CPU mask will be zeros and commas
+                if setting.replace("0", "").replace(",", ""):
+                    raise KsftSkipEx(f"RPS/RFS is configured: {f}: {setting}")
+        except FileNotFoundError:
+            pass
+
+    # 1 is the default, if someone changed it we probably shouldn"t mess with it
+    af = cmd("cat /proc/sys/net/ipv6/auto_flowlabels", host=cfg.remote).stdout
+    if af.strip() != "1":
+        raise KsftSkipEx("Remote does not have auto_flowlabels enabled")
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
+    _check_system(cfg)
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


