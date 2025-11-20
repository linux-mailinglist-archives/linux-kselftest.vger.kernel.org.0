Return-Path: <linux-kselftest+bounces-46041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D87C71C84
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3F354E41FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 02:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCF5280327;
	Thu, 20 Nov 2025 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvm5q6kS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F8D27FD5A;
	Thu, 20 Nov 2025 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604644; cv=none; b=EtSiAtxkFncw3IR6NEDiorYm/aILpnuuB9XYH+3txDb5EZQ4LOpMJWCCPBmadJQaallctAObuYv46QPIF7NvQ3CPOUEsZyPCnQfCVePPQNhBbYHFMAmnkQ0Jrp1oxnlOqvmvsIUcSCbhN4pNmUyoHOQxne9nvvHMbJgbVBS3Uq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604644; c=relaxed/simple;
	bh=b+X41mWMAQNr+HIJHBkVEr/hmF18sHzw0a6w5PrI2/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3C/LIJ8qEL6rpSlpOXA3dIVKpzoSut02DxjdYqYWcXoP6fbq1JO3hBKtM9JGU8y4D6wJZKEFA2q/mBsg8rcaQEGR18bl8mJ4bffKI/5g1E4rfDxV7cr3ncV0qA4vNzFxGav/wHyv3B7n3QM+ZyPQbizkM6SB4eBu9LGd2z9khA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvm5q6kS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F62C113D0;
	Thu, 20 Nov 2025 02:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604644;
	bh=b+X41mWMAQNr+HIJHBkVEr/hmF18sHzw0a6w5PrI2/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvm5q6kS6IrzSMTjsx3L0/B3lfqKumepCJiSt8rLqxcf7ZzqbomAT7X0hZO2pLV/Y
	 eH7XNFThHgvWO/P/ci8/wsUK3BLV1NiRthudh0EWVh73B3U8QrX4Nues5tHMAKklN1
	 6fDPktG530JrDT8p5zM08x53vMPzFzuGsn91gsO91AIIYTJlUJILpveUHTxqZs/xzZ
	 GyurMnq+1oZNw0pcb8Rr1aC1qXSnprQbOjPA8M+pj4EVt1i1tlF9/m3/k7DodhKou1
	 +CgoznOzdUkGH3UnXsqTkgHkPlQumRmWZc6d2S2NoINlyYDSHE0CPEeam/+JVrsMTR
	 i5fJjNboibo7w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	krakauer@google.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	hawk@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 04/12] selftests: drv-net: xdp: use variants for qstat tests
Date: Wed, 19 Nov 2025 18:10:16 -0800
Message-ID: <20251120021024.2944527-5-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120021024.2944527-1-kuba@kernel.org>
References: <20251120021024.2944527-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use just-added ksft variants for XDP qstat tests.

While at it correct the number of packets, we're sending
1000 packets now.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
cc: hawk@kernel.org
cc: daniel@iogearbox.net
cc: ast@kernel.org
cc: bpf@vger.kernel.org
---
 tools/testing/selftests/drivers/net/xdp.py | 42 ++++++++--------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index 834a37ae7d0d..e54df158dfe9 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -12,6 +12,7 @@ from dataclasses import dataclass
 from enum import Enum
 
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, ksft_ne, ksft_pr
+from lib.py import KsftNamedVariant, ksft_variants
 from lib.py import KsftFailEx, NetDrvEpEnv
 from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import bkg, cmd, rand_port, wait_port_listen
@@ -672,7 +673,18 @@ from lib.py import ip, bpftool, defer
     _validate_res(res, offset_lst, pkt_sz_lst)
 
 
-def _test_xdp_native_ifc_stats(cfg, act):
+@ksft_variants([
+    KsftNamedVariant("pass", XDPAction.PASS),
+    KsftNamedVariant("drop", XDPAction.DROP),
+    KsftNamedVariant("tx", XDPAction.TX),
+])
+def test_xdp_native_qstats(cfg, act):
+    """
+    Send 1000 messages. Expect XDP action specified in @act.
+    Make sure the packets were counted to interface level qstats
+    (Rx, and Tx if act is TX).
+    """
+
     cfg.require_cmd("socat")
 
     bpf_info = BPFProgInfo("xdp_prog", "xdp_native.bpf.o", "xdp", 1500)
@@ -733,30 +745,6 @@ from lib.py import ip, bpftool, defer
             ksft_ge(after['tx-packets'], before['tx-packets'])
 
 
-def test_xdp_native_qstats_pass(cfg):
-    """
-    Send 2000 messages, expect XDP_PASS, make sure the packets were counted
-    to interface level qstats (Rx).
-    """
-    _test_xdp_native_ifc_stats(cfg, XDPAction.PASS)
-
-
-def test_xdp_native_qstats_drop(cfg):
-    """
-    Send 2000 messages, expect XDP_DROP, make sure the packets were counted
-    to interface level qstats (Rx).
-    """
-    _test_xdp_native_ifc_stats(cfg, XDPAction.DROP)
-
-
-def test_xdp_native_qstats_tx(cfg):
-    """
-    Send 2000 messages, expect XDP_TX, make sure the packets were counted
-    to interface level qstats (Rx and Tx)
-    """
-    _test_xdp_native_ifc_stats(cfg, XDPAction.TX)
-
-
 def main():
     """
     Main function to execute the XDP tests.
@@ -781,9 +769,7 @@ from lib.py import ip, bpftool, defer
                 test_xdp_native_adjst_tail_shrnk_data,
                 test_xdp_native_adjst_head_grow_data,
                 test_xdp_native_adjst_head_shrnk_data,
-                test_xdp_native_qstats_pass,
-                test_xdp_native_qstats_drop,
-                test_xdp_native_qstats_tx,
+                test_xdp_native_qstats,
             ],
             args=(cfg,))
     ksft_exit()
-- 
2.51.1


