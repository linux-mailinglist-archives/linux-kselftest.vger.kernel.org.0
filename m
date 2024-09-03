Return-Path: <linux-kselftest+bounces-17102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F24C96B05B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 07:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DEAB22B44
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 05:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC9E83A06;
	Wed,  4 Sep 2024 05:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y/zsa4gI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A232F58ABC;
	Wed,  4 Sep 2024 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426882; cv=none; b=dHldoHGQOFXn0R3rekb0pRfsRr5ny3kLTweL1GOmjYqNrY8nzrXWy01hxIgyj23fTKAxKun4fw1wY036RZCbpQdACRgSEN2AeikZECB5Z/cJjAvCEo+z/hBMsBdFSMzDLHXjH2tUJIskNSbaymGoMPtvMFdBmuoEsflc66V8XAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426882; c=relaxed/simple;
	bh=mtlfEanAfYMSUSoIVuuAooYcKIUWTEVrlYHzkqcJItY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7AZkg02qwzKmj3A6fHsgrpcmHo+QwggQ1/+5Oz3OX1eGWmc53DOqujLEbFsu5tCEaVmWkjAOQt7buKsF8ZWnU9P6Mn4hv2wvvKy6ztvooJJMtGLO6UBTzmqjaClpqQcnwDsYeRxiwEzczVSDgDRMbDgwYm4dtgcdBAlCiR/5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y/zsa4gI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725426881; x=1756962881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mtlfEanAfYMSUSoIVuuAooYcKIUWTEVrlYHzkqcJItY=;
  b=y/zsa4gIm7e7gycScKUWF3MqR8hhqVM5MxfbBa7+sMGm+g5cRG3n1oWu
   CzKQusNuiMgOI5UkpGjSLzFJ6ke0eEEam0qRywtwJ0Dqitnrh/YgyERbu
   znamgPKrDF+4ShXcju80IH6mAMw9dEDO+PkQws9LxWSsDSt2XKBv8/BI8
   iEY7xQIeyGBrQ/kzYDCk6DzcWW/owfcPRkIcLLF5DHP1SncBjaclzV7cv
   podzGnAeN1I1iohCLD/ufYk4GVYy6NkoyZC+pHBnFpgSe8NoTy1uIvb+F
   vu9+TftAEDG4YQ8twam0/VdsqBqq0Fg5gfpMJfyU5+gmbwusgawMVHkQk
   Q==;
X-CSE-ConnectionGUID: tj+/ggMhS4S42i0wyHIlFg==
X-CSE-MsgGUID: tLL4u5EjSTaBoGqPeJnSvA==
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="31271671"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2024 22:14:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Sep 2024 22:14:20 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 3 Sep 2024 22:14:15 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <shuah@kernel.org>, <bryan.whitehead@microchip.com>,
	<mohan.prasad@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>
Subject: [PATCH net-next 1/3] selftests: lan743x: Add testfile for lan743x network driver
Date: Wed, 4 Sep 2024 03:45:47 +0530
Message-ID: <20240903221549.1215842-2-mohan.prasad@microchip.com>
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

Add testfile for lan743x network driver.
Testfile includes the verification of status of autonegotiation.
Ksft modules and ethtool are used for the testing.
net/lib libraries are included for testing.
Add the __init__.py file.
Include /microchip/lan743x as a target in Makefile.
Updated MAINTAINERS list.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
 MAINTAINERS                                   |  2 +
 tools/testing/selftests/Makefile              |  2 +-
 .../drivers/net/hw/microchip/lan743x/Makefile |  7 +++
 .../net/hw/microchip/lan743x/lan743x.py       | 51 +++++++++++++++++++
 .../hw/microchip/lan743x/lib/py/__init__.py   | 16 ++++++
 5 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/microchip/lan743x/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/microchip/lan743x/lib/py/__init__.py

