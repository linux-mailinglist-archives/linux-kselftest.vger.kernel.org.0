Return-Path: <linux-kselftest+bounces-19914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 429EC9A19DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 06:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB2DB250BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 04:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACF717BB25;
	Thu, 17 Oct 2024 04:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qGMQL8yN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2901314EC47;
	Thu, 17 Oct 2024 04:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140480; cv=none; b=Wk8IheumqyGRVNsqEYxDzgykIDovUxMRWpjDXZeUXU1XCMmBfQ/7tRcFR+uozDv/pd1LZmB6tAHevwqHFiyqFpwruVeGkDFlqTIf5aGXxEE8n4a+L0qZ2dceAwG4qaZjR+BrG0oB+F13AJtMEO+txNp8MhmPkdCS78Y+NZ1o2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140480; c=relaxed/simple;
	bh=z6t5jam2u2/qWSb3wbi2/QDu1djFH81oyHBk5nMiNsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAVs+yIy8YgPNrcCeU76aLmPMUakBb4pWotN6qYDL/WmrUYZlypoRgVbRVTF33QheQ0cMr1dzNWcO4aTpopeZNI/IyFFLDsEyb6z6kjqAtH1qld0/z1bBuEAgQcycW1sojAzinlfy4iuKdaVGXZzhW/xs+T7hDC8qKJLQNj+710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qGMQL8yN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729140475; x=1760676475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z6t5jam2u2/qWSb3wbi2/QDu1djFH81oyHBk5nMiNsg=;
  b=qGMQL8yNzP0Fd1DIssaBSVEupGUEdoDMA7mwB/5qJIW+hQoOHby94WDs
   Yzzd0QMlLwc9BOkOkbtUVl/kNUyelkI1xAVKFoZKWjSEHejIwuNbOfybk
   /q9vm4ANkGMwIX2VDFsWqqxu4gaZGgBZ8cnUkxZmzTKl76QoDD4q/gmrN
   xGXZ1nZg4MgglBJWP033vV1e0FpSxmmxF/HCrOEQloBkb/WT5Csuf9rIF
   1/C7Q6K3JDWNPPceavVC8kCe+wWYMA1JIOR4FZbNanIdYSnCf2skbg9LQ
   O1OudMq8Nu5Caqq1GYksrmjqA255NxQMwEJ0AjqtfGbK7lo7UGBahEMUe
   w==;
X-CSE-ConnectionGUID: 8pbTCNeqT7aHxiJ1HBLGWw==
X-CSE-MsgGUID: xiMjuXNmTMS+F8IIOLsAwA==
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="200553966"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2024 21:47:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 16 Oct 2024 21:47:27 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 16 Oct 2024 21:47:22 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<mohan.prasad@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<willemb@google.com>, <petrm@nvidia.com>
Subject: [PATCH net-next v3 1/3] selftests: nic_link_layer: Add link layer selftest for NIC driver
Date: Thu, 17 Oct 2024 03:20:05 +0530
Message-ID: <20241016215014.401476-2-mohan.prasad@microchip.com>
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

