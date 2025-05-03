Return-Path: <linux-kselftest+bounces-32268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E144AA7DE9
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 03:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F07467333
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 01:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF4470838;
	Sat,  3 May 2025 01:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XexlgN+Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1008A54279;
	Sat,  3 May 2025 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746236130; cv=none; b=l+56Vi/EVfnZ2KAp0fVbxOC810g2RTG/L6QKLfX6V5wfN6vFiDAWgPkUEXOVcmOdR03l/1GJXYLRUU7gWcgxh8oRbnqQLI1gc6aJRXNXzPdwHtWmsXrcWnL1xrAAbZb9d/rYdGp+nSwhoCMDEpVrhWJlmpsDaOxgDqAuRfuFD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746236130; c=relaxed/simple;
	bh=XboAePqEWipWmJ3TvjEbAJDStreJexcsNHjqH/93G6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cv4DRYxL5Wz0ZgdIfrauIfiZVr+94yXvCxs+oT9ksHTy6A365STGXhRQJfrNWd0APNaOBrB+pi5DygGIG5ObWmS2zgAamlNAREewgZ4QK42dhxKQUXEl1+oo/iSuOgaTGiZLrmyHb0ZDI7Og/hNSNkkEOaBQsliEmfmUhUenPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XexlgN+Q; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso20007545e9.2;
        Fri, 02 May 2025 18:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746236127; x=1746840927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0EBn+T/n1/s/B5DK/tven5qnoJu/wlLnsHT1C/PloE=;
        b=XexlgN+Q2srFVBhh1CZZj6Tn6NX4j/2qVZVKoffU4rebX5eftbAU3aA3BreY+/pFnH
         9eHvIVI2fBhqY0Z8NYixvBA87FGM4XpOvpTWsiqFGa9KKJthbO7lOHSvUSOdyfpFXAik
         HUH3vpsO+MdJgBJIDr7flJZ0KHZcSbhRHQcjhMNlqJ0mzFG3TlUQ2uaGi6XFgUJ4qTIn
         hozOR8VVzH7E3IhjBZDchwe4hbJoe8iP9hMtDe/eJObt9e8UPCsTJ9gO4b47yDh2nQrY
         A4oYvnqowpMPSAvx5s9bsoJPPo8b1+cQf2DQnT9anw12ky+lPA9M8jEXS36d1oFqTGQQ
         69Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746236127; x=1746840927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0EBn+T/n1/s/B5DK/tven5qnoJu/wlLnsHT1C/PloE=;
        b=O7Y9Q2bXhBRx7dH0H4KvmHwLoyvVYKTa1Qf2ZG35ADYzTlweMKIb5RLsOHu4Gkj5g2
         8tSsQyZHjNHx0MArtTvHb1JqrNxi0AAmfAEAP8w5HduvyvfOTyWv+sYxC2pOPIbqOrX3
         XdWvjnuNdSOESDEnnni0CCsDbAsvpr6B1f59DnjHS7rjQ3+mRf0gG5ayr9UDp1qIYJX+
         +sOHXlliEua6rMFNT0ZBqcuL5wqB61aTti8q8zw9TfCGNv308m45eGVWAMMowYGWbvIQ
         bn6k2kHGVSEsRvPR+8s8N3Nlc6IPk3QadCRKcHkI6xFI1lIg0PN2fjRXqDH3Q1jUPCTO
         KDYA==
X-Forwarded-Encrypted: i=1; AJvYcCV4pIvqs6/a9J+1oqmZy2r3TMZ1mOtTn2jhOmNYVjsq2UZCTc3X4eIZl5YGEpKvlXKxaAPaJksipSRCpYnQ/34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9TXmO4Pro4FEpkp2HvdXd5T5vOQUPCCReBWFVDRMJPd19b9Xt
	r3xeAyAAR91gGqcqH61gUljAZrODcclhsiwu+ZUJr2eWv23cI/P3Xhm1bQc/
