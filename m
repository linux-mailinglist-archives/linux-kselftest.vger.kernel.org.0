Return-Path: <linux-kselftest+bounces-42421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BD0BA17FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 23:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA1F561073
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 21:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFBD322A1D;
	Thu, 25 Sep 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQLilS6C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE34D322765
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835018; cv=none; b=Nyh6AFOc5hwBrc9q+ppZWxUMS2NZ/rrf3Zb9a2S68wpuNzv3T4NPNLII71f+PDtRNHwqxRPSJeii1U8AcqiaWeeH0imD0zHhBIKUFRgPm6wEHXDweXSXUMJHx/fAaz4lybMlDeejlaYpdiAWw8rbkpWFXAXzeq3FN2XSvXiGsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835018; c=relaxed/simple;
	bh=ws9l/iUQnq4Qdk2FokqagUnjaYLJdlpIxQS4QqeTTcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBj4Kn0NXiddc01nAMpRxIezPefME/9i/1Jx/665tyvgQo2wH9lNHB+m1uGZ0HqcNmvhL039xr792R9s24urPJW7Kw9X0k92aIeltMEB1Ptgk86/cbqnAvUqMXYpWc0K7SCK9jwvN80LLRVAfWEiExvjvWbLR4ECr2jZZ+Cc1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQLilS6C; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d60504788so13586077b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 14:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758835016; x=1759439816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQ8iOrryw968uEYUZ4XHX3ZtqDXI/POFGbLQK1E3BvQ=;
        b=gQLilS6CGZJLzZvFlxPlW75zuyev8X1r5Sr0uyVOUJd/GmAqqRVcAL6OvX5pL+hJAK
         h7D+Dzz3adV+4lQSSVWZ23crsFKfKhSNOESqXv63Q7eKq8EKYg+iRsRqdoQECv+TsgCr
         U30TANyYI9tYKc8OWBGcd72QiPwy/mxdTNW6u3UMXqq2IPjEvEXvgzdgzBKs3HKQQIZC
         g7thN46fT04+WVjAAJlWrByGcWR+kLtp47HNDORe1jpNtMcZnKudInxUmqamPizUaQ4Y
         ykotfLulaVlKsLYQNc3/znSoC58FPgkawxlUIUrbJbcu2Di94vtzWJJcLwJgRT9ZAdC2
         Oa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835016; x=1759439816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQ8iOrryw968uEYUZ4XHX3ZtqDXI/POFGbLQK1E3BvQ=;
        b=tUN6vWXw8C4H444f5QYks0dSdXou3P6ZJHTtUcB9PW457T1Tco6k+JX0TWaQGfoyKT
         104eOf0itSB2vb+ABFwYV0S77kGR9f26V0Uf+bq3KCaDig0+Cyv2dYVuxqFwGCz5YcZO
         QuvaNHUyOcF4S35RmSslxeCAXc9piLjlXHbazauVAqpzlAfv4ophYlfrGg06lPKbjtCe
         e+uSUmHn5aU8IfTLFCxfsnh7d+0UamIPEfl5xv9TSOvNAabitTzlZwt+w0QdiXNAdRlW
         iBb2exlA+ujMCJuojY1v4Mc54uHMm5Qo1A3EQcRI+QF6FSr0uoCjOHGENmWQ4PkJYpBx
         BF2g==
X-Forwarded-Encrypted: i=1; AJvYcCWFl58LEIgyN8DE8MRIcrYjLeGj2Z1h8TmqWsmvYsTwGF7nqhbBfQr+pJKG0EG4nJdPT3uHF2dP9wR2V86EENk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiHb0VNj+tqRz+3hE4mDYkZyH12SnYA9VTYllnB/YcSHsn6iCR
	XXenLRhJTqeg/PiqTz+/FDUy/3z4Jmlhs4R0spknat1E6qQczmTVzlsA
X-Gm-Gg: ASbGncuP+NWQ3W4bTgyEHuI8yLv2ym17pFdkwE7zTKwP3W4TUtfOb2uis0uNvbeDqdV
	wRIQnCGfy/5eYcKdBVMkapedE9MgPHMRg2tPNvShL26ZXjHbmnRMCW6WEZWxkGrjuzEyElDBtyk
	Jr7vVKMDrLpXHbhgeeoGAmTM9sjytqV1ClRFoboGj2SdtVKznhmpqGieOo8q2g4HAXooJ4iOBCY
	bf32WU5BOIZukTGwP3SCZsHq8CrAAKs1cnVQWzoPoEhOdMTAdmtBFvqnChpUR2H/g/AbvS5GCJM
	PhqD51ZPd1apNcr22t/AlRLs0IbNrdANZIGNug/rnwZBDeeuiHcTl3EI+917J0NJVtf34RknpGl
	ZUkm+uYmYzE4z88XNaopb
