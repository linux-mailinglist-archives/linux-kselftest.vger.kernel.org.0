Return-Path: <linux-kselftest+bounces-37616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDA5B0AEB6
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 10:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F471C21E9A
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 08:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5281D237717;
	Sat, 19 Jul 2025 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8TgJRm6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348A237708;
	Sat, 19 Jul 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752913893; cv=none; b=lgRf3QLyRn/GXUcHTmjyq1XoTSRPkmcaOQzDvuTZ7toVDJvkeLtJ04qJ8088QrjUORcwNTtYwXuQZA5wNn395PoWF221VDtjhvDYPPunMW7Mwv/fuYbjWGGpU1v3jhUk51ojQDI+9FNfGGBQoyKfReNk+5bP2gh3RnDr7IeWucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752913893; c=relaxed/simple;
	bh=rvJeC9NtG6GWmSLmynjcKxTkoXCMwQwqqyEYujmIQf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AARIvg6tdOd7VjxxGX7HNeScGUaNrO55e1lBy/8vePLt4k+dlbu7GpVEZi0akeoUXp8lFaun7ZA1U3bpuQMZQhufqyOLl5+2AC+7GVlzobxXaq61HjdvqV0dhxSlBWej1U88KhFRZvDeT4NE1aQsYJOIpM8MUbdRip4cehAlV5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8TgJRm6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d54214adso20351505e9.3;
        Sat, 19 Jul 2025 01:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752913889; x=1753518689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJyLDB4U23RWT+0oCnkRU1HjwJBJkzDTi48ZtRrT2Xo=;
        b=L8TgJRm68s51pu2KBgt6Gydu3B/KVbQlHwc0REBFYDml1AUW4pqGhTx/qB9/XvQdGm
         QobPvHrQE9kdIrz4hZ9uPeiiLaEuX9NVkpXo4YLbEGgAcVYbqYs9qaU/+z8Ur1DjU7pw
         2g9Y0OAmdpC3nuvhc75dDs7L4UdZSVHVdPy5Y5AiNkJG8EDu2GLdCLUn+eB4EVxU3S8k
         BK0kPeLzI+arZPefLe7EI1NP/yb5lRcfVgo9D82zlrztVvyeCviKd3cizpdAuTPfPVKM
         LonkCU/SQ/zx9vNUFwThzJyzl1z0BCbYmHeWbB1yDG1pLp/L7xyJoJOTBKWPtFZkcBtA
         1LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752913889; x=1753518689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJyLDB4U23RWT+0oCnkRU1HjwJBJkzDTi48ZtRrT2Xo=;
        b=fQDx6HbeQsOSlELZs+JD1IzohhDKVefG9e2PcrsFMWbHbcbTuZendiGn0YB0b/2ZCR
         i8VsVdrPQIoW2du3Xtm19dfRS3zmMj9Vywrom/ISWRV1yGPKE1vUixemABV1imIHlLDS
         0GEWlmGCKmhcFEAA/HEWLNURi3gqCu8qGl2P6y6AwnL4zSqYkxy4g5Lyn/0gmRpSpI9B
         5QA6VnHYPq+NNHBpd31H2Et0XnhQSkhGlbGB2oKmVuZKbE0wZs7IrUcJeBT/J1ppbJMI
         zXhr1hlbx6QvpOSE4QcVHDMzXIUyYOnF9LK/0qhDnwGyUHhjXhVO0dLAiYfFBHqcArAX
         losQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGKbd5mRBTBgwzbhHZlsyRo7tUjUTMJ+OK9dzIB145bg7bfM7URXLr1mVhf3tjEMHD+IEjw3W2MQLZlx3p/o8e@vger.kernel.org, AJvYcCXS81g7QDwFU3EdAAlwvuUlOHOZwB7sl6vPuSao86Cs8XUXJ+Q5dSToggAmZrYwOE+VWxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzye/pjZzaeD0yt2rPp5os1YLrZdDIuDej1Hxy2Tlrdn+NPF5GH
	n1bd1K6GwCbUHgYuxj7lvrl0fU+QdGhn1QR0bMgswXk/iAINoCgVvC8d1cue4eLE
