Return-Path: <linux-kselftest+bounces-42550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C052BA6498
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 00:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288921887BEC
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 22:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D27124676A;
	Sat, 27 Sep 2025 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTKbMx1n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73928241673;
	Sat, 27 Sep 2025 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759013672; cv=none; b=rB0oCPRS1WMcV5ysRCZUAv4AUxF0WfGeA+LB4v4jZic00w3D5LXqwcHgftzps7hn+MUW3MnepyjjT/6DDYlQY1gkIFU287UPuVjvd3VUMZydeyLNNr4NP28ABzAs/fNJyeJNSXO6jcXt8dslFjFl/W4uUiS0+HXD0xF5DKPgQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759013672; c=relaxed/simple;
	bh=8pgVu2v3wURSf/gAPzywSsOS4eirW99VnIKWsBYuXlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1yhfdGrJrVfTDxwVuXQ3EFnN9fe7FkJV6Zd92Mj2wR1dKZ2zrGNU7g4gdWRLRXRsuo2569QprLWxyVNyiZcCmnmLU79oGjitytOXg4MrFHqjelNDE71wZFIIp0G7E0KDHGax9EIwyZAVMkPm2Bp/rdlagBfYrCGoC1OgmVD6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTKbMx1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24FAC4CEF5;
	Sat, 27 Sep 2025 22:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759013672;
	bh=8pgVu2v3wURSf/gAPzywSsOS4eirW99VnIKWsBYuXlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sTKbMx1n+E3TA5Is0XKJPVAxBqzUgarhT7cGEKax3fdghi/VBHbKjXRPTOqsdzGUY
	 pfGorlSIe9nyQ0ubXSRhQ92uFOzdHBFLRXYVsGz5xUImD6iH/o3riKto09cL/AXInP
	 clTZarkHI+b29X8xYYHnykn1fsnHtjqb/YYOGxh5JAQCpdvHk4StZHVhz2mgSsLyVo
	 1VjNPv6KJfNLwMOhnWxA279/FxEAa1hRDgdHT6ojIEzY1ALyhMXL5Ho+epOsf66t0m
	 buqYPeu3mqDCklf2PGQUJMo8RevrZ4gpB3fG02QGvKb7UkpG7JVDlMxgZQV6db/rm3
	 nFlf4dJoDOuZg==
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
Subject: [PATCH net-next v3 6/8] selftests: drv-net: psp: add connection breaking tests
Date: Sat, 27 Sep 2025 15:54:18 -0700
Message-ID: <20250927225420.1443468-7-kuba@kernel.org>
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

Add test checking conditions which lead to connections breaking.
Using bad key or connection gets stuck if device key is rotated
twice.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 92 +++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index c817553cc5e8..e8c80ebfa2f6 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -98,6 +98,16 @@ from lib.py import bkg, rand_port, wait_port_listen
         time.sleep(0.01)
     ksft_eq(read_len, exp_len)
 
+
+def _check_data_outq(s, exp_len, force_wait=False):
+    outq = 0
+    for _ in range(10):
+        outq = _get_outq(s)
+        if not force_wait and outq == exp_len:
+            break
+        time.sleep(0.01)
+    ksft_eq(outq, exp_len)
+
 #
 # Test case boiler plate
 #
@@ -372,6 +382,85 @@ from lib.py import bkg, rand_port, wait_port_listen
     _close_psp_conn(cfg, s)
 
 
+def __bad_xfer_do(cfg, s, tx, version='hdr0-aes-gcm-128'):
+    # Make sure we accept the ACK for the SPI before we seal with the bad assoc
+    _check_data_outq(s, 0)
+
+    cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                        "version": version,
+                        "tx-key": tx,
+                        "sock-fd": s.fileno()})
+
+    data_len = _send_careful(cfg, s, 20)
+    _check_data_outq(s, data_len, force_wait=True)
+    _check_data_rx(cfg, 0)
+    _close_psp_conn(cfg, s)
+
+
+def data_send_bad_key(cfg):
+    """ Test send data with bad key """
+    _init_psp_dev(cfg)
+
+    s = _make_psp_conn(cfg)
+
+    rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                   "dev-id": cfg.psp_dev_id,
+                                   "sock-fd": s.fileno()})
+    rx = rx_assoc['rx-key']
+    tx = _spi_xchg(s, rx)
+    tx['key'] = (tx['key'][0] ^ 0xff).to_bytes(1, 'little') + tx['key'][1:]
+    __bad_xfer_do(cfg, s, tx)
+
+
+def data_send_disconnect(cfg):
+    """ Test socket close after sending data """
+    _init_psp_dev(cfg)
+
+    with _make_psp_conn(cfg) as s:
+        assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                  "sock-fd": s.fileno()})
+        tx = _spi_xchg(s, assoc['rx-key'])
+        cfg.pspnl.tx_assoc({"version": 0,
+                          "tx-key": tx,
+                          "sock-fd": s.fileno()})
+
+        data_len = _send_careful(cfg, s, 100)
+        _check_data_rx(cfg, data_len)
+
+        s.shutdown(socket.SHUT_RDWR)
+        s.close()
+
+
+def data_stale_key(cfg):
+    """ Test send on a double-rotated key """
+    _init_psp_dev(cfg)
+
+    s = _make_psp_conn(cfg)
+    try:
+        rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                     "dev-id": cfg.psp_dev_id,
+                                     "sock-fd": s.fileno()})
+        rx = rx_assoc['rx-key']
+        tx = _spi_xchg(s, rx)
+
+        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                          "version": 0,
+                          "tx-key": tx,
+                          "sock-fd": s.fileno()})
+
+        data_len = _send_careful(cfg, s, 100)
+        _check_data_rx(cfg, data_len)
+        _check_data_outq(s, 0)
+
+        cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
+        cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
+
+        s.send(b'0123456789' * 200)
+        _check_data_outq(s, 2000, force_wait=True)
+    finally:
+        _close_psp_conn(cfg, s)
+
+
 def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
     """Build test cases for each combo of PSP version and IP version"""
     def test_case(cfg):
@@ -410,7 +499,8 @@ from lib.py import bkg, rand_port, wait_port_listen
                 ]
 
                 ksft_run(cases=cases, globs=globals(),
-                         case_pfx={"dev_", "assoc_"}, args=(cfg, ))
+                         case_pfx={"dev_", "data_", "assoc_"},
+                         args=(cfg, ))
 
                 cfg.comm_sock.send(b"exit\0")
                 cfg.comm_sock.close()
-- 
2.51.0


