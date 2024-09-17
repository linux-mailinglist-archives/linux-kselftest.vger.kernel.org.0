Return-Path: <linux-kselftest+bounces-18072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9362C97AE03
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 11:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DF92839AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 09:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CF4169AC5;
	Tue, 17 Sep 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VnMaUcMk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7C71607B2;
	Tue, 17 Sep 2024 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565614; cv=none; b=hyrxvCAZUpGPbpeq3MOTSr/p5EgA5IS42PGT10MAar4wf9tY4MVLG/uXXk3s0AhDr/jeDXD1265PlM70ICiTA4IkelAen3VzwSKnDckE9b67b34seZVHZORrdeqAkKc6Ys7kGKpVjsfBYIg+J6DVzQT9evL63bbR7i5os9+136Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565614; c=relaxed/simple;
	bh=Ik0q+kG52pUEBG7O9vwZrn8AEHRBYvpH8IPG2Z0C/zk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WC6HYyjNMrC0C9rmg/ywccLL1PI2LVg5+b5NqUyOKJ3I3ab80vCMy4RRvyHutfJbbM24zQ7cE0rKRmaYep7ZhzDJxn0ULrFl0lIXw8QMrbT7dL3wpe0zS1gm46TIqmaK/kntuyDd5CHpa5gIBiPFA2PfV0zxcln8ppvlVd8O1Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VnMaUcMk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726565602; x=1758101602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ik0q+kG52pUEBG7O9vwZrn8AEHRBYvpH8IPG2Z0C/zk=;
  b=VnMaUcMkKWBwMpKwXi/0V1RnifJPzprJldXp24LXSQN+X4JlxL1jjj67
   AgFpk42IztDgNW8rhy4KznB5HsuXR2mgLZ1d+UVbpJKDeooIG4iu1lzlD
   OedgSH954nhfP6+t+7zerMayXuPVxwgtMMrkJ9uBbMVUD5LkC4JnZFjNi
   uahBUpLctgUvfLVfwuT+0L/cxwiRT0Q5tzsSX3wcc007ZD67nkYysH80s
   2zq5KTujJvdfuZURgwpPUNeo/LWodQhxi4K/eIEfat+69w3ryoh5qq8u9
   bRIbJRyNQF5bHfPxC8jyypRNYXCFSSxUJH+K/R3VtbHXgYiVCCU/RXtRb
   Q==;
X-CSE-ConnectionGUID: 6j7NM/cARrCart7pGaXQPQ==
X-CSE-MsgGUID: +9XrsLtvTXyQpsiwuE1qgg==
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="31767006"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2024 02:33:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 17 Sep 2024 02:32:57 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 17 Sep 2024 02:32:52 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<mohan.prasad@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<willemb@google.com>
Subject: [PATCH net-next v2 3/3] selftests: nic_basic_tests: Add selftest case for throughput check
Date: Tue, 17 Sep 2024 08:04:09 +0530
Message-ID: <20240917023525.2571082-4-mohan.prasad@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240917023525.2571082-1-mohan.prasad@microchip.com>
References: <20240917023525.2571082-1-mohan.prasad@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add selftest case to check the send and receive throughput.
Supported link modes between local NIC driver and partner
are varied. Then send and receive throughput is captured
and verified. Test uses iperf3 tool.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
 .../drivers/net/hw/nic_basic_tests.py         | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py b/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py
index ff46f2406..ec1f5b6a2 100644
--- a/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py
+++ b/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py
@@ -182,6 +182,45 @@ def test_network_speed(cfg) -> None:
         else:
             KsftSkipEx("Mismatch in the number of speeds and duplex modes")
 
+def test_tcp_throughput(cfg) -> None:
+    check_autonegotiation(cfg.ifname)
+    if not common_link_modes:
+        KsftSkipEx("No common link modes found")
+    cfg.require_cmd("iperf3", remote=True)
+    """iperf3 server to be run in the partner pc"""
+    speeds, duplex_modes = get_speed_duplex(common_link_modes)
+    """Test duration in seconds"""
+    duration = test_duration
+    target_ip = cfg.remote_addr
+
+    for idx in range(len(speeds)-1, -1, -1):
+        set_speed_and_duplex(cfg.ifname, speeds[idx], duplex_modes[idx])
+        time.sleep(sleep_time)
+        verify_link_up(cfg.ifname)
+        send_command=f"iperf3 -c {target_ip} -t {duration} --json"
+        receive_command=f"iperf3 -c {target_ip} -t {duration} --reverse --json"
+        send_result = cmd(send_command)
+        receive_result = cmd(receive_command)
+        if send_result.ret != 0 or receive_result.ret != 0:
+            raise KsftSkipEx("No server is running")
+
+        send_output = send_result.stdout
+        receive_output = receive_result.stdout
+
+        send_data = json.loads(send_output)
+        receive_data = json.loads(receive_output)
+        """Convert throughput to Mbps"""
+        send_throughput = round(send_data['end']['sum_sent']['bits_per_second'] / 1e6, 2)
+        receive_throughput = round(receive_data['end']['sum_received']['bits_per_second'] / 1e6, 2)
+
+        ksft_pr(f"Send throughput: {send_throughput} Mbps, Receive throughput: {receive_throughput} Mbps")
+        """Check whether throughput is not below the threshold (default:80% of set speed)"""
+        threshold = float(speeds[idx]) * float(throughput_threshold)
+        if send_throughput < threshold:
+            raise KsftFailEx("Send throughput is below threshold")
+        elif receive_throughput < threshold:
+            raise KsftFailEx("Receive throughput is below threshold")
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg,))
-- 
2.43.0


