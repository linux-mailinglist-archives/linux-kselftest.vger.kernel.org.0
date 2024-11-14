Return-Path: <linux-kselftest+bounces-22077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BAC9CD558
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 03:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8434D282C1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 02:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7776154BE4;
	Fri, 15 Nov 2024 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VaEjkRKC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E37514375C;
	Fri, 15 Nov 2024 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637439; cv=none; b=q9phmUMzKm4haPmKROoO5bpbHTQZ1vrXk302cEPq8H9qd7J9uMn7ZOo/JRP3GJEHD5PlMLfGbXZqaEreSQ4Yc0KUrSTBn7KzqniDb16Tubc+/6nJnpRAF7L/C+uKTXxGaweKMaRphizXXKtF0keDJsZoQHJHQ2020RWZ+RyOcI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637439; c=relaxed/simple;
	bh=pimSIS07xfTY+krQp46V4R99Vq3TX/rxIP4Tzm9ti1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOYgStBQYDoPqp39/FGYCAJcG5FaxWfCfxwnc3DgF9AvkqwCP+ZrodZQhVeyALKzNwbYrfrf6bSR0KOEz6BjQFf7GPGho+qSYTDOOcfEoJ35Izkvt8gWKQozes29+zzH/QrAwmGw57EiJQkkZq7p8Fq2kZ0H585HgwyT7DakIDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VaEjkRKC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731637437; x=1763173437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pimSIS07xfTY+krQp46V4R99Vq3TX/rxIP4Tzm9ti1A=;
  b=VaEjkRKC/R6Scs8hpdqaVdUbfr5xbxFMfwZe0kqLhtJ8hgQgHG3lNApC
   BhIYnFB4IqXnPvWpheCV2lZ7yH222nTNVbSrE5Unp8Y56pRbIEc5sNLhL
   UpwJeoPY0dE5QNAY1hHYHRYCw5gFh7W5W2GlBDzUIpuir0xdC+sZKc80u
   8KmcpOES5m8ihO++iwU3YUPxAbeqC1kbJEzp14UT1rjcBDuNff6D1JMOY
   oryqQ4Igwp/WXrt7aCrajOQKNGD/xdi6Ex0Fy9I9jJkAORQmYnc4NiAPG
   CRAKdjyXed7sHEpCexC54spe4QJkE8OkVNdP/n7tGNai0fj3CtCvbe4zt
   w==;
X-CSE-ConnectionGUID: 44dLkhyPQcCnPJiBO6oYOQ==
X-CSE-MsgGUID: 9XAuJ7JTRrOOz9qtbOBYxw==
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="34348660"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2024 19:23:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Nov 2024 19:23:18 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 14 Nov 2024 19:23:13 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<mohan.prasad@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<willemb@google.com>, <petrm@nvidia.com>
Subject: [PATCH net-next v4 1/3] selftests: nic_link_layer: Add link layer selftest for NIC driver
Date: Fri, 15 Nov 2024 00:55:18 +0530
Message-ID: <20241114192545.1742514-2-mohan.prasad@microchip.com>
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

Add selftest file for the link layer tests of a NIC driver.
Test for auto-negotiation is added.
Add LinkConfig class for changing link layer configs.
Selftest makes use of ksft modules and ethtool.
Include selftest file in the Makefile.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   5 +-
 .../drivers/net/hw/lib/py/__init__.py         |   1 +
 .../drivers/net/hw/lib/py/linkconfig.py       | 222 ++++++++++++++++++
 .../drivers/net/hw/nic_link_layer.py          |  91 +++++++
 4 files changed, 317 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/nic_link_layer.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 1c6a77480..7939f81fe 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -11,6 +11,7 @@ TEST_PROGS = \
 	hw_stats_l3.sh \
 	hw_stats_l3_gre.sh \
 	loopback.sh \
+	nic_link_layer.py \
 	pp_alloc_fail.py \
 	rss_ctx.py \
 	#
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index b58288578..399789a96 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -9,6 +9,7 @@ try:
     sys.path.append(KSFT_DIR.as_posix())
     from net.lib.py import *
     from drivers.net.lib.py import *
