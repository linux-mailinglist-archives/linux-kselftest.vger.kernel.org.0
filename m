Return-Path: <linux-kselftest+bounces-17104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261B296B061
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 07:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3ECA285600
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 05:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24018126C11;
	Wed,  4 Sep 2024 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vjjo8xqP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92F84A32;
	Wed,  4 Sep 2024 05:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426885; cv=none; b=ey6vLWyY6PPulnBnSAYHR/TGZiNi32qHLjmm83Mv+co+TDboPkWCiPSdwjlLkwrKrTcd8bwJeOejZHC8cNeKwNWbN1iM6dq5kdJ944zSaQaTE2taODmypVIW683KuS67b+VwWcfjvI5mtd90pkmPpHug7DosnjNWC74iy+dMHKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426885; c=relaxed/simple;
	bh=JlZSM40ifyeZNoN07U6vpgyOTY7VOt2WsqMUA0RUAzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=knAWIzTrOfMPpZUntjioJZS0b0Ev1+mzPuNZ3Y+ruZllQyQAaOCGPJoQXj229nHd3IBoTivDEAyx0M+a3bcLk8ZSMI98OVE/8MFd3pexu1OLYoT5D0++9gtjf3tKo3d3mryFFyEtKanSXd1RS0mvwrYjOuiNxD1EHfAAg3CB2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vjjo8xqP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725426884; x=1756962884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JlZSM40ifyeZNoN07U6vpgyOTY7VOt2WsqMUA0RUAzQ=;
  b=vjjo8xqPp7IBde3Bj/NCJN7W0goDpviVEK30WojDmTPdAjoFVEUmBG1S
   XO85J6yNlePf7apamrzKi0Di6rkzCs5xFyws+vzAuPIca9FPFFkDqeWHp
   CwbxxXwIjSAQvH1uHiUicGWImBqT9LXuQKCiyykvSZxk/7uYuq8srfHS6
   Jvx2NRTBH9c9Saf7qQ48p7MyfvfjNK1GoAMYS+I4CW6J1G6AH0zZCv6n8
   UdXh07lCaWcyruFa1pCMLhc9jAvqy9piaIgFWwNyUwAFzM4BCxrRoeO6z
   5we+aBqGBG62wfvmRHEmC+50vkMnEZpSjtDLHFQawLZecUz7/no6KxpGB
   g==;
X-CSE-ConnectionGUID: tj+/ggMhS4S42i0wyHIlFg==
X-CSE-MsgGUID: S0xlivOhTbSTLcOJjjSDLw==
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="31271673"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2024 22:14:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Sep 2024 22:14:35 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 3 Sep 2024 22:14:31 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <shuah@kernel.org>, <bryan.whitehead@microchip.com>,
	<mohan.prasad@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>
Subject: [PATCH net-next 3/3] selftests: lan743x: Add testcase to check throughput of lan743x
Date: Wed, 4 Sep 2024 03:45:49 +0530
Message-ID: <20240903221549.1215842-4-mohan.prasad@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903221549.1215842-1-mohan.prasad@microchip.com>
References: <20240903221549.1215842-1-mohan.prasad@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add testcase to check TCP throughput of lan743x network driver.
Test uses iperf3 to do performance testing of the driver.
TCP data at different speeds is sent, received and verified.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
 .../net/hw/microchip/lan743x/lan743x.py       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
index 59f0be2a7..a3dcf7896 100755
--- a/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
+++ b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
@@ -3,6 +3,7 @@
 
 import time
 import re
+import json
 from lib.py import ksft_run, ksft_exit, ksft_pr, ksft_eq
 from lib.py import KsftFailEx, KsftSkipEx
 from lib.py import NetDrvEpEnv
@@ -75,6 +76,38 @@ def test_network_speed(cfg) -> None:
             time.sleep(5)
             verify_speed_and_duplex(cfg.ifname, speed, duplex)
 
+def test_tcp_throughput(cfg) -> None:
+    speeds = ["10", "100", "1000"]
+    """Test duration in seconds"""
+    test_duration = 5
+    target_ip = cfg.remote_addr
+
+    for speed in speeds:
+        set_speed_and_duplex(cfg.ifname, speed, 'full')
+        time.sleep(5)
+        verify_link_up(cfg.ifname)
+        send_command=f"iperf3 -c {target_ip} -t {test_duration} --json"
+        receive_command=f"iperf3 -c {target_ip} -t {test_duration} --reverse --json"
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
+        """Check whether throughput is not below 0.9 times the set speed"""
+        threshold = float(speed) * 0.9
+        if send_throughput < threshold or receive_throughput < threshold:
+            raise KsftFailEx("Throughput is below threshold")
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg,))
-- 
2.43.0


