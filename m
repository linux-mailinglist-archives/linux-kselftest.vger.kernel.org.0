Return-Path: <linux-kselftest+bounces-42420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBBFBA182F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 23:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5851C820BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 21:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A705B322778;
	Thu, 25 Sep 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6lnewa2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE1322747
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835017; cv=none; b=c/WZLI0NTWcmg9W+MfkohwpDt2mQW8jEXueBBoPIGFzA8FoDmKijrdE0o5lAFf6F/VYNesj0itDygtOX86zwKxhPmtjQ4AKN3cCQpHXiBayTrSnkl9mBRgyAgqR8eQ7RTT/J4DJXr+nqF8G6WH2UDmXnOa3vVP/dH59hUzmkmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835017; c=relaxed/simple;
	bh=YVNczPjMIhQgLdl3Wef7WtHfRKGKZGaBJUQSmJnOL6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mi7OJF6Vf7WFXo1JNt+WvygOyTnebU0KQxWLDinpKhfqH1ldUN2DiBe0QKHqjMvE+Q8Z1kCbv//znLaG7QwT+XOAhIEmJ72WtNvPQsHnmSaMokWRyx422z5F+rWSibHsGE9TPPCtshCzRo/rMrknQ9whAVCY0PWnBluSVSPvt7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6lnewa2; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6089a139396so505621d50.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758835015; x=1759439815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4HmXD6gUMFjAGchz3rDVYaPB1MZ6dVbNlEnmKsbHA8=;
        b=X6lnewa2BDyioas3e5du0PiPXWl3snNYwqhT2nUDVOkV5HNu+zAQ8ocbNFzLVqHmzU
         9Xq4XnePsRTywrsYMSGc1yK2a3SuKbG5JtDjiURj+AZfAHgL2Mk+gTyaH/ttv3v+Gbbt
         YHr4IEvzDtHjyMVQQ23BaG34WdB06CRqSP/gYcmmWGLuYNUf35R1QlYi6pREwmuuxInM
         fPkbpsjf/XB9/9auwQUqLXm5ri+i2wzjY5eVzZvGDiga6ualGpuG2FUUI+DkgcuzjqU0
         tb/4V5C4rXdHoYF5V7kOqjAaih2P/5ulyeSWyWSnEGcZSvIMDZiaAUtwQXA5h1XCR1Sd
         AWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835015; x=1759439815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4HmXD6gUMFjAGchz3rDVYaPB1MZ6dVbNlEnmKsbHA8=;
        b=jjpRla3nUmKj6kBDVn6pRbgi9Z5PyKs+Lh2dOI9+4hDgOybBY+jy/uGy8LXbfOAkeT
         p9aY85IsMnT8tWHAk0P0jaulSYmgjI0x6M+8UvuZDp+24yQ68vy40kYXnhuKpKoqmofZ
         MA8FFLP10R47A++yKj4uqPmU614cpWuj8q28Z6BnyzoaOWsBCzz4gH3ivekUbtKWo6im
         RYEcqLy348og4uI0Z4iGXqNYEzlmw1D/yz920cM7ADsGBF8nBpdPmVTkffcOK1QB3GR6
         xt5QNRt7mBYYO/RjRPm9P8H8h6pQ3uIiUpmRl0Z3tgpLTSAyVDB7hG7IWWBt0PwuNyj/
         rSAA==
X-Forwarded-Encrypted: i=1; AJvYcCW/2SETIIIRKQ26rgxjjJRs1sPJNpPeV6KNHop/376zIAKyIwfGFqIfnt1pnEWuyJucc6m4nvWWPfEyp1jUE2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCpfBWzcjmNpw+PQ9FffveqdCygfvuR0yKyz+Ioqame7th+A6B
	A99OuwZh/UEf5ToQVkGTJKVgppw7Isd+2UHWuznZA4g7DFOLS7boSyGD6Hh0lA==
X-Gm-Gg: ASbGncslCFyQpHsVJsy7Og6k3w6QUvKFmqhSkXzs+8DCQi5HfYhul8HKQYjb1eIa/i5
	YGW+hkCvLkZrGe7zQYQugLyyGHWzVMBmq1cTzEe5GkqgKq/rPEq8AwF2rrEStguH92mZvRLredw
	ZV+F0N10eOuhTkoO4SFVWET0ouxfNcObAK9MGPT4y1rwJzwxloK71q0zo4DbmP4CjWJ6JEtwvRc
	EnL4UgRFAGeA1LIM8LfvA61vitum6jU0NREUmHJ7FSWb62NHu/9YIdItO2dvZMybhEJAbXrl8iY
	apL9U8CQbcPS9ot1c09hDNJHGzIvDpwzqonIuIm25j8pX2Tto8FWMd+k+kPDcouXcb4Yn6hcD/2
	gjfp6hArDow2E7idVxOg=