Add selftest file for the link layer tests of a NIC driver.
Test for auto-negotiation is added.
Add LinkConfig class for changing link layer configs.
Selftest makes use of ksft modules and ethtool.
Include selftest file in the Makefile.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   1 +
 .../drivers/net/hw/lib/py/linkconfig.py       | 220 ++++++++++++++++++
 .../drivers/net/hw/nic_link_layer.py          |  84 +++++++
 4 files changed, 306 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/nic_link_layer.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index c9f2f48fc..0dac40c4e 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -10,6 +10,7 @@ TEST_PROGS = \
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
index 000000000..86cbf10a3
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
@@ -0,0 +1,220 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import cmd
+from lib.py import ethtool
+from lib.py import ksft_pr, ksft_eq
+import re
+import time
+import json
+
+#The LinkConfig class is implemented to handle the link layer configurations.
+#Required minimum ethtool version is 6.10
+#The ethtool and ip would require authentication to make changes, so better
+# to check them for sudo privileges for interruption free testing.
+
+class LinkConfig:
+    """Class for handling the link layer configurations"""
+    def __init__(self, cfg):
+        self.cfg = cfg
+        self.partner_netif = self.get_partner_netif_name()
+
+        """Get the initial link configuration of local interface"""
+        self.common_link_modes = self.get_common_link_modes()
+
+    def get_partner_netif_name(self):
+        partner_netif = None
+        try:
+            """Get partner interface name"""
+            partner_cmd = f"ip -o -f inet addr show | grep '{self.cfg.remote_addr}' " + "| awk '{print $2}'"
+            partner_output = cmd(partner_cmd, host=self.cfg.remote)
+            partner_netif = partner_output.stdout.strip()
+            ksft_pr(f"Partner Interface name: {partner_netif}")
+        except Exception as e:
+            print(f"Unexpected error occurred: {e}")
+        self.partner_netif = partner_netif
+        return partner_netif
+
+    def verify_link_up(self):
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
+    def reset_interface(self, local=True, remote=True):
+        ksft_pr("Resetting interfaces in local and remote")
+        if remote:
+            if self.partner_netif is not None:
+                ifname = self.partner_netif
+                link_up_cmd = f"sudo ip link set up {ifname}"
+                link_down_cmd = f"sudo ip link set down {ifname}"
+                reset_cmd = f"{link_down_cmd} && sleep 5 && {link_up_cmd}"
+                try:
+                    cmd(f"{reset_cmd}", host=self.cfg.remote)
+                except Exception as e:
+                    ksft_pr("Check sudo permission for ip command")
+                    ksft_pr(f"Unexpected error occurred: {e}")
+            else:
+                ksft_pr("Partner interface not available")
+        if local:
+            ifname = self.cfg.ifname
+            link_up_cmd = f"sudo ip link set up {ifname}"
+            link_down_cmd = f"sudo ip link set down {ifname}"
+            reset_cmd = f"{link_down_cmd} && sleep 5 && {link_up_cmd}"
+            try:
+                cmd(f"{reset_cmd}")
+            except Exception as e:
+                ksft_pr("Check sudo permission for ip command")
+                ksft_pr(f"Unexpected error occurred: {e}")
+        time.sleep(10)
+        if self.verify_link_up() and self.get_ethtool_field("link-detected"):
+            ksft_pr("Local and remote interfaces reset to original state")
+            return True
+        else:
+            return False
+
+    def set_speed_and_duplex(self, speed: str, duplex: str, autoneg=True):
+        """Set the speed and duplex state for the interface"""
+        autoneg_state = "on" if autoneg is True else "off"
+        process = None
+        try:
+            process = ethtool(f"--change {self.cfg.ifname} speed {speed} duplex {duplex} autoneg {autoneg_state}")
+        except Exception as e:
+            ksft_pr(f"Unexpected error occurred: {e}")
+        if process is None or process.ret != 0:
+            return False
+        else:
+            ksft_pr(f"Speed: {speed} Mbps, Duplex: {duplex} set for Interface: {self.cfg.ifname}")
+            return True
+
+    def verify_speed_and_duplex(self, expected_speed: str, expected_duplex: str):
+        if self.verify_link_up() == False:
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
+    def set_autonegotiation_state(self, state: str, remote=False):
+        common_link_modes = self.common_link_modes
+        speeds, duplex_modes = self.get_speed_duplex_values(self.common_link_modes)
+        speed = speeds[0]
+        duplex = duplex_modes[0]
+        if not speed or not duplex:
+            ksft_pr("No speed or duplex modes found")
+            return False
+
+        speed_duplex_cmd = f"speed {speed} duplex {duplex}" if state == "off" else ""
+        if remote==True:
+            """Set the autonegotiation state for the partner"""
+            command = f"sudo ethtool -s {self.partner_netif} {speed_duplex_cmd} autoneg {state}"
+            partner_autoneg_change = None
+            """Set autonegotiation state for interface in remote pc"""
+            try:
+                partner_autoneg_change = cmd(command, host=self.cfg.remote)
+            except Exception as e:
+                ksft_pr("Check sudo permission for ethtool")
+                ksft_pr(f"Unexpected error occurred: {e}")
+            if partner_autoneg_change is None or partner_autoneg_change.ret != 0:
+                ksft_pr(f"Not able to set autoneg parameter for interface {self.partner_netif}. Check permissions for ethtool.")
+                return False
+            ksft_pr(f"Autoneg set as {state} for {self.partner_netif}")
+        else:
+            process = None
+            """Set the autonegotiation state for the interface"""
+            try:
+                process = ethtool(f"-s {self.cfg.ifname} {speed_duplex_cmd} autoneg {state}")
+            except Exception as e:
+                ksft_pr("Check sudo permission for ethtool")
+                ksft_pr(f"Unexpected error occurred: {e}")
+            if process is None or process.ret != 0:
+                ksft_pr(f"Not able to set autoneg parameter for interface {self.cfg.ifname}")
+                return False
+            ksft_pr(f"Autoneg set as {state} for {self.cfg.ifname}")
+        return True
+
+    def check_autoneg_supported(self, remote=False):
+        if remote==False:
+            local_autoneg = self.get_ethtool_field("supports-auto-negotiation")
+            if local_autoneg is None:
+                ksft_pr(f"Unable to fetch auto-negotiation status for interface {self.cfg.ifname}")
+            """Return autoneg status of the local interface"""
+            status = True if local_autoneg == True else False
+            return status
+        else:
+            """Check remote auto-negotiation support status"""
+            partner_autoneg = False
+            if self.partner_netif is not None:
+                partner_autoneg = self.get_ethtool_field("supports-auto-negotiation", remote=True)
+                if partner_autoneg is None:
+                    ksft_pr(f"Unable to fetch auto-negotiation status for interface {partner_netif}")
+            status = True if partner_autoneg is True else False
+            return status
+
+    def get_common_link_modes(self):
+        common_link_modes = None
+        """Populate common link modes"""
+        link_modes = self.get_ethtool_field("supported-link-modes")
+        partner_link_modes = self.get_ethtool_field("link-partner-advertised-link-modes")
+        if link_modes is None:
+            raise Exception(f"Link modes not available for {self.cfg.ifname}")
+        if partner_link_modes is None:
+            raise Exception(f"Partner link modes not available for {self.cfg.ifname}")
+        common_link_modes = set(link_modes) and set(partner_link_modes)
+        return common_link_modes
+
+    def get_speed_duplex_values(self, link_modes):
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
+    def get_ethtool_field(self, field: str, remote=False):
+        process = None
+        if remote == False:
+            """Get the ethtool field value for the local interface"""
+            ifname = self.cfg.ifname
+            try:
+                process = ethtool(f"--json {ifname}")
+            except Exception as e:
+                ksft_pr("Required minimum ethtool version is 6.10")
+                ksft_pr(f"Unexpected error occurred: {e}")
+        else:
+            """Get the ethtool field value for the remote interface"""
+            remote = True
+            ifname = self.partner_netif
+            self.cfg.require_cmd("ethtool", remote)
+            command = f"ethtool --json {ifname}"
+            try:
+                process = cmd(command, host=self.cfg.remote)
+            except Exception as e:
+                ksft_pr("Required minimum ethtool version is 6.10")
+                ksft_pr("Unexpected error occurred: {e}")
+        if process is None or process.ret != 0:
+            print(f"Error while getting the ethtool content for interface {ifname}. Required minimum ethtool version is 6.10")
+            return None
+        output = json.loads(process.stdout)
+        json_data = output[0]
+        """Check if the field exist in the json data"""
+        if field not in json_data:
+            raise Exception(f"Field {field} does not exist in the output of interface {json_data["ifname"]}")
+            return None
+        return json_data[field]
diff --git a/tools/testing/selftests/drivers/net/hw/nic_link_layer.py b/tools/testing/selftests/drivers/net/hw/nic_link_layer.py
new file mode 100644
index 000000000..fb046efbe
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nic_link_layer.py
@@ -0,0 +1,84 @@
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
+#To prevent interruptions, Add ethtool, ip to the sudoers list in remote PC and get the ssh key from remote.
+#Required minimum ethtool version is 6.10
+#Change the below configuration based on your hw needs.
+# """Default values"""
+time_delay = 8 #time taken to wait for transitions to happen, in seconds.
+test_duration = 10  #performance test duration for the throughput check, in seconds.
+
+import time
+from lib.py import ksft_run, ksft_exit, ksft_pr, ksft_eq
+from lib.py import KsftFailEx, KsftSkipEx
+from lib.py import NetDrvEpEnv
+from lib.py import LinkConfig
+
+def verify_autonegotiation(cfg, expected_state: str, link_config) -> None:
+    if link_config.verify_link_up() == False:
+        raise KsftSkipEx(f"Link state of interface {cfg.ifname} is DOWN")
+    """Verifying the autonegotiation state in partner"""
+    partner_autoneg_output = link_config.get_ethtool_field("auto-negotiation", remote=True)
+    if partner_autoneg_output is None:
+        KsftSkipEx(f"Auto-negotiation state not available for interface {link_config.partner_netif}")
+    partner_autoneg_state = "on" if partner_autoneg_output is True else "off"
+
+    ksft_eq(partner_autoneg_state, expected_state)
+
+    """Verifying the autonegotiation state"""
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
+def test_autonegotiation(cfg, link_config) -> None:
+    if link_config.partner_netif == None:
+        KsftSkipEx("Partner interface name is not available")
+    if not link_config.check_autoneg_supported() or not link_config.check_autoneg_supported(remote=True):
+        KsftSkipEx(f"Auto-negotiation not supported for interface {cfg.ifname} or {link_config.partner_netif}")
+    for state in ["off", "on"]:
+        if link_config.set_autonegotiation_state(state, remote=True) == False:
+            raise KsftSkipEx(f"Unable to set auto-negotiation state for interface {link_config.partner_netif}")
+        if link_config.set_autonegotiation_state(state) == False:
+            raise KsftSkipEx(f"Unable to set auto-negotiation state for interface {cfg.ifname}")
+        time.sleep(time_delay)
+        verify_autonegotiation(cfg, state, link_config)
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