X-Gm-Gg: ASbGncthpG5V/id9JUi8FwzRrBEfhNrV50HzZHqe0E3omB+PHzTpneFxsjcOWiLu/IZ
	PF91+1k5RP3KMdZh0E5OjFcI7kB6LVBVUNbLHE8MYhQjlVvl210qr4aMCcFW8tneWotQLnPRoNf
	dccEpn+4szoc7hdUBT+I9+oVYk6zsxq9X4BZgud4X/Mw/uz9b+Wh/250pHbH9LkFol/6Z4VHrm/
	ueNdw36AQzsPEoSMl6390+C84+erGD+SxKBl2hKQy8tVmzdKpPiWgmBn5+np59VDPy55o/Ytj7i
	Y+s/bCavI130AX+8DjJbVUsYK+HFDWUkxV7dg4KXOk6w9GOvjzVhJ0tkxvuuQqcqkg2RH4uL6Sf
	ye2AgUVlfPqZyvhXZYNc=
X-Google-Smtp-Source: AGHT+IEkq0/v7hkT587yBkpPs59mQI/UuVc3yA16QCJlWHtCt/cM8SikTMW7KWeBurYPBhXpv5rO7g==
X-Received: by 2002:a05:600c:450a:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-456352e8aa8mr103857545e9.12.1752913888214;
        Sat, 19 Jul 2025 01:31:28 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:9::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bac1sm4135399f8f.25.2025.07.19.01.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 01:31:27 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	cratiu@nvidia.com,
	noren@nvidia.com,
	cjubran@nvidia.com,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	jdamato@fastly.com,
	gal@nvidia.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next V6 2/5] selftests: drv-net: Test XDP_PASS/DROP support
Date: Sat, 19 Jul 2025 01:30:56 -0700
Message-ID: <20250719083059.3209169-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test XDP_PASS/DROP in single buffer and multi buffer mode when
XDP native support is available.

./drivers/net/xdp.py
TAP version 13
1..4
ok 1 xdp.test_xdp_native_pass_sb
ok 2 xdp.test_xdp_native_pass_mb
ok 3 xdp.test_xdp_native_drop_sb
ok 4 xdp.test_xdp_native_drop_mb
\# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/xdp.py    | 303 ++++++++++++++++++
 .../selftests/net/lib/xdp_native.bpf.c        | 158 +++++++++
 3 files changed, 462 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/xdp.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_native.bpf.c

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 9bd84d6b542e..3556f3563e08 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -22,6 +22,7 @@ TEST_PROGS := \
 	stats.py \
 	shaper.py \
 	hds.py \
