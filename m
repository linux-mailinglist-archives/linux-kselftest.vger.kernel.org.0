Return-Path: <linux-kselftest+bounces-9236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA3D8B8FE6
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 20:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D811F217AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8286160790;
	Wed,  1 May 2024 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry3wTudr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB1E37E;
	Wed,  1 May 2024 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714589680; cv=none; b=ffPgYGE5lXBPgHU6xoG6ycthCcD1F/N1ZYLO2BtIcWb+WfCwkS+9sA9wGTNaAyY+F3TPukRmCLWnVhuhD8IsHpwCQhB8beI1hUXwXPQQtUfAZcmMWN5KybFSR+zehynISySoIv3IWwnDSJoFJheAslS55alI6SbIaLJP9CHvzVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714589680; c=relaxed/simple;
	bh=hqV+vt6fZQKBW9oemdBhaAZAEJODm4eESDAin7+C+NY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/6Dh2l85EK7gb/X+tOCVsW/YOQgfWoWAnMvEXKZDqUoxGMF+ocJUeMYMezHITj7g/Zo6Hpa49KUtnicP+V0hchbiqZbLyyaF6EdTiW5zCSvKbU/o+8dyJuxFudBqVm4Ucy1uB8k/RnlLtZrFU9OUnqCjowOk2SqpRzXdYoX2zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ry3wTudr; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-790f91b834cso295738685a.0;
        Wed, 01 May 2024 11:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714589678; x=1715194478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0c6qLM0Me1FNyi7Z4OScGe5AGSrmgpGWP7Rq6CKLk6M=;
        b=Ry3wTudrexqPOqrsKRUg9bd34ElDTqWv5B8EovJuMeObiznZB26UmjZWNmmKm9LfXE
         q+6VQw4S8GKGPwVCOafPmMZ1Z2eKp1FtoA/PONI10UTE+4IuZ+l8eYjt/Mcru/1SXmjP
         2TLcK5oGyHAqwiP2TOgJmdcGr2ZKz6qz4Qvxqt2k7IcWjm1X/m1aZXpCn8a+ZMnzrUpl
         hOe9NxoLG6mWAtCoRwrAOdlrf9nSIpVhoZ4ouBgczuIpCTl2Z8Te1rtDZ2OvKbNfTaLH
         azILzLpFiYfQWBa6t9ipCrMfIvpJ4gyxgNN9R9wimNto2qpaEoNLteVcTw5PlY7QbnhK
         wI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714589678; x=1715194478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0c6qLM0Me1FNyi7Z4OScGe5AGSrmgpGWP7Rq6CKLk6M=;
        b=ZeBIAXdw0+sM8KQRPbR/5+s9HsZaHqr7Xmu5GTVeljcWRJuEO0xl84U3nW5i+9f6pA
         /0OQR/VdW0NRm+BmtiX1rt/B5TcJFttE1myaEavHeZUJNAnn36QKhKplEf553i4+tJvk
         Y3d04PN05E/fuiTq5/xYl/jpyy7ak0zfsq/Z4+OGWvZ4sGqWLFQyX0Mn1bKv75we2xO6
         gvgGAxd72NkodSmPs9S45dprmqrfUj929Gleae6hG7goKOVzKvRnuoZH7PlX/TQnU6bP
         +LeTigPyMNz43aQMnqxfEhtWOkStA7Hu10ob1ex3x7l6ZTJ607xBX7BBKncq6hidfcXH
         XsOw==
X-Forwarded-Encrypted: i=1; AJvYcCVeii9viZBQ0YDnwW+q9KlxTCE0Gs13PmnJ6WS81QBDNZeBgF203WB6uUNzth0pbZBtkQTVepxnDa56b5BSpHX5n1bDMldiLVK0lkaG1vMC
X-Gm-Message-State: AOJu0YzhAd4PvbDChfCK822ue0PxrkLvCQqx1IUCVCXvTZMN2mtc2M7u
	LWBZvegzhIU9dzM+5Cbb4yR3RJKCscJFs1mXu3UJE1lC286/vrjOi1NodA==
X-Google-Smtp-Source: AGHT+IGIpDK+5l1pOBqxSTbu5RXhVnRRTj7qY0kUqhKO5nZFTvAVOuXt218rO0f93zLDT9dYvs1FZg==
X-Received: by 2002:a05:620a:22f0:b0:790:6543:adfa with SMTP id p16-20020a05620a22f000b007906543adfamr3378797qki.78.1714589677696;
        Wed, 01 May 2024 11:54:37 -0700 (PDT)
Received: from willemb.c.googlers.com.com (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id pa2-20020a05620a830200b0078ede2e9125sm12426459qkn.57.2024.05.01.11.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 11:54:37 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests: drv-net: add checksum tests
Date: Wed,  1 May 2024 14:51:34 -0400
Message-ID: <20240501185432.3593168-1-willemdebruijn.kernel@gmail.com>
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
It saves a lot of boilerplate, but is a little harder to follow, so
partially here as a point for discussion.

Also detect hardware offload feature availability using Ethtool
netlink and skip tests when either feature is off. This need may be
common for offload feature tests and eventually deserving of a thin
wrapper in lib.py.

Missing are the PF_PACKET based send tests ('-P'). These use
virtio_net_hdr to program hardware checksum offload. Which requires
looking up the local MAC address and (harder) the MAC of the next hop.
I'll have to give it some though how to do that robustly and where
that code would belong.

Tested on Google cloud:

        make -C tools/testing/selftests/ \
                TARGETS="drivers/net drivers/net/hw net" \
                install INSTALL_PATH=/tmp/ksft
        cd /tmp/ksft

	sudo NETIF=ens4 REMOTE_TYPE=ssh \
		REMOTE_ARGS="root@10.40.0.2" \
		LOCAL_V4="10.40.0.1"
		REMOTE_V4="10.40.0.2" \
		LOCAL_V6="<REDACTED>" \
		REMOTE_V6="<REDACTED>" \
		./run_kselftest.sh -t drivers/net/hw:csum.py

	TAP version 13
	1..1
	# timeout set to 0
	# selftests: drivers/net/hw: csum.py
	# KTAP version 1
	# 1..12
	# ok 1 csum.ipv4_rx_tcp
	# ok 2 csum.ipv4_rx_tcp_invalid
	# ok 3 csum.ipv4_rx_udp
	# ok 4 csum.ipv4_rx_udp_invalid
	# ok 5 csum.ipv4_tx_udp_csum_offload
	# ok 6 csum.ipv4_tx_udp_zero_checksum
	# ok 7 csum.ipv6_rx_tcp
	# ok 8 csum.ipv6_rx_tcp_invalid
	# ok 9 csum.ipv6_rx_udp
	# ok 10 csum.ipv6_rx_udp_invalid
	# ok 11 csum.ipv6_tx_udp_csum_offload
	# ok 12 csum.ipv6_tx_udp_zero_checksum
	# # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
	ok 1 selftests: drivers/net/hw: csum.py

Warning that for now transmit errors are not detected, as for those
the receiver runs remotely and failures with bkg are ignored.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../testing/selftests/drivers/net/hw/csum.py  | 114 ++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/csum.py

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
index 000000000000..e40c510f303d
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
+        cfg.bin_local = path.abspath(path.dirname(__file__) + "/../../../net/csum")
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
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


