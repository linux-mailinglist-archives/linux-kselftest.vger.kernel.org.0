Return-Path: <linux-kselftest+bounces-9606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD818BE798
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 17:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C891F2456C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 15:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB587161313;
	Tue,  7 May 2024 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc/OePlU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250915E1E2;
	Tue,  7 May 2024 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096543; cv=none; b=BeDEVzhzuImVAQu/ESyV7Pxhzr9Cc5dNwJhzzcLbBb1rWWeb43RXTFJVICpLWfdkCcs/cQjnkoUkWB4kiNLCxvLC85OSRKrG4duwey2Z+9e3w6E3hkyJS/ggFaFTSmPmMKP0bJ0Cbr1gKltLga5K2LDc/SB+UAfCHHcXZk74qOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096543; c=relaxed/simple;
	bh=4YyaO7J/iBhpLgm+29DhhOZSj4KPxejM4S0FJ9l52Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yb3uvCZ0at4s6OnT+b5ghCm3fXDOVx+qpm+JCCDJXN6Iha+NQQijFcQ+3Df2QTPhSmJvrykYPZIx8vU0D82VNvXn9rPPSM5JXOoeGiODZxVe+/mHVPKS6ajhskeOak+1jtbNCpEEN9KrpJeuQaet67ctr9y7ODYgY4E5AxvMKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nc/OePlU; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a0a7cf89deso11119596d6.0;
        Tue, 07 May 2024 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715096541; x=1715701341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXKY0aSO0HmnDU4LqQburbJtFpfCoEzhjwBFOUgmFiI=;
        b=Nc/OePlUZVx3TMrRO2FCvrCBDjLy+0oM3vOB0d7YTh3f9ugpQ9SMwgeCCH0i3n4vzX
         RG2TWVZBeZV4acyn/CkbR6oauh5kSw8h+7dS9GmXgnMoaAxIMg4IK2fOq7ba5IM9/DDL
         L34EHESX3uclPfu0U17I37pk/AhS/Ovm4UeuwWAIyxWxPaieApW1SQVSMo62YTunwFdr
         LFCzLpoxcOpq9oAFjTRkCuaVePeFp5+uD4fiGjC3UM1lAOCNPSLnDTP+keIV3+ZbBrdS
         SHtEYzjQ3n9yMQ9G84AsnBeJBPaHSJP8Wi+Wmxo20CXYLbybvPR/5XrDmCFEDw0Vdnwl
         s84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715096541; x=1715701341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXKY0aSO0HmnDU4LqQburbJtFpfCoEzhjwBFOUgmFiI=;
        b=Om8iFqZR8eNBIZGHTJDc2pwWiBPTIivJoWJNf4Fx3JCj+f0MI1UUoyrvpGPT1cEHC3
         nlvkHo5f7MhmOjnKsmjNlyNsK38ZNouANqV5jPuakTR3S5OdS0B9R3j4fyM5iJI3kLU9
         Wz6Q5ZqMI352F41OOCb2haZvrtoemlzGpypQ9dAhTALduvwLn/0Kih36iggoHoIvOaN1
         CKFQvZKpimo+7rAKtQCIcgO5WohWGQKQoPRcTjp38CxsLvVM6HKGaQ/5i5JmseDuyfbp
         KJe4ihlnjgf4tgnlx2NZUvKHcW8I2ecEXOPcdm1tb1mWySLT7Sf0kjswbc/8/akFu7fJ
         retQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXgWp3Mm1TifAe0zbF0oQopV+x+n6tOWvMM9oerRpaM5IHkKZ7aAaappo99trkUEqTWuqtKy8VL7Q7y5N94woUq3grJgXee5UibOUxFAH1
X-Gm-Message-State: AOJu0Yz8r941mqRKZ5HuwXjgszG1j+QCeQDuoEKoiXm+jiQAS95SI2Sg
	9o4y81ZAHY1Xj2BSlA0kLPpS3Rpf8Pj10hN8ltY9KKha6Q6jDvzi4RFp+w==
X-Google-Smtp-Source: AGHT+IEFHWD2MENwmPTSRyrA2Kkj42xwDgEqADOCAVb42nMaVPGndSnkar+pTWNhHOhrueHu78+X4A==
X-Received: by 2002:a05:6214:2aac:b0:6a0:cf21:abc9 with SMTP id 6a1803df08f44-6a151427db6mr2171366d6.6.1715096540834;
        Tue, 07 May 2024 08:42:20 -0700 (PDT)
Received: from willemb.c.googlers.com.com (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id f6-20020a056214164600b006a10054acadsm4788331qvw.19.2024.05.07.08.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 08:42:20 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3] selftests: drv-net: add checksum tests
Date: Tue,  7 May 2024 11:40:58 -0400
Message-ID: <20240507154216.501111-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Run tools/testing/selftest/net/csum.c as part of drv-net.
This binary covers multiple scenarios, based on arguments given,
for both IPv4 and IPv6:

