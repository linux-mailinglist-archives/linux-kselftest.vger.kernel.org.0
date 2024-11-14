Return-Path: <linux-kselftest+bounces-22079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341F59CD55F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 03:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BFA282B22
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 02:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E5D1553AA;
	Fri, 15 Nov 2024 02:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VK7hJ5zq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201A21442F4;
	Fri, 15 Nov 2024 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637559; cv=none; b=GEzqOgIcX4UsM46GLUJJtv4ChLBZx5Le1SN0cp5Y4+Jl7RoN0e91rVzowEyubxgo1t8CklVigiFcyPaWs5mz/4CIEstLiGP8tGAv4+6PWwaStmZxsHmVkNPxQULNnrN9eBn8+X36TbrSj9TWGz4XDv06fZD6U8CbBVZZZZ+HRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637559; c=relaxed/simple;
	bh=Q/FqzVI86T2PL06lpAwTVGipB5NTfw5oUN3fUT9Pudo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QX3vhoKhiAqHFz8MfZ8uF9sayOhVZ9K3itWqm1tdSFgNXIHewXQeAgLPosGCGdYVDLzp7cwGxKHEizr50bZKA1vR/kcsyqYDHrqDGh1G2mueGriTu7IghV7uW3KyBnWQ7UIdsel5muKMASGXK6urcEvO0tZ/dAePfpRc3K+yeeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VK7hJ5zq; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731637557; x=1763173557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q/FqzVI86T2PL06lpAwTVGipB5NTfw5oUN3fUT9Pudo=;
  b=VK7hJ5zqXCTMngsMd7qlpbMIxU/vxs3NOJ4x/S/UtWA6N4Huqx9tLJ+p
   jM1oSc2x+TbRXZDhZEnWB/FwsbkFZyh7zEdEkt4Ic3z8WAfznEk8yGjEK
   x1NQGP7XHtk/XmzX7s7fZtPWeHsv3hNrEWX142vxkueQI6Kwt71H+fHJK
   WSWJTCPAEfCQ9xPSdz/I7aqoEK/Cq1tPP+e8DvJhQ8eOUSQ3RqyrcwcRf
   8TmeHNf6dC/tR/c5Iw6bqAaQoTKdAva6GSuinazKw8SHtjIeXrC1+uLu6
   s/DyJXGJVMFpkrncOWV+DhPzpHX+NEOoQcRSo6bQyVq5KIbzxRBm1ikCZ
   A==;
X-CSE-ConnectionGUID: QjuG0j+zR8eJOiYtRT/ezA==
X-CSE-MsgGUID: f9zCoi30QROEMbR52xbuZA==
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="34078315"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2024 19:23:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Nov 2024 19:23:38 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 14 Nov 2024 19:23:33 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<mohan.prasad@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<willemb@google.com>, <petrm@nvidia.com>
Subject: [PATCH net-next v4 3/3] selftests: nic_performance: Add selftest for performance of NIC driver
Date: Fri, 15 Nov 2024 00:55:20 +0530
Message-ID: <20241114192545.1742514-4-mohan.prasad@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114192545.1742514-1-mohan.prasad@microchip.com>
References: <20241114192545.1742514-1-mohan.prasad@microchip.com>
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
Add iperf3 server/client function in GenerateTraffic class.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/nic_performance.py         | 137 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/load.py      |  20 ++-
 3 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nic_performance.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 7939f81fe..e400fd097 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -12,6 +12,7 @@ TEST_PROGS = \
 	hw_stats_l3_gre.sh \
 	loopback.sh \
 	nic_link_layer.py \
+	nic_performance.py \
 	pp_alloc_fail.py \
 	rss_ctx.py \
 	#
