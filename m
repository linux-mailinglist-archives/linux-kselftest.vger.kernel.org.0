Return-Path: <linux-kselftest+bounces-28564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B82A584A0
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 14:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8B2188DCF4
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 13:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EEA1DC9AD;
	Sun,  9 Mar 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL1DAG4t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C371DC996;
	Sun,  9 Mar 2025 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527846; cv=none; b=pXrcExgVIsiBcLjklqHxq702p9u6E/3LaD1mP0qIb/oaiGyww0oCxmp5GVhBPvvnCaGXNGF+GXErO43pXYxVTGERTVm6Tiqi3TXaDyTfxT8DickePb4dxxIQF0YgVuh/NlJEOVeWIbcoF5l4i+2PRiZw7fPrUZNxUMjLUyin6Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527846; c=relaxed/simple;
	bh=BetOEpXT4sktIbCCQ2L9DlSwPslXcVObeTItgL1p0Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EpGCGAWoEkSD5h5jd3JveRxZOV3NnpF6V6LnsVPD3hj5jlGwyU6Yut2UiffrcBxtAZxxNIsKuMjL/pYVZqbseWazsBG07R+Ax6/hbhzYfCQm+CzWcq2upYJM/jginTD30qBwTRtfKQz9FWeAA4xmL6pBpCe9t3LSSNSwDlqb5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL1DAG4t; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223fd89d036so64924745ad.1;
        Sun, 09 Mar 2025 06:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527844; x=1742132644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaEFJP+ktkukRwLsnnvs6JN1FNl+ELjQ7TqtkoU4H70=;
        b=HL1DAG4t/DGcChm+AbOUM3lpERnKM2DWXNIrcqaMaBI2huOOPKCfFYqbrUo+2C7jgp
         uQ+JuhXpr33quo69QMSHk7C2UVgPLRF0SQYwcdECDh9y+QV1s2kzqJB5Nc81nPOwWslI
         /PhL9kwDIZfMQPgRCYUrlL+CazsOcxmcTKDyBSKTDUSK+Ri4m5BtySYR+NY4M5wxoWiS
         6SuMwbCYuwOLE8xcZlFs7WrYT+zWwKiJS2VW8o30vxrD6uOnfsXwQUGbU5fdcM/13AJr
         HeaYzgUlAaNUCXHjqPM7Z0qRkftg9pbyw2W2Ta0IDEdpEFDqySf7pR7wJLIzS/eXZwYD
         sftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527844; x=1742132644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaEFJP+ktkukRwLsnnvs6JN1FNl+ELjQ7TqtkoU4H70=;
        b=Nua7FkbKVrKYtJ+LlKUScKw7cGpTp16W5pH7OX3puJOseiKFNruK3hGV7sETYSJWbZ
         xmdEdRnR1Py4L8SD1/XDZffyGspQ5yynW4TF49Pzi8AUjbs6ZGG3qPLdy7Ggc4J2UNvt
         yfmqxktXctMCPTCWINtm5iMYcsM8wdpq3SlmU9xwnCA43lv7EKp3djV9UH2z3SrZX6kx
         Bbtyv2a7A6rPl/zP03O9rY6e5FLUwpvGv7DGb3ycQUVEdWRNTOwePa1wrsyUtuHRwKuz
         LTgpXifH2W2y/es+0EICnMIppYnC6vMtmZb9yjrRsVlDnkyITC6cn8weXJi02BqsChHR
         CmYw==
X-Forwarded-Encrypted: i=1; AJvYcCU5MI0CxgD9SOE2ElDNuelMT0tiM3gTnr/ipfiF07Hj7ksYeSIywl+C/8+RgizAlCo+2FtA56Vi9/jY9/HQeYs=@vger.kernel.org, AJvYcCW+L7bU8sC1ZHuOSW3G065RKlHMnSeFhnppAGQ6XkDsQbX7X68RM5r9nWmzlQtmKX2hWxCSvWYB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5doYSaPkYDgvBxrJiG3wwdtFEk8X27iOkjSw4tu599eA+tcvO
	+SrJxhSVYZHpQdf5pa5EIaSxDbmjsZlZqzQjLSIHdU3Et9G55H4/
X-Gm-Gg: ASbGncvMNOLmCQ3oRodWTTyw+/1UicU0mePStfHKOol9qkLnlDNVw5JfM6SLmQLhnKa
	mHh+8Jlwt4x9WW7ha5unXE8wHyB7CcL0ejbkkU8aUBcfQfq+ex6KCNXq757NwMqi75FIzDEemTi
	fAGIhfRKibyFKQ7B6pxEqtZ1JEyLMp5Y55212xFy0wfHKGpN1oREAOVg4Lv2nL89DNYpRQG6pOY
	moOFkpgig3s+RW7pKTknRpDKZNGyLM19lr1agwZvVOSKa+kc0BPSKK1Nlh+it4DO1qdl9oKRhQX
	97e+Iubke8RH9EmHmS4C3hbqnLhnE6Aei+TKo6WdelK5
X-Google-Smtp-Source: AGHT+IEfsQvvzA74mKDNozulYmWb1+2TYl1v5p+CMdDWwcrEObDxrU4laIZqnodgLp8lJ8NkNWBp9A==
X-Received: by 2002:a05:6a21:497:b0:1f1:2a5:1667 with SMTP id adf61e73a8af0-1f544c381e0mr21309623637.32.1741527844524;
        Sun, 09 Mar 2025 06:44:04 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c41dda7csm2296841b3a.85.2025.03.09.06.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:44:03 -0700 (PDT)
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
	amritha.nambiar@intel.com,
	xuanzhuo@linux.alibaba.com,
	ap420073@gmail.com
Subject: [PATCH v3 net 8/8] selftests: drv-net: add xdp cases for ping.py
Date: Sun,  9 Mar 2025 13:42:19 +0000
Message-Id: <20250309134219.91670-9-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309134219.91670-1-ap420073@gmail.com>
References: <20250309134219.91670-1-ap420073@gmail.com>
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

v3:
 - No changes.

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