- Accept UDP correct checksum
- Detect UDP invalid checksum
- Accept TCP correct checksum
- Detect TCP invalid checksum

- Transmit UDP: basic checksum offload
- Transmit UDP: zero checksum conversion

The test direction is reversed between receive and transmit tests, so
that the NIC under test is always the local machine.

In total this adds up to 12 testcases, with more to follow. For
conciseness, I replaced individual functions with a function factory.

Also detect hardware offload feature availability using Ethtool
netlink and skip tests when either feature is off. This need may be
common for offload feature tests and eventually deserving of a thin
wrapper in lib.py.

Missing are the PF_PACKET based send tests ('-P'). These use
virtio_net_hdr to program hardware checksum offload. Which requires
looking up the local MAC address and (harder) the MAC of the next hop.
I'll have to give it some though how to do that robustly and where
that code would belong.

Tested:

        make -C tools/testing/selftests/ \
                TARGETS="drivers/net drivers/net/hw" \
                install INSTALL_PATH=/tmp/ksft
        cd /tmp/ksft

	sudo NETIF=ens4 REMOTE_TYPE=ssh \
		REMOTE_ARGS="root@10.40.0.2" \
		LOCAL_V4="10.40.0.1" \
		REMOTE_V4="10.40.0.2" \
		./run_kselftest.sh -t drivers/net/hw:csum.py

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

I think we also want the following for correct line breaks?

    +++ b/tools/testing/selftests/net/lib/py/utils.py
    @@ -42,7 +42,7 @@ class cmd:
    	     if len(stderr) > 0 and stderr[-1] == "\n":
    		 stderr = stderr[:-1]
    	     raise Exception("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
    -                            (self.proc.args, stdout, stderr))
    +                            (self.proc.args, self.stdout, self.stderr))

Changes
  - v2->v3
      - support NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM
      - minor: fix missing backslash in commit message Tested
      - minor: fix inconsistent single vs double quotes
  - v1->v2
      - remove dependency on tools/testing/selftests/net: move csum
      - remove test output from git commit message:
        has noisy (expected) failures on test platform after bkg changes
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../testing/selftests/drivers/net/hw/csum.py  | 122 ++++++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   1 -
 tools/testing/selftests/net/lib/.gitignore    |   2 +
 tools/testing/selftests/net/lib/Makefile      |   7 +
 tools/testing/selftests/net/{ => lib}/csum.c  |   0
 7 files changed, 132 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/csum.py
 create mode 100644 tools/testing/selftests/net/lib/.gitignore
 rename tools/testing/selftests/net/{ => lib}/csum.c (100%)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 1dd732855d76..4933d045ab66 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
 TEST_PROGS = \
+	csum.py \
 	devlink_port_split.py \
 	ethtool.sh \
 	ethtool_extended_state.sh \
