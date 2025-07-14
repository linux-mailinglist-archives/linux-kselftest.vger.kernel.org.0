Return-Path: <linux-kselftest+bounces-37287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B27BAB04917
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292411AA0B49
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7A2727F1;
	Mon, 14 Jul 2025 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C80iW9I+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC860256C9B;
	Mon, 14 Jul 2025 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527071; cv=none; b=FFqGxem93ZNCcOIt0pFv1LLODikB9bysmeYKHAlyjpk9saPK9a5kgd+pOFFgqWMoVTNgOQfcSP80/y1D5wtTZ83w9ajU+K39kDbWhvvHv3pGxClp4rQaohmNhoQwl7goiwOl8pl12IThbmvAsJVqNdDgwufNvXC/LSah6U0i3Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527071; c=relaxed/simple;
	bh=Kq5VYyZkgUBiBOw/QP8gi9GNG/IGjjcWE+0pM3ak5WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2htBRaGJ3OguRUKytLbLZC8lPi2Uh8XZqkQ7Rn9mEchUtY3r/ZlTSUKG1sR1IcBuxxbUsjnC6DrLVqpmmXvyxmxl0w9he/hfhYHvqq3NwIuUR6G7ub2Qfo3C960lLclDPMyN83VFqFNc83sLTX8amoYfwFxC0nKbddfi2hj/tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C80iW9I+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4561607166aso12990685e9.2;
        Mon, 14 Jul 2025 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752527067; x=1753131867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nuabv5xi71vnEgDc5G3sM5foH8HJlpfdhmtC+vYJ/N0=;
        b=C80iW9I+hl56fP/xesI6YYttizYZszDhLuoRgEz1cLAK3Gf3klJBCiYWhAHu5p7AH/
         vEyuf+aV43jeLf9xkG59BpNNBFOIb8tgueqwmoxHjxJEkiU3AH5dkzX7yf5KHAj1LU/1
         K/0fIXLL0fhfIJ2FDdg57hfYsugSrQcKgU7QAneW5OTJFVsBzI43n7gXXD5pySKB2bEN
         mHn2MSAe17JPNbQ4U/1Cm6mV5zm689vlWJnPWgpGQhhWzNWrUeJoJfeM6ws5HnxuDm5u
         cRUPT68BDD5AzL2n3zxqFVE9T43e3Nod1s+V5SnnHBd8KWVz1g5BFvBYdb0lTRO0AGNq
         4C6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752527067; x=1753131867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nuabv5xi71vnEgDc5G3sM5foH8HJlpfdhmtC+vYJ/N0=;
        b=Y0PW5ldCIDifL1gyhqSZHiT75epjgO8RKJQTbft9Lc2ohRx2CV2KIxBzzCVoa/JTSd
         pZFdkqfBUwmFw4lDudBf6Eohy8V7XKBqNKDq+FdaE6W1x84Rvbma+jOEaoX4CameysC1
         aHXf8MDkp2oBJx59vk5PKqw00jGYarQvHIP6Yp8vDP0FYiIUpEKev0W/29SFwvhT0qTK
         UrQfrmWV9Hc8/TetR7YsICW7TqaB0/uI4BPRL0d2+rJoZAwgamueM8NJYTWKg+09WG6Z
         wGn8UIPhOI1WrZaReUVLTQIFbE6fhTPKMuC1RAicFqzzAPMCMq8SlrE36zLXpbDSWYeS
         RiIA==
X-Forwarded-Encrypted: i=1; AJvYcCUm01RIcC5pdjaw/kEQtBmZn+M71tddoCUzGEORZ8Aee2GmOHHgBaEtNKU+E/BYeIWK3/vqW1M+RI+eAocvur5D@vger.kernel.org, AJvYcCXRliRuSBqYz5b3zeRQGOAz3LInaVFCVpv4rqHnx47nUNKx2Ndgu8FnMJWkxc//DyeRrV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylbnBs5k9SuqTpSXQ2vb31orW5XFAQ6ERTMaOjhu9bkd00Quos
	RwCMdxXA8/kJgOmRYkgCi/Jjmwim2MYX4TnlVOdTeD772rV36TZYSSRoIeXg0WzT
