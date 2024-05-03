Return-Path: <linux-kselftest+bounces-9431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A598BB4D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 22:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7501FB223C7
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 20:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A85D159219;
	Fri,  3 May 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4/LqMqf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54089158D6C;
	Fri,  3 May 2024 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767919; cv=none; b=pbq5mE9Oq6fscPJ8/qpd64H9rnBWxo7F8Sq4hCMZuOCcAd4WTyIkjC5/AjlnSl9WWnvr7/fBD2lo57OdiGlNR3fljJfEFUgmI03j99B10lSw8jFlA/PQ9iIQVufNMuIkGAxK2h8/cpI2whVEPZHxFc50YGZHVy7xz68A2uYBIHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767919; c=relaxed/simple;
	bh=i0C5xpWD5f2z/IYxX3nNRhYxI2NXVo00ssiCrH00ejU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jC7RWnL1gFtXiWBQOlYs5DCEF+uUNyONpio/CmUyFBDYWChI4IDlcwCBQM6qli2psC3Dn5iI0Yzhh1ytwF4h6J0HiHO8z6ZiLvnpwYbkJEfo9uW2UsLjAhCoY5aYOD977+07fS9uiafbMba0DuUu+4S2mIOh+bd65/nepRAlLxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4/LqMqf; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ee266e2999so28115a34.2;
        Fri, 03 May 2024 13:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714767916; x=1715372716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GoBSzwJr6dBy8LeIYFsSYiftBkef0PBvl0Rps45KpJ0=;
        b=b4/LqMqf06B9ubElI0qioWHWUDa+v9zRw1hUgkEPwKr6tGyh4u7/+Y9sPk5Cmp71ME
         IqiGyrnVea1FQjMwWjiUvy21x1gXYTmRNKwJO1KdlXkbLm3sfRfNaGxdOW7EAfHmS+Sq
         zyXX5Vc7/8HtgTrllY+2ul8z0dGAZxEsxXWa8rfWBFParpBCXLU/8jet24Oby5jw9ESl
         PJETPALGRuHlxWuLrJ4Piv7TSJw8Y76NZ4SV0kRIjy/QMqhPJbE2T5HN8gkysseUy84X
         HLnvJXvBnynRrFrBVwVynlGuJxEBw99rnjJEjK7QzXZXz6GMtFBcKcgiozBsFt30/wzT
         17YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714767916; x=1715372716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoBSzwJr6dBy8LeIYFsSYiftBkef0PBvl0Rps45KpJ0=;
        b=WtRndQbSXl+yEyKyI+TeNl8TGFalkPSgx0FMqOI7+qK0pMO51QD/4BIKTmlGrW3ufs
         Rg5S7paG3DbICLtiQtMPVDXhknUgBegpPV98Msw0IvFVjwJsMBvj8pThp4c4cCeUE8tZ
         ea72OJRpLeuGP5e+rtN8jMlGkD6NvonwloziXYx7LUMs4M+NNUNguxsNiBFrg2uMVEqa
         GqO5cDnWM+dg6haopldGHbDSpuJCEbbWnIFMsusd3/q9QfpPYMCnELeQOGZSoGXyAGCz
         ke355rlutYgeEjsBb7BVHgH46dd1Nf1NGrjKMOT87xViJDpAYI//NgmgwV9Iovt/x1B+
         ys0A==
X-Forwarded-Encrypted: i=1; AJvYcCX2lU6EgW20PRd0mzasar1O83AkJjX6ZU4eqWmjeczZvUCp2Xmgt6Z7UIB1e8msHiBmwCDZPKrqImPep0BWSbWSkAwwA9YPZR066q7oj5iW
X-Gm-Message-State: AOJu0YzvgWqaxpZiVhqD24/uhgXyB0aS+sT+TPSsu2h4Hvio5/NhAFHq
	nLiu6uj5mauXLC6eOA9s9eoDO2pAanHUKjQziOewq5sJShRqVkeuAqCaOw==
X-Google-Smtp-Source: AGHT+IEEn5HB1dWLopB8IqW/ss5GWkMtvHuTbuQiBF1VE+R57i1wK2a9qmw05eyHpr5q1oZiTVHF4w==
X-Received: by 2002:a9d:3e4c:0:b0:6eb:7c52:fd19 with SMTP id h12-20020a9d3e4c000000b006eb7c52fd19mr4146101otg.16.1714767916222;
        Fri, 03 May 2024 13:25:16 -0700 (PDT)
Received: from willemb.c.googlers.com.com (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id oq32-20020a05620a612000b007907d4bbeccsm1517932qkn.43.2024.05.03.13.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:25:15 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2] selftests: drv-net: add checksum tests
Date: Fri,  3 May 2024 16:24:49 -0400
Message-ID: <20240503202511.4044515-1-willemdebruijn.kernel@gmail.com>
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
		LOCAL_V4="10.40.0.1"
		REMOTE_V4="10.40.0.2" \
		./run_kselftest.sh -t drivers/net/hw:csum.py

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  - v1->v2
      - remove dependency on tools/testing/selftests/net: move csum
      - remove test output from git commit message:
        has noisy (expected) failures on test platform after bkg changes
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../testing/selftests/drivers/net/hw/csum.py  | 114 ++++++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   1 -
 tools/testing/selftests/net/lib/.gitignore    |   2 +
 tools/testing/selftests/net/lib/Makefile      |   7 ++
 tools/testing/selftests/net/{ => lib}/csum.c  |   0
 7 files changed, 124 insertions(+), 2 deletions(-)
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
index 000000000000..7e3a955fc426
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/csum.py
@@ -0,0 +1,114 @@
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
+        wait_port_listen(34000, proto='udp')
+        cmd(tx_cmd, host=cfg.remote)
+
+
+def test_transmit(cfg, ipv4=False, extra_args=None):
+    """Test local nic checksum transmit. Remote host verifies packets."""
+    if not cfg.have_tx_csum:
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
+        wait_port_listen(34000, proto='udp', host=cfg.remote)
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
+    cfg.have_tx_csum = False
+    cfg.have_rx_csum = False
+
+    ethnl = EthtoolFamily()
+    features = ethnl.features_get({"header": {"dev-index": cfg.ifindex}})
+    for f in features["active"]["bits"]["bit"]:
+        if f["name"] == "tx-checksum-ip-generic":
+            cfg.have_tx_csum = True
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


