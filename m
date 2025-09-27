Return-Path: <linux-kselftest+bounces-42549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C4DBA648F
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 00:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9234A0410
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 22:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096B9245028;
	Sat, 27 Sep 2025 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC96A/YQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2923244687;
	Sat, 27 Sep 2025 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759013671; cv=none; b=bd8vZvhAdJtEo2cIZDAXblSKoI1embFmvEnHkpUH/SvcYL0fP7oV1jwre2T8+/pCOxILV9HmV/sjIClP3QGKED1WW9UYYeZeDzrdsyD/ZZYKXG5xXzJy0Lw+wUvd33/F7uvDrzA7SoGQVj/jNL0TMmuDv70kG74rbO0/tABXr4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759013671; c=relaxed/simple;
	bh=TnfKM+PyYGH8wIWPnlqR9C5XY1Imm0+MJFa96E/P1fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4d/mCPifhqHLvHpy1CaFSKUHXMeL0FdwkQjmkb//nhluTF7W3hPa82SdbzTrc4Lv8LSvxznmrJXbkU26irXlUlSJPYmHk+0A+Mnh2hXkNIs1j5H8k76fQ8cg0/NMei9TThqWuvTkEiFeb3Dk1Q5ygEH3T9sbQPMPHHUZ/yfu58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC96A/YQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312A5C113D0;
	Sat, 27 Sep 2025 22:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759013671;
	bh=TnfKM+PyYGH8wIWPnlqR9C5XY1Imm0+MJFa96E/P1fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TC96A/YQVCpKp4ExuKmloZpgbD72rlRaWvjlShRGdBE4Nzs58w3GzjEwpi0xG0PX0
	 QHNc/W6Cq9z41HIyZg2JAUuvxd/82q/UybN2StX5Q8/iFLBw5nutjac4OgX2jRUoNk
	 v2SykmROHXbOeABNqPv5M2eXNFelZY1R2LElF7TPskxklTuq+YoBBJpsL7juN0arQy
	 Mc6OVAxEK1Zeqn+TJOy5QL2N+yeVTKDfQCGX6CgLw8zicwyPAjMv2juOgPS3w6oRXZ
	 XJ21GE7mS8Vbzst4rMBFXqauxW/HEEmfReP5UDWK9LNWHdBNyrRZbI/H08oXt/DBpm
	 pMJlG3hfNp6Uw==
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
Subject: [PATCH net-next v3 5/8] selftests: drv-net: psp: add association tests
Date: Sat, 27 Sep 2025 15:54:17 -0700
Message-ID: <20250927225420.1443468-6-kuba@kernel.org>
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

Add tests for exercising PSP associations for TCP sockets.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 .../drivers/net/hw/lib/py/__init__.py         |   2 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/drivers/net/psp.py    | 162 +++++++++++++++++-
 tools/testing/selftests/net/lib/py/ksft.py    |   5 +
 4 files changed, 167 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 559c572e296a..1c631f3c81f1 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -22,7 +22,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
-        ksft_ne, ksft_not_in, ksft_raises, ksft_true
+        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt
     from net.lib.py import NetNSEnter
     from drivers.net.lib.py import GenerateTraffic
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 31ecc618050c..8a795eeb5051 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -21,7 +21,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
-        ksft_ne, ksft_not_in, ksft_raises, ksft_true
+        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `net` library from kernel sources")
     ksft_pr(str(e))
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 56ebedb27710..c817553cc5e8 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -12,7 +12,7 @@ import time
 
 from lib.py import defer
 from lib.py import ksft_run, ksft_exit, ksft_pr
-from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_raises
+from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises
 from lib.py import KsftSkipEx
 from lib.py import NetDrvEpEnv, PSPFamily, NlError
 from lib.py import bkg, rand_port, wait_port_listen
@@ -36,6 +36,13 @@ from lib.py import bkg, rand_port, wait_port_listen
     return int(cfg.comm_sock.recv(1024)[:-1].decode('utf-8'))
 
 
+def _make_clr_conn(cfg, ipver=None):
+    _send_with_ack(cfg, b'conn clr\0')
+    remote_addr = cfg.remote_addr_v[ipver] if ipver else cfg.remote_addr
+    s = socket.create_connection((remote_addr, cfg.comm_port), )
+    return s
+
+
 def _make_psp_conn(cfg, version=0, ipver=None):
     _send_with_ack(cfg, b'conn psp\0' + struct.pack('BB', version, version))
     remote_addr = cfg.remote_addr_v[ipver] if ipver else cfg.remote_addr
@@ -181,6 +188,156 @@ from lib.py import bkg, rand_port, wait_port_listen
     ksft_ne(top_a, top_b)
 
 