X-Gm-Gg: ASbGnctYGlnium3lTs9WHgDJTSf2p2ciDohByxQDWJIq0vGb6oxE4r516+RAaC7ioLl
	UwqPV39ARZg7HRAJYfjlTnYKYhPneLdhpjNZij5+ZTU2DJA1M+A9cnEAQhwKdVHPyvkTqyFHm+l
	XqwWlbRDXA0UTE4pvRoEnP2+qvKjGe0/lhIrsSUgbrEFVEPg4H7K0O5MHkHRezJVK1nQsdosYUY
	lTrOmNphlaZMY2029iGDNOFaPTN4HaA4OGKPm1FQW7EXnES7mmWGnYj2FtsAaP9yKxHEcriVUVo
	hih2gzYcT1ADAATfCXzuLvz1jzMj2hb6WID+v6TL9lU778babyMxauq37JL2f/b25EM7tlZNcZy
	Gwe8ZMtwdW1eVWoATpHh3
X-Google-Smtp-Source: AGHT+IFTrC4qxzUB2xq51zp1eoHtVaNqM/ornD9haAUSo8VsWqJVUvJDxQu2oGDCpdyjqaArmi9SPA==
X-Received: by 2002:a05:6000:25c1:b0:3a4:e4ee:4ca9 with SMTP id ffacd0b85a97d-3b5f35416b9mr9615657f8f.23.1752527066234;
        Mon, 14 Jul 2025 14:04:26 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:49::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e269a0sm13167881f8f.86.2025.07.14.14.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 14:04:25 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next V4 4/5] selftests: drv-net: Test tail-adjustment support
Date: Mon, 14 Jul 2025 14:03:51 -0700
Message-ID: <20250714210352.1115230-5-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250714210352.1115230-1-mohsin.bashr@gmail.com>
References: <20250714210352.1115230-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test to validate support for the two cases of tail adjustment: 1)
tail extension, and 2) tail shrinking across different frame sizes and
offset values. For each of the two cases, test both the single and
multi-buffer cases by choosing appropriate packet size.

Since tail adjustment support varies across drivers, classify the test as
pass if at least one combination of packet size and offset from a
pre-selected list results in a successful run. In case of an unsuccessful
run, report the failure and highlight the packet size and offset values
that caused the test to fail, as well as the values that resulted in the
last successful run.

Note: The growing part of this test appears flaky for netdevsim, with
inconsistent results depending on the availability of tailroom. Since
tailroom is not explicitly reserved, in general, the test should fail
due to insufficient tailroom. However, when truesize is expanded to
include any remaining space on the page, enough tailroom becomes available,
resulting in occasional test passes. On multiple real NICs including fbnic
the test results are deterministic and repeatable.

./drivers/net/xdp.py
TAP version 13
1..7
ok 1 xdp.test_xdp_native_pass_sb
ok 2 xdp.test_xdp_native_pass_mb
ok 3 xdp.test_xdp_native_drop_sb
ok 4 xdp.test_xdp_native_drop_mb
ok 5 xdp.test_xdp_native_tx_mb
\# Failed run: pkt_sz 2048, .... offset -256. Reason: Adjustment failed
ok 6 xdp.test_xdp_native_adjst_tail_grow_data
ok 7 xdp.test_xdp_native_adjst_tail_shrnk_data

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/xdp.py    | 178 +++++++++++++++++-
 .../selftests/net/lib/xdp_native.bpf.c        | 136 ++++++++++++-
 2 files changed, 310 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index b1611e5178a4..8d80f6860b8b 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -11,7 +11,7 @@ import string
 from dataclasses import dataclass
 from enum import Enum
 
-from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ne
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ne, ksft_pr
 from lib.py import KsftFailEx, NetDrvEpEnv
 from lib.py import bkg, cmd, rand_port
 from lib.py import ip, bpftool, defer
@@ -21,6 +21,8 @@ class TestConfig(Enum):
     """Enum for XDP configuration options."""
     MODE = 0  # Configures the BPF program for a specific test
     PORT = 1  # Port configuration to communicate with the remote host
+    ADJST_OFFSET = 2  # Tail/Head adjustment offset for extension/shrinking
+    ADJST_TAG = 3  # Adjustment tag to annotate the start and end of extension
 
 
 class XDPAction(Enum):
@@ -28,6 +30,7 @@ class XDPAction(Enum):
     PASS = 0  # Pass the packet up to the stack
     DROP = 1  # Drop the packet
     TX = 2    # Route the packet to the remote host
+    TAIL_ADJST = 3  # Adjust the tail of the packet
 
 
 class XDPStats(Enum):
@@ -36,6 +39,7 @@ class XDPStats(Enum):
     PASS = 1  # Count of packets passed up to the stack
     DROP = 2  # Count of packets dropped
     TX = 3    # Count of incoming packets routed to the remote host
