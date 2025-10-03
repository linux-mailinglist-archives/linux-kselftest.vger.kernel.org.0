Return-Path: <linux-kselftest+bounces-42745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D784BB867A
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 01:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB0484EE155
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Oct 2025 23:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9DF287259;
	Fri,  3 Oct 2025 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlzfkoDo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F42285C8E;
	Fri,  3 Oct 2025 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534259; cv=none; b=BLZGCD/P0NMSuDZk14mGpINoPLZiiZzgfx776yn8xABm2Gl+Bebfhw7rMrgjkwHkLFyFqDyiOjumVml3MeBhrUCdLFyrgBt+75E2mZfhrbRZwXxn6APK2Uunvl+ahtVlZSZfFtdgjJriOff5sobvmUBpvkGvFzMqw/3q3J46Sps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534259; c=relaxed/simple;
	bh=YkgToYS++8u0+Wyb7wCZMMG10IB8+FVt3Vi4vzFyhbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwSfDl/iH0egnWQFQX9jbPfn6U1HKm4J/xbWQhkZLvpSg3Ogoj/oa9LT78Yc58grGbZTij5c8f9EJx9op0OzCkYICaU2zpyr/EAShcQ3oVdgHTGIUSEZmvvBKA9CywsKp4+wN5lMmAuPEYa6R7/RNUGzADbQB0eEBai2PFYARiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlzfkoDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06C9C113D0;
	Fri,  3 Oct 2025 23:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759534259;
	bh=YkgToYS++8u0+Wyb7wCZMMG10IB8+FVt3Vi4vzFyhbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KlzfkoDo+wT3pgMYeKdVqmjuhWHACTQ+AVStZ4/6KT+1IUGvXtDhFgFpZMU8SJJ9D
	 5Xh7EB1kUBDIut1vUUd9GaZ9QZZOWxFzezFW+12wKdvPX30rqk5TANhoD7IwZ2PR/E
	 jhW41EWZh/yU93x89Jf9byeNnRwZxGswdchSvFV1PziVVcH7Ej5RCW8C7iH5fPElkf
	 uMNPsPrcTJD8M4HJmvIuwGmi41kEpovJhxmbWpjvfc1SzudBJStBvRYep5ZUoEbzcB
	 /H+eFGZH1dcjj/bui6aWKcA3HX4F1h4Sd/dSfW/2w7zELyul8BOKywWrntz5rpPj5x
	 vdL4xXezoeBgQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 5/9] selftests: drv-net: xdp: add test for interface level qstats
Date: Fri,  3 Oct 2025 16:30:21 -0700
Message-ID: <20251003233025.1157158-6-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003233025.1157158-1-kuba@kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Send a non-trivial number of packets and make sure that they
are counted correctly in qstats. Per qstats specification
XDP is the first layer of the stack so we should see Rx and Tx
counters go up for packets which went thru XDP.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: sdf@fomichev.me
CC: linux-kselftest@vger.kernel.org
CC: bpf@vger.kernel.org
---
 tools/testing/selftests/drivers/net/xdp.py | 91 +++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index a7a4d97aa228..a148004e1c36 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -11,8 +11,9 @@ import string
 from dataclasses import dataclass
 from enum import Enum
 
-from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ne, ksft_pr
-from lib.py import KsftFailEx, NetDrvEpEnv, EthtoolFamily, NlError
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, ksft_ne, ksft_pr
+from lib.py import KsftFailEx, NetDrvEpEnv
+from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import bkg, cmd, rand_port, wait_port_listen
 from lib.py import ip, bpftool, defer
 
@@ -671,6 +672,88 @@ from lib.py import ip, bpftool, defer
     _validate_res(res, offset_lst, pkt_sz_lst)
 
 
