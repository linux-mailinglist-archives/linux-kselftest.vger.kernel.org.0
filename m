Return-Path: <linux-kselftest+bounces-18070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDECB97ADF4
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 11:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58EC71F24534
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F33160783;
	Tue, 17 Sep 2024 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="quDrHUcW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFD215A876;
	Tue, 17 Sep 2024 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565602; cv=none; b=Xi8AHrPTgRuIdvKR8Ws49isOTObNf0m2+BrFH9FSQ3gD90zGWptsQZCP+Z3WJtBDXfdqXJu4tk6I4eVWRr/4ubBt/GdWVCc+Zvg8OTxRzGaFkIPxmh1mDRR9mVpfb39DezNXEBD1aOy0XB1u9Fz8OhOFdUZu8ejOOf8eQnpm43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565602; c=relaxed/simple;
	bh=xKBsIof4E7wOEeiJl0o4Yk5WPvDZIHOhRWJAelVvQSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+TesFAnJ2MKr8UjFZ+g83gVeqUZ1HHAyMjMp7UblilaYd3U8pnYdSztlywrpknlrn+/FgSZuEF2B8XQA7852pmVmJ1nOHVfOt48D5Y/W7oaM9Y1v3D3KRuz1RvO4o9op9jVx5EyeqC83WrrlPUjylalL832Vt/cZzBiXfm8H9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=quDrHUcW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726565600; x=1758101600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xKBsIof4E7wOEeiJl0o4Yk5WPvDZIHOhRWJAelVvQSE=;
  b=quDrHUcWd9PkgZsSv1qBS9KoQiTW+Ir3wcKTm1rxOUCHH8rwkSHDqEZE
   maV7mPNmccmyVCyOBpouqGhyKOXee1Cdo5OCHCj/TwpIwbmeLYKNA3Vjx
   56ki7P66kt8vgoe6awPDbNthEl3LLS5ITEQuMeuaRz8KtzSaESpPy7TGk
   OyCqR51E3PtVKBU4s0YDjEKXFEMJcIMIDer+Epx8bju4vsO40NWnbthbX
   VdprHFa1LdSgpOg+1Wz4zfqEbL2lf1pi5POBMfE10x3zEcjshYDOjjsmA
   Ylu5kBkn29N5B8vEAw6KB6VfJ0l1BoVPrRtXDOUiYOkov22G6HJCoGZr/
   A==;
X-CSE-ConnectionGUID: 6j7NM/cARrCart7pGaXQPQ==
X-CSE-MsgGUID: vxRNJkEsSQqZIXY2FA4zOA==
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="31767004"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2024 02:33:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 17 Sep 2024 02:32:44 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 17 Sep 2024 02:32:40 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<mohan.prasad@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<willemb@google.com>
Subject: [PATCH net-next v2 1/3] selftests: nic_basic_tests: Add selftest file for basic tests of NIC
Date: Tue, 17 Sep 2024 08:04:07 +0530
Message-ID: <20240917023525.2571082-2-mohan.prasad@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240917023525.2571082-1-mohan.prasad@microchip.com>
References: <20240917023525.2571082-1-mohan.prasad@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Add selftest file to test basic features of a NIC driver.
Tests for link modes, auto-negotiation are placed.
Selftest makes use of ksft modules and ethtool.
Add selftest file in the Makefile.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/nic_basic_tests.py         | 145 ++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nic_basic_tests.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index c9f2f48fc..9f105227c 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -10,6 +10,7 @@ TEST_PROGS = \
 	hw_stats_l3.sh \
 	hw_stats_l3_gre.sh \
 	loopback.sh \
+	nic_basic_tests.py \
 	pp_alloc_fail.py \
 	rss_ctx.py \
 	#