X-Gm-Gg: ASbGncuK6VV/2eRZOslv12MPbzCJ9+oRZdMC9NvxD+1ivZmPutFfBvTahgn1L+vG9tB
	+HoEZnSOaj6hXQiuHH8fX4wM2vWyXChvXThnoCVNDzEqtNlvhPGc0XPNvGXr6q3Xn96HKwXTSKz
	L8f1ucL2hKcK8/6Lb0tBt0AB7nVpZaIldxqFKkewozcNRL8cO6wdygrY9d6EsB/OSpiG+LgS0G+
	ggQzwsQeFVBkII7wy1dVUPGIAkHT2w2At7R20Y6PqsJe21n6K5hoAoN5TzA/PICuGbFHhVdyLcE
	BIw3fZhf87Y7iRHOBL7uHxSGSBn1kJiSTQVqzl8=
X-Google-Smtp-Source: AGHT+IHn6yrXLpq3lStRwaOrD/v0hlkYiPPU0sIqaJydcEG9nqJTydbUIM/qG0kMU6FQZuGT9rOXow==
X-Received: by 2002:a05:600c:1385:b0:43d:1f1:8cd with SMTP id 5b1f17b1804b1-441bbf2d13dmr38548285e9.24.1746236127107;
        Fri, 02 May 2025 18:35:27 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89ee3a9sm59048585e9.23.2025.05.02.18.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 18:35:26 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	ap420073@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/3] selftests: drv: net: fix test failure on ipv6 sys
Date: Fri,  2 May 2025 18:35:16 -0700
Message-ID: <20250503013518.1722913-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `get_interface_info` call has ip version hard-coded which leads to
failures on an IPV6 system. The NetDrvEnv class already gathers
information about remote interface, so instead of fixing the local
implementation switch to using cfg.remote_ifname.

Before:
./drivers/net/ping.py
Traceback (most recent call last):
  File "/new_tests/./drivers/net/ping.py", line 217, in <module>
    main()
  File "/new_tests/./drivers/net/ping.py", line 204, in main
    get_interface_info(cfg)
  File "/new_tests/./drivers/net/ping.py", line 128, in get_interface_info
    raise KsftFailEx('Can not get remote interface')
net.lib.py.ksft.KsftFailEx: Can not get remote interface

After:
./drivers/net/ping.py
TAP version 13
1..6
ok 1 ping.test_default # SKIP Test requires IPv4 connectivity
ok 2 ping.test_xdp_generic_sb # SKIP Test requires IPv4 connectivity
ok 3 ping.test_xdp_generic_mb # SKIP Test requires IPv4 connectivity
ok 4 ping.test_xdp_native_sb # SKIP Test requires IPv4 connectivity
ok 5 ping.test_xdp_native_mb # SKIP Test requires IPv4 connectivity
ok 6 ping.test_xdp_offload # SKIP device does not support offloaded XDP
Totals: pass:0 fail:0 xfail:0 xpass:0 skip:6 error:0

Fixes: 75cc19c8ff89 ("selftests: drv-net: add xdp cases for ping.py")
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/ping.py | 22 +++++++++------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index 4b6822866066..5272e8b3536d 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -9,7 +9,6 @@ from lib.py import EthtoolFamily, NetDrvEpEnv
 from lib.py import bkg, cmd, wait_port_listen, rand_port
 from lib.py import defer, ethtool, ip
 
-remote_ifname=""
 no_sleep=False
 
 def _test_v4(cfg) -> None:
@@ -57,7 +56,7 @@ def _set_offload_checksum(cfg, netnl, on) -> None:
 
 def _set_xdp_generic_sb_on(cfg) -> None:
     prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
-    cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
+    cmd(f"ip link set dev {cfg.remote_ifname} mtu 1500", shell=True, host=cfg.remote)
     cmd(f"ip link set dev {cfg.ifname} mtu 1500 xdpgeneric obj {prog} sec xdp", shell=True)
     defer(cmd, f"ip link set dev {cfg.ifname} xdpgeneric off")
 
