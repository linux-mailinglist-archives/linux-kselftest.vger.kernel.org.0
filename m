Return-Path: <linux-kselftest+bounces-28378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798FFA5439F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 08:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122023AFEF1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 07:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D21C8625;
	Thu,  6 Mar 2025 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jELIyqBH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186717C98;
	Thu,  6 Mar 2025 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245910; cv=none; b=brzMa0qg76Y8EagNAZMosMHrJFMOTSzG5YbE3DmcsedR1PZgRJj+P/QaDnH9Vrgegkp9iw3EPeRVAuaTrWGHCMz1Li5bSb/+hXmL01nF0EAunkLDAR5Ax1vi/dmRyuh96vppLoNZBnN6XM5djHpC8ziXN9F67pGBhYyEkWdW3WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245910; c=relaxed/simple;
	bh=kufHmTRB++jZQY64ZMozQJ3Wbc9eALcrHlZIJBbmxK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CBrbhk6htbBaqeRDIlN+JFxiiRJMXdapdDALjXYX63JpjwvbalPEIYdkaQYskigOIrR/Fykk/5068iBzWh/Bu97SBzM6Q+oCdPIeBZc1MC5hBLdKhtlgtLciFhQIBHcoKMgmOsbvwgSoU8SHzpa7OCRxBulHrE71Pc+GRkcL02w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jELIyqBH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2239c066347so4372105ad.2;
        Wed, 05 Mar 2025 23:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741245908; x=1741850708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsKO0nzseNJqKnkU34vflNea8Zesxh3zcsIa2WAI8VI=;
        b=jELIyqBHkw3v66z8MZ+ZE6caQWMraVWmg8MS7uNxvRyS7ilMSWjlGqUNUs/1PVTaEk
         nQncACAzgCCEU48SPo3mB7KvvWPLS1Px4kn9/N8tEy+UGcce696V0S3g0SkdHjkmlN85
         HdjNMVrWZ5CNB9xU9Z0qn6cqS6IOpe+FE/MLG7+Kw3+N1v8EttsxAee5N1WLz84XV/2A
         YRYYd7WWcdM//JCuMy0r+DWhakt5dq795Tmub5PDjpzFhsBYq4nQC5slY9l8jE+/9IF7
         PfgOXUjEeWYPyZz0emgwgmzYfQHtuC2I7pU1rp0RTT2njTjKD4AXqkUDyddma84t6JWx
         e6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741245908; x=1741850708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsKO0nzseNJqKnkU34vflNea8Zesxh3zcsIa2WAI8VI=;
        b=YXnfgA5ikcu5xeoVlRilJvbDh8u5tfWR78NZPoyt+1ndJPO8wbKuAqoHWUTCwrn0AN
         QffiwSogzN9ZRB4h5vxM02sfgVegwoDohr2ZwtVC8NqMSpxu7VIUVPsVOp6TS9QlvCA2
         DrwFC2G7NPErWWDVVLqetviTW2uWt2WX5rnOGEtPP0ktufyyrPE+/gN6Aqpz627Yoaz0
         mj6FWvAJS4YNjgQ+u/cL+DvVERzRY4zzSEchMoYMJFoiKtl6G12PS8mXbUU+nvbMy2Dt
         Nze84A0C3SxNBCXYww/WZ3jdeGEuiEqMfzlU1mWmmFsysYBdLQngPWiDEwpIIqFgkqNN
         tu/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXnCQXs9D9AqtZayv8LJqHbEHeVWPR/20EZAg2ODHDatyzv2KRFN0fQc8bB8pIj2R17UvFnn/dN9egT5g/4Bw=@vger.kernel.org, AJvYcCXRBljGb97hQ7SWza9+RCppSqMCJ3i15lTO001g0lU7Ri30a4HIU3F8P4dCCwQBvjdgooLNHJMs@vger.kernel.org
X-Gm-Message-State: AOJu0YxReqNvws4s59rmVXz6AgwnNRW6JyNgRXANLHzBWiy+SWs85aLk
	l0JlPf26JsBrCUlHIhsPxujfa3n0GIfyiocf0LbxYI2CDC4sFjy0