diff --git a/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py b/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py
new file mode 100644
index 000000000..27f780032
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py
@@ -0,0 +1,145 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+#Introduction:
+#This file has basic tests for generic NIC drivers.
+#The test comprises of auto-negotiation, speed and duplex checks.
+#Also has tests to check the throughput
+#
+#Setup:
+#Connect the DUT PC with NIC card to partner pc back via ethernet medium of your choice(RJ45, T1)
+#
+#        DUT PC                                              Partner PC
+#┌───────────────────────┐                         ┌──────────────────────────┐
+#│                       │                         │                          │
+#│                       │                         │                          │
+#│           ┌───────────┐                         │                          │
+#│           │DUT NIC    │         Eth             │                          │
+#│           │Interface ─┼─────────────────────────┼─    any eth Interface    │
+#│           └───────────┘                         │                          │
+#│                       │                         │                          │
+#│                       │                         │                          │
+#└───────────────────────┘                         └──────────────────────────┘
+#
+#Configurations:
+# Change the below configuration based on your hw needs.
+# """Default values"""
+sleep_time = 5 #time taken to wait for transitions to happen, in seconds.
+test_duration = 5  #performance test duration for the throughput check, in seconds.
+throughput_threshold = 0.8 #percentage of throughput required to pass the throughput
+
+import time
+import os
+import re
+import configparser
+import json
+from lib.py import ksft_run, ksft_exit, ksft_pr, ksft_eq
+from lib.py import KsftFailEx, KsftSkipEx
+from lib.py import NetDrvEpEnv
+from lib.py import cmd
+from lib.py import ethtool
+
+"""Global variables"""
+common_link_modes = []
+
+def get_ethtool_content(ifname: str, field: str):
+    capture = False
+    content = []
+
+    """Get the ethtool content for the interface"""
+    process = ethtool(f"{ifname}")
+    if process.ret != 0:
+        raise KsftSkipEx(f"Error while getting the ethtool content for interface {ifname}")
+    lines = process.stdout.splitlines()
+
+    """Retrieve the content of the field"""
+    for line in lines:
+        if field in line:
+            capture = True
+            data = line.split(":")[1].strip()
+            content.extend(data.split())
+            continue
+
+        if capture:
+            if ":" in line:
+                break;
+            if line.strip():
+                content.extend(line.strip().split())
+    if capture == False:
+        raise KsftSkipEx(f"Field \"{field}\" not found in ethtool output")
+    return content
+
+def get_speed_duplex(content):
+    speed = []
+    duplex = []
+    """Check the link modes"""
+    for data in content:
+        parts = data.split('/')
+        speed_value = re.match(r'\d+', parts[0])
+        if speed_value:
+            speed.append(speed_value.group())
+        else:
+            raise KsftSkipEx(f"No speed value found for interface {ifname}")
+        duplex.append(parts[1].lower())
+    return speed, duplex
+
+def verify_link_up(ifname: str) -> None:
+    """Verify whether the link is up"""
+    with open(f"/sys/class/net/{ifname}/operstate", "r") as fp:
+        link_state = fp.read().strip()
+
+    if link_state == "down":
+        raise KsftSkipEx(f"Link state of interface {ifname} is DOWN")
+
+def set_autonegotiation_state(ifname: str, state: str) -> None:
+    content = get_ethtool_content(ifname, "Supported link modes:")
+    speeds, duplex_modes = get_speed_duplex(content)
+    speed = speeds[0]
+    duplex = duplex_modes[0]
+    if not speed or not duplex:
+        KsftSkipEx("No speed or duplex modes found")
+    """Set the autonegotiation state for the interface"""
+    process = ethtool(f"-s {ifname} speed {speed} duplex {duplex} autoneg {state}")
+    if process.ret != 0:
+        raise KsftFailEx(f"Not able to set autoneg parameter for {ifname}")
+    ksft_pr(f"Autoneg set as {state} for {ifname}")
+
+def verify_autonegotiation(ifname: str, expected_state: str) -> None:
+    verify_link_up(ifname)
+    """Verifying the autonegotiation state"""
+    output = get_ethtool_content(ifname, "Auto-negotiation:")
+    actual_state = output[0]
+
+    ksft_eq(actual_state, expected_state)
+
+def test_link_modes(cfg) -> None:
+    global common_link_modes
+    link_modes = get_ethtool_content(cfg.ifname, "Supported link modes:")
+    partner_link_modes = get_ethtool_content(cfg.ifname, "Link partner advertised link modes:")
+
+    if link_modes and partner_link_modes:
+        for idx1 in range(len(link_modes)):
+            for idx2 in range(len(partner_link_modes)):
+                if link_modes[idx1] == partner_link_modes[idx2]:
+                    common_link_modes.append(link_modes[idx1])
+                    break
+    else:
+        raise KsftFailEx("No link modes available")
+
+def test_autonegotiation(cfg) -> None:
+    autoneg = get_ethtool_content(cfg.ifname, "Supports auto-negotiation:")
+    if autoneg[0] == "Yes":
+        for state in ["off", "on"]:
+            set_autonegotiation_state(cfg.ifname, state)
+            time.sleep(sleep_time)
+            verify_autonegotiation(cfg.ifname, state)
+    else:
+        raise KsftSkipEx(f"Auto-Negotiation is not supported for interface {cfg.ifname}")
+
+def main() -> None:
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg,))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0