diff --git a/tools/testing/selftests/drivers/net/hw/csum.py b/tools/testing/selftests/drivers/net/hw/csum.py
new file mode 100755
index 000000000000..cb40497faee4
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/csum.py
@@ -0,0 +1,122 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Run the tools/testing/selftests/net/csum testsuite."""
+
+from os import path
+
+from lib.py import ksft_run, ksft_exit, KsftSkipEx
+from lib.py import EthtoolFamily, NetDrvEpEnv
+from lib.py import bkg, cmd, wait_port_listen
+
+def test_receive(cfg, ipv4=False, extra_args=None):
+    """Test local nic checksum receive. Remote host sends crafted packets."""
+    if not cfg.have_rx_csum:
+        raise KsftSkipEx(f"Test requires rx checksum offload on {cfg.ifname}")
+
+    if ipv4:
+        ip_args = f"-4 -S {cfg.remote_v4} -D {cfg.v4}"
+    else:
+        ip_args = f"-6 -S {cfg.remote_v6} -D {cfg.v6}"
+
+    rx_cmd = f"{cfg.bin_local} -i {cfg.ifname} -n 100 {ip_args} -r 1 -R {extra_args}"
+    tx_cmd = f"{cfg.bin_remote} -i {cfg.ifname} -n 100 {ip_args} -r 1 -T {extra_args}"
+
+    with bkg(rx_cmd, exit_wait=True):
+        wait_port_listen(34000, proto="udp")
+        cmd(tx_cmd, host=cfg.remote)
+
+
+def test_transmit(cfg, ipv4=False, extra_args=None):
+    """Test local nic checksum transmit. Remote host verifies packets."""
+    if (not cfg.have_tx_csum_generic and
+        not (cfg.have_tx_csum_ipv4 and ipv4) and
+        not (cfg.have_tx_csum_ipv6 and not ipv4)):
+        raise KsftSkipEx(f"Test requires tx checksum offload on {cfg.ifname}")
+
+    if ipv4:
+        ip_args = f"-4 -S {cfg.v4} -D {cfg.remote_v4}"
+    else:
+        ip_args = f"-6 -S {cfg.v6} -D {cfg.remote_v6}"
+
+    # Cannot randomize input when calculating zero checksum
+    if extra_args != "-U -Z":
+        extra_args += " -r 1"
+
+    rx_cmd = f"{cfg.bin_remote} -i {cfg.ifname} -L 1 -n 100 {ip_args} -R {extra_args}"
+    tx_cmd = f"{cfg.bin_local} -i {cfg.ifname} -L 1 -n 100 {ip_args} -T {extra_args}"
+
+    with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
+        wait_port_listen(34000, proto="udp", host=cfg.remote)
+        cmd(tx_cmd)
+
+
+def test_builder(name, cfg, ipv4=False, tx=False, extra_args=""):
+    """Construct specific tests from the common template.
+
+       Most tests follow the same basic pattern, differing only in
+       Direction of the test and optional flags passed to csum."""
+    def f(cfg):
+        if ipv4:
+            cfg.require_v4()
+        else:
+            cfg.require_v6()
+
+        if tx:
+            test_transmit(cfg, ipv4, extra_args)
+        else:
+            test_receive(cfg, ipv4, extra_args)
+
+    if ipv4:
+        f.__name__ = "ipv4_" + name
+    else:
+        f.__name__ = "ipv6_" + name
+    return f
+
+
+def check_nic_features(cfg) -> None:
+    """Test whether Tx and Rx checksum offload are enabled.
+
+       If the device under test has either off, then skip the relevant tests."""
+    cfg.have_tx_csum_generic = False
+    cfg.have_tx_csum_ipv4 = False
+    cfg.have_tx_csum_ipv6 = False
+    cfg.have_rx_csum = False
+
+    ethnl = EthtoolFamily()
+    features = ethnl.features_get({"header": {"dev-index": cfg.ifindex}})
+    for f in features["active"]["bits"]["bit"]:
+        if f["name"] == "tx-checksum-ip-generic":
+            cfg.have_tx_csum_generic = True
+        elif f["name"] == "tx-checksum-ipv4":
+            cfg.have_tx_csum_ipv4 = True
+        elif f["name"] == "tx-checksum-ipv6":
+            cfg.have_tx_csum_ipv6 = True
+        elif f["name"] == "rx-checksum":
+            cfg.have_rx_csum = True
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        check_nic_features(cfg)
+
+        cfg.bin_local = path.abspath(path.dirname(__file__) + "/../../../net/lib/csum")
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+
+        cases = []
+        for ipv4 in [True, False]:
+            cases.append(test_builder("rx_tcp", cfg, ipv4, False, "-t"))
+            cases.append(test_builder("rx_tcp_invalid", cfg, ipv4, False, "-t -E"))
+
+            cases.append(test_builder("rx_udp", cfg, ipv4, False, ""))
+            cases.append(test_builder("rx_udp_invalid", cfg, ipv4, False, "-E"))
+
+            cases.append(test_builder("tx_udp_csum_offload", cfg, ipv4, True, "-U"))
+            cases.append(test_builder("tx_udp_zero_checksum", cfg, ipv4, True, "-U -Z"))
+
+        ksft_run(cases=cases, args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index d996a0ab0765..74ae1068229c 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -2,7 +2,6 @@
 bind_bhash
 bind_timewait
 bind_wildcard
-csum
 cmsg_sender
 diag_uid
 fin_ack_lat
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5befca249452..052c21438dc4 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -81,7 +81,6 @@ TEST_PROGS += test_ingress_egress_chaining.sh
 TEST_GEN_PROGS += so_incoming_cpu
 TEST_PROGS += sctp_vrf.sh
 TEST_GEN_FILES += sctp_hello
-TEST_GEN_FILES += csum
 TEST_GEN_FILES += ip_local_port_range
 TEST_GEN_FILES += bind_wildcard
 TEST_PROGS += test_vxlan_mdb.sh
diff --git a/tools/testing/selftests/net/lib/.gitignore b/tools/testing/selftests/net/lib/.gitignore
new file mode 100644
index 000000000000..1ebc6187f421
--- /dev/null
+++ b/tools/testing/selftests/net/lib/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+csum
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index 48557e6250dd..82c3264b115e 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -1,8 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
+CFLAGS += -I../../../../../usr/include/ $(KHDR_INCLUDES)
+# Additional include paths needed by kselftest.h
+CFLAGS += -I../../
+
 TEST_FILES := ../../../../../Documentation/netlink/specs
 TEST_FILES += ../../../../net/ynl
 
+TEST_GEN_FILES += csum
+
 TEST_INCLUDES := $(wildcard py/*.py)
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/csum.c b/tools/testing/selftests/net/lib/csum.c
similarity index 100%
rename from tools/testing/selftests/net/csum.c
rename to tools/testing/selftests/net/lib/csum.c
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


