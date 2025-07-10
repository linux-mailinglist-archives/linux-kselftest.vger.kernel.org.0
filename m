Return-Path: <linux-kselftest+bounces-37034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2B8B00B97
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 20:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242FA3BF0D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9C32FCFF6;
	Thu, 10 Jul 2025 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBQK81Ou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA52FD581;
	Thu, 10 Jul 2025 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752173117; cv=none; b=WsjLeDmLa3DFACzXpWIwHb4Ab4c4oSqlV/I5IOI7S7djfk/hUxINJdXMuMSucBu2mRXTH8aM48LKqZpNkiVIVyN3HMKAaI1fmvquKcUYhrcJIOffEc/K+wFOzSCP64C0ZNmtXkCxbHjHvylsrpe3bOGNFKYHafyKnb4tyKKqqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752173117; c=relaxed/simple;
	bh=8dVFkbtF6wJtyrEC5Lsbr3vqz2/wqsawz/M3Iu4PYBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9JX/iH2Z2Ntk+lwTFIm3gB3aUACuBr62bvMens2SFcXe+PEQIOHI+faCeEYFrciDI2eTcakgnjhBil13oUn1Dkfb7IJJhbriBAX2h3WOyQwVpJ6ATJPtTjnuS+bfT7vPZMQqtxA/Z/C6zcqaOg7ZsfZhlkuquQ/OvtmnwAsul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBQK81Ou; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso1367271f8f.3;
        Thu, 10 Jul 2025 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752173113; x=1752777913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YtNYsYL5vFyGw5evZ0ZyaA0Kshmo1OgT5eqWOHOymU=;
        b=BBQK81OuSGsbGbaIXcgIBwyg9lOWouJrVk2MkVGSUJkEgMpChiNYAqKZ7UxCllVKyx
         Miuwh0Iu8ipvkkhPSOYAHED4D6+oWOQbqL/QpoVHUwpPcg56Qs0+u+0NwfOr8AjINTni
         jWTnxBmtZyX1oOF658R9+zNXSSTj7WMyYi7CqDLbTA9rp6eXDSRQI4flinY2oyX9TR44
         9L1oYxODqi9NHVykm7RjQ8Ko5IE9Al9ADn5oL1WZj+Rp+FJ6zvyJRwvYIjXt54FrC2xy
         f9gNQJiu1MdLbRn4vpALCU8kCs/orkn7kJ1jJlqvOn3Vr3KAJPXXpxqkwnRibVZdsigA
         L0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752173113; x=1752777913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YtNYsYL5vFyGw5evZ0ZyaA0Kshmo1OgT5eqWOHOymU=;
        b=SwHSGoLRyy0rIDcj+EZeU2g5IvT9ipi1VxGrUuZ8mlBo4Q++CZO4Rxu3kAMptQqlFu
         DK6jT+AvNqq7qqjVZBtvKi3un0tyDT44MeUth2szx1UvAlQebj4femAfSATN5AdDEbub
         52olPNCzeIN0IHJNeANZYYxwys+UpySBbbWmB2di4SFGfmvAKiwwjc9vaLb/zzuWt2ro
         WUET5NbrCxhEKcGNPYDVw0fhAMtnKoYfCscOT0OFaVZPldG3Sggxoeum4h9qJ1ExYbcq
         9l811BlKh+VVus9iQ3+UBgWFJjXaALAZEN6dG4rqMhu3ju1TgIc+n5pBs2CTN02h0NFC
         hyyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV98/DVrEm69X2S98hTRML3Hs3eMN/ZKtuxVUHXRkkguyt5weyH9Ukog9UGE3vZE0TGMl9vpOJyKXh5Vkq8lQBI@vger.kernel.org, AJvYcCWVP9qsmekKR1xdzouUW7XuTxRsN8zs3F6XrzaEkorPNVAtxSqjRE86QR9dNDClo8o/Lt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLHSPO9sOKhsKdjxgZrxn7mrmrSskXLsUibgREmt4CjVOcygh
	Go6Dm7T1Y5BhiljAS2JKcndamVpYRkF+ATnY+fUPteRwNvw/KU9ylKedTVLWq408
