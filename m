Return-Path: <linux-kselftest+bounces-45785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF09C662DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6B6435BA5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 20:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FBB34CFAF;
	Mon, 17 Nov 2025 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWP9UijO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F3E34C986;
	Mon, 17 Nov 2025 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413114; cv=none; b=pYQoNpKnbqlPSj82saA98dvSEvHbPgLhgaHOgBNywhuY9LG2qoBielhLikyc7ZjtvMlKBZ1k42/fuSYzyGcRDwszmI2aMPPvwLDERCq10bTQvUpW6W+TZAF4YURhnkCQ5j7nCQ9duAI8u/SQ8X+waArR0GI6DUFo/bzqVoSRshs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413114; c=relaxed/simple;
	bh=4dumnAHZrFHrAG7WbJ1+eKBvMGAsvZHlegQtzZcBGh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnETeXepyrW73E+qjopCJ8oHZeGV2BWP68kTsnhX50GB+kIDeVUeTsi2VXLYDI9tzZfCPlKWvQay99CFdr2aFRPBgzxy1Dj1W6e7pEaiDAc/xYyoe1DszPJ3ToYRb/CemlhjhMX2q4s7tZVdEVojHT0Q+KEx9jD5P6fPm4wluXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWP9UijO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE53C4AF18;
	Mon, 17 Nov 2025 20:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763413112;
	bh=4dumnAHZrFHrAG7WbJ1+eKBvMGAsvZHlegQtzZcBGh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rWP9UijOsNEKt8LfhJ3PP9S3AzRBIbFF1UxcUTx0ifatLZnhtmOIJVnlov8JFbws9
	 KaRChIqRMwwj0YJqVMPxN9JJlAoPAxRR9gd2g69+VkS7MBAetY7a1hBLsVqyUD17aL
	 Ln0GQGiIUxKSG37ojXjs4x1NApgnQEAy6Do5yGyxVxsUGZF+sj9wXaauZN9el+y89q
	 EbYgwIj6wG0+NgHmF5RDldVJdZSKosoXxqp8FshWIKldcpbUUNdrGFclDu1LN+v0VC
	 yeP6pPyIKhP/sxwngd1b2T2j7K9GqJOzpPcM2UOQrG7i2/oWke4TovD2FinZAdefBV
	 ZQH8JzClGpF0w==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 04/12] selftests: drv-net: xdp: use variants for qstat tests
Date: Mon, 17 Nov 2025 12:58:02 -0800
Message-ID: <20251117205810.1617533-5-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117205810.1617533-1-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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


