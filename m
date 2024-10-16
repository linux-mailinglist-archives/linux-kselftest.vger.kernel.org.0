Return-Path: <linux-kselftest+bounces-19913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2009A19D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 06:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D37B25088
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 04:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067BB178CC8;
	Thu, 17 Oct 2024 04:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="guDISHgE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26E715C139;
	Thu, 17 Oct 2024 04:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140478; cv=none; b=gi/Cxt9AfNnbe4AsCJ3cb7yiQc1wxVhlHDa8TqTBaFPSzOdmmSjxi6BcHdF13GiC319uYXbIuW54U2Lar65Kiz0dykSqX/be4Nnh/mP1taeJyqnQthttg+dqRFrEWfETH1pRBSNK+leFOJeIH8mqBm4arXqMz9sIjTnE9j8m4Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140478; c=relaxed/simple;
	bh=7LgSNHRO6Vnu+y4V9uslcARGBrj2FWHJd03mIg0UZ5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmPRwBkoCUha4lsfrB2zqvBDnyCNnnU9rxgXhAjYO9E3pGxOkIwA7Xgq8kWNCxQ0A3aaSJ/+wqZ6rop6feO6+V4Wt92QsACVS+NPUaLSamNTulUdcl/jfGDT9o7CZ04dyxNIDNbYBk2nkMoRE6eoiRUD9uOYnYXtmhgqZRPuYe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=guDISHgE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729140475; x=1760676475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7LgSNHRO6Vnu+y4V9uslcARGBrj2FWHJd03mIg0UZ5s=;
  b=guDISHgEF2dcSLSRuJZOn/dUlvxHgQoLBujtaNcqZicHDlZWkGpPh4SV
   lZKZWf33akDMBDZh7sc4YZhVlYmooGJ+XgVtHTPrUyVvdIPeTQIg10UcL
   u6fLruAiMZna+Ff/2B2CNhDlslU8NeUsd7aNVJY/H1/xKwCjRAUYBrv9q
   /assH7acD5ZjbwEK2b2z2RoT0AYzT/5n3IT8P2pygFdnzn2JJosvLU0Aw
   +ls+R6oMVwXCXMl1s3xd4cfMJDEM37AloYT7VDbQfVSAZ3zF1/yQjkYuB
   2r8RVSU6oZtNunmq/HeVVuBPx649NwmiH87voKfgHHkQuelJdmskdJF15
   Q==;
X-CSE-ConnectionGUID: 8pbTCNeqT7aHxiJ1HBLGWw==
X-CSE-MsgGUID: LZS7e8iGREuinqFeL0j2qg==
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="200553967"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2024 21:47:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 16 Oct 2024 21:47:34 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 16 Oct 2024 21:47:29 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<mohan.prasad@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<willemb@google.com>, <petrm@nvidia.com>
Subject: [PATCH net-next v3 2/3] selftests: nic_link_layer: Add selftest case for speed and duplex states
Date: Thu, 17 Oct 2024 03:20:06 +0530
Message-ID: <20241016215014.401476-3-mohan.prasad@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016215014.401476-1-mohan.prasad@microchip.com>
References: <20241016215014.401476-1-mohan.prasad@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add selftest case for testing the speed and duplex state of
local NIC driver and the partner based on the supported
link modes obtained from the ethtool. Speed and duplex states
are varied and verified using ethtool.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
 .../drivers/net/hw/nic_link_layer.py          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/nic_link_layer.py b/tools/testing/selftests/drivers/net/hw/nic_link_layer.py
index fb046efbe..4548da3d9 100644
--- a/tools/testing/selftests/drivers/net/hw/nic_link_layer.py
+++ b/tools/testing/selftests/drivers/net/hw/nic_link_layer.py
@@ -73,6 +73,27 @@ def test_autonegotiation(cfg, link_config) -> None:
         time.sleep(time_delay)
         verify_autonegotiation(cfg, state, link_config)
 
+def test_network_speed(cfg, link_config) -> None:
+    common_link_modes = link_config.common_link_modes
+    if not common_link_modes:
+        KsftSkipEx("No common link modes exist")
+    speeds, duplex_modes = link_config.get_speed_duplex_values(common_link_modes)
+
+    if speeds and duplex_modes and len(speeds) == len(duplex_modes):
+        for idx in range(len(speeds)):
+            speed = speeds[idx]
+            duplex = duplex_modes[idx]
+            if link_config.set_speed_and_duplex(speed, duplex) == False:
+                raise KsftFailEx(f"Unable to set speed and duplex parameters for {cfg.ifname}")
+            time.sleep(time_delay)
+            if link_config.verify_speed_and_duplex(speed, duplex) == False:
+                raise KsftSkipEx(f"Unable to verify speed and duplex states for interface {cfg.ifname}")
+    else:
+        if not speeds or not duplex_modes:
+            KsftSkipEx(f"No supported speeds or duplex modes found for interface {cfg.ifname}")
+        else:
+            KsftSkipEx("Mismatch in the number of speeds and duplex modes")
+
 def main() -> None:
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         link_config = LinkConfig(cfg)
-- 
2.43.0