X-Google-Smtp-Source: AGHT+IE0uqj5uuhUQtY9GrIava96/rc6kDAl5GbSml0wGfvPaF0HUznptsyO71AcvlDonjlSLU4d1g==
X-Received: by 2002:a05:690c:55c5:b0:73b:bc38:267 with SMTP id 00721157ae682-763fa05f419mr49124737b3.10.1758835015755;
        Thu, 25 Sep 2025 14:16:55 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765bb916ac8sm7479627b3.3.2025.09.25.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:16:55 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/8] selftests: drv-net: psp: add association tests
Date: Thu, 25 Sep 2025 14:16:41 -0700
Message-ID: <20250925211647.3450332-6-daniel.zahka@gmail.com>
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

Add tests for exercising PSP associations for TCP sockets.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 .../drivers/net/hw/lib/py/__init__.py         |   2 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/drivers/net/psp.py    | 147 +++++++++++++++++-
 tools/testing/selftests/net/lib/py/ksft.py    |   5 +
 4 files changed, 152 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 559c572e296a..1c631f3c81f1 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -22,7 +22,7 @@ try:
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
@@ -21,7 +21,7 @@ try:
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
-        ksft_ne, ksft_not_in, ksft_raises, ksft_true
+        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `net` library from kernel sources")
     ksft_pr(str(e))
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index f81ad6200627..b4d97a9a5fbc 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -10,7 +10,7 @@ import termios
 import time
 
 from lib.py import ksft_run, ksft_exit, ksft_pr
-from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_raises, KsftSkipEx
+from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises, KsftSkipEx
 from lib.py import NetDrvEpEnv, PSPFamily, NlError
 from lib.py import bkg, rand_port, wait_port_listen
 
@@ -33,6 +33,13 @@ def _remote_read_len(cfg):
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
@@ -151,6 +158,140 @@ def dev_rotate_spi(cfg):
     ksft_ne(top_a, top_b)
 
 
+def assoc_basic(cfg):
+    """ Test creating associations """
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
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        with ksft_raises(NlError) as cm:
+            cfg.pspnl.rx_assoc({"version": 0,
+                              "dev-id": cfg.psp_dev_id + 1234567,
+                              "sock-fd": s.fileno()})
+        ksft_eq(cm.exception.nl_msg.error, -19)
+
+
+def assoc_sk_only_conn(cfg):
+    """ Test creating associations based on socket """
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
+    with _make_clr_conn(cfg) as s:
+        with ksft_raises(NlError) as cm:
+            cfg.pspnl.rx_assoc({"version": 0,
+                              "dev-id": cfg.psp_dev_id + 1234567,
+                              "sock-fd": s.fileno()})
+        the_exception = cm.exception
+        ksft_eq(the_exception.nl_msg.extack['bad-attr'], ".dev-id")
+        ksft_eq(the_exception.nl_msg.error, -22)
+
+
+def assoc_sk_only_mismatch_tx(cfg):
+    """ Test creating associations based on socket (dev mismatch) """
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
+        ksft_eq(the_exception.nl_msg.error, -22)
+
+
+def assoc_sk_only_unconn(cfg):
+    """ Test creating associations based on socket (unconnected, should fail) """
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        with ksft_raises(NlError) as cm:
+            cfg.pspnl.rx_assoc({"version": 0,
+                              "sock-fd": s.fileno()})
+        the_exception = cm.exception
+        ksft_eq(the_exception.nl_msg.extack['miss-type'], "dev-id")
+        ksft_eq(the_exception.nl_msg.error, -22)
+
+
+def assoc_version_mismatch(cfg):
+    """ Test creating associations where Rx and Tx PSP versions do not match """
+    versions = list(cfg.psp_supported_versions)
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
+            ksft_eq(the_exception.nl_msg.error, -22)
+
+
+def assoc_twice(cfg):
+    """ Test reusing Tx assoc for two sockets """
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
     # Version 0 is required by spec, don't let it skip
@@ -232,7 +373,9 @@ def main() -> None:
                 ]
 
                 if cfg.psp_dev_id is not None:
-                    ksft_run(cases=cases, globs=globals(), case_pfx={"dev_",}, args=(cfg, ))
+                    ksft_run(cases=cases, globs=globals(),
+                             case_pfx={"dev_", "assoc_"},
+                             args=(cfg, ))
                 else:
                     ksft_pr("No PSP device found, skipping all tests")
 
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 8e35ed12ed9e..72cddd6abae8 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -92,6 +92,11 @@ def ksft_ge(a, b, comment=""):
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
2.47.3


