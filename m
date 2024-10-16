Return-Path: <linux-kselftest+bounces-19915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA569A19E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 06:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B312873A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 04:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6557917E01A;
	Thu, 17 Oct 2024 04:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y9EDVH5S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D01791EB;
	Thu, 17 Oct 2024 04:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140482; cv=none; b=XeewoW5kvP5BxgS6UEHSDvMPsGqnttz/m0rXsKmGKjkHE1dWRJCMHSYcPOafcGDwfUjQYUJbdoGqJRdEH9scoGDnfPsyLSvqslQ+VLDAhDEAuQo8KbHxmmsffJpYJ5eiz2eMXnINoBYXODNUlaKivYnCEj8IvtbSzQntsIyMKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140482; c=relaxed/simple;
	bh=hGoy1m3iAmRAPhSfvDXhU4J22za0qmzPoPvGb1PP6Ek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/nic+XFrVd/O/YoOvGKdqRFQP8EE5cw8OoyjPHfn4DAFB/piJ01BUZL1ymiWqWwSUo9XllPSKN40dx1OdHHWQ3MB9SxYsdGOK++ENqyOsFW5HjhG5aNXVgOHFJznDzwhgLu/oSIMFon3qUu36XjCqja7b25bxmhu2ckM9gFMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y9EDVH5S; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729140479; x=1760676479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hGoy1m3iAmRAPhSfvDXhU4J22za0qmzPoPvGb1PP6Ek=;
  b=Y9EDVH5Sj/hXkAiJEpVHr1TlbdlUYxpBgOKiwDou3dzmVTt3ZkTseHFi
   7EXVWn1zIjbi1IxGEP2d6Z1lFInGywj8oihGohodwma5sGelhB8xD1tsM
   lUf/OKHE2P1jmr+78muUx1UCcNxzoWgXV9vfPBs5JiOTiuTplPlV94d+7
   T5AeiqQ7LHE4A/vcm6XopmmLmt694lOP8MzkD70kHVltROF4qOAfdfWJ3
   mc32mllk5ZRp9TuTVx6f/RMl7552pzkd/u0ptLYSLzFRcrhEa9k7ZOpNb
   Mzwyaqm3+Kxk/m+ga/YyeDv3/8xp/IGb2qak7A0sHwmvd8SmjvH0Q7B+t
   A==;
X-CSE-ConnectionGUID: 8pbTCNeqT7aHxiJ1HBLGWw==
X-CSE-MsgGUID: JcJNttygRZG6oNzePtkFsw==
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="200553968"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2024 21:47:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 16 Oct 2024 21:47:41 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 16 Oct 2024 21:47:36 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<mohan.prasad@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<willemb@google.com>, <petrm@nvidia.com>
Subject: [PATCH net-next v3 3/3] selftests: nic_performance: Add selftest for performance of NIC driver
Date: Thu, 17 Oct 2024 03:20:07 +0530
Message-ID: <20241016215014.401476-4-mohan.prasad@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016215014.401476-1-mohan.prasad@microchip.com>
References: <20241016215014.401476-1-mohan.prasad@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Add selftest case to check the send and receive throughput.
Supported link modes between local NIC driver and partner
are varied. Then send and receive throughput is captured
and verified. Test uses iperf3 tool.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/nic_performance.py         | 121 ++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nic_performance.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 0dac40c4e..289512092 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -11,6 +11,7 @@ TEST_PROGS = \
 	hw_stats_l3_gre.sh \
 	loopback.sh \
 	nic_link_layer.py \
+	nic_performance.py \
 	pp_alloc_fail.py \
 	rss_ctx.py \
 	#
