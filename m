Return-Path: <linux-kselftest+bounces-42548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A58F3BA6489
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 00:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DAC17C6B2
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 22:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97535244675;
	Sat, 27 Sep 2025 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrbecMfw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6FB243964;
	Sat, 27 Sep 2025 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759013671; cv=none; b=RgcCRJFV7hpzMBF3Saf7BD8zDE0rPrEwKUwAP9sGoeBqPpMr0K06f67n1YWclhYdr7oBVEDQIDd8Ozt7Bg+t2UbHvDn4H8v8k0Pl/rvPbUrElc3fuqdDHsivR4CprPospq7/PB0WxAarLS9enTe13mpicgzojDxFD/xBEdoccy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759013671; c=relaxed/simple;
	bh=jnZ1xTIGKt7Adt7WC+LhNparzVE7txkeJaKL7GnbHyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dusbFYJkYNlLTe2z+b2HQP0EpqsPCXhW3eggq2BuS/mGPvbOw+QPnQ2fFjZB0/TNYwrNhD48AVvzR52dbbiVbRp1v5hRTRH7K7TO3guMVr2lNSB6tYXUzFAYMA84CzsW3PzI/ZU2cZwD4+W8t70VPCW68EKjZhjwT0J05inNvlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrbecMfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84781C113CF;
	Sat, 27 Sep 2025 22:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759013671;
	bh=jnZ1xTIGKt7Adt7WC+LhNparzVE7txkeJaKL7GnbHyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IrbecMfwQ2M/DBCypoOlhm2aSIl6+1g0ktr2j9aDrWX6Et5FHs5fGVmBh9tgBgAZb
	 6AN/rNGAr734oY0Mgxama+/I7Lpm/7oOaizxXlHGQq4BuTDWVzhcCI+HCEdW3Kouyx
	 F9H55ssMOOuzQ65cSkM7o23FzceZzVcCV4R0HlcUNzLRncEMie9EHc/0qHm1F8/XhG
	 hVtX1CdQKguPn9ta3dUSAmvNOSs0ogl/E3DgOkQ22/b7px7aG5uNfyIAOmEWJzUcqp
	 /qEkwbdASVXhmATEK1pBF5RJ4PEyrXbFb2E+cFIGyJHzAQuA6k3Bt24jt0ABYiDXcM
	 9KePcysBu4SiA==
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
Subject: [PATCH net-next v3 4/8] selftests: drv-net: psp: add basic data transfer and key rotation tests
Date: Sat, 27 Sep 2025 15:54:16 -0700
Message-ID: <20250927225420.1443468-5-kuba@kernel.org>
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

Add basic tests for sending data over PSP and making sure that key
rotation toggles the MSB of the spi.

Deploy PSP responder on the remote end. We also need a healthy dose
of common helpers for setting up the connections, assertions and
interrogating socket state on the Python side.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
v3:
 - remove double-checking retries
---
 tools/testing/selftests/drivers/net/psp.py | 194 ++++++++++++++++++++-
 1 file changed, 191 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 5910222a43ef..56ebedb27710 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -4,12 +4,92 @@
 """Test suite for PSP capable drivers."""
 
 import errno
+import fcntl
+import socket
+import struct
+import termios
+import time
 
 from lib.py import defer
-from lib.py import ksft_run, ksft_exit
-from lib.py import ksft_true, ksft_eq
+from lib.py import ksft_run, ksft_exit, ksft_pr
+from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_raises
 from lib.py import KsftSkipEx
 from lib.py import NetDrvEpEnv, PSPFamily, NlError
+from lib.py import bkg, rand_port, wait_port_listen
+
+
+def _get_outq(s):
+    one = b'\0' * 4
+    outq = fcntl.ioctl(s.fileno(), termios.TIOCOUTQ, one)
+    return struct.unpack("I", outq)[0]
+
+
+def _send_with_ack(cfg, msg):
+    cfg.comm_sock.send(msg)
+    response = cfg.comm_sock.recv(4)
+    if response != b'ack\0':
+        raise RuntimeError("Unexpected server response", response)
+
+
+def _remote_read_len(cfg):
+    cfg.comm_sock.send(b'read len\0')
+    return int(cfg.comm_sock.recv(1024)[:-1].decode('utf-8'))
+
+
+def _make_psp_conn(cfg, version=0, ipver=None):
+    _send_with_ack(cfg, b'conn psp\0' + struct.pack('BB', version, version))
+    remote_addr = cfg.remote_addr_v[ipver] if ipver else cfg.remote_addr
+    s = socket.create_connection((remote_addr, cfg.comm_port), )
+    return s
+
+
+def _close_conn(cfg, s):
+    _send_with_ack(cfg, b'data close\0')
+    s.close()
+
+
+def _close_psp_conn(cfg, s):
+    _close_conn(cfg, s)
+
+
+def _spi_xchg(s, rx):
+    s.send(struct.pack('I', rx['spi']) + rx['key'])
+    tx = s.recv(4 + len(rx['key']))
+    return {
+        'spi': struct.unpack('I', tx[:4])[0],
+        'key': tx[4:]
+    }
+
+
+def _send_careful(cfg, s, rounds):
+    data = b'0123456789' * 200
+    for i in range(rounds):
+        n = 0
+        for _ in range(10): # allow 10 retries
+            try:
+                n += s.send(data[n:], socket.MSG_DONTWAIT)
+                if n == len(data):
+                    break
+            except BlockingIOError:
+                time.sleep(0.05)
+        else:
+            rlen = _remote_read_len(cfg)
+            outq = _get_outq(s)
+            report = f'sent: {i * len(data) + n} remote len: {rlen} outq: {outq}'
+            raise RuntimeError(report)
+
+    return len(data) * rounds
+
+
+def _check_data_rx(cfg, exp_len):
+    read_len = -1
+    for _ in range(30):
+        cfg.comm_sock.send(b'read len\0')
+        read_len = int(cfg.comm_sock.recv(1024)[:-1].decode('utf-8'))
+        if read_len == exp_len:
+            break
+        time.sleep(0.01)
+    ksft_eq(read_len, exp_len)
 
 #
 # Test case boiler plate
