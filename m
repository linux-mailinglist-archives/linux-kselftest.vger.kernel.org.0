Return-Path: <linux-kselftest+bounces-32578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDFDAAE273
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 16:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F134D526375
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3515628A700;
	Wed,  7 May 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqDO+A5y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF668C1E;
	Wed,  7 May 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626475; cv=none; b=ovpSwZbdUVbyuf7j9RWmc2G44bwTrSiet79QE9WJ94HcRLbTpjIrKey/AHyk6usKfqUf60F8ieA+JakIMbPOd1ujDpn0pbMMB6e3hczkfhrv+OFjdSts0mqph5k5/AhPNZpAqChaZ6HCW7J2iWMzD5dCRug2rcVG2rf3fuqZkcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626475; c=relaxed/simple;
	bh=yBqI7NIqV/sLEMy8tOEvDqAOF0lvvbr4JN7lTU4D6pE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nw2wbXW8yjUcJvCmWuG6kkeaoBPsFGAWSLDBx9Fpeh/wtz5NRB+r2eFSqyXIGPcAJKQKmGWY9vPyazCfXKb88fzE7GYhuqNnWGZWVM0abIqjtzF66/bFds32oKgNrLxBV8AK08QPBdnG3V4pZ2teqX7jCzMEfFGdvvJ2TaLVoLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqDO+A5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E337C4CEE2;
	Wed,  7 May 2025 14:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746626474;
	bh=yBqI7NIqV/sLEMy8tOEvDqAOF0lvvbr4JN7lTU4D6pE=;
	h=From:To:Cc:Subject:Date:From;
	b=EqDO+A5yxJyaxi8RFg6HWKSr7J3KSsGOQVlh0bTxGHiwTaESWK3dwLv3Zs4Byexfl
	 z4BHXok5RL0w8LpKBlYXTXxucG5sEl5UWCxJGk4mSKPg4hse6f9saWeLG6NoZJPRzA
	 AZBm/bpEbCPpzni5Y7z0PIeMnf6nQqYTXoX6vfPR6QFUR7q9iRTktF6MeuEuOsso14
	 MZn/8GRJxxCOyOKmvKbIr0wKzc9LN2RRY9ouJE4zoEYtnTZx366YCw2rs31SX8NYbk
	 9ecH+8UOgfOe+csGbJajSkm3nADxTMAU/hK09Ttm7lJb+6G3jP+qgrSjGFnTl1jV6x
	 l9OPM2Jsd7nYg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	sdf@fomichev.me,
	mohan.prasad@microchip.com,
	dw@davidwei.uk,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net-drv: remove the nic_performance and nic_link_layer tests
Date: Wed,  7 May 2025 07:01:07 -0700
Message-ID: <20250507140109.929801-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Revert fbbf93556f0c ("selftests: nic_performance: Add selftest for performance of NIC driver")
Revert c087dc54394b ("selftests: nic_link_layer: Add selftest case for speed and duplex states")
Revert 6116075e18f7 ("selftests: nic_link_layer: Add link layer selftest for NIC driver")

These tests don't clean up after themselves, don't use the disruptive
annotations, don't get included in make install etc. etc. The tests
were added before we have any "HW" runner, so the issues were missed.
Our CI doesn't have any way of excluding broken tests, remove these
for now to stop the random pollution of results due to broken env.
We can always add them back once / if fixed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: sdf@fomichev.me
CC: mohan.prasad@microchip.com
CC: dw@davidwei.uk
CC: petrm@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 .../testing/selftests/drivers/net/hw/Makefile |   2 -
 .../drivers/net/hw/lib/py/__init__.py         |   1 -
 .../drivers/net/hw/lib/py/linkconfig.py       | 222 ------------------
 .../drivers/net/hw/nic_link_layer.py          | 113 ---------
 .../drivers/net/hw/nic_performance.py         | 137 -----------
 .../selftests/drivers/net/lib/py/load.py      |  20 +-
 6 files changed, 1 insertion(+), 494 deletions(-)
 delete mode 100644 tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
 delete mode 100644 tools/testing/selftests/drivers/net/hw/nic_link_layer.py
 delete mode 100644 tools/testing/selftests/drivers/net/hw/nic_performance.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 5447785c286e..df2c047ffa90 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -15,8 +15,6 @@ TEST_PROGS = \
 	iou-zcrx.py \
 	irq.py \
 	loopback.sh \