diff --git a/tools/testing/selftests/drivers/net/hw/nic_performance.py b/tools/testing/selftests/drivers/net/hw/nic_performance.py
new file mode 100644
index 000000000..152c62511
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nic_performance.py
@@ -0,0 +1,121 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+#Introduction:
+#This file has basic performance test for generic NIC drivers.
+#The test comprises of throughput check for TCP and UDP streams.
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
+#To prevent interruptions, Add ethtool, ip to the sudoers list in remote PC and get the ssh key from remote.
+#Required minimum ethtool version is 6.10
+#Change the below configuration based on your hw needs.
+# """Default values"""
+time_delay = 8 #time taken to wait for transitions to happen, in seconds.
+test_duration = 10  #performance test duration for the throughput check, in seconds.
+send_throughput_threshold = 80 #percentage of send throughput required to pass the check
+receive_throughput_threshold = 50 #percentage of receive throughput required to pass the check
+
+import time
+import json
+from lib.py import ksft_run, ksft_exit, ksft_pr, ksft_true
+from lib.py import KsftFailEx, KsftSkipEx
+from lib.py import NetDrvEpEnv
+from lib.py import cmd
+from lib.py import LinkConfig
+
+def verify_throughput(cfg, link_config) -> None:
+    protocols = ["TCP", "UDP"]
+    common_link_modes = link_config.common_link_modes
+    speeds, duplex_modes = link_config.get_speed_duplex_values(common_link_modes)
+    """Test duration in seconds"""
+    duration = test_duration
+    target_ip = cfg.remote_addr
+
+    for protocol in protocols:
+        ksft_pr(f"{protocol} test")
+        test_type = "-u" if protocol == "UDP" else ""
+        send_throughput = []
+        receive_throughput = []
+        for idx in range(0, len(speeds)):
+            bit_rate = f"-b {speeds[idx]}M" if protocol == "UDP" else ""
+            if link_config.set_speed_and_duplex(speeds[idx], duplex_modes[idx]) == False:
+                raise KsftFailEx(f"Not able to set speed and duplex parameters for {cfg.ifname}")
+            time.sleep(time_delay)
+            if link_config.verify_link_up() == False:
+                raise KsftSkipEx(f"Link state of interface {cfg.ifname} is DOWN")
+            send_command=f"iperf3 {test_type} -c {target_ip} {bit_rate} -t {duration} --json"
+            receive_command=f"iperf3 {test_type} -c {target_ip} {bit_rate} -t {duration} --reverse --json"
+            send_result = cmd(send_command)
+            receive_result = cmd(receive_command)
+            if send_result.ret != 0 or receive_result.ret != 0:
+                raise KsftSkipEx("Unexpected error occurred during transmit/receive")
+
+            send_output = send_result.stdout
+            receive_output = receive_result.stdout
+
+            send_data = json.loads(send_output)
+            receive_data = json.loads(receive_output)
+            """Convert throughput to Mbps"""
+            send_throughput.append(round(send_data['end']['sum_sent']['bits_per_second'] / 1e6, 2))
+            receive_throughput.append(round(receive_data['end']['sum_received']['bits_per_second'] / 1e6, 2))
+
+            ksft_pr(f"{protocol}: Send throughput: {send_throughput[idx]} Mbps, Receive throughput: {receive_throughput[idx]} Mbps")
+
+        """Check whether throughput is not below the threshold (default values set at start)"""
+        for idx in range(0, len(speeds)):
+            send_threshold = float(speeds[idx]) * float(send_throughput_threshold / 100)
+            receive_threshold = float(speeds[idx]) * float(receive_throughput_threshold / 100)
+            ksft_true(send_throughput[idx] >= send_threshold, f"{protocol}: Send throughput is below threshold for {speeds[idx]} Mbps in {duplex_modes[idx]} duplex")
+            ksft_true(receive_throughput[idx] >= receive_threshold, f"{protocol}: Receive throughput is below threshold for {speeds[idx]} Mbps in {duplex_modes[idx]} duplex")
+
+def test_throughput(cfg, link_config) -> None:
+    common_link_modes = link_config.common_link_modes
+    if not common_link_modes:
+        KsftSkipEx("No common link modes found")
+    if link_config.partner_netif == None:
+        KsftSkipEx("Partner interface name not available")
+    if link_config.check_autoneg_supported() and link_config.check_autoneg_supported(remote=True):
+        KsftSkipEx("Auto-negotiation not supported by local or remote")
+    cfg.require_cmd("iperf3", remote=True)
+    try:
+        """iperf3 server to be run in the remote pc"""
+        command = "iperf3 -s -D"
+        process = cmd(command, host=cfg.remote)
+        if "Address already in use" in process.stdout:
+            ksft_pr("Iperf server already running in remote")
+        elif process.ret != 0:
+            raise KsftSkipEx("Unable to start server in remote PC")
+        verify_throughput(cfg, link_config)
+    except Exception as e:
+        raise KsftSkipEx(f"Unexpected error occurred: {e}")
+    finally:
+        """Kill existing iperf server in remote pc"""
+        try:
+            cmd("pkill iperf3", host=cfg.remote)
+        except Exception as e:
+            ksft_pr("Unable to stop iperf3 server in remote")
+
+def main() -> None:
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        link_config = LinkConfig(cfg)
+        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, link_config,))
+        link_config.reset_interface()
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0