+    from .linkconfig import LinkConfig
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `net` library from kernel sources")
     ksft_pr(str(e))
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py b/tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
new file mode 100644
index 000000000..db84000fc
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
@@ -0,0 +1,222 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import cmd, ethtool, ip
+from lib.py import ksft_pr, ksft_eq, KsftSkipEx
+from typing import Optional
+import re
+import time
+import json
+
+#The LinkConfig class is implemented to handle the link layer configurations.
+#Required minimum ethtool version is 6.10
+
+class LinkConfig:
+    """Class for handling the link layer configurations"""
+    def __init__(self, cfg: object) -> None:
+        self.cfg = cfg
+        self.partner_netif = self.get_partner_netif_name()
+
+        """Get the initial link configuration of local interface"""
+        self.common_link_modes = self.get_common_link_modes()
+
+    def get_partner_netif_name(self) -> Optional[str]:
+        partner_netif = None
+        try:
+            if not self.verify_link_up():
+                return None
+            """Get partner interface name"""
+            partner_json_output = ip("addr show", json=True, host=self.cfg.remote)
+            for interface in partner_json_output:
+                for addr in interface.get('addr_info', []):
+                    if addr.get('local') == self.cfg.remote_addr:
+                        partner_netif = interface['ifname']
+                        ksft_pr(f"Partner Interface name: {partner_netif}")
+            if partner_netif is None:
+                ksft_pr("Unable to get the partner interface name")
+        except Exception as e:
+            print(f"Unexpected error occurred while getting partner interface name: {e}")
+        self.partner_netif = partner_netif
+        return partner_netif
+
+    def verify_link_up(self) -> bool:
+        """Verify whether the local interface link is up"""
+        with open(f"/sys/class/net/{self.cfg.ifname}/operstate", "r") as fp:
+            link_state = fp.read().strip()
+
+        if link_state == "down":
+            ksft_pr(f"Link state of interface {self.cfg.ifname} is DOWN")
+            return False
+        else:
+            return True
+
+    def reset_interface(self, local: bool = True, remote: bool = True) -> bool:
+        ksft_pr("Resetting interfaces in local and remote")
+        if remote:
+            if self.verify_link_up():
+                if self.partner_netif is not None:
+                    ifname = self.partner_netif
+                    link_up_cmd = f"ip link set up {ifname}"
+                    link_down_cmd = f"ip link set down {ifname}"
+                    reset_cmd = f"{link_down_cmd} && sleep 5 && {link_up_cmd}"
+                    try:
+                        cmd(reset_cmd, host=self.cfg.remote)
+                    except Exception as e:
+                        ksft_pr(f"Unexpected error occurred while resetting remote: {e}")
+                else:
+                    ksft_pr("Partner interface not available")
+        if local:
+            ifname = self.cfg.ifname
+            link_up_cmd = f"ip link set up {ifname}"
+            link_down_cmd = f"ip link set down {ifname}"
+            reset_cmd = f"{link_down_cmd} && sleep 5 && {link_up_cmd}"
+            try:
+                cmd(reset_cmd)
+            except Exception as e:
+                ksft_pr(f"Unexpected error occurred while resetting local: {e}")
+        time.sleep(10)
+        if self.verify_link_up() and self.get_ethtool_field("link-detected"):
+            ksft_pr("Local and remote interfaces reset to original state")
+            return True
+        else:
+            ksft_pr("Error occurred after resetting interfaces. Link is DOWN.")
+            return False
+
+    def set_speed_and_duplex(self, speed: str, duplex: str, autoneg: bool = True) -> bool:
+        """Set the speed and duplex state for the interface"""
+        autoneg_state = "on" if autoneg is True else "off"
+        process = None
+        try:
+            process = ethtool(f"--change {self.cfg.ifname} speed {speed} duplex {duplex} autoneg {autoneg_state}")
+        except Exception as e:
+            ksft_pr(f"Unexpected error occurred while setting speed/duplex: {e}")
+        if process is None or process.ret != 0:
+            return False
+        else:
+            ksft_pr(f"Speed: {speed} Mbps, Duplex: {duplex} set for Interface: {self.cfg.ifname}")
+            return True
+
+    def verify_speed_and_duplex(self, expected_speed: str, expected_duplex: str) -> bool:
+        if not self.verify_link_up():
+            return False
+        """Verifying the speed and duplex state for the interface"""
+        with open(f"/sys/class/net/{self.cfg.ifname}/speed", "r") as fp:
+            actual_speed = fp.read().strip()
+        with open(f"/sys/class/net/{self.cfg.ifname}/duplex", "r") as fp:
+            actual_duplex = fp.read().strip()
+
+        ksft_eq(actual_speed, expected_speed)
+        ksft_eq(actual_duplex, expected_duplex)
+        return True
+
+    def set_autonegotiation_state(self, state: str, remote: bool = False) -> bool:
+        common_link_modes = self.common_link_modes
+        speeds, duplex_modes = self.get_speed_duplex_values(self.common_link_modes)
+        speed = speeds[0]
+        duplex = duplex_modes[0]
+        if not speed or not duplex:
+            ksft_pr("No speed or duplex modes found")
+            return False
+
+        speed_duplex_cmd = f"speed {speed} duplex {duplex}" if state == "off" else ""
+        if remote:
+            if not self.verify_link_up():
+                return False
+            """Set the autonegotiation state for the partner"""
+            command = f"-s {self.partner_netif} {speed_duplex_cmd} autoneg {state}"
+            partner_autoneg_change = None
+            """Set autonegotiation state for interface in remote pc"""
+            try:
+                partner_autoneg_change = ethtool(command, host=self.cfg.remote)
+            except Exception as e:
+                ksft_pr(f"Unexpected error occurred while changing auto-neg in remote: {e}")
+            if partner_autoneg_change is None or partner_autoneg_change.ret != 0:
+                ksft_pr(f"Not able to set autoneg parameter for interface {self.partner_netif}.")
+                return False
+            ksft_pr(f"Autoneg set as {state} for {self.partner_netif}")
+        else:
+            """Set the autonegotiation state for the interface"""
+            try:
+                process = ethtool(f"-s {self.cfg.ifname} {speed_duplex_cmd} autoneg {state}")
+                if process.ret != 0:
+                    ksft_pr(f"Not able to set autoneg parameter for interface {self.cfg.ifname}")
+                    return False
+            except Exception as e:
+                ksft_pr(f"Unexpected error occurred while changing auto-neg in local: {e}")
+                return False
+            ksft_pr(f"Autoneg set as {state} for {self.cfg.ifname}")
+        return True
+
+    def check_autoneg_supported(self, remote: bool = False) -> bool:
+        if not remote:
+            local_autoneg = self.get_ethtool_field("supports-auto-negotiation")
+            if local_autoneg is None:
+                ksft_pr(f"Unable to fetch auto-negotiation status for interface {self.cfg.ifname}")
+            """Return autoneg status of the local interface"""
+            return local_autoneg
+        else:
+            if not self.verify_link_up():
+                raise KsftSkipEx("Link is DOWN")
+            """Check remote auto-negotiation support status"""
+            partner_autoneg = False
+            if self.partner_netif is not None:
+                partner_autoneg = self.get_ethtool_field("supports-auto-negotiation", remote=True)
+                if partner_autoneg is None:
+                    ksft_pr(f"Unable to fetch auto-negotiation status for interface {self.partner_netif}")
+            return partner_autoneg
+
+    def get_common_link_modes(self) -> set[str]:
+        common_link_modes = []
+        """Populate common link modes"""
+        link_modes = self.get_ethtool_field("supported-link-modes")
+        partner_link_modes = self.get_ethtool_field("link-partner-advertised-link-modes")
+        if link_modes is None:
+            raise KsftSkipEx(f"Link modes not available for {self.cfg.ifname}")
+        if partner_link_modes is None:
+            raise KsftSkipEx(f"Partner link modes not available for {self.cfg.ifname}")
+        common_link_modes = set(link_modes) and set(partner_link_modes)
+        return common_link_modes
+
+    def get_speed_duplex_values(self, link_modes: list[str]) -> tuple[list[str], list[str]]:
+        speed = []
+        duplex = []
+        """Check the link modes"""
+        for data in link_modes:
+            parts = data.split('/')
+            speed_value = re.match(r'\d+', parts[0])
+            if speed_value:
+                speed.append(speed_value.group())
+            else:
+                ksft_pr(f"No speed value found for interface {self.ifname}")
+                return None, None
+            duplex.append(parts[1].lower())
+        return speed, duplex
+
+    def get_ethtool_field(self, field: str, remote: bool = False) -> Optional[str]:
+        process = None
+        if not remote:
+            """Get the ethtool field value for the local interface"""
+            try:
+                process = ethtool(self.cfg.ifname, json=True)
+            except Exception as e:
+                ksft_pr("Required minimum ethtool version is 6.10")
+                ksft_pr(f"Unexpected error occurred while getting ethtool field in local: {e}")
+                return None
+        else:
+            if not self.verify_link_up():
+                return None
+            """Get the ethtool field value for the remote interface"""
+            self.cfg.require_cmd("ethtool", remote=True)
+            if self.partner_netif is None:
+                ksft_pr(f"Partner interface name is unavailable.")
+                return None
+            try:
+                process = ethtool(self.partner_netif, json=True, host=self.cfg.remote)
+            except Exception as e:
+                ksft_pr("Required minimum ethtool version is 6.10")
+                ksft_pr(f"Unexpected error occurred while getting ethtool field in remote: {e}")
+                return None
+        json_data = process[0]
+        """Check if the field exist in the json data"""
+        if field not in json_data:
+            raise KsftSkipEx(f"Field {field} does not exist in the output of interface {json_data["ifname"]}")
+        return json_data[field]
diff --git a/tools/testing/selftests/drivers/net/hw/nic_link_layer.py b/tools/testing/selftests/drivers/net/hw/nic_link_layer.py
new file mode 100644
index 000000000..d8cc12e84
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nic_link_layer.py
@@ -0,0 +1,91 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+#Introduction:
+#This file has basic link layer tests for generic NIC drivers.
+#The test comprises of auto-negotiation, speed and duplex checks.
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
+#Required minimum ethtool version is 6.10 (supports json)
+#Default values:
+#time_delay = 8 #time taken to wait for transitions to happen, in seconds.
+
+import time
+import argparse
+from lib.py import ksft_run, ksft_exit, ksft_pr, ksft_eq
+from lib.py import KsftFailEx, KsftSkipEx
+from lib.py import NetDrvEpEnv
+from lib.py import LinkConfig
+
+def _pre_test_checks(cfg: object, link_config: LinkConfig) -> None:
+    if link_config.partner_netif is None:
+        KsftSkipEx("Partner interface is not available")
+    if not link_config.check_autoneg_supported() or not link_config.check_autoneg_supported(remote=True):
+        KsftSkipEx(f"Auto-negotiation not supported for interface {cfg.ifname} or {link_config.partner_netif}")
+    if not link_config.verify_link_up():
+        raise KsftSkipEx(f"Link state of interface {cfg.ifname} is DOWN")
+
+def verify_autonegotiation(cfg: object, expected_state: str, link_config: LinkConfig) -> None:
+    if not link_config.verify_link_up():
+        raise KsftSkipEx(f"Link state of interface {cfg.ifname} is DOWN")
+    """Verifying the autonegotiation state in partner"""
+    partner_autoneg_output = link_config.get_ethtool_field("auto-negotiation", remote=True)
+    if partner_autoneg_output is None:
+        KsftSkipEx(f"Auto-negotiation state not available for interface {link_config.partner_netif}")
+    partner_autoneg_state = "on" if partner_autoneg_output is True else "off"
+
+    ksft_eq(partner_autoneg_state, expected_state)
+
+    """Verifying the autonegotiation state of local"""
+    autoneg_output = link_config.get_ethtool_field("auto-negotiation")
+    if autoneg_output is None:
+        KsftSkipEx(f"Auto-negotiation state not available for interface {cfg.ifname}")
+    actual_state = "on" if autoneg_output is True else "off"
+
+    ksft_eq(actual_state, expected_state)
+
+    """Verifying the link establishment"""
+    link_available = link_config.get_ethtool_field("link-detected")
+    if link_available is None:
+        KsftSkipEx(f"Link status not available for interface {cfg.ifname}")
+    if link_available != True:
+        raise KsftSkipEx("Link not established at interface {cfg.ifname} after changing auto-negotiation")
+
+def test_autonegotiation(cfg: object, link_config: LinkConfig, time_delay: int) -> None:
+    _pre_test_checks(cfg, link_config)
+    for state in ["off", "on"]:
+        if not link_config.set_autonegotiation_state(state, remote=True):
+            raise KsftSkipEx(f"Unable to set auto-negotiation state for interface {link_config.partner_netif}")
+        if not link_config.set_autonegotiation_state(state):
+            raise KsftSkipEx(f"Unable to set auto-negotiation state for interface {cfg.ifname}")
+        time.sleep(time_delay)
+        verify_autonegotiation(cfg, state, link_config)
+
+def main() -> None:
+    parser = argparse.ArgumentParser(description="Run basic link layer tests for NIC driver")
+    parser.add_argument('--time-delay', type=int, default=8, help='Time taken to wait for transitions to happen(in seconds). Default is 8 seconds.')
+    args = parser.parse_args()
+    time_delay = args.time_delay
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        link_config = LinkConfig(cfg)
+        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, link_config, time_delay,))
+        link_config.reset_interface()
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0