X-Gm-Gg: ASbGncs12icXZuOcBonailiHLA1YTQEBRbNsodQtxhA0Tq+7vzNw5Rm8Dm6wUW/eCfN
	zPPr+xFHH/d2i2GP2l8JCd8JAILCOoM4M48DoNMTHqnFV5qmORnx6He9488gSikP4iMMkO2HJAv
	isF4nGiPd3y/R6bJlPWV92lvUJ3DU+DMtdu701YBv+YP2rDn36hi0HnvBKwGru4PS5SWQvtUUrR
	wed+ho5/QU+9acnP6FmbtGNU7iLhR0P9XcEOMQ84jL14tMZo4fDmvUMUZeYxQ8XBBBGZSs4kc34
	vtLvkf+iRUbOMvoaq+nSDcRw3tXV60fYMA==
X-Google-Smtp-Source: AGHT+IE0tBICBW97zmbYjsCSFEvkmjp0kkAzkNWysxV3gfvI+A1Lsvn17an83iZMNzP1vaAj1An9bQ==
X-Received: by 2002:a17:902:ebc4:b0:224:10b9:357a with SMTP id d9443c01a7336-22410c87c9emr16495845ad.32.1741245907691;
        Wed, 05 Mar 2025 23:25:07 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693534f8sm567196a91.17.2025.03.05.23.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 23:25:06 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: almasrymina@google.com,
	asml.silence@gmail.com,
	willemb@google.com,
	kaiyuanz@google.com,
	skhawaja@google.com,
	sdf@fomichev.me,
	gospo@broadcom.com,
	somnath.kotur@broadcom.com,
	dw@davidwei.uk,
	ap420073@gmail.com
Subject: [PATCH v2 net 6/6] selftests: drv-net: add xdp cases for ping.py
Date: Thu,  6 Mar 2025 07:24:22 +0000
Message-Id: <20250306072422.3303386-7-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306072422.3303386-1-ap420073@gmail.com>
References: <20250306072422.3303386-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ping.py has 3 cases, test_v4, test_v6 and test_tcp.
But these cases are not executed on the XDP environment.
So, it adds XDP environment, existing tests(test_v4, test_v6, and
test_tcp) are executed too on the below XDP environment.
So, it adds XDP cases.
1. xdp-generic + single-buffer
2. xdp-generic + multi-buffer
3. xdp-native + single-buffer
4. xdp-native + multi-buffer
5. xdp-offload

It also makes test_{v4 | v6 | tcp} sending large size packets. this may
help to check whether multi-buffer is working or not.

Note that the physical interface may be down and then up when xdp is
attached or detached.
This takes some period to activate traffic. So sleep(10) is
added if the test interface is the physical interface.
netdevsim and veth type interfaces skip sleep.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2:
 - Patch added.

 tools/testing/selftests/drivers/net/ping.py   | 200 ++++++++++++++++--
 .../testing/selftests/net/lib/xdp_dummy.bpf.c |   6 +
 2 files changed, 191 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index eb83e7b48797..93f4b411b378 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -1,49 +1,219 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import os
+import random, string, time
 from lib.py import ksft_run, ksft_exit
-from lib.py import ksft_eq
-from lib.py import NetDrvEpEnv
+from lib.py import ksft_eq, KsftSkipEx, KsftFailEx
+from lib.py import EthtoolFamily, NetDrvEpEnv
 from lib.py import bkg, cmd, wait_port_listen, rand_port
+from lib.py import ethtool, ip
 
+remote_ifname=""
+no_sleep=False
 
-def test_v4(cfg) -> None:
+def _test_v4(cfg) -> None:
     cfg.require_v4()
 
     cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
     cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
+    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.remote_v4}")
+    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
 
-
-def test_v6(cfg) -> None:
+def _test_v6(cfg) -> None:
     cfg.require_v6()
 
-    cmd(f"ping -c 1 -W0.5 {cfg.remote_v6}")
-    cmd(f"ping -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
-
+    cmd(f"ping -c 1 -W5 {cfg.remote_v6}")
+    cmd(f"ping -c 1 -W5 {cfg.v6}", host=cfg.remote)
+    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.remote_v6}")
+    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
 