-	nic_link_layer.py \
-	nic_performance.py \
 	pp_alloc_fail.py \
 	rss_ctx.py \
 	rss_input_xfrm.py \
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 399789a9676a..b582885786f5 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -9,7 +9,6 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
     sys.path.append(KSFT_DIR.as_posix())
     from net.lib.py import *
     from drivers.net.lib.py import *
-    from .linkconfig import LinkConfig
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `net` library from kernel sources")
     ksft_pr(str(e))
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py b/tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
deleted file mode 100644
index 79fde603cbbc..000000000000
--- a/tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
+++ /dev/null
@@ -1,222 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-from lib.py import cmd, ethtool, ip
-from lib.py import ksft_pr, ksft_eq, KsftSkipEx
-from typing import Optional
-import re
-import time
-import json
-
-#The LinkConfig class is implemented to handle the link layer configurations.
-#Required minimum ethtool version is 6.10
-
-class LinkConfig:
-    """Class for handling the link layer configurations"""
-    def __init__(self, cfg: object) -> None:
-        self.cfg = cfg
-        self.partner_netif = self.get_partner_netif_name()
-
-        """Get the initial link configuration of local interface"""
-        self.common_link_modes = self.get_common_link_modes()
-
-    def get_partner_netif_name(self) -> Optional[str]:
-        partner_netif = None
-        try:
-            if not self.verify_link_up():
-                return None
-            """Get partner interface name"""
-            partner_json_output = ip("addr show", json=True, host=self.cfg.remote)
-            for interface in partner_json_output:
-                for addr in interface.get('addr_info', []):
-                    if addr.get('local') == self.cfg.remote_addr:
-                        partner_netif = interface['ifname']
-                        ksft_pr(f"Partner Interface name: {partner_netif}")
-            if partner_netif is None:
-                ksft_pr("Unable to get the partner interface name")
-        except Exception as e:
-            print(f"Unexpected error occurred while getting partner interface name: {e}")
-        self.partner_netif = partner_netif
-        return partner_netif
-
-    def verify_link_up(self) -> bool:
-        """Verify whether the local interface link is up"""
-        with open(f"/sys/class/net/{self.cfg.ifname}/operstate", "r") as fp:
-            link_state = fp.read().strip()
-
-        if link_state == "down":
-            ksft_pr(f"Link state of interface {self.cfg.ifname} is DOWN")
-            return False
-        else:
-            return True
-
-    def reset_interface(self, local: bool = True, remote: bool = True) -> bool:
-        ksft_pr("Resetting interfaces in local and remote")
-        if remote:
-            if self.verify_link_up():
-                if self.partner_netif is not None:
-                    ifname = self.partner_netif
-                    link_up_cmd = f"ip link set up {ifname}"
-                    link_down_cmd = f"ip link set down {ifname}"
-                    reset_cmd = f"{link_down_cmd} && sleep 5 && {link_up_cmd}"
-                    try:
-                        cmd(reset_cmd, host=self.cfg.remote)
-                    except Exception as e:
-                        ksft_pr(f"Unexpected error occurred while resetting remote: {e}")
-                else:
-                    ksft_pr("Partner interface not available")
-        if local:
-            ifname = self.cfg.ifname
-            link_up_cmd = f"ip link set up {ifname}"
-            link_down_cmd = f"ip link set down {ifname}"
-            reset_cmd = f"{link_down_cmd} && sleep 5 && {link_up_cmd}"
-            try:
-                cmd(reset_cmd)
-            except Exception as e:
-                ksft_pr(f"Unexpected error occurred while resetting local: {e}")
-        time.sleep(10)
-        if self.verify_link_up() and self.get_ethtool_field("link-detected"):
-            ksft_pr("Local and remote interfaces reset to original state")
-            return True
-        else:
-            ksft_pr("Error occurred after resetting interfaces. Link is DOWN.")
-            return False
-
-    def set_speed_and_duplex(self, speed: str, duplex: str, autoneg: bool = True) -> bool:
-        """Set the speed and duplex state for the interface"""
-        autoneg_state = "on" if autoneg is True else "off"
-        process = None
-        try:
-            process = ethtool(f"--change {self.cfg.ifname} speed {speed} duplex {duplex} autoneg {autoneg_state}")
-        except Exception as e:
-            ksft_pr(f"Unexpected error occurred while setting speed/duplex: {e}")
-        if process is None or process.ret != 0:
-            return False
-        else:
-            ksft_pr(f"Speed: {speed} Mbps, Duplex: {duplex} set for Interface: {self.cfg.ifname}")
-            return True
-
-    def verify_speed_and_duplex(self, expected_speed: str, expected_duplex: str) -> bool:
-        if not self.verify_link_up():
-            return False
-        """Verifying the speed and duplex state for the interface"""
-        with open(f"/sys/class/net/{self.cfg.ifname}/speed", "r") as fp:
-            actual_speed = fp.read().strip()
-        with open(f"/sys/class/net/{self.cfg.ifname}/duplex", "r") as fp:
-            actual_duplex = fp.read().strip()
-
-        ksft_eq(actual_speed, expected_speed)
-        ksft_eq(actual_duplex, expected_duplex)
-        return True
-
-    def set_autonegotiation_state(self, state: str, remote: bool = False) -> bool:
-        common_link_modes = self.common_link_modes
-        speeds, duplex_modes = self.get_speed_duplex_values(self.common_link_modes)
-        speed = speeds[0]
-        duplex = duplex_modes[0]
-        if not speed or not duplex:
-            ksft_pr("No speed or duplex modes found")
-            return False
-
-        speed_duplex_cmd = f"speed {speed} duplex {duplex}" if state == "off" else ""
-        if remote:
-            if not self.verify_link_up():
-                return False
-            """Set the autonegotiation state for the partner"""
-            command = f"-s {self.partner_netif} {speed_duplex_cmd} autoneg {state}"
-            partner_autoneg_change = None
-            """Set autonegotiation state for interface in remote pc"""
-            try:
-                partner_autoneg_change = ethtool(command, host=self.cfg.remote)
-            except Exception as e:
-                ksft_pr(f"Unexpected error occurred while changing auto-neg in remote: {e}")
-            if partner_autoneg_change is None or partner_autoneg_change.ret != 0:
-                ksft_pr(f"Not able to set autoneg parameter for interface {self.partner_netif}.")
-                return False
-            ksft_pr(f"Autoneg set as {state} for {self.partner_netif}")
-        else:
-            """Set the autonegotiation state for the interface"""
-            try:
-                process = ethtool(f"-s {self.cfg.ifname} {speed_duplex_cmd} autoneg {state}")
-                if process.ret != 0:
-                    ksft_pr(f"Not able to set autoneg parameter for interface {self.cfg.ifname}")
-                    return False
-            except Exception as e:
-                ksft_pr(f"Unexpected error occurred while changing auto-neg in local: {e}")
-                return False
-            ksft_pr(f"Autoneg set as {state} for {self.cfg.ifname}")
-        return True
-
-    def check_autoneg_supported(self, remote: bool = False) -> bool:
-        if not remote:
-            local_autoneg = self.get_ethtool_field("supports-auto-negotiation")
-            if local_autoneg is None:
-                ksft_pr(f"Unable to fetch auto-negotiation status for interface {self.cfg.ifname}")
-            """Return autoneg status of the local interface"""
-            return local_autoneg
-        else:
-            if not self.verify_link_up():
-                raise KsftSkipEx("Link is DOWN")
-            """Check remote auto-negotiation support status"""
-            partner_autoneg = False
-            if self.partner_netif is not None:
-                partner_autoneg = self.get_ethtool_field("supports-auto-negotiation", remote=True)
-                if partner_autoneg is None:
-                    ksft_pr(f"Unable to fetch auto-negotiation status for interface {self.partner_netif}")
-            return partner_autoneg
-
-    def get_common_link_modes(self) -> set[str]:
-        common_link_modes = []
-        """Populate common link modes"""
-        link_modes = self.get_ethtool_field("supported-link-modes")
-        partner_link_modes = self.get_ethtool_field("link-partner-advertised-link-modes")
-        if link_modes is None:
-            raise KsftSkipEx(f"Link modes not available for {self.cfg.ifname}")
-        if partner_link_modes is None:
-            raise KsftSkipEx(f"Partner link modes not available for {self.cfg.ifname}")
-        common_link_modes = set(link_modes) and set(partner_link_modes)
-        return common_link_modes
-
-    def get_speed_duplex_values(self, link_modes: list[str]) -> tuple[list[str], list[str]]:
-        speed = []
-        duplex = []
-        """Check the link modes"""
-        for data in link_modes:
-            parts = data.split('/')
-            speed_value = re.match(r'\d+', parts[0])
-            if speed_value:
-                speed.append(speed_value.group())
-            else:
-                ksft_pr(f"No speed value found for interface {self.ifname}")
-                return None, None
-            duplex.append(parts[1].lower())
-        return speed, duplex
-
-    def get_ethtool_field(self, field: str, remote: bool = False) -> Optional[str]:
-        process = None
-        if not remote:
-            """Get the ethtool field value for the local interface"""
-            try:
-                process = ethtool(self.cfg.ifname, json=True)
-            except Exception as e:
-                ksft_pr("Required minimum ethtool version is 6.10")
-                ksft_pr(f"Unexpected error occurred while getting ethtool field in local: {e}")
-                return None
-        else:
-            if not self.verify_link_up():
-                return None
-            """Get the ethtool field value for the remote interface"""
-            self.cfg.require_cmd("ethtool", remote=True)
-            if self.partner_netif is None:
-                ksft_pr(f"Partner interface name is unavailable.")
-                return None
-            try:
-                process = ethtool(self.partner_netif, json=True, host=self.cfg.remote)
-            except Exception as e:
-                ksft_pr("Required minimum ethtool version is 6.10")
-                ksft_pr(f"Unexpected error occurred while getting ethtool field in remote: {e}")
-                return None
-        json_data = process[0]
-        """Check if the field exist in the json data"""
-        if field not in json_data:
-            raise KsftSkipEx(f'Field {field} does not exist in the output of interface {json_data["ifname"]}')
-        return json_data[field]
diff --git a/tools/testing/selftests/drivers/net/hw/nic_link_layer.py b/tools/testing/selftests/drivers/net/hw/nic_link_layer.py
deleted file mode 100644
index efd921180532..000000000000
--- a/tools/testing/selftests/drivers/net/hw/nic_link_layer.py
+++ /dev/null
@@ -1,113 +0,0 @@
-#!/usr/bin/env python3
-# SPDX-License-Identifier: GPL-2.0
-
-#Introduction:
-#This file has basic link layer tests for generic NIC drivers.
-#The test comprises of auto-negotiation, speed and duplex checks.
-#
-#Setup:
-#Connect the DUT PC with NIC card to partner pc back via ethernet medium of your choice(RJ45, T1)
-#
-#        DUT PC                                              Partner PC
-#┌───────────────────────┐                         ┌──────────────────────────┐
-#│                       │                         │                          │
-#│                       │                         │                          │
-#│           ┌───────────┐                         │                          │
-#│           │DUT NIC    │         Eth             │                          │
-#│           │Interface ─┼─────────────────────────┼─    any eth Interface    │
-#│           └───────────┘                         │                          │
-#│                       │                         │                          │
-#│                       │                         │                          │
-#└───────────────────────┘                         └──────────────────────────┘
-#
-#Configurations:
-#Required minimum ethtool version is 6.10 (supports json)
-#Default values:
-#time_delay = 8 #time taken to wait for transitions to happen, in seconds.
-
-import time
-import argparse
-from lib.py import ksft_run, ksft_exit, ksft_pr, ksft_eq
-from lib.py import KsftFailEx, KsftSkipEx
-from lib.py import NetDrvEpEnv
-from lib.py import LinkConfig
-
-def _pre_test_checks(cfg: object, link_config: LinkConfig) -> None:
-    if link_config.partner_netif is None:
-        KsftSkipEx("Partner interface is not available")
-    if not link_config.check_autoneg_supported() or not link_config.check_autoneg_supported(remote=True):
-        KsftSkipEx(f"Auto-negotiation not supported for interface {cfg.ifname} or {link_config.partner_netif}")
-    if not link_config.verify_link_up():
-        raise KsftSkipEx(f"Link state of interface {cfg.ifname} is DOWN")
-
-def verify_autonegotiation(cfg: object, expected_state: str, link_config: LinkConfig) -> None:
-    if not link_config.verify_link_up():
-        raise KsftSkipEx(f"Link state of interface {cfg.ifname} is DOWN")
-    """Verifying the autonegotiation state in partner"""
-    partner_autoneg_output = link_config.get_ethtool_field("auto-negotiation", remote=True)
-    if partner_autoneg_output is None:
-        KsftSkipEx(f"Auto-negotiation state not available for interface {link_config.partner_netif}")
-    partner_autoneg_state = "on" if partner_autoneg_output is True else "off"
-
-    ksft_eq(partner_autoneg_state, expected_state)
-
-    """Verifying the autonegotiation state of local"""
-    autoneg_output = link_config.get_ethtool_field("auto-negotiation")
-    if autoneg_output is None:
-        KsftSkipEx(f"Auto-negotiation state not available for interface {cfg.ifname}")
-    actual_state = "on" if autoneg_output is True else "off"
-
-    ksft_eq(actual_state, expected_state)
-
-    """Verifying the link establishment"""
-    link_available = link_config.get_ethtool_field("link-detected")
-    if link_available is None:
-        KsftSkipEx(f"Link status not available for interface {cfg.ifname}")
-    if link_available != True:
-        raise KsftSkipEx("Link not established at interface {cfg.ifname} after changing auto-negotiation")
-
-def test_autonegotiation(cfg: object, link_config: LinkConfig, time_delay: int) -> None:
-    _pre_test_checks(cfg, link_config)
-    for state in ["off", "on"]:
-        if not link_config.set_autonegotiation_state(state, remote=True):
-            raise KsftSkipEx(f"Unable to set auto-negotiation state for interface {link_config.partner_netif}")
-        if not link_config.set_autonegotiation_state(state):
-            raise KsftSkipEx(f"Unable to set auto-negotiation state for interface {cfg.ifname}")
-        time.sleep(time_delay)
-        verify_autonegotiation(cfg, state, link_config)
-
-def test_network_speed(cfg: object, link_config: LinkConfig, time_delay: int) -> None:
-    _pre_test_checks(cfg, link_config)
-    common_link_modes = link_config.common_link_modes
-    if not common_link_modes:
-        KsftSkipEx("No common link modes exist")
-    speeds, duplex_modes = link_config.get_speed_duplex_values(common_link_modes)
-
-    if speeds and duplex_modes and len(speeds) == len(duplex_modes):
-        for idx in range(len(speeds)):
-            speed = speeds[idx]
-            duplex = duplex_modes[idx]
-            if not link_config.set_speed_and_duplex(speed, duplex):
-                raise KsftFailEx(f"Unable to set speed and duplex parameters for {cfg.ifname}")
-            time.sleep(time_delay)
-            if not link_config.verify_speed_and_duplex(speed, duplex):
-                raise KsftSkipEx(f"Error occurred while verifying speed and duplex states for interface {cfg.ifname}")
-    else:
-        if not speeds or not duplex_modes:
-            KsftSkipEx(f"No supported speeds or duplex modes found for interface {cfg.ifname}")
-        else:
-            KsftSkipEx("Mismatch in the number of speeds and duplex modes")
-
-def main() -> None:
-    parser = argparse.ArgumentParser(description="Run basic link layer tests for NIC driver")
-    parser.add_argument('--time-delay', type=int, default=8, help='Time taken to wait for transitions to happen(in seconds). Default is 8 seconds.')
-    args = parser.parse_args()
-    time_delay = args.time_delay
-    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
-        link_config = LinkConfig(cfg)
-        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, link_config, time_delay,))
-        link_config.reset_interface()
-    ksft_exit()
-
-if __name__ == "__main__":
-    main()
diff --git a/tools/testing/selftests/drivers/net/hw/nic_performance.py b/tools/testing/selftests/drivers/net/hw/nic_performance.py
deleted file mode 100644
index 201403b76ea3..000000000000
--- a/tools/testing/selftests/drivers/net/hw/nic_performance.py
+++ /dev/null
@@ -1,137 +0,0 @@
-#!/usr/bin/env python3
-# SPDX-License-Identifier: GPL-2.0
-
-#Introduction:
-#This file has basic performance test for generic NIC drivers.
-#The test comprises of throughput check for TCP and UDP streams.
-#
-#Setup:
-#Connect the DUT PC with NIC card to partner pc back via ethernet medium of your choice(RJ45, T1)
-#
-#        DUT PC                                              Partner PC
-#┌───────────────────────┐                         ┌──────────────────────────┐
-#│                       │                         │                          │
-#│                       │                         │                          │
-#│           ┌───────────┐                         │                          │
-#│           │DUT NIC    │         Eth             │                          │
-#│           │Interface ─┼─────────────────────────┼─    any eth Interface    │
-#│           └───────────┘                         │                          │
-#│                       │                         │                          │
-#│                       │                         │                          │
-#└───────────────────────┘                         └──────────────────────────┘
-#
-#Configurations:
-#To prevent interruptions, Add ethtool, ip to the sudoers list in remote PC and get the ssh key from remote.
-#Required minimum ethtool version is 6.10
-#Change the below configuration based on your hw needs.
-# """Default values"""
-#time_delay = 8 #time taken to wait for transitions to happen, in seconds.
-#test_duration = 10  #performance test duration for the throughput check, in seconds.
-#send_throughput_threshold = 80 #percentage of send throughput required to pass the check
-#receive_throughput_threshold = 50 #percentage of receive throughput required to pass the check
-
-import time
-import json
-import argparse
-from lib.py import ksft_run, ksft_exit, ksft_pr, ksft_true
-from lib.py import KsftFailEx, KsftSkipEx, GenerateTraffic
-from lib.py import NetDrvEpEnv, bkg, wait_port_listen
-from lib.py import cmd
-from lib.py import LinkConfig
-
-class TestConfig:
-    def __init__(self, time_delay: int, test_duration: int, send_throughput_threshold: int, receive_throughput_threshold: int) -> None:
-        self.time_delay = time_delay
-        self.test_duration = test_duration
-        self.send_throughput_threshold = send_throughput_threshold
-        self.receive_throughput_threshold = receive_throughput_threshold
-
-def _pre_test_checks(cfg: object, link_config: LinkConfig) -> None:
-    if not link_config.verify_link_up():
-        KsftSkipEx(f"Link state of interface {cfg.ifname} is DOWN")
-    common_link_modes = link_config.common_link_modes
-    if common_link_modes is None:
-        KsftSkipEx("No common link modes found")
-    if link_config.partner_netif == None:
-        KsftSkipEx("Partner interface is not available")
-    if link_config.check_autoneg_supported():
-        KsftSkipEx("Auto-negotiation not supported by local")
-    if link_config.check_autoneg_supported(remote=True):
-        KsftSkipEx("Auto-negotiation not supported by remote")
-    cfg.require_cmd("iperf3", remote=True)
-
-def check_throughput(cfg: object, link_config: LinkConfig, test_config: TestConfig, protocol: str, traffic: GenerateTraffic) -> None:
-    common_link_modes = link_config.common_link_modes
-    speeds, duplex_modes = link_config.get_speed_duplex_values(common_link_modes)
-    """Test duration in seconds"""
-    duration = test_config.test_duration
-
-    ksft_pr(f"{protocol} test")
-    test_type = "-u" if protocol == "UDP" else ""
-
-    send_throughput = []
-    receive_throughput = []
-    for idx in range(0, len(speeds)):
-        if link_config.set_speed_and_duplex(speeds[idx], duplex_modes[idx]) == False:
-            raise KsftFailEx(f"Not able to set speed and duplex parameters for {cfg.ifname}")
-        time.sleep(test_config.time_delay)
-        if not link_config.verify_link_up():
-            raise KsftSkipEx(f"Link state of interface {cfg.ifname} is DOWN")
-
-        send_command=f"{test_type} -b 0 -t {duration} --json"
-        receive_command=f"{test_type} -b 0 -t {duration} --reverse --json"
-
-        send_result = traffic.run_remote_test(cfg, command=send_command)
-        if send_result.ret != 0:
-            raise KsftSkipEx("Error occurred during data transmit: {send_result.stdout}")
-
-        send_output = send_result.stdout
-        send_data = json.loads(send_output)
-
-        """Convert throughput to Mbps"""
-        send_throughput.append(round(send_data['end']['sum_sent']['bits_per_second'] / 1e6, 2))
-        ksft_pr(f"{protocol}: Send throughput: {send_throughput[idx]} Mbps")
-
-        receive_result = traffic.run_remote_test(cfg, command=receive_command)
-        if receive_result.ret != 0:
-            raise KsftSkipEx("Error occurred during data receive: {receive_result.stdout}")
-
-        receive_output = receive_result.stdout
-        receive_data = json.loads(receive_output)
-
-        """Convert throughput to Mbps"""
-        receive_throughput.append(round(receive_data['end']['sum_received']['bits_per_second'] / 1e6, 2))
-        ksft_pr(f"{protocol}: Receive throughput: {receive_throughput[idx]} Mbps")
-
-    """Check whether throughput is not below the threshold (default values set at start)"""
-    for idx in range(0, len(speeds)):
-        send_threshold = float(speeds[idx]) * float(test_config.send_throughput_threshold / 100)
-        receive_threshold = float(speeds[idx]) * float(test_config.receive_throughput_threshold / 100)
-        ksft_true(send_throughput[idx] >= send_threshold, f"{protocol}: Send throughput is below threshold for {speeds[idx]} Mbps in {duplex_modes[idx]} duplex")
-        ksft_true(receive_throughput[idx] >= receive_threshold, f"{protocol}: Receive throughput is below threshold for {speeds[idx]} Mbps in {duplex_modes[idx]} duplex")
-
-def test_tcp_throughput(cfg: object, link_config: LinkConfig, test_config: TestConfig, traffic: GenerateTraffic) -> None:
-    _pre_test_checks(cfg, link_config)
-    check_throughput(cfg, link_config, test_config, 'TCP', traffic)
-
-def test_udp_throughput(cfg: object, link_config: LinkConfig, test_config: TestConfig, traffic: GenerateTraffic) -> None:
-    _pre_test_checks(cfg, link_config)
-    check_throughput(cfg, link_config, test_config, 'UDP', traffic)
-
-def main() -> None:
-    parser = argparse.ArgumentParser(description="Run basic performance test for NIC driver")
-    parser.add_argument('--time-delay', type=int, default=8, help='Time taken to wait for transitions to happen(in seconds). Default is 8 seconds.')
-    parser.add_argument('--test-duration', type=int, default=10, help='Performance test duration for the throughput check, in seconds. Default is 10 seconds.')
-    parser.add_argument('--stt', type=int, default=80, help='Send throughput Threshold: Percentage of send throughput upon actual throughput required to pass the throughput check (in percentage). Default is 80.')
-    parser.add_argument('--rtt', type=int, default=50, help='Receive throughput Threshold: Percentage of receive throughput upon actual throughput required to pass the throughput check (in percentage). Default is 50.')
-    args=parser.parse_args()
-    test_config = TestConfig(args.time_delay, args.test_duration, args.stt, args.rtt)
-    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
-        traffic = GenerateTraffic(cfg)
-        link_config = LinkConfig(cfg)
-        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, link_config, test_config, traffic,  ))
-        link_config.reset_interface()
-    ksft_exit()
-
-if __name__ == "__main__":
-    main()
diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index da5af2c680fa..d9c10613ae67 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -2,7 +2,7 @@
 
 import time
 
-from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen, bkg
+from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
 
 class GenerateTraffic:
     def __init__(self, env, port=None):
@@ -23,24 +23,6 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen, bkg
             self.stop(verbose=True)
             raise Exception("iperf3 traffic did not ramp up")
 
-    def run_remote_test(self, env: object, port=None, command=None):
-        if port is None:
-            port = rand_port()
-        try:
-            server_cmd = f"iperf3 -s 1 -p {port} --one-off"
-            with bkg(server_cmd, host=env.remote):
-                #iperf3 opens TCP connection as default in server
-                #-u to be specified in client command for UDP
-                wait_port_listen(port, host=env.remote)
-        except Exception as e:
-            raise Exception(f"Unexpected error occurred while running server command: {e}")
-        try:
-            client_cmd = f"iperf3 -c {env.remote_addr} -p {port} {command}"
-            proc = cmd(client_cmd)
-            return proc
-        except Exception as e:
-            raise Exception(f"Unexpected error occurred while running client command: {e}")
-
     def _wait_pkts(self, pkt_cnt=None, pps=None):
         """
         Wait until we've seen pkt_cnt or until traffic ramps up to pps.
-- 
2.49.0