@@ -69,13 +149,121 @@ from lib.py import NetDrvEpEnv, PSPFamily, NlError
     ksft_true(raised)
 
 
+def dev_rotate(cfg):
+    """ Test key rotation """
+    _init_psp_dev(cfg)
+
+    rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
+    ksft_eq(rot['id'], cfg.psp_dev_id)
+    rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
+    ksft_eq(rot['id'], cfg.psp_dev_id)
+
+
+def dev_rotate_spi(cfg):
+    """ Test key rotation and SPI check """
+    _init_psp_dev(cfg)
+
+    top_a = top_b = 0
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        assoc_a = cfg.pspnl.rx_assoc({"version": 0,
+                                     "dev-id": cfg.psp_dev_id,
+                                     "sock-fd": s.fileno()})
+        top_a = assoc_a['rx-key']['spi'] >> 31
+        s.close()
+    rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        ksft_eq(rot['id'], cfg.psp_dev_id)
+        assoc_b = cfg.pspnl.rx_assoc({"version": 0,
+                                    "dev-id": cfg.psp_dev_id,
+                                    "sock-fd": s.fileno()})
+        top_b = assoc_b['rx-key']['spi'] >> 31
+        s.close()
+    ksft_ne(top_a, top_b)
+
+
+def _data_basic_send(cfg, version, ipver):
+    """ Test basic data send """
+    _init_psp_dev(cfg)
+
+    # Version 0 is required by spec, don't let it skip
+    if version:
+        name = cfg.pspnl.consts["version"].entries_by_val[version].name
+        if name not in cfg.psp_info['psp-versions-cap']:
+            with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+                with ksft_raises(NlError) as cm:
+                    cfg.pspnl.rx_assoc({"version": version,
+                                        "dev-id": cfg.psp_dev_id,
+                                        "sock-fd": s.fileno()})
+                ksft_eq(cm.exception.nl_msg.error, -errno.EOPNOTSUPP)
+            raise KsftSkipEx("PSP version not supported", name)
+
+    s = _make_psp_conn(cfg, version, ipver)
+
+    rx_assoc = cfg.pspnl.rx_assoc({"version": version,
+                                   "dev-id": cfg.psp_dev_id,
+                                   "sock-fd": s.fileno()})
+    rx = rx_assoc['rx-key']
+    tx = _spi_xchg(s, rx)
+
+    cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                        "version": version,
+                        "tx-key": tx,
+                        "sock-fd": s.fileno()})
+
+    data_len = _send_careful(cfg, s, 100)
+    _check_data_rx(cfg, data_len)
+    _close_psp_conn(cfg, s)
+
+
+def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
+    """Build test cases for each combo of PSP version and IP version"""
+    def test_case(cfg):
+        cfg.require_ipver(ipver)
+        test_case.__name__ = f"{name}_v{psp_ver}_ip{ipver}"
+        test_func(cfg, psp_ver, ipver)
+    return test_case
+
+
 def main() -> None:
     """ Ksft boiler plate main """
 
     with NetDrvEpEnv(__file__) as cfg:
         cfg.pspnl = PSPFamily()
 
-        ksft_run(globs=globals(), case_pfx={"dev_",}, args=(cfg, ))
+        # Set up responder and communication sock
+        responder = cfg.remote.deploy("psp_responder")
+
+        cfg.comm_port = rand_port()
+        srv = None
+        try:
+            with bkg(responder + f" -p {cfg.comm_port}", host=cfg.remote,
+                     exit_wait=True) as srv:
+                wait_port_listen(cfg.comm_port, host=cfg.remote)
+
+                cfg.comm_sock = socket.create_connection((cfg.remote_addr,
+                                                          cfg.comm_port),
+                                                         timeout=1)
+
+                cases = [
+                    psp_ip_ver_test_builder(
+                        "data_basic_send", _data_basic_send, version, ipver
+                    )
+                    for version in range(0, 4)
+                    for ipver in ("4", "6")
+                ]
+
+                ksft_run(cases=cases, globs=globals(), case_pfx={"dev_",}, args=(cfg, ))
+
+                cfg.comm_sock.send(b"exit\0")
+                cfg.comm_sock.close()
+        finally:
+            if srv and (srv.stdout or srv.stderr):
+                ksft_pr("")
+                ksft_pr(f"Responder logs ({srv.ret}):")
+            if srv and srv.stdout:
+                ksft_pr("STDOUT:\n#  " + srv.stdout.strip().replace("\n", "\n#  "))
+            if srv and srv.stderr:
+                ksft_pr("STDERR:\n#  " + srv.stderr.strip().replace("\n", "\n#  "))
     ksft_exit()
 
 
-- 
2.51.0