+def assoc_basic(cfg):
+    """ Test creating associations """
+    _init_psp_dev(cfg)
+
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                  "dev-id": cfg.psp_dev_id,
+                                  "sock-fd": s.fileno()})
+        ksft_eq(assoc['dev-id'], cfg.psp_dev_id)
+        ksft_gt(assoc['rx-key']['spi'], 0)
+        ksft_eq(len(assoc['rx-key']['key']), 16)
+
+        assoc = cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                                  "version": 0,
+                                  "tx-key": assoc['rx-key'],
+                                  "sock-fd": s.fileno()})
+        ksft_eq(len(assoc), 0)
+        s.close()
+
+
+def assoc_bad_dev(cfg):
+    """ Test creating associations with bad device ID """
+    _init_psp_dev(cfg)
+
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        with ksft_raises(NlError) as cm:
+            cfg.pspnl.rx_assoc({"version": 0,
+                              "dev-id": cfg.psp_dev_id + 1234567,
+                              "sock-fd": s.fileno()})
+        ksft_eq(cm.exception.nl_msg.error, -errno.ENODEV)
+
+
+def assoc_sk_only_conn(cfg):
+    """ Test creating associations based on socket """
+    _init_psp_dev(cfg)
+
+    with _make_clr_conn(cfg) as s:
+        assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                  "sock-fd": s.fileno()})
+        ksft_eq(assoc['dev-id'], cfg.psp_dev_id)
+        cfg.pspnl.tx_assoc({"version": 0,
+                          "tx-key": assoc['rx-key'],
+                          "sock-fd": s.fileno()})
+        _close_conn(cfg, s)
+
+
+def assoc_sk_only_mismatch(cfg):
+    """ Test creating associations based on socket (dev mismatch) """
+    _init_psp_dev(cfg)
+
+    with _make_clr_conn(cfg) as s:
+        with ksft_raises(NlError) as cm:
+            cfg.pspnl.rx_assoc({"version": 0,
+                              "dev-id": cfg.psp_dev_id + 1234567,
+                              "sock-fd": s.fileno()})
+        the_exception = cm.exception
+        ksft_eq(the_exception.nl_msg.extack['bad-attr'], ".dev-id")
+        ksft_eq(the_exception.nl_msg.error, -errno.EINVAL)
+
+
+def assoc_sk_only_mismatch_tx(cfg):
+    """ Test creating associations based on socket (dev mismatch) """
+    _init_psp_dev(cfg)
+
+    with _make_clr_conn(cfg) as s:
+        with ksft_raises(NlError) as cm:
+            assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                      "sock-fd": s.fileno()})
+            cfg.pspnl.tx_assoc({"version": 0,
+                              "tx-key": assoc['rx-key'],
+                              "dev-id": cfg.psp_dev_id + 1234567,
+                              "sock-fd": s.fileno()})
+        the_exception = cm.exception
+        ksft_eq(the_exception.nl_msg.extack['bad-attr'], ".dev-id")
+        ksft_eq(the_exception.nl_msg.error, -errno.EINVAL)
+
+
+def assoc_sk_only_unconn(cfg):
+    """ Test creating associations based on socket (unconnected, should fail) """
+    _init_psp_dev(cfg)
+
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        with ksft_raises(NlError) as cm:
+            cfg.pspnl.rx_assoc({"version": 0,
+                              "sock-fd": s.fileno()})
+        the_exception = cm.exception
+        ksft_eq(the_exception.nl_msg.extack['miss-type'], "dev-id")
+        ksft_eq(the_exception.nl_msg.error, -errno.EINVAL)
+
+
+def assoc_version_mismatch(cfg):
+    """ Test creating associations where Rx and Tx PSP versions do not match """
+    _init_psp_dev(cfg)
+
+    versions = list(cfg.psp_info['psp-versions-cap'])
+    if len(versions) < 2:
+        raise KsftSkipEx("Not enough PSP versions supported by the device for the test")
+
+    # Translate versions to integers
+    versions = [cfg.pspnl.consts["version"].entries[v].value for v in versions]
+
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        rx = cfg.pspnl.rx_assoc({"version": versions[0],
+                                 "dev-id": cfg.psp_dev_id,
+                                 "sock-fd": s.fileno()})
+
+        for version in versions[1:]:
+            with ksft_raises(NlError) as cm:
+                cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                                    "version": version,
+                                    "tx-key": rx['rx-key'],
+                                    "sock-fd": s.fileno()})
+            the_exception = cm.exception
+            ksft_eq(the_exception.nl_msg.error, -errno.EINVAL)
+
+
+def assoc_twice(cfg):
+    """ Test reusing Tx assoc for two sockets """
+    _init_psp_dev(cfg)
+
+    def rx_assoc_check(s):
+        assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                  "dev-id": cfg.psp_dev_id,
+                                  "sock-fd": s.fileno()})
+        ksft_eq(assoc['dev-id'], cfg.psp_dev_id)
+        ksft_gt(assoc['rx-key']['spi'], 0)
+        ksft_eq(len(assoc['rx-key']['key']), 16)
+
+        return assoc
+
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        assoc = rx_assoc_check(s)
+        tx = cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                               "version": 0,
+                               "tx-key": assoc['rx-key'],
+                               "sock-fd": s.fileno()})
+        ksft_eq(len(tx), 0)
+
+        # Use the same Tx assoc second time
+        with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s2:
+            rx_assoc_check(s2)
+            tx = cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                                   "version": 0,
+                                   "tx-key": assoc['rx-key'],
+                                   "sock-fd": s2.fileno()})
+            ksft_eq(len(tx), 0)
+
+        s.close()
+
+
 def _data_basic_send(cfg, version, ipver):
     """ Test basic data send """
     _init_psp_dev(cfg)
@@ -252,7 +409,8 @@ from lib.py import bkg, rand_port, wait_port_listen
                     for ipver in ("4", "6")
                 ]
 
-                ksft_run(cases=cases, globs=globals(), case_pfx={"dev_",}, args=(cfg, ))
+                ksft_run(cases=cases, globs=globals(),
+                         case_pfx={"dev_", "assoc_"}, args=(cfg, ))
 
                 cfg.comm_sock.send(b"exit\0")
                 cfg.comm_sock.close()
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 8e35ed12ed9e..72cddd6abae8 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -92,6 +92,11 @@ KSFT_DISRUPTIVE = True
         _fail("Check failed", a, "<", b, comment)
 
 
+def ksft_gt(a, b, comment=""):
+    if a <= b:
+        _fail("Check failed", a, "<=", b, comment)
+
+
 def ksft_lt(a, b, comment=""):
     if a >= b:
         _fail("Check failed", a, ">=", b, comment)
-- 
2.51.0