+def _test_xdp_native_ifc_stats(cfg, act):
+    cfg.require_cmd("socat")
+
+    bpf_info = BPFProgInfo("xdp_prog", "xdp_native.bpf.o", "xdp", 1500)
+    prog_info = _load_xdp_prog(cfg, bpf_info)
+    port = rand_port()
+
+    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, act.value)
+    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+
+    # Discard the input, but we need a listener to avoid ICMP errors
+    rx_udp = f"socat -{cfg.addr_ipver} -T 2 -u UDP-RECV:{port},reuseport " + \
+        "/dev/null"
+    # Listener runs on "remote" in case of XDP_TX
+    rx_host = cfg.remote if act == XDPAction.TX else None
+    # We want to spew 2000 packets quickly, bash seems to do a good enough job
+    tx_udp =  f"exec 5<>/dev/udp/{cfg.addr}/{port}; " \
+        "for i in `seq 2000`; do echo a >&5; done; exec 5>&-"
+
+    cfg.wait_hw_stats_settle()
+    # Qstats have more clearly defined semantics than rtnetlink.
+    # XDP is the "first layer of the stack" so XDP packets should be counted
+    # as received and sent as if the decision was made in the routing layer.
+    before = cfg.netnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
+
+    with bkg(rx_udp, host=rx_host, exit_wait=True):
+        wait_port_listen(port, proto="udp", host=rx_host)
+        cmd(tx_udp, host=cfg.remote, shell=True)
+
+    cfg.wait_hw_stats_settle()
+    after = cfg.netnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
+
+    ksft_ge(after['rx-packets'] - before['rx-packets'], 2000)
+    if act == XDPAction.TX:
+        ksft_ge(after['tx-packets'] - before['tx-packets'], 2000)
+
+    expected_pkts = 2000
+    stats = _get_stats(prog_info["maps"]["map_xdp_stats"])
+    ksft_eq(stats[XDPStats.RX.value], expected_pkts, "XDP RX stats mismatch")
+    if act == XDPAction.TX:
+        ksft_eq(stats[XDPStats.TX.value], expected_pkts, "XDP TX stats mismatch")
+
+    # Flip the ring count back and forth to make sure the stats from XDP rings
+    # don't get lost.
+    chans = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    if chans.get('combined-count', 0) > 1:
+        cfg.ethnl.channels_set({'header': {'dev-index': cfg.ifindex},
+                                'combined-count': 1})
+        cfg.ethnl.channels_set({'header': {'dev-index': cfg.ifindex},
+                                'combined-count': chans['combined-count']})
+        before = after
+        after = cfg.netnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
+
+        ksft_ge(after['rx-packets'], before['rx-packets'])
+        if act == XDPAction.TX:
+            ksft_ge(after['tx-packets'], before['tx-packets'])
+
+
+def test_xdp_native_qstats_pass(cfg):
+    """
+    Send 2000 messages, expect XDP_PASS, make sure the packets were counted
+    to interface level qstats (Rx).
+    """
+    _test_xdp_native_ifc_stats(cfg, XDPAction.PASS)
+
+
+def test_xdp_native_qstats_drop(cfg):
+    """
+    Send 2000 messages, expect XDP_DROP, make sure the packets were counted
+    to interface level qstats (Rx).
+    """
+    _test_xdp_native_ifc_stats(cfg, XDPAction.DROP)
+
+
+def test_xdp_native_qstats_tx(cfg):
+    """
+    Send 2000 messages, expect XDP_TX, make sure the packets were counted
+    to interface level qstats (Rx and Tx)
+    """
+    _test_xdp_native_ifc_stats(cfg, XDPAction.TX)
+
+
 def main():
     """
     Main function to execute the XDP tests.
@@ -682,6 +765,7 @@ from lib.py import ip, bpftool, defer
     """
     with NetDrvEpEnv(__file__) as cfg:
         cfg.ethnl = EthtoolFamily()
+        cfg.netnl = NetdevFamily()
         ksft_run(
             [
                 test_xdp_native_pass_sb,
@@ -694,6 +778,9 @@ from lib.py import ip, bpftool, defer
                 test_xdp_native_adjst_tail_shrnk_data,
                 test_xdp_native_adjst_head_grow_data,
                 test_xdp_native_adjst_head_shrnk_data,
+                test_xdp_native_qstats_pass,
+                test_xdp_native_qstats_drop,
+                test_xdp_native_qstats_tx,
             ],
             args=(cfg,))
     ksft_exit()
-- 
2.51.0