@@ -66,8 +65,8 @@ def _set_xdp_generic_sb_on(cfg) -> None:
 
 def _set_xdp_generic_mb_on(cfg) -> None:
     prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
-    cmd(f"ip link set dev {remote_ifname} mtu 9000", shell=True, host=cfg.remote)
-    defer(ip, f"link set dev {remote_ifname} mtu 1500", host=cfg.remote)
+    cmd(f"ip link set dev {cfg.remote_ifname} mtu 9000", shell=True, host=cfg.remote)
+    defer(ip, f"link set dev {cfg.remote_ifname} mtu 1500", host=cfg.remote)
     ip("link set dev %s mtu 9000 xdpgeneric obj %s sec xdp.frags" % (cfg.ifname, prog))
     defer(ip, f"link set dev {cfg.ifname} mtu 1500 xdpgeneric off")
 
@@ -76,7 +75,7 @@ def _set_xdp_generic_mb_on(cfg) -> None:
 
 def _set_xdp_native_sb_on(cfg) -> None:
     prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
-    cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
+    cmd(f"ip link set dev {cfg.remote_ifname} mtu 1500", shell=True, host=cfg.remote)
     cmd(f"ip -j link set dev {cfg.ifname} mtu 1500 xdp obj {prog} sec xdp", shell=True)
     defer(ip, f"link set dev {cfg.ifname} mtu 1500 xdp off")
     xdp_info = ip("-d link show %s" % (cfg.ifname), json=True)[0]
@@ -93,8 +92,8 @@ def _set_xdp_native_sb_on(cfg) -> None:
 
 def _set_xdp_native_mb_on(cfg) -> None:
     prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
-    cmd(f"ip link set dev {remote_ifname} mtu 9000", shell=True, host=cfg.remote)
-    defer(ip, f"link set dev {remote_ifname} mtu 1500", host=cfg.remote)
+    cmd(f"ip link set dev {cfg.remote_ifname} mtu 9000", shell=True, host=cfg.remote)
+    defer(ip, f"link set dev {cfg.remote_ifname} mtu 1500", host=cfg.remote)
     try:
         cmd(f"ip link set dev {cfg.ifname} mtu 9000 xdp obj {prog} sec xdp.frags", shell=True)
         defer(ip, f"link set dev {cfg.ifname} mtu 1500 xdp off")
@@ -112,18 +111,15 @@ def _set_xdp_offload_on(cfg) -> None:
     except Exception as e:
         raise KsftSkipEx('device does not support offloaded XDP')
     defer(ip, f"link set dev {cfg.ifname} xdpoffload off")
-    cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
+    cmd(f"ip link set dev {cfg.remote_ifname} mtu 1500", shell=True, host=cfg.remote)
 
     if no_sleep != True:
         time.sleep(10)
 
 def get_interface_info(cfg) -> None:
-    global remote_ifname
     global no_sleep
 
-    remote_info = cmd(f"ip -4 -o addr show to {cfg.remote_addr_v['4']} | awk '{{print $2}}'", shell=True, host=cfg.remote).stdout
-    remote_ifname = remote_info.rstrip('\n')
-    if remote_ifname == "":
+    if cfg.remote_ifname == "":
         raise KsftFailEx('Can not get remote interface')
     local_info = ip("-d link show %s" % (cfg.ifname), json=True)[0]
     if 'parentbus' in local_info and local_info['parentbus'] == "netdevsim":
@@ -136,7 +132,7 @@ def set_interface_init(cfg) -> None:
     cmd(f"ip link set dev {cfg.ifname} xdp off ", shell=True)
     cmd(f"ip link set dev {cfg.ifname} xdpgeneric off ", shell=True)
     cmd(f"ip link set dev {cfg.ifname} xdpoffload off", shell=True)
-    cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
+    cmd(f"ip link set dev {cfg.remote_ifname} mtu 1500", shell=True, host=cfg.remote)
 
 def test_default(cfg, netnl) -> None:
     _set_offload_checksum(cfg, netnl, "off")
-- 
2.47.1