diff --git a/tools/testing/selftests/drivers/net/hw/nic_performance.py b/tools/testing/selftests/drivers/net/hw/nic_performance.py
new file mode 100644
index 000000000..201403b76
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nic_performance.py
@@ -0,0 +1,137 @@
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
+#time_delay = 8 #time taken to wait for transitions to happen, in seconds.
+#test_duration = 10  #performance test duration for the throughput check, in seconds.
+#send_throughput_threshold = 80 #percentage of send throughput required to pass the check
+#receive_throughput_threshold = 50 #percentage of receive throughput required to pass the check
+
+import time
+import json
+import argparse
+from lib.py import ksft_run, ksft_exit, ksft_pr, ksft_true
+from lib.py import KsftFailEx, KsftSkipEx, GenerateTraffic
+from lib.py import NetDrvEpEnv, bkg, wait_port_listen
+from lib.py import cmd
+from lib.py import LinkConfig
+
+class TestConfig:
+    def __init__(self, time_delay: int, test_duration: int, send_throughput_threshold: int, receive_throughput_threshold: int) -> None:
+        self.time_delay = time_delay
+        self.test_duration = test_duration
+        self.send_throughput_threshold = send_throughput_threshold
+        self.receive_throughput_threshold = receive_throughput_threshold
+
+def _pre_test_checks(cfg: object, link_config: LinkConfig) -> None:
+    if not link_config.verify_link_up():
+        KsftSkipEx(f"Link state of interface {cfg.ifname} is DOWN")
+    common_link_modes = link_config.common_link_modes
+    if common_link_modes is None:
+        KsftSkipEx("No common link modes found")
+    if link_config.partner_netif == None:
+        KsftSkipEx("Partner interface is not available")
+    if link_config.check_autoneg_supported():
+        KsftSkipEx("Auto-negotiation not supported by local")
+    if link_config.check_autoneg_supported(remote=True):
+        KsftSkipEx("Auto-negotiation not supported by remote")
+    cfg.require_cmd("iperf3", remote=True)
+
+def check_throughput(cfg: object, link_config: LinkConfig, test_config: TestConfig, protocol: str, traffic: GenerateTraffic) -> None:
+    common_link_modes = link_config.common_link_modes
+    speeds, duplex_modes = link_config.get_speed_duplex_values(common_link_modes)
+    """Test duration in seconds"""
+    duration = test_config.test_duration
+
+    ksft_pr(f"{protocol} test")
+    test_type = "-u" if protocol == "UDP" else ""
+
+    send_throughput = []
+    receive_throughput = []
+    for idx in range(0, len(speeds)):
+        if link_config.set_speed_and_duplex(speeds[idx], duplex_modes[idx]) == False:
+            raise KsftFailEx(f"Not able to set speed and duplex parameters for {cfg.ifname}")
+        time.sleep(test_config.time_delay)
+        if not link_config.verify_link_up():
+            raise KsftSkipEx(f"Link state of interface {cfg.ifname} is DOWN")
+
+        send_command=f"{test_type} -b 0 -t {duration} --json"
+        receive_command=f"{test_type} -b 0 -t {duration} --reverse --json"
+
+        send_result = traffic.run_remote_test(cfg, command=send_command)
+        if send_result.ret != 0:
+            raise KsftSkipEx("Error occurred during data transmit: {send_result.stdout}")
+
+        send_output = send_result.stdout
+        send_data = json.loads(send_output)
+
+        """Convert throughput to Mbps"""
+        send_throughput.append(round(send_data['end']['sum_sent']['bits_per_second'] / 1e6, 2))
+        ksft_pr(f"{protocol}: Send throughput: {send_throughput[idx]} Mbps")
+
+        receive_result = traffic.run_remote_test(cfg, command=receive_command)
+        if receive_result.ret != 0:
+            raise KsftSkipEx("Error occurred during data receive: {receive_result.stdout}")
+
+        receive_output = receive_result.stdout
+        receive_data = json.loads(receive_output)
+
+        """Convert throughput to Mbps"""
+        receive_throughput.append(round(receive_data['end']['sum_received']['bits_per_second'] / 1e6, 2))
+        ksft_pr(f"{protocol}: Receive throughput: {receive_throughput[idx]} Mbps")
+
+    """Check whether throughput is not below the threshold (default values set at start)"""
+    for idx in range(0, len(speeds)):
+        send_threshold = float(speeds[idx]) * float(test_config.send_throughput_threshold / 100)
+        receive_threshold = float(speeds[idx]) * float(test_config.receive_throughput_threshold / 100)
+        ksft_true(send_throughput[idx] >= send_threshold, f"{protocol}: Send throughput is below threshold for {speeds[idx]} Mbps in {duplex_modes[idx]} duplex")
+        ksft_true(receive_throughput[idx] >= receive_threshold, f"{protocol}: Receive throughput is below threshold for {speeds[idx]} Mbps in {duplex_modes[idx]} duplex")
+
+def test_tcp_throughput(cfg: object, link_config: LinkConfig, test_config: TestConfig, traffic: GenerateTraffic) -> None:
+    _pre_test_checks(cfg, link_config)
+    check_throughput(cfg, link_config, test_config, 'TCP', traffic)
+
+def test_udp_throughput(cfg: object, link_config: LinkConfig, test_config: TestConfig, traffic: GenerateTraffic) -> None:
+    _pre_test_checks(cfg, link_config)
+    check_throughput(cfg, link_config, test_config, 'UDP', traffic)
+
+def main() -> None:
+    parser = argparse.ArgumentParser(description="Run basic performance test for NIC driver")
+    parser.add_argument('--time-delay', type=int, default=8, help='Time taken to wait for transitions to happen(in seconds). Default is 8 seconds.')
+    parser.add_argument('--test-duration', type=int, default=10, help='Performance test duration for the throughput check, in seconds. Default is 10 seconds.')
+    parser.add_argument('--stt', type=int, default=80, help='Send throughput Threshold: Percentage of send throughput upon actual throughput required to pass the throughput check (in percentage). Default is 80.')
+    parser.add_argument('--rtt', type=int, default=50, help='Receive throughput Threshold: Percentage of receive throughput upon actual throughput required to pass the throughput check (in percentage). Default is 50.')
+    args=parser.parse_args()
+    test_config = TestConfig(args.time_delay, args.test_duration, args.stt, args.rtt)
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        traffic = GenerateTraffic(cfg)
+        link_config = LinkConfig(cfg)
+        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, link_config, test_config, traffic,  ))
+        link_config.reset_interface()
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index d9c10613a..da5af2c68 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -2,7 +2,7 @@
 
 import time
 
-from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
+from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen, bkg
 
 class GenerateTraffic:
     def __init__(self, env, port=None):
@@ -23,6 +23,24 @@ class GenerateTraffic:
             self.stop(verbose=True)
             raise Exception("iperf3 traffic did not ramp up")
 
+    def run_remote_test(self, env: object, port=None, command=None):
+        if port is None:
+            port = rand_port()
+        try:
+            server_cmd = f"iperf3 -s 1 -p {port} --one-off"
+            with bkg(server_cmd, host=env.remote):
+                #iperf3 opens TCP connection as default in server
+                #-u to be specified in client command for UDP
+                wait_port_listen(port, host=env.remote)
+        except Exception as e:
+            raise Exception(f"Unexpected error occurred while running server command: {e}")
+        try:
+            client_cmd = f"iperf3 -c {env.remote_addr} -p {port} {command}"
+            proc = cmd(client_cmd)
+            return proc
+        except Exception as e:
+            raise Exception(f"Unexpected error occurred while running client command: {e}")
+
     def _wait_pkts(self, pkt_cnt=None, pps=None):
         """
         Wait until we've seen pkt_cnt or until traffic ramps up to pps.
-- 
2.43.0


