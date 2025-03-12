Return-Path: <linux-kselftest+bounces-28809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E8EA5DD7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 14:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A9377AD609
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 13:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA19244EA1;
	Wed, 12 Mar 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4HcCxiF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B3523F376;
	Wed, 12 Mar 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785051; cv=none; b=TVrGADGldOo0Z0iBG++zlvWIdwjQ0fezd1RuCph90Jm7sfA5IhJOqqsRz/0szs+ZeFcZmyZsPh2amO9+Tla66VLcAEwD/FI2M+vYbhmBeIr804pEZYcGuQ/o0AUCElStKcwRp4xkZF00UEjZ0/JnEJ3h129gaRfgaZEVxEz35eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785051; c=relaxed/simple;
	bh=YxQy9RhnsEnCW0He+QcRzfmTEud041311PAgh672cVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUN1piLnIX6a7wXwZA8yFsTstQEiPKH15gFWPbNweoGzOvEuIFQtduWVrOvWDTg6gN10jN+uoDJDc6r2FVjlnjcNlNgrY3ZUcBnk29EB5dfq7O/49FrmFACNFvejtkJ/RCPT1wAB98ury9+FbDSriHpGYlk0CXGkgRW2q9dgNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4HcCxiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44BAC4CEE3;
	Wed, 12 Mar 2025 13:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741785050;
	bh=YxQy9RhnsEnCW0He+QcRzfmTEud041311PAgh672cVA=;
	h=From:To:Cc:Subject:Date:From;
	b=p4HcCxiFBWmpauxxm8J+cPbbtoikXoBLGSXUlTT4nSsTCkbhJaStYP1Pj359dDopB
	 M/llB79dsdIjfh3IU2OznoPlZpKoI/jiRD034op4kzjZytT4wUla6xxn31XWUz0bn/
	 UGSh9GaHADSMCX1d6wKmZdXR1lbLStXvbagtx9WbR03Xos4zBj2iYmLRwSJuI+7cBh
	 bv7oGr5qCIDdR2BmfpPMm2wUFYZs2rl+aVmuvHEVuB4agKDDqySL8k8hSajtuZbN2f
	 CeOTZO3RjN3uwfMfdF5AkvXWfeQwPYgJc7lVNeFWLfX98dL2unIlngujfbO1RrOhFs
	 eRzbVz8pSyJZQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	ap420073@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: drv-net: use defer in the ping test
Date: Wed, 12 Mar 2025 14:10:40 +0100
Message-ID: <20250312131040.660386-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure the test cleans up after itself. The XDP off statements
at the end of the test may not be reached.

Fixes: 75cc19c8ff89 ("selftests: drv-net: add xdp cases for ping.py")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: ap420073@gmail.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/ping.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index 93f4b411b378..fc69bfcc37c4 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -7,7 +7,7 @@ from lib.py import ksft_run, ksft_exit
 from lib.py import ksft_eq, KsftSkipEx, KsftFailEx
 from lib.py import EthtoolFamily, NetDrvEpEnv
 from lib.py import bkg, cmd, wait_port_listen, rand_port
-from lib.py import ethtool, ip
+from lib.py import defer, ethtool, ip
 
 remote_ifname=""
 no_sleep=False
@@ -60,6 +60,7 @@ no_sleep=False
     prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
     cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
     cmd(f"ip link set dev {cfg.ifname} mtu 1500 xdpgeneric obj {prog} sec xdp", shell=True)
+    defer(cmd, f"ip link set dev {cfg.ifname} xdpgeneric off")
 
     if no_sleep != True:
         time.sleep(10)
@@ -68,7 +69,9 @@ no_sleep=False
     test_dir = os.path.dirname(os.path.realpath(__file__))
     prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
     cmd(f"ip link set dev {remote_ifname} mtu 9000", shell=True, host=cfg.remote)
+    defer(ip, f"link set dev {remote_ifname} mtu 1500", host=cfg.remote)
     ip("link set dev %s mtu 9000 xdpgeneric obj %s sec xdp.frags" % (cfg.ifname, prog))
+    defer(ip, f"link set dev {cfg.ifname} mtu 1500 xdpgeneric off")
 
     if no_sleep != True:
         time.sleep(10)
@@ -78,6 +81,7 @@ no_sleep=False
     prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
     cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
     cmd(f"ip -j link set dev {cfg.ifname} mtu 1500 xdp obj {prog} sec xdp", shell=True)
+    defer(ip, f"link set dev {cfg.ifname} mtu 1500 xdp off")
     xdp_info = ip("-d link show %s" % (cfg.ifname), json=True)[0]
     if xdp_info['xdp']['mode'] != 1:
         """
@@ -94,10 +98,11 @@ no_sleep=False
     test_dir = os.path.dirname(os.path.realpath(__file__))
     prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
     cmd(f"ip link set dev {remote_ifname} mtu 9000", shell=True, host=cfg.remote)
+    defer(ip, f"link set dev {remote_ifname} mtu 1500", host=cfg.remote)
     try:
         cmd(f"ip link set dev {cfg.ifname} mtu 9000 xdp obj {prog} sec xdp.frags", shell=True)
+        defer(ip, f"link set dev {cfg.ifname} mtu 1500 xdp off")
     except Exception as e:
-        cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
         raise KsftSkipEx('device does not support native-multi-buffer XDP')
 
     if no_sleep != True:
@@ -111,6 +116,7 @@ no_sleep=False
         cmd(f"ip link set dev {cfg.ifname} xdpoffload obj {prog} sec xdp", shell=True)
     except Exception as e:
         raise KsftSkipEx('device does not support offloaded XDP')
+    defer(ip, f"link set dev {cfg.ifname} xdpoffload off")
     cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
 
     if no_sleep != True:
@@ -157,7 +163,6 @@ no_sleep=False
     _test_v4(cfg)
     _test_v6(cfg)
     _test_tcp(cfg)
-    ip("link set dev %s xdpgeneric off" % cfg.ifname)
 
 def test_xdp_generic_mb(cfg, netnl) -> None:
     _set_xdp_generic_mb_on(cfg)
@@ -169,7 +174,6 @@ no_sleep=False
     _test_v4(cfg)
     _test_v6(cfg)
     _test_tcp(cfg)
-    ip("link set dev %s xdpgeneric off" % cfg.ifname)
 
 def test_xdp_native_sb(cfg, netnl) -> None:
     _set_xdp_native_sb_on(cfg)
@@ -181,7 +185,6 @@ no_sleep=False
     _test_v4(cfg)
     _test_v6(cfg)
     _test_tcp(cfg)
-    ip("link set dev %s xdp off" % cfg.ifname)
 
 def test_xdp_native_mb(cfg, netnl) -> None:
     _set_xdp_native_mb_on(cfg)
@@ -193,14 +196,12 @@ no_sleep=False
     _test_v4(cfg)
     _test_v6(cfg)
     _test_tcp(cfg)
-    ip("link set dev %s xdp off" % cfg.ifname)
 
 def test_xdp_offload(cfg, netnl) -> None:
     _set_xdp_offload_on(cfg)
     _test_v4(cfg)
     _test_v6(cfg)
     _test_tcp(cfg)
-    ip("link set dev %s xdpoffload off" % cfg.ifname)
 
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
@@ -213,7 +214,6 @@ no_sleep=False
                   test_xdp_native_mb,
                   test_xdp_offload],
                  args=(cfg, EthtoolFamily()))
-        set_interface_init(cfg)
     ksft_exit()
 
 
-- 
2.48.1