X-Google-Smtp-Source: AGHT+IER97xY6Et8j3JfHp1u9ZVkwpCuQYxYpDFpEhSiiGsqorjaHnKW0PIB402OAXwId0s/j2+6Cw==
X-Received: by 2002:a05:690e:15d8:b0:635:4ed0:5721 with SMTP id 956f58d0204a3-6361d618d18mr2368459d50.25.1758835014709;
        Thu, 25 Sep 2025 14:16:54 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-eb383929b93sm933925276.21.2025.09.25.14.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:16:54 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	Breno Leitao <leitao@debian.org>,
	Petr Machata <petrm@nvidia.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 4/8] selftests: drv-net: psp: add basic data transfer and key rotation tests
Date: Thu, 25 Sep 2025 14:16:40 -0700
Message-ID: <20250925211647.3450332-5-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250925211647.3450332-1-daniel.zahka@gmail.com>
References: <20250925211647.3450332-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add basic tests for sending data over PSP and making sure that key
rotation toggles the MSB of the spi.

Deploy PSP responder on the remote end. We also need a healthy dose
of common helpers for setting up the connections, assertions and
interrogating socket state on the Python side.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 195 ++++++++++++++++++++-
 1 file changed, 191 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 43dfa497be9b..f81ad6200627 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -3,9 +3,94 @@
 
 """Test suite for PSP capable drivers."""
 
+import fcntl
+import socket
+import struct
+import termios
+import time
+
 from lib.py import ksft_run, ksft_exit, ksft_pr
-from lib.py import ksft_true, ksft_eq
+from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_raises, KsftSkipEx
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
+        retries = 0
+        while True:
+            try:
+                n += s.send(data[n:], socket.MSG_DONTWAIT)
+                if n == len(data):
+                    break
+            except BlockingIOError:
+                time.sleep(0.05)
+
+            retries += 1
+            if retries > 10:
+                rlen = _remote_read_len(cfg)
+                outq = _get_outq(s)
+                report = f'sent: {i * len(data) + n} remote len: {rlen} outq: {outq}'
+                if retries > 10:
+                    raise RuntimeError(report)
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
 # Test cases
@@ -38,6 +123,75 @@ def dev_get_device_bad(cfg):
     ksft_true(raised)
 
 
+def dev_rotate(cfg):
+    """ Test key rotation """
+    rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
+    ksft_eq(rot['id'], cfg.psp_dev_id)
+    rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
+    ksft_eq(rot['id'], cfg.psp_dev_id)
+
+
+def dev_rotate_spi(cfg):
+    """ Test key rotation and SPI check """
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
+    # Version 0 is required by spec, don't let it skip
+    if version:
+        name = cfg.pspnl.consts["version"].entries_by_val[version].name
+        if name not in cfg.psp_supported_versions:
+            with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+                with ksft_raises(NlError) as cm:
+                    cfg.pspnl.rx_assoc({"version": version,
+                                        "dev-id": cfg.psp_dev_id,
+                                        "sock-fd": s.fileno()})
+                ksft_eq(cm.exception.nl_msg.error, -95)
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
     with NetDrvEpEnv(__file__) as cfg:
         cfg.pspnl = PSPFamily()
@@ -55,14 +209,47 @@ def main() -> None:
                 versions = info['psp-versions-ena']
                 cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
                                    "psp-versions-ena": info['psp-versions-cap']})
+            cfg.psp_supported_versions = info['psp-versions-cap']
+
+        # Set up responder and communication sock
+        responder = cfg.remote.deploy("psp_responder")
+
+        cfg.comm_port = rand_port()
+        srv = None
+        try:
+            with bkg(responder + f" -p {cfg.comm_port}", host=cfg.remote, exit_wait=True) as srv:
+                wait_port_listen(cfg.comm_port, host=cfg.remote)
+
+                cfg.comm_sock = socket.create_connection((cfg.remote_addr,
+                                                          cfg.comm_port), timeout=1)
+
+                cases = [
+                    psp_ip_ver_test_builder(
+                        "data_basic_send", _data_basic_send, version, ipver
+                    )
+                    for version in range(0, 4)
+                    for ipver in ("4", "6")
+                ]
 
                 if cfg.psp_dev_id is not None:
-                    ksft_run(globs=globals(), case_pfx={"dev_",}, args=(cfg, ))
+                    ksft_run(cases=cases, globs=globals(), case_pfx={"dev_",}, args=(cfg, ))
                 else:
                     ksft_pr("No PSP device found, skipping all tests")
 
-        if versions is not None:
-            cfg.pspnl.dev_set({"id": cfg.psp_dev_id, "psp-versions-ena": versions})
+                cfg.comm_sock.send(b"exit\0")
+                cfg.comm_sock.close()
+
+            if versions is not None:
+                cfg.pspnl.dev_set({"id": cfg.psp_dev_id, "psp-versions-ena": versions})
+
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
2.47.3