diff --git a/MAINTAINERS b/MAINTAINERS
index baf88e74c..461f94ae0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14960,10 +14960,12 @@ F:	net/dsa/tag_ksz.c
 
 MICROCHIP LAN743X ETHERNET DRIVER
 M:	Bryan Whitehead <bryan.whitehead@microchip.com>
+M:	Mohan Prasad J <mohan.prasad@microchip.com>
 M:	UNGLinuxDriver@microchip.com
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan743x_*
+F:	tools/testing/selftests/drivers/net/hw/microchip/lan743x/
 
 MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
 M:	Arun Ramadoss <arun.ramadoss@microchip.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index a5f1c0c27..8059529c9 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -122,7 +122,7 @@ TARGETS_HOTPLUG = cpu-hotplug
 TARGETS_HOTPLUG += memory-hotplug
 
 # Networking tests want the net/lib target, include it automatically
-ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
+ifneq ($(filter net drivers/net drivers/net/hw drivers/net/hw/microchip/lan743x,$(TARGETS)),)
 ifeq ($(filter net/lib,$(TARGETS)),)
 	INSTALL_DEP_TARGETS := net/lib
 endif
diff --git a/tools/testing/selftests/drivers/net/hw/microchip/lan743x/Makefile b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/Makefile
new file mode 100644
index 000000000..542128678
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_INCLUDES := $(wildcard lib/py/*.py ../../../lib/py/*.py)
+
+TEST_PROGS := lan743x.py
+
+include ../../../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
new file mode 100755
index 000000000..f1ad97dc2
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
@@ -0,0 +1,51 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import time
+import re
+from lib.py import ksft_run, ksft_exit, ksft_pr, ksft_eq
+from lib.py import KsftFailEx, KsftSkipEx
+from lib.py import NetDrvEpEnv
+from lib.py import cmd
+from lib.py import ethtool
+
+def verify_link_up(ifname: str) -> None:
+    """Verify whether the link is up initially"""
+    with open(f"/sys/class/net/{ifname}/operstate", "r") as fp:
+        link_state = fp.read().strip()
+
+    if link_state == "down":
+        raise KsftSkipEx(f"Link state of interface {ifname} is DOWN")
+
+def set_autonegotiation_state(ifname: str, state: str) -> None:
+    """Set the autonegotiation state for the interface"""
+    process = ethtool(f"-s {ifname} speed 10 duplex half autoneg {state}")
+    if process.ret != 0:
+        raise KsftFailEx(f"Not able to set autoneg parameter for {ifname}")
+    ksft_pr(f"Autoneg set as {state} for {ifname}")
+
+def verify_autonegotiation(ifname: str, expected_state: str) -> None:
+    verify_link_up(ifname)
+    """Verifying the autonegotiation state"""
+    output = ethtool(f"{ifname}")
+    autoneg_match = re.search(r'Auto-negotiation:\s+(\w+)', output.stdout)
+
+    if not autoneg_match:
+        raise KsftFailEx("Failed to find autonegotiation information in ethtool output.")
+
+    actual_state = autoneg_match.group(1)
+    ksft_eq(actual_state, expected_state)
+
+def test_autonegotiation(cfg) -> None:
+    for state in ["off", "on"]:
+        set_autonegotiation_state(cfg.ifname, state)
+        time.sleep(5)
+        verify_autonegotiation(cfg.ifname, state)
+
+def main() -> None:
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg,))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lib/py/__init__.py
new file mode 100644
index 000000000..e571631af
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lib/py/__init__.py
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import sys
+from pathlib import Path
+
+KSFT_DIR = (Path(__file__).parent / "../../../../../../..").resolve()
+
+try:
+    sys.path.append(KSFT_DIR.as_posix())
+    from net.lib.py import *
+    from drivers.net.lib.py import *
+except ModuleNotFoundError as e:
+    ksft_pr("Failed importing `net` library from kernel sources")
+    ksft_pr(str(e))
+    ktap_result(True, comment="SKIP")
+    sys.exit(4)
-- 
2.43.0