+	xdp.py \
 # end of TEST_PROGS
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
new file mode 100755
index 000000000000..8ab1607edcd8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -0,0 +1,303 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+This file contains tests to verify native XDP support in network drivers.
+The tests utilize the BPF program `xdp_native.bpf.o` from the `selftests.net.lib`
+directory, with each test focusing on a specific aspect of XDP functionality.
+"""
+import random
+import string
+from dataclasses import dataclass
+from enum import Enum
+
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ne
+from lib.py import KsftFailEx, NetDrvEpEnv
+from lib.py import bkg, cmd, rand_port
+from lib.py import ip, bpftool, defer
+
+
+class TestConfig(Enum):
+    """Enum for XDP configuration options."""
+    MODE = 0  # Configures the BPF program for a specific test
+    PORT = 1  # Port configuration to communicate with the remote host
+
+
+class XDPAction(Enum):
+    """Enum for XDP actions."""
+    PASS = 0  # Pass the packet up to the stack
+    DROP = 1  # Drop the packet
+
+
+class XDPStats(Enum):
+    """Enum for XDP statistics."""
+    RX = 0    # Count of valid packets received for testing
+    PASS = 1  # Count of packets passed up to the stack
+    DROP = 2  # Count of packets dropped
+
+
+@dataclass
+class BPFProgInfo:
+    """Data class to store information about a BPF program."""
+    name: str               # Name of the BPF program
+    file: str               # BPF program object file
+    xdp_sec: str = "xdp"    # XDP section name (e.g., "xdp" or "xdp.frags")
+    mtu: int = 1500         # Maximum Transmission Unit, default is 1500
+
+
+def _exchg_udp(cfg, port, test_string):
+    """
+    Exchanges UDP packets between a local and remote host using the socat tool.
+
+    Args:
+        cfg: Configuration object containing network settings.
+        port: Port number to use for the UDP communication.
+        test_string: String that the remote host will send.
+
+    Returns:
+        The string received by the test host.
+    """
+    cfg.require_cmd("socat", remote=True)
+
+    rx_udp_cmd = f"socat -{cfg.addr_ipver} -T 2 -u UDP-RECV:{port},reuseport STDOUT"
+    tx_udp_cmd = f"echo -n {test_string} | socat -t 2 -u STDIN UDP:{cfg.baddr}:{port}"
+
+    with bkg(rx_udp_cmd, exit_wait=True) as nc:
+        cmd(tx_udp_cmd, host=cfg.remote, shell=True)
+
+    return nc.stdout.strip()
+
+
+def _test_udp(cfg, port, size=256):
+    """
+    Tests UDP packet exchange between a local and remote host.
+
+    Args:
+        cfg: Configuration object containing network settings.
+        port: Port number to use for the UDP communication.
+        size: The length of the test string to be exchanged, default is 256 characters.
+
+    Returns:
+        bool: True if the received string matches the sent string, False otherwise.
+    """
+    test_str = "".join(random.choice(string.ascii_lowercase) for _ in range(size))
+    recvd_str = _exchg_udp(cfg, port, test_str)
+
+    return recvd_str == test_str
+
+
+def _load_xdp_prog(cfg, bpf_info):
+    """
+    Loads an XDP program onto a network interface.
+
+    Args:
+        cfg: Configuration object containing network settings.
+        bpf_info: BPFProgInfo object containing information about the BPF program.
+
+    Returns:
+        dict: A dictionary containing the XDP program ID, name, and associated map IDs.
+    """
+    abs_path = cfg.net_lib_dir / bpf_info.file
+    prog_info = {}
+
+    cmd(f"ip link set dev {cfg.remote_ifname} mtu {bpf_info.mtu}", shell=True, host=cfg.remote)
+    defer(ip, f"link set dev {cfg.remote_ifname} mtu 1500", host=cfg.remote)
+
+    cmd(
+    f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdp obj {abs_path} sec {bpf_info.xdp_sec}",
+    shell=True
+    )
+    defer(ip, f"link set dev {cfg.ifname} mtu 1500 xdp off")
+
+    xdp_info = ip(f"-d link show dev {cfg.ifname}", json=True)[0]
+    prog_info["id"] = xdp_info["xdp"]["prog"]["id"]
+    prog_info["name"] = xdp_info["xdp"]["prog"]["name"]
+    prog_id = prog_info["id"]
+
+    map_ids = bpftool(f"prog show id {prog_id}", json=True)["map_ids"]
+    prog_info["maps"] = {}
+    for map_id in map_ids:
+        name = bpftool(f"map show id {map_id}", json=True)["name"]
+        prog_info["maps"][name] = map_id
+
+    return prog_info
+
+
+def format_hex_bytes(value):
+    """
+    Helper function that converts an integer into a formatted hexadecimal byte string.
+
+    Args:
+        value: An integer representing the number to be converted.
+
+    Returns:
+        A string representing hexadecimal equivalent of value, with bytes separated by spaces.
+    """
+    hex_str = value.to_bytes(4, byteorder='little', signed=True)
+    return ' '.join(f'{byte:02x}' for byte in hex_str)
+
+
+def _set_xdp_map(map_name, key, value):
+    """
+    Updates an XDP map with a given key-value pair using bpftool.
+
+    Args:
+        map_name: The name of the XDP map to update.
+        key: The key to update in the map, formatted as a hexadecimal string.
+        value: The value to associate with the key, formatted as a hexadecimal string.
+    """
+    key_formatted = format_hex_bytes(key)
+    value_formatted = format_hex_bytes(value)
+    bpftool(
+        f"map update name {map_name} key hex {key_formatted} value hex {value_formatted}"
+    )
+
+
+def _get_stats(xdp_map_id):
+    """
+    Retrieves and formats statistics from an XDP map.
+
+    Args:
+        xdp_map_id: The ID of the XDP map from which to retrieve statistics.
+
+    Returns:
+        A dictionary containing formatted packet statistics for various XDP actions.
+        The keys are based on the XDPStats Enum values.
+
+    Raises:
+        KsftFailEx: If the stats retrieval fails.
+    """
+    stats_dump = bpftool(f"map dump id {xdp_map_id}", json=True)
+    if not stats_dump:
+        raise KsftFailEx(f"Failed to get stats for map {xdp_map_id}")
+
+    stats_formatted = {}
+    for key in range(0, 4):
+        val = stats_dump[key]["formatted"]["value"]
+        if stats_dump[key]["formatted"]["key"] == XDPStats.RX.value:
+            stats_formatted[XDPStats.RX.value] = val
+        elif stats_dump[key]["formatted"]["key"] == XDPStats.PASS.value:
+            stats_formatted[XDPStats.PASS.value] = val
+        elif stats_dump[key]["formatted"]["key"] == XDPStats.DROP.value:
+            stats_formatted[XDPStats.DROP.value] = val
+
+    return stats_formatted
+
+
+def _test_pass(cfg, bpf_info, msg_sz):
+    """
+    Tests the XDP_PASS action by exchanging UDP packets.
+
+    Args:
+        cfg: Configuration object containing network settings.
+        bpf_info: BPFProgInfo object containing information about the BPF program.
+        msg_sz: Size of the test message to send.
+    """
+
+    prog_info = _load_xdp_prog(cfg, bpf_info)
+    port = rand_port()
+
+    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.PASS.value)
+    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+
+    ksft_eq(_test_udp(cfg, port, msg_sz), True, "UDP packet exchange failed")
+    stats = _get_stats(prog_info["maps"]["map_xdp_stats"])
+
+    ksft_ne(stats[XDPStats.RX.value], 0, "RX stats should not be zero")
+    ksft_eq(stats[XDPStats.RX.value], stats[XDPStats.PASS.value], "RX and PASS stats mismatch")
+
+
+def test_xdp_native_pass_sb(cfg):
+    """
+    Tests the XDP_PASS action for single buffer case.
+
+    Args:
+        cfg: Configuration object containing network settings.
+    """
+    bpf_info = BPFProgInfo("xdp_prog", "xdp_native.bpf.o", "xdp", 1500)
+
+    _test_pass(cfg, bpf_info, 256)
+
+
+def test_xdp_native_pass_mb(cfg):
+    """
+    Tests the XDP_PASS action for a multi-buff size.
+
+    Args:
+        cfg: Configuration object containing network settings.
+    """
+    bpf_info = BPFProgInfo("xdp_prog_frags", "xdp_native.bpf.o", "xdp.frags", 9000)
+
+    _test_pass(cfg, bpf_info, 8000)
+
+
+def _test_drop(cfg, bpf_info, msg_sz):
+    """
+    Tests the XDP_DROP action by exchanging UDP packets.
+
+    Args:
+        cfg: Configuration object containing network settings.
+        bpf_info: BPFProgInfo object containing information about the BPF program.
+        msg_sz: Size of the test message to send.
+    """
+
+    prog_info = _load_xdp_prog(cfg, bpf_info)
+    port = rand_port()
+
+    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.DROP.value)
+    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+
+    ksft_eq(_test_udp(cfg, port, msg_sz), False, "UDP packet exchange should fail")
+    stats = _get_stats(prog_info["maps"]["map_xdp_stats"])
+
+    ksft_ne(stats[XDPStats.RX.value], 0, "RX stats should be zero")
+    ksft_eq(stats[XDPStats.RX.value], stats[XDPStats.DROP.value], "RX and DROP stats mismatch")
+
+
+def test_xdp_native_drop_sb(cfg):
+    """
+    Tests the XDP_DROP action for a signle-buff case.
+
+    Args:
+        cfg: Configuration object containing network settings.
+    """
+    bpf_info = BPFProgInfo("xdp_prog", "xdp_native.bpf.o", "xdp", 1500)
+
+    _test_drop(cfg, bpf_info, 256)
+
+
+def test_xdp_native_drop_mb(cfg):
+    """
+    Tests the XDP_DROP action for a multi-buff case.
+
+    Args:
+        cfg: Configuration object containing network settings.
+    """
+    bpf_info = BPFProgInfo("xdp_prog_frags", "xdp_native.bpf.o", "xdp.frags", 9000)
+
+    _test_drop(cfg, bpf_info, 8000)
+
+
+def main():
+    """
+    Main function to execute the XDP tests.
+
+    This function runs a series of tests to validate the XDP support for
+    both the single and multi-buffer. It uses the NetDrvEpEnv context
+    manager to manage the network driver environment and the ksft_run
+    function to execute the tests.
+    """
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run(
+            [
+                test_xdp_native_pass_sb,
+                test_xdp_native_pass_mb,
+                test_xdp_native_drop_sb,
+                test_xdp_native_drop_mb,
+            ],
+            args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
new file mode 100644
index 000000000000..90b34b2a4fef
--- /dev/null
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <linux/in.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/udp.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+enum {
+	XDP_MODE = 0,
+	XDP_PORT = 1,
+} xdp_map_setup_keys;
+
+enum {
+	XDP_MODE_PASS = 0,
+	XDP_MODE_DROP = 1,
+} xdp_map_modes;
+
+enum {
+	STATS_RX = 0,
+	STATS_PASS = 1,
+	STATS_DROP = 2,
+} xdp_stats;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__type(value, __s32);
+} map_xdp_setup SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 4);
+	__type(key, __u32);
+	__type(value, __u64);
+} map_xdp_stats SEC(".maps");
+
+static void record_stats(struct xdp_md *ctx, __u32 stat_type)
+{
+	__u64 *count;
+
+	count = bpf_map_lookup_elem(&map_xdp_stats, &stat_type);
+
+	if (count)
+		__sync_fetch_and_add(count, 1);
+}
+
+static struct udphdr *filter_udphdr(struct xdp_md *ctx, __u16 port)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	struct udphdr *udph = NULL;
+	struct ethhdr *eth = data;
+
+	if (data + sizeof(*eth) > data_end)
+		return NULL;
+
+	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		struct iphdr *iph = data + sizeof(*eth);
+
+		if (iph + 1 > (struct iphdr *)data_end ||
+		    iph->protocol != IPPROTO_UDP)
+			return NULL;
+
+		udph = (void *)eth + sizeof(*iph) + sizeof(*eth);
+	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
+		struct ipv6hdr *ipv6h = data + sizeof(*eth);
+
+		if (ipv6h + 1 > (struct ipv6hdr *)data_end ||
+		    ipv6h->nexthdr != IPPROTO_UDP)
+			return NULL;
+
+		udph = (void *)eth + sizeof(*ipv6h) + sizeof(*eth);
+	} else {
+		return NULL;
+	}
+
+	if (udph + 1 > (struct udphdr *)data_end)
+		return NULL;
+
+	if (udph->dest != bpf_htons(port))
+		return NULL;
+
+	record_stats(ctx, STATS_RX);
+
+	return udph;
+}
+
+static int xdp_mode_pass(struct xdp_md *ctx, __u16 port)
+{
+	struct udphdr *udph = NULL;
+
+	udph = filter_udphdr(ctx, port);
+	if (!udph)
+		return XDP_PASS;
+
+	record_stats(ctx, STATS_PASS);
+
+	return XDP_PASS;
+}
+
+static int xdp_mode_drop_handler(struct xdp_md *ctx, __u16 port)
+{
+	struct udphdr *udph = NULL;
+
+	udph = filter_udphdr(ctx, port);
+	if (!udph)
+		return XDP_PASS;
+
+	record_stats(ctx, STATS_DROP);
+
+	return XDP_DROP;
+}
+
+static int xdp_prog_common(struct xdp_md *ctx)
+{
+	__u32 key, *port;
+	__s32 *mode;
+
+	key = XDP_MODE;
+	mode = bpf_map_lookup_elem(&map_xdp_setup, &key);
+	if (!mode)
+		return XDP_PASS;
+
+	key = XDP_PORT;
+	port = bpf_map_lookup_elem(&map_xdp_setup, &key);
+	if (!port)
+		return XDP_PASS;
+
+	switch (*mode) {
+	case XDP_MODE_PASS:
+		return xdp_mode_pass(ctx, (__u16)(*port));
+	case XDP_MODE_DROP:
+		return xdp_mode_drop_handler(ctx, (__u16)(*port));
+	}
+
+	/* Default action is to simple pass */
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int xdp_prog(struct xdp_md *ctx)
+{
+	return xdp_prog_common(ctx);
+}
+
+SEC("xdp.frags")
+int xdp_prog_frags(struct xdp_md *ctx)
+{
+	return xdp_prog_common(ctx);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