-def test_tcp(cfg) -> None:
+def _test_tcp(cfg) -> None:
     cfg.require_cmd("socat", remote=True)
 
     port = rand_port()
     listen_cmd = f"socat -{cfg.addr_ipver} -t 2 -u TCP-LISTEN:{port},reuseport STDOUT"
 
+    test_string = ''.join(random.choice(string.ascii_lowercase) for _ in range(65536))
     with bkg(listen_cmd, exit_wait=True) as nc:
         wait_port_listen(port)
 
-        cmd(f"echo ping | socat -t 2 -u STDIN TCP:{cfg.baddr}:{port}",
+        cmd(f"echo {test_string} | socat -t 2 -u STDIN TCP:{cfg.baddr}:{port}",
             shell=True, host=cfg.remote)
-    ksft_eq(nc.stdout.strip(), "ping")
+    ksft_eq(nc.stdout.strip(), test_string)
 
+    test_string = ''.join(random.choice(string.ascii_lowercase) for _ in range(65536))
     with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as nc:
         wait_port_listen(port, host=cfg.remote)
 
-        cmd(f"echo ping | socat -t 2 -u STDIN TCP:{cfg.remote_baddr}:{port}", shell=True)
-    ksft_eq(nc.stdout.strip(), "ping")
-
+        cmd(f"echo {test_string} | socat -t 2 -u STDIN TCP:{cfg.remote_baddr}:{port}", shell=True)
+    ksft_eq(nc.stdout.strip(), test_string)
+
+def _set_offload_checksum(cfg, netnl, on) -> None:
+    try:
+        ethtool(f" -K {cfg.ifname} rx {on} tx {on} ")
+    except:
+        return
+
+def _set_xdp_generic_sb_on(cfg) -> None:
+    test_dir = os.path.dirname(os.path.realpath(__file__))
+    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
+    cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
+    cmd(f"ip link set dev {cfg.ifname} mtu 1500 xdpgeneric obj {prog} sec xdp", shell=True)
+
+    if no_sleep != True:
+        time.sleep(10)
+
+def _set_xdp_generic_mb_on(cfg) -> None:
+    test_dir = os.path.dirname(os.path.realpath(__file__))
+    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
+    cmd(f"ip link set dev {remote_ifname} mtu 9000", shell=True, host=cfg.remote)
+    ip("link set dev %s mtu 9000 xdpgeneric obj %s sec xdp.frags" % (cfg.ifname, prog))
+
+    if no_sleep != True:
+        time.sleep(10)
+
+def _set_xdp_native_sb_on(cfg) -> None:
+    test_dir = os.path.dirname(os.path.realpath(__file__))
+    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
+    cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
+    cmd(f"ip -j link set dev {cfg.ifname} mtu 1500 xdp obj {prog} sec xdp", shell=True)
+    xdp_info = ip("-d link show %s" % (cfg.ifname), json=True)[0]
+    if xdp_info['xdp']['mode'] != 1:
+        """
+        If the interface doesn't support native-mode, it falls back to generic mode.
+        The mode value 1 is native and 2 is generic.
+        So it raises an exception if mode is not 1(native mode).
+        """
+        raise KsftSkipEx('device does not support native-XDP')
+
+    if no_sleep != True:
+        time.sleep(10)
+
+def _set_xdp_native_mb_on(cfg) -> None:
+    test_dir = os.path.dirname(os.path.realpath(__file__))
+    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
+    cmd(f"ip link set dev {remote_ifname} mtu 9000", shell=True, host=cfg.remote)
+    try:
+        cmd(f"ip link set dev {cfg.ifname} mtu 9000 xdp obj {prog} sec xdp.frags", shell=True)
+    except Exception as e:
+        cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
+        raise KsftSkipEx('device does not support native-multi-buffer XDP')
+
+    if no_sleep != True:
+        time.sleep(10)
+
+def _set_xdp_offload_on(cfg) -> None:
+    test_dir = os.path.dirname(os.path.realpath(__file__))
+    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
+    cmd(f"ip link set dev {cfg.ifname} mtu 1500", shell=True)
+    try:
+        cmd(f"ip link set dev {cfg.ifname} xdpoffload obj {prog} sec xdp", shell=True)
+    except Exception as e:
+        raise KsftSkipEx('device does not support offloaded XDP')
+    cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
+
+    if no_sleep != True:
+        time.sleep(10)
+
+def get_interface_info(cfg) -> None:
+    global remote_ifname
+    global no_sleep
+
+    remote_info = cmd(f"ip -4 -o addr show to {cfg.remote_v4} | awk '{{print $2}}'", shell=True, host=cfg.remote).stdout
+    remote_ifname = remote_info.rstrip('\n')
+    if remote_ifname == "":
+        raise KsftFailEx('Can not get remote interface')
+    local_info = ip("-d link show %s" % (cfg.ifname), json=True)[0]
+    if 'parentbus' in local_info and local_info['parentbus'] == "netdevsim":
+        no_sleep=True
+    if 'linkinfo' in local_info and local_info['linkinfo']['info_kind'] == "veth":
+        no_sleep=True
+
+def set_interface_init(cfg) -> None:
+    cmd(f"ip link set dev {cfg.ifname} mtu 1500", shell=True)
+    cmd(f"ip link set dev {cfg.ifname} xdp off ", shell=True)
+    cmd(f"ip link set dev {cfg.ifname} xdpgeneric off ", shell=True)
+    cmd(f"ip link set dev {cfg.ifname} xdpoffload off", shell=True)
+    cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
+
+def test_default(cfg, netnl) -> None:
+    _set_offload_checksum(cfg, netnl, "off")
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+    _set_offload_checksum(cfg, netnl, "on")
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+
+def test_xdp_generic_sb(cfg, netnl) -> None:
+    _set_xdp_generic_sb_on(cfg)
+    _set_offload_checksum(cfg, netnl, "off")
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+    _set_offload_checksum(cfg, netnl, "on")
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+    ip("link set dev %s xdpgeneric off" % cfg.ifname)
+
+def test_xdp_generic_mb(cfg, netnl) -> None:
+    _set_xdp_generic_mb_on(cfg)
+    _set_offload_checksum(cfg, netnl, "off")
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+    _set_offload_checksum(cfg, netnl, "on")
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+    ip("link set dev %s xdpgeneric off" % cfg.ifname)
+
+def test_xdp_native_sb(cfg, netnl) -> None:
+    _set_xdp_native_sb_on(cfg)
+    _set_offload_checksum(cfg, netnl, "off")
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+    _set_offload_checksum(cfg, netnl, "on")
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+    ip("link set dev %s xdp off" % cfg.ifname)
+
+def test_xdp_native_mb(cfg, netnl) -> None:
+    _set_xdp_native_mb_on(cfg)
+    _set_offload_checksum(cfg, netnl, "off")
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+    _set_offload_checksum(cfg, netnl, "on")
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+    ip("link set dev %s xdp off" % cfg.ifname)
+
+def test_xdp_offload(cfg, netnl) -> None:
+    _set_xdp_offload_on(cfg)
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+    ip("link set dev %s xdpoffload off" % cfg.ifname)
 
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
-        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
+        get_interface_info(cfg)
+        set_interface_init(cfg)
+        ksft_run([test_default,
+                  test_xdp_generic_sb,
+                  test_xdp_generic_mb,
+                  test_xdp_native_sb,
+                  test_xdp_native_mb,
+                  test_xdp_offload],
+                 args=(cfg, EthtoolFamily()))
+        set_interface_init(cfg)
     ksft_exit()
 
 
diff --git a/tools/testing/selftests/net/lib/xdp_dummy.bpf.c b/tools/testing/selftests/net/lib/xdp_dummy.bpf.c
index d988b2e0cee8..e73fab3edd9f 100644
--- a/tools/testing/selftests/net/lib/xdp_dummy.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_dummy.bpf.c
@@ -10,4 +10,10 @@ int xdp_dummy_prog(struct xdp_md *ctx)
 	return XDP_PASS;
 }
 
+SEC("xdp.frags")
+int xdp_dummy_prog_frags(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1


