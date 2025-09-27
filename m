Return-Path: <linux-kselftest+bounces-42551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB2DBA64A1
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 00:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4252E1898944
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 22:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9FF248166;
	Sat, 27 Sep 2025 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCdRDsgh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72782244687;
	Sat, 27 Sep 2025 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759013673; cv=none; b=uUq/1NMZkYpvwMsFPyC0jZU1EQ4MQBlkcMcZsNl9tUyP93b2AobNFiNpOdBq8tKvhSdosbN17zf9XrGL8n7+GXpVroLsCZMki2PVi9Yw4pG1cw2r3MtDXX4WoWO0K9HTrDoOXMXnkto2IaOQH8voRSZWLWp9dATVziIn5Rp8BIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759013673; c=relaxed/simple;
	bh=GneB0ThLHbVtLS0XbnCrB32Rb5d5BSNKT7g7GRQxoU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEqwhtqln+JCLgRrzvm9T+h66kAGn8u8RP/RsYtNhbDQ/x2TJD9l3LYc1bvob9Q20B/ftaTC8+09YxPAmfVOoKJLrtb83Eg8NkU8wGm6DzZ225l93MdFRMtFsYcJaI+K1Z0Loi9uEEsbcLVoCxQT8tKH3sWNDPkjnlUUcuoER5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCdRDsgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5D8C4CEE7;
	Sat, 27 Sep 2025 22:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759013673;
	bh=GneB0ThLHbVtLS0XbnCrB32Rb5d5BSNKT7g7GRQxoU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCdRDsghuMCpGuHrmcCCucJvDUstx1O5yWcglgKl9IMVtrHDyWh397LvukltTcE5O
	 G4UGdCEXraxOyocjrI7JAhpHSXPBr86fbWIvON9ZEHiYQdx3KmZxXOVH6Ae6+V1NHE
	 AbQ2hxGgjohqw/iZPS4N1edg3cV8hJkfaTvALanxTGM2bbcYDRtgjGXZoGhb9vxo80
	 LhbjiJPjT1v1CQpcAWh8VTpXuxFZdX2QTnfvpgxO6+spnTwP9s+9X5a3b5peJMhh2L
	 0GGtXxBO00A1JJv23Z0JTw/Donc9BHjHkJMPdPjDf0oqk9OFpS2960yncuuNYEtN1L
	 QFeWa62VOPk/Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	petrm@nvidia.com,
	willemb@google.com,
	shuah@kernel.org,
	daniel.zahka@gmail.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 7/8] selftests: drv-net: psp: add test for auto-adjusting TCP MSS
Date: Sat, 27 Sep 2025 15:54:19 -0700
Message-ID: <20250927225420.1443468-8-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250927225420.1443468-1-kuba@kernel.org>
References: <20250927225420.1443468-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test TCP MSS getting auto-adjusted. PSP adds an encapsulation overhead
of 40B per packet, when used in transport mode without any
virtualization cookie or other optional PSP header fields. The kernel
should adjust the MSS for a connection after PSP tx state is reached.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index e8c80ebfa2f6..37953838abf8 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -431,6 +431,45 @@ from lib.py import bkg, rand_port, wait_port_listen
         s.close()
 
 
+def _data_mss_adjust(cfg, ipver):
+    _init_psp_dev(cfg)
+
+    # First figure out what the MSS would be without any adjustments
+    s = _make_clr_conn(cfg, ipver)
+    s.send(b"0123456789abcdef" * 1024)
+    _check_data_rx(cfg, 16 * 1024)
+    mss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
+    _close_conn(cfg, s)
+
+    s = _make_psp_conn(cfg, 0, ipver)
+    try:
+        rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                     "dev-id": cfg.psp_dev_id,
+                                     "sock-fd": s.fileno()})
+        rx = rx_assoc['rx-key']
+        tx = _spi_xchg(s, rx)
+
+        rxmss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
+        ksft_eq(mss, rxmss)
+
+        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                          "version": 0,
+                          "tx-key": tx,
+                          "sock-fd": s.fileno()})
+
+        txmss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
+        ksft_eq(mss, txmss + 40)
+
+        data_len = _send_careful(cfg, s, 100)
+        _check_data_rx(cfg, data_len)
+        _check_data_outq(s, 0)
+
+        txmss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
+        ksft_eq(mss, txmss + 40)
+    finally:
+        _close_psp_conn(cfg, s)
+
+
 def data_stale_key(cfg):
     """ Test send on a double-rotated key """
     _init_psp_dev(cfg)
@@ -470,6 +509,15 @@ from lib.py import bkg, rand_port, wait_port_listen
     return test_case
 
 
+def ipver_test_builder(name, test_func, ipver):
+    """Build test cases for each IP version"""
+    def test_case(cfg):
+        cfg.require_ipver(ipver)
+        test_case.__name__ = f"{name}_ip{ipver}"
+        test_func(cfg, ipver)
+    return test_case
+
+
 def main() -> None:
     """ Ksft boiler plate main """
 
@@ -497,6 +545,10 @@ from lib.py import bkg, rand_port, wait_port_listen
                     for version in range(0, 4)
                     for ipver in ("4", "6")
                 ]
+                cases += [
+                    ipver_test_builder("data_mss_adjust", _data_mss_adjust, ipver)
+                    for ipver in ("4", "6")
+                ]
 
                 ksft_run(cases=cases, globs=globals(),
                          case_pfx={"dev_", "data_", "assoc_"},
-- 
2.51.0


