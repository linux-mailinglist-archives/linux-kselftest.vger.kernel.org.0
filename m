Return-Path: <linux-kselftest+bounces-45922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5570C6BC60
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 22:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9AC0C35E527
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 21:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF42D30FC03;
	Tue, 18 Nov 2025 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXxHNBAW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2930F94B;
	Tue, 18 Nov 2025 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502721; cv=none; b=scTic2JDO1u5tetprrpRNBIY8uqKu/GHq1JFFQtk+/nqPyhZV9dGw65ueeZekisM8F2/vZUAYtB5Gv4dGfeH2MI3DiaMbFz6gksKjHF0yWyrEkw4ywrSIyyekka/6s82NLhfIe2i2AtYyu9ChkYXKIwwVtocfA1fVixS6BYFvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502721; c=relaxed/simple;
	bh=4dumnAHZrFHrAG7WbJ1+eKBvMGAsvZHlegQtzZcBGh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnaFqrKPz5f56CaBFBg+F7HUXCJXExG/PAiKNwMVehi/pvOntuUYDCsXOATu+PFNukPH7Qot9Pzg6Yj2jO3JJJnFFjaN8mEoScebVLs+JUisRJj+KFhM9oNFE4Q+FmEVXrc3cNFkebH73oYqwQvfZDsAhZuN1c4/djN8JQIiXdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXxHNBAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69E5C16AAE;
	Tue, 18 Nov 2025 21:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763502721;
	bh=4dumnAHZrFHrAG7WbJ1+eKBvMGAsvZHlegQtzZcBGh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXxHNBAWyYWJ8ehuPuAA0zToJmXkdhC0eBrm2X0LAWKJw9sBFpLEzjc439m7D2gDm
	 g3aCgZOfU1krw9OQoz/4tQAQv2melJNm4bMsIvxOWhkRoJRACVMjaQbSrqyiLilg5O
	 x7WnQ6H8iWWgc2EsTpyqxao0RxG55lEFZ7wlunEL8gjoDgovG4K0L8WpFYHpT9inbI
	 cjMst4rXOEsa8UxyycNSOe08uYTcotrZdh+qnVpRYsWhTOIe0FK5SNiAAU22AzrkZ9
	 tSVNEhNLHWvne34nTfjHpmm/RCUd8zbvzt6vryr+vKIkXFAEIf+9vI77g5juDT29Jq
	 LQ3KwuoqNodTw==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 04/12] selftests: drv-net: xdp: use variants for qstat tests
Date: Tue, 18 Nov 2025 13:51:18 -0800
Message-ID: <20251118215126.2225826-5-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118215126.2225826-1-kuba@kernel.org>
References: <20251118215126.2225826-1-kuba@kernel.org>
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


