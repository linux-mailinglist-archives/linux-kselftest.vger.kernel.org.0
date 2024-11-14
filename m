Return-Path: <linux-kselftest+bounces-22078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB10A9CD55D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 03:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E15B22376
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 02:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F08E13D8A0;
	Fri, 15 Nov 2024 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hHdVYJSt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3E2558BC;
	Fri, 15 Nov 2024 02:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637557; cv=none; b=H8E+nKhY5X3qKpP4iRKaZHhMrknVXbWWVKvU2zyrMT2N890/k46xkITQH21/M1aasHe1F6rJuEToeleW7sqLks47xYAK7Hu6YKFIapNV8iY8x9v/w3T+OQlMv47LFu9qOixvgQki0zzK86yq3M26/NgerpRneWUFBLRLr5IXsyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637557; c=relaxed/simple;
	bh=diQYWzRLt6DbkP9+0LMg4OfquCgvtMnxE6BA39LxF7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKil3O1lZO+kD53LlzTN/CeTaFkSprkR1E2FkrjA9u8DOKhHIr0iurMgpkAkS8MC18mtkm/odv41XSTaXpNfeOOn/S3ZPaMxWmvIaNXAHFsLH7Km4RKyHpGvZIihNJUSBFlay/Xi+Br+WMOQ7VZ8kPOtinQRtZzGhDZ4SylejEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hHdVYJSt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731637555; x=1763173555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=diQYWzRLt6DbkP9+0LMg4OfquCgvtMnxE6BA39LxF7I=;
  b=hHdVYJStsTVdfQh+W049JySGWab3Y8Ac5LpHkbMSsGEOZdFAbqsuM5bG
   eHUNxWtnqsXVeKmPSKJk0hpLAVLKQCk1kLkXqVNTooqha4AgvCcdCrOEm
   YSg/AZymLVZTIlTBaTMCxNbz7cvc4gq7hU8nDqNn08LCKMIPqmVucIv0b
   0zfk8dT4125b3SMhlvQ7kxHt9lQ5XjNkkQvrq/BSZFDYH6zqJaDeK7lXZ
   DiWIz11Xsjfd1kUvlSxBPnSYOQmoiNqt8JjIctLRQ9Xf7zzBYnuD/MHtW
   9b5rSlKITP+b1/AHZ8IKOtkl6H8BPa124TdhycQmmTVn/qkF4XjLstbOt
   Q==;
X-CSE-ConnectionGUID: QjuG0j+zR8eJOiYtRT/ezA==
X-CSE-MsgGUID: HaiGjlfdScaLkx2o1349fw==
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="34078313"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2024 19:23:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Nov 2024 19:23:27 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 14 Nov 2024 19:23:22 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<mohan.prasad@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<willemb@google.com>, <petrm@nvidia.com>
Subject: [PATCH net-next v4 2/3] selftests: nic_link_layer: Add selftest case for speed and duplex states
Date: Fri, 15 Nov 2024 00:55:19 +0530
Message-ID: <20241114192545.1742514-3-mohan.prasad@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114192545.1742514-1-mohan.prasad@microchip.com>
References: <20241114192545.1742514-1-mohan.prasad@microchip.com>
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
 .../drivers/net/hw/nic_link_layer.py          | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/nic_link_layer.py b/tools/testing/selftests/drivers/net/hw/nic_link_layer.py
index d8cc12e84..efd921180 100644
--- a/tools/testing/selftests/drivers/net/hw/nic_link_layer.py
+++ b/tools/testing/selftests/drivers/net/hw/nic_link_layer.py
@@ -76,6 +76,28 @@ def test_autonegotiation(cfg: object, link_config: LinkConfig, time_delay: int)
         time.sleep(time_delay)
         verify_autonegotiation(cfg, state, link_config)
 
+def test_network_speed(cfg: object, link_config: LinkConfig, time_delay: int) -> None:
+    _pre_test_checks(cfg, link_config)
+    common_link_modes = link_config.common_link_modes
+    if not common_link_modes:
+        KsftSkipEx("No common link modes exist")
+    speeds, duplex_modes = link_config.get_speed_duplex_values(common_link_modes)
+
+    if speeds and duplex_modes and len(speeds) == len(duplex_modes):
+        for idx in range(len(speeds)):
+            speed = speeds[idx]
+            duplex = duplex_modes[idx]
+            if not link_config.set_speed_and_duplex(speed, duplex):
+                raise KsftFailEx(f"Unable to set speed and duplex parameters for {cfg.ifname}")
+            time.sleep(time_delay)
+            if not link_config.verify_speed_and_duplex(speed, duplex):
+                raise KsftSkipEx(f"Error occurred while verifying speed and duplex states for interface {cfg.ifname}")
+    else:
+        if not speeds or not duplex_modes:
+            KsftSkipEx(f"No supported speeds or duplex modes found for interface {cfg.ifname}")
+        else:
+            KsftSkipEx("Mismatch in the number of speeds and duplex modes")
+
 def main() -> None:
     parser = argparse.ArgumentParser(description="Run basic link layer tests for NIC driver")
     parser.add_argument('--time-delay', type=int, default=8, help='Time taken to wait for transitions to happen(in seconds). Default is 8 seconds.')
-- 
2.43.0