X-Gm-Gg: ASbGncubOK26UNgEILsmn2HWtZq4fEZnYKZnAKIkSasOR9ob5+iwfkEZfaTSUaCVBo+
	bdUPte+kfMW4lHK0wcg1aGbVzP60/GtD3kIqdZsqfylPdSVEpGjrx+CZO1xe8iJX8toY9thbVbT
	BEf6vXStLh4G7L3J+ZtYxAgxbJ59pe3DYf/wDeEXNj1QW2AxCZnTv8fjGtE5Hl+xhxUcCk26JAf
	mNWYQlCPSGGo/sc9KriVbkAattOpevckJ21O+Ti4eXtYAJu915XVhexx05ZhsK0RFzc/tYT2jMf
	VsuqR3vIy0Yfl+BCloebMivWTW5wl96ND6cne+zCGUIPnyT2pUsyuuFjPLw=
X-Google-Smtp-Source: AGHT+IHCBIxSVgA0xt/xF/fMHnMutzMlNQHvq6xmvEc68ZCzwRNz+KLFjxmPAe5YhUJb6xkkBEp0TA==
X-Received: by 2002:a05:6000:2d03:b0:3b1:9259:3ead with SMTP id ffacd0b85a97d-3b5f188ea57mr470272f8f.28.1752173112625;
        Thu, 10 Jul 2025 11:45:12 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e8cfsm2452232f8f.80.2025.07.10.11.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 11:45:11 -0700 (PDT)
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
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/5] selftests: drv-net: Test XDP_PASS/DROP support
Date: Thu, 10 Jul 2025 11:43:48 -0700
Message-ID: <20250710184351.63797-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250710184351.63797-1-mohsin.bashr@gmail.com>
References: <20250710184351.63797-1-mohsin.bashr@gmail.com>
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
1..6
ok 1 xdp.test_xdp_native_pass_sb
ok 2 xdp.test_xdp_native_pass_mb
ok 3 xdp.test_xdp_native_drop_sb
ok 4 xdp.test_xdp_native_drop_mb

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/xdp.py    | 310 ++++++++++++++++++
 .../selftests/net/lib/xdp_native.bpf.c        | 158 +++++++++
 3 files changed, 469 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/xdp.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_native.bpf.c

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index bd309b2d3909..2ba7ae2bfe11 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -21,6 +21,7 @@ TEST_PROGS := \
 	stats.py \
 	shaper.py \
 	hds.py \
+	xdp.py \
 # end of TEST_PROGS
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
new file mode 100755
index 000000000000..ac7eaaecef14
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -0,0 +1,310 @@
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
+from lib.py import KsftFailEx, KsftSkipEx, NetDrvEpEnv
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
+    tx_udp_cmd = f"echo {test_string} | socat -t 2 -u STDIN UDP:{cfg.baddr}:{port}"
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
+
+    Raises:
+        KsftSkipEx: If the XDP program fails to attach.
+    """
+    abs_path = cfg.net_lib_dir / bpf_info.file
+    prog_info = {}
+
+    cmd(f"ip link set dev {cfg.remote_ifname} mtu {bpf_info.mtu}", shell=True, host=cfg.remote)
+    defer(ip, f"link set dev {cfg.remote_ifname} mtu 1500", host=cfg.remote)
+
+    try:
+        cmd(
+        f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdp obj {abs_path} "
+        f"sec {bpf_info.xdp_sec}",
+        shell=True
+        )
+        defer(ip, f"link set dev {cfg.ifname} mtu 1500 xdp off")
+    except Exception as e:
+        raise KsftSkipEx(f"Failed to attach XDP porgram: {bpf_info.name}") from e
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


