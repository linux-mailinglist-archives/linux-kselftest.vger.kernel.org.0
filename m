Return-Path: <linux-kselftest+bounces-18071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2DA97ADF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 11:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7FA1C2234F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E19161B43;
	Tue, 17 Sep 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="h36VYsmr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BAC15D5B3;
	Tue, 17 Sep 2024 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565603; cv=none; b=q3YOBUh76TtbD9CyRKNYGCaut/qOv+8DwXAiSH0iQ1wMPqJ2kxCuDC0yJTcGbLQiIC2/wr4pPmKaJUnvKVno4sUzu2T+dCzHUuU/6tIfXFv1fhMuv8lFnE/Ak074ITgsTiFV1wwoMHNcCjD7Yu/z5zXM7VyWfl8fkbdA7JLetf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565603; c=relaxed/simple;
	bh=RwqSI2k9wTT/4iWlQrznLe744Nspq0k/xcGDeW2uO3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNxbG4RcSjWJ5hzq/RaRjbbCKAVGOUDDG5K8KvYZgliYfNRJYxbGuUSO5DCxcQ8rxSL8HOgasUKvpTL1y0hH6v96dHXVR035Djk4USNCRkVQJgbzaWrE5pXFVnbR+shmL0orXLzHKnlN9IBD9WUPdJWMAymSYCmybT8F9AsZKw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=h36VYsmr; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726565601; x=1758101601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RwqSI2k9wTT/4iWlQrznLe744Nspq0k/xcGDeW2uO3c=;
  b=h36VYsmr5OPThboVhbwCheqkCLR+h9XijmPf1xFfnVfjDk6HrgtOQwKh
   pT3dEuK8fcqEB7i/+bMYY2UCMmUSsJre8wY9V0qYQO6v4zKe+dTBcQaeB
   G9yNM9pMPTyA5KYtTPT7hh2cNASeke3fRujWVupnAuvyDoAIEXt26CAGc
   vzBclzhxeYLTKdD/Rm+hN+sPghirVuaPa3PjfKoVxYH0QbsE2hYnd0DJ/
   6uKZRdyN9cAc/2llphVd8wPOU9zn8jtJYoAX9SQe2Zqd0pUNaiNgdAnWE
   9NjRb/yoVSEa3PpSfzBxyE0/9OTKBM6xkVmtCoyAg5+BTolqmQUIhiUai
   g==;
X-CSE-ConnectionGUID: 6j7NM/cARrCart7pGaXQPQ==
X-CSE-MsgGUID: Bcqn/ohrQu24bLe0N+OjUQ==
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="31767005"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2024 02:33:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 17 Sep 2024 02:32:51 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 17 Sep 2024 02:32:46 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<mohan.prasad@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<willemb@google.com>
Subject: [PATCH net-next v2 2/3] selftests: nic_basic_tests: Add selftest case for speed and duplex state checks
Date: Tue, 17 Sep 2024 08:04:08 +0530
Message-ID: <20240917023525.2571082-3-mohan.prasad@microchip.com>
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

Add selftest case for testing the speed and duplex state of
local NIC driver and the partner based on the supported
link modes obtained from the ethtool. Speed and duplex states
are varied and verified using ethtool.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
 .../drivers/net/hw/nic_basic_tests.py         | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py b/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py
index 27f780032..ff46f2406 100644
--- a/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py
+++ b/tools/testing/selftests/drivers/net/hw/nic_basic_tests.py
@@ -42,6 +42,14 @@ from lib.py import ethtool
 """Global variables"""
 common_link_modes = []
 
+def check_autonegotiation(ifname: str) -> None:
+    autoneg = get_ethtool_content(ifname, "Supports auto-negotiation:")
+    partner_autoneg = get_ethtool_content(ifname, "Link partner advertised auto-negotiation:")
+
+    """Check if auto-neg supported by local and partner NIC"""
+    if autoneg[0] != "Yes" or partner_autoneg[0] != "Yes":
+        raise KsftSkipEx(f"Interface {ifname} or partner does not support auto-negotiation")
+
 def get_ethtool_content(ifname: str, field: str):
     capture = False
     content = []
@@ -112,6 +120,25 @@ def verify_autonegotiation(ifname: str, expected_state: str) -> None:
 
     ksft_eq(actual_state, expected_state)
 
+def set_speed_and_duplex(ifname: str, speed: str, duplex: str) -> None:
+    """Set the speed and duplex state for the interface"""
+    process = ethtool(f"--change {ifname} speed {speed} duplex {duplex} autoneg on")
+
+    if process.ret != 0:
+        raise KsftFailEx(f"Not able to set speed and duplex parameters for {ifname}")
+    ksft_pr(f"Speed: {speed} Mbps, Duplex: {duplex} set for Interface: {ifname}")
+
+def verify_speed_and_duplex(ifname: str, expected_speed: str, expected_duplex: str) -> None:
+    verify_link_up(ifname)
+    """Verifying the speed and duplex state for the interface"""
+    with open(f"/sys/class/net/{ifname}/speed", "r") as fp:
+        actual_speed = fp.read().strip()
+    with open(f"/sys/class/net/{ifname}/duplex", "r") as fp:
+        actual_duplex = fp.read().strip()
+
+    ksft_eq(actual_speed, expected_speed)
+    ksft_eq(actual_duplex, expected_duplex)
+
 def test_link_modes(cfg) -> None:
     global common_link_modes
     link_modes = get_ethtool_content(cfg.ifname, "Supported link modes:")
@@ -136,6 +163,25 @@ def test_autonegotiation(cfg) -> None:
     else:
         raise KsftSkipEx(f"Auto-Negotiation is not supported for interface {cfg.ifname}")
 
+def test_network_speed(cfg) -> None:
+    check_autonegotiation(cfg.ifname)
+    if not common_link_modes:
+        KsftSkipEx("No common link modes exist")
+    speeds, duplex_modes = get_speed_duplex(common_link_modes)
+
+    if speeds and duplex_modes and len(speeds) == len(duplex_modes):
+        for idx in range(len(speeds)):
+            speed = speeds[idx]
+            duplex = duplex_modes[idx]
+            set_speed_and_duplex(cfg.ifname, speed, duplex)
+            time.sleep(sleep_time)
+            verify_speed_and_duplex(cfg.ifname, speed, duplex)
+    else:
+        if not speeds or not duplex_modes:
+            KsftSkipEx(f"No supported speeds or duplex modes found for interface {cfg.ifname}")
+        else:
+            KsftSkipEx("Mismatch in the number of speeds and duplex modes")
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg,))
-- 
2.43.0