+    ABORT = 4 # Count of packets that were aborted
 
 
 @dataclass
@@ -174,7 +178,7 @@ def _get_stats(xdp_map_id):
         raise KsftFailEx(f"Failed to get stats for map {xdp_map_id}")
 
     stats_formatted = {}
-    for key in range(0, 4):
+    for key in range(0, 5):
         val = stats_dump[key]["formatted"]["value"]
         if stats_dump[key]["formatted"]["key"] == XDPStats.RX.value:
             stats_formatted[XDPStats.RX.value] = val
@@ -184,6 +188,8 @@ def _get_stats(xdp_map_id):
             stats_formatted[XDPStats.DROP.value] = val
         elif stats_dump[key]["formatted"]["key"] == XDPStats.TX.value:
             stats_formatted[XDPStats.TX.value] = val
+        elif stats_dump[key]["formatted"]["key"] == XDPStats.ABORT.value:
+            stats_formatted[XDPStats.ABORT.value] = val
 
     return stats_formatted
 
@@ -311,6 +317,172 @@ def test_xdp_native_tx_mb(cfg):
     ksft_eq(stats[XDPStats.TX.value], 1, "TX stats mismatch")
 
 
+def _validate_res(res, offset_lst, pkt_sz_lst):
+    """
+    Validates the result of a test.
+
+    Args:
+        res: The result of the test, which should be a dictionary with a "status" key.
+
+    Raises:
+        KsftFailEx: If the test fails to pass any combination of offset and packet size.
+    """
+    if "status" not in res:
+        raise KsftFailEx("Missing 'status' key in result dictionary")
+
+    # Validate that not a single case was successful
+    if res["status"] == "fail":
+        if res["offset"] == offset_lst[0] and res["pkt_sz"] == pkt_sz_lst[0]:
+            raise KsftFailEx(f"{res['reason']}")
+
+        # Get the previous offset and packet size to report the successful run
+        tmp_idx = offset_lst.index(res["offset"])
+        prev_offset = offset_lst[tmp_idx - 1]
+        if tmp_idx == 0:
+            tmp_idx = pkt_sz_lst.index(res["pkt_sz"])
+            prev_pkt_sz = pkt_sz_lst[tmp_idx - 1]
+        else:
+            prev_pkt_sz = res["pkt_sz"]
+
+        # Use these values for error reporting
+        ksft_pr(
+        f"Failed run: pkt_sz {res['pkt_sz']}, offset {res['offset']}. "
+        f"Last successful run: pkt_sz {prev_pkt_sz}, offset {prev_offset}. "
+        f"Reason: {res['reason']}"
+        )
+
+
+def _check_for_failures(recvd_str, stats):
+    """
+    Checks for common failures while adjusting headroom or tailroom.
+
+    Args:
+        recvd_str: The string received from the remote host after sending a test string.
+        stats: A dictionary containing formatted packet statistics for various XDP actions.
+
+    Returns:
+        str: A string describing the failure reason if a failure is detected, otherwise None.
+    """
+
+    # Any adjustment failure result in an abort hence, we track this counter
+    if stats[XDPStats.ABORT.value] != 0:
+        return "Adjustment failed"
+
+    # Since we are using aggregate stats for a single test across all offsets and packet sizes
+    # we can't use RX stats only to track data exchange failure without taking a previous
+    # snapshot. An easier way is to simply check for non-zero length of received string.
+    if len(recvd_str) == 0:
+        return "Data exchange failed"
+
+    # Check for RX and PASS stats mismatch. Ideally, they should be equal for a successful run
+    if stats[XDPStats.RX.value] != stats[XDPStats.PASS.value]:
+        return "RX stats mismatch"
+
+    return None
+
+
+def _test_xdp_native_tail_adjst(cfg, pkt_sz_lst, offset_lst):
+    """
+    Tests the XDP tail adjustment functionality.
+
+    This function loads the appropriate XDP program based on the provided
+    program name and configures the XDP map for tail adjustment. It then
+    validates the tail adjustment by sending and receiving UDP packets
+    with specified packet sizes and offsets.
+
+    Args:
+        cfg: Configuration object containing network settings.
+        prog: Name of the XDP program to load.
+        pkt_sz_lst: List of packet sizes to test.
+        offset_lst: List of offsets to validate support for tail adjustment.
+
+    Returns:
+        dict: A dictionary with test status and failure details if applicable.
+    """
+    port = rand_port()
+    bpf_info = BPFProgInfo("xdp_prog_frags", "xdp_native.bpf.o", "xdp.frags", 9000)
+
+    prog_info = _load_xdp_prog(cfg, bpf_info)
+
+    # Configure the XDP map for tail adjustment
+    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.TAIL_ADJST.value)
+    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+
+    for offset in offset_lst:
+        tag = format(random.randint(65, 90), "02x")
+
+        _set_xdp_map("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)
+        if offset < 0:
+            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
+
+        for pkt_sz in pkt_sz_lst:
+            test_str = "".join(random.choice(string.ascii_lowercase) for _ in range(pkt_sz))
+            recvd_str = _exchg_udp(cfg, port, test_str)
+            stats = _get_stats(prog_info["maps"]["map_xdp_stats"])
+
+            failure = _check_for_failures(recvd_str, stats)
+            if failure is not None:
+                return {
+                    "status": "fail",
+                    "reason": failure,
+                    "offset": offset,
+                    "pkt_sz": pkt_sz,
+                }
+
+            # Validate data content based on offset direction
+            expected_data = None
+            if offset < 0:
+                expected_data = test_str + '\n' + (0 - offset) * chr(int(tag, 16))
+            else:
+                expected_data = test_str[0:pkt_sz - offset + 1]
+
+            if recvd_str != expected_data:
+                return {
+                    "status": "fail",
+                    "reason": "Data mismatch",
+                    "offset": offset,
+                    "pkt_sz": pkt_sz,
+                }
+
+    return {"status": "pass"}
+
+
+def test_xdp_native_adjst_tail_grow_data(cfg):
+    """
+    Tests the XDP tail adjustment by growing packet data.
+
+    Args:
+        cfg: Configuration object containing network settings.
+    """
+    pkt_sz_lst = [512, 1024, 2048]
+    offset_lst = [-16, -32, -64, -128, -256]
+    res = _test_xdp_native_tail_adjst(
+        cfg,
+        pkt_sz_lst,
+        offset_lst,
+    )
+
+    _validate_res(res, offset_lst, pkt_sz_lst)
+
+
+def test_xdp_native_adjst_tail_shrnk_data(cfg):
+    """
+    Tests the XDP tail adjustment by shrinking packet data.
+
+    Args:
+        cfg: Configuration object containing network settings.
+    """
+    pkt_sz_lst = [512, 1024, 2048]
+    offset_lst = [16, 32, 64, 128, 256]
+    res = _test_xdp_native_tail_adjst(
+        cfg,
+        pkt_sz_lst,
+        offset_lst,
+    )
+
+    _validate_res(res, offset_lst, pkt_sz_lst)
+
+
 def main():
     """
     Main function to execute the XDP tests.
@@ -328,6 +500,8 @@ def main():
                 test_xdp_native_drop_sb,
                 test_xdp_native_drop_mb,
                 test_xdp_native_tx_mb,
+                test_xdp_native_adjst_tail_grow_data,
+                test_xdp_native_adjst_tail_shrnk_data,
             ],
             args=(cfg,))
     ksft_exit()
diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index 84376710d3fe..1b196a809a07 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -10,15 +10,23 @@
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 
+#define min(a, b) ((a) < (b) ? (a) : (b))
+
+#define MAX_ADJST_OFFSET 256
+#define MAX_PAYLOAD_LEN 9000
+
 enum {
 	XDP_MODE = 0,
 	XDP_PORT = 1,
+	XDP_ADJST_OFFSET = 2,
+	XDP_ADJST_TAG = 3,
 } xdp_map_setup_keys;
 
 enum {
 	XDP_MODE_PASS = 0,
 	XDP_MODE_DROP = 1,
 	XDP_MODE_TX = 2,
+	XDP_MODE_TAIL_ADJST = 3,
 } xdp_map_modes;
 
 enum {
@@ -26,18 +34,19 @@ enum {
 	STATS_PASS = 1,
 	STATS_DROP = 2,
 	STATS_TX = 3,
+	STATS_ABORT = 4,
 } xdp_stats;
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 2);
+	__uint(max_entries, 5);
 	__type(key, __u32);
 	__type(value, __s32);
 } map_xdp_setup SEC(".maps");
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 4);
+	__uint(max_entries, 5);
 	__type(key, __u32);
 	__type(value, __u64);
 } map_xdp_stats SEC(".maps");
@@ -195,6 +204,127 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 	return XDP_PASS;
 }
 
+static void *update_pkt(void *data, void *data_end, __s16 offset)
+{
+	struct ethhdr *eth = data;
+	struct udphdr *udph = NULL;
+	__u16 udp_len = 0;
+
+	if (data + sizeof(*eth) > data_end)
+		return NULL;
+
+	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		struct iphdr *iph = data + sizeof(*eth);
+		__u16 total_len;
+
+		if (iph + 1 > (struct iphdr *)data_end)
+			return NULL;
+
+		total_len = bpf_ntohs(iph->tot_len) + offset;
+		iph->tot_len = bpf_htons(total_len);
+
+		udph = (void *)eth + sizeof(*iph) + sizeof(*eth);
+	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
+		struct ipv6hdr *ipv6h = data + sizeof(*eth);
+		__u16 payload_len;
+
+		if (ipv6h + 1 > (struct ipv6hdr *)data_end)
+			return NULL;
+
+		payload_len = bpf_ntohs(ipv6h->payload_len) + offset;
+		ipv6h->payload_len = bpf_htons(payload_len);
+
+		udph = (void *)eth + sizeof(*ipv6h) + sizeof(*eth);
+	} else {
+		return NULL;
+	}
+
+	if (udph == NULL || udph + 1 > (struct udphdr *)data_end)
+		return NULL;
+
+	udp_len = bpf_ntohs(udph->len) + offset;
+	udph->len = bpf_htons(udp_len);
+
+	return udph;
+}
+
+static int xdp_tail_ext(struct xdp_md *ctx, __u16 port)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	struct udphdr *udph = NULL;
+	__s32 *adjust_offset, *val;
+	void *offset_ptr;
+	__u32 key;
+	__u8 tag;
+
+	udph = filter_udphdr(ctx, port);
+	if (udph == NULL)
+		return XDP_PASS;
+
+	key = XDP_ADJST_OFFSET;
+	adjust_offset = bpf_map_lookup_elem(&map_xdp_setup, &key);
+	if (!adjust_offset)
+		return XDP_PASS;
+
+	/* Only attempt to shrink the data part */
+	if (*adjust_offset > bpf_ntohs(udph->len))
+		goto abort_pkt;
+
+	if (bpf_xdp_adjust_tail(ctx, 0 - *adjust_offset) < 0)
+		goto abort_pkt;
+
+	key = XDP_ADJST_TAG;
+	val = bpf_map_lookup_elem(&map_xdp_setup, &key);
+	if (!val)
+		goto abort_pkt;
+	tag = (__u8)(*val);
+
+	data = (void *)(long)ctx->data;
+	data_end = (void *)(long)ctx->data_end;
+
+	udph = update_pkt(data, data_end, (__s16)(0 - *adjust_offset));
+	if (!udph)
+		goto abort_pkt;
+
+	/* For the tail-shrink case, we can simply proceed to passing
+	 * the packet up to the stack. For the tail-growth case, we
+	 * insert appropriate tags at the start and end of the newly
+	 * created space and then validate these tags in the BPF program
+	 */
+	if (*adjust_offset > 0)
+		goto pass_pkt;
+
+	__u32 pkt_offset = bpf_ntohs(udph->len) - (__u32)(0 - *adjust_offset);
+
+	/* The min operations here set the upper bound on the adjustment
+	 * offset and offset_ptr allowing us to pass the BPF verifier check
+	 */
+	offset_ptr = (void *)udph + min(MAX_PAYLOAD_LEN, pkt_offset);
+	for (int i = 0; i < MAX_ADJST_OFFSET; i++) {
+		if (offset_ptr == (void *)udph + min(MAX_PAYLOAD_LEN,
+						     bpf_ntohs(udph->len)))
+			break;
+
+		if ((void *)(offset_ptr + 1) > data_end)
+			goto abort_pkt;
+
+		__builtin_memcpy(offset_ptr, &tag, 1);
+
+		offset_ptr++;
+	}
+
+pass_pkt:
+	record_stats(ctx, STATS_PASS);
+
+	return XDP_PASS;
+
+abort_pkt:
+	record_stats(ctx, STATS_ABORT);
+
+	return XDP_ABORTED;
+}
+
 static int xdp_prog_common(struct xdp_md *ctx)
 {
 	__u32 key, *port;
@@ -217,6 +347,8 @@ static int xdp_prog_common(struct xdp_md *ctx)
 		return xdp_mode_drop_handler(ctx, (__u16)(*port));
 	case XDP_MODE_TX:
 		return xdp_mode_tx_handler(ctx, (__u16)(*port));
+	case XDP_MODE_TAIL_ADJST:
+		return xdp_tail_ext(ctx, (__u16)(*port));
 	}
 
 	/* Default action is to simple pass */
-- 
2.47.1


