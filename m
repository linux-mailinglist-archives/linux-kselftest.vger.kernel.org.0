Return-Path: <linux-kselftest+bounces-17103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D519296B05E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 07:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11EDA1C23A35
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 05:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7115F84E0A;
	Wed,  4 Sep 2024 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bj7kBhKd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B8883A17;
	Wed,  4 Sep 2024 05:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426884; cv=none; b=bRvHnbJSdybDO0mOXIgdzCRSANsjuffQ3qyMGlhvFBaOYEDhojE2dwQE3hjNN9xUx2mDmIh341+4+nYpf279BN23Fk9+6ysOf5LJN1DSFnKNdwSR2ksNyL6bA4Nvoj5mwFqjTghfKGyNVBDoY5tgNTsLJnIHlwdORdFb4M/CJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426884; c=relaxed/simple;
	bh=Hja1n0/1fpHUQJXWD1EiDmFTR3ZmSeBBZwUB2XpF/qQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkgcTlrskYRF2mhAkGfBFl0r6MvuloCAeYg2dzNnddLp8JILHFL4qe0ijQcbUYcBHXkuu//pm9pdNoL4KRiZXBpMuTBjexvu7c+Kbe+n36yuZ3iwC6ONKBYf0Rglh8irumVzwMNLcIHeiFVLRoeuDr/wY3nZXltyqdXqi8JPw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bj7kBhKd; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725426883; x=1756962883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hja1n0/1fpHUQJXWD1EiDmFTR3ZmSeBBZwUB2XpF/qQ=;
  b=bj7kBhKdDmYlDg+7hwvP2taibCU8lpeg0M8zC9kDRwDyGfMxDD341YuP
   CFlNwn8cmIbYzFnV825sO3BJcf7u9C4HcwIWej6XYlnWIo66g3RPnuRYs
   sbzQ1VlxEC24LNWd0K7v0W8H/rF4SFY8kBuySbooywKq1S9kygRgmORHp
   SD/b/v9fDPNTXIseprnhjmb3Y1L6F+72QyIFHSbL5U3Xx61daIgdFsR+g
   cbwXaYqYBUuTpDuj4AkU4r7rSnoS6UK22JH9ydGxtPUQfdgK5RIS0U1g3
   o6UW/muy3j6/kTwM+QDCLCHv10TnM3UiyyeUrAp00V9eleaAHwi2k+Vh1
   g==;
X-CSE-ConnectionGUID: tj+/ggMhS4S42i0wyHIlFg==
X-CSE-MsgGUID: LQZgLfUNTE+Pkb8U6gRTkg==
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="31271672"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2024 22:14:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Sep 2024 22:14:29 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 3 Sep 2024 22:14:24 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <shuah@kernel.org>, <bryan.whitehead@microchip.com>,
	<mohan.prasad@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>
Subject: [PATCH net-next 2/3] selftests: lan743x: Add testcase to check speed and duplex state of lan743x
Date: Wed, 4 Sep 2024 03:45:48 +0530
Message-ID: <20240903221549.1215842-3-mohan.prasad@microchip.com>
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

Add testcase for checking speed and duplex states for
lan743x network driver.
Testcase comprises of varying the network speed and duplex
state to 10/100/1000Mbps and half/full via ethtool.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
 .../net/hw/microchip/lan743x/lan743x.py       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
index f1ad97dc2..59f0be2a7 100755
--- a/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
+++ b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
@@ -36,12 +36,45 @@ def verify_autonegotiation(ifname: str, expected_state: str) -> None:
     actual_state = autoneg_match.group(1)
     ksft_eq(actual_state, expected_state)
 
+def set_speed_and_duplex(ifname: str, speed: str, duplex: str) -> None:
+    """Set the speed and duplex state for the interface"""
+    process = ethtool(f"--change {ifname} speed {speed} duplex {duplex} autoneg on")
+
+    if process.ret != 0:
+        raise KsftFailEx(f"Not able to set speeed and duplex parameters for {ifname}")
+    ksft_pr(f"Speed: {speed} Mbps, Duplex: {duplex} set for Interface: {ifname}")
+
+def verify_speed_and_duplex(ifname: str, expected_speed: str, expected_duplex: str) -> None:
+    verify_link_up(ifname)
+    """Verifying the speed and duplex state for the interface"""
+    output = ethtool(f"{ifname}")
+    with open(f"/sys/class/net/{ifname}/speed", "r") as fp:
+        actual_speed = fp.read().strip()
+    with open(f"/sys/class/net/{ifname}/duplex", "r") as fp:
+        actual_duplex = fp.read().strip()
+
+    ksft_eq(actual_speed, expected_speed)
+    ksft_eq(actual_duplex, expected_duplex)
+
 def test_autonegotiation(cfg) -> None:
     for state in ["off", "on"]:
         set_autonegotiation_state(cfg.ifname, state)
         time.sleep(5)
         verify_autonegotiation(cfg.ifname, state)
 
+def test_network_speed(cfg) -> None:
+    speeds = ["10", "100", "1000"]
+    duplex_modes = ["half", "full"]
+
+    for speed in speeds:
+        for duplex in duplex_modes:
+            # Skip for speed = 1000Mbps, duplex = Half
+            if speed == "1000" and duplex == "half":
+                continue
+            set_speed_and_duplex(cfg.ifname, speed, duplex)
+            time.sleep(5)
+            verify_speed_and_duplex(cfg.ifname, speed, duplex)
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg,))
-- 
2.43.0


