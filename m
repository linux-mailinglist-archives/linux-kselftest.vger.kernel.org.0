Return-Path: <linux-kselftest+bounces-37618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D97B0AEBE
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 10:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8E84E0FB6
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67675238D42;
	Sat, 19 Jul 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpGkc63i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C80238C21;
	Sat, 19 Jul 2025 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752913897; cv=none; b=Q+nLNXy5wT/dHsi0JQaXVpsx7ZaDewWUa+jHMWMutxD+LESUV4PRr7Uephhf/gj5zCWMS/QdLjuwqMdn8zRj/CIjU4WvbUI9uzwtBl2y9wfHCKkfPSCOdN7nXB7cMBIpvGpEwvEABua4qsdUKCsILG6THMFSRM6yBkWNrMzutKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752913897; c=relaxed/simple;
	bh=xzNQaeOTlFwoobZCUwc7yeQzTexoiiIvVp6QFJh2y8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzJwQn3Ar5mkN/nJKC0PxOdi026G5KKpyoGueclm+yCW73sClFA5J9Gz7Ytxmstj/Ie2j+8xn/pBR9ozwf76qRJT46j5jsBXZLbwMwknpkjPkShd7G5QYHro1NQqxS5X7eBR7ypBwlAKt248T+PmXXZgFrdKZJIJaLteWQN2Rxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpGkc63i; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a54700a46eso1612212f8f.1;
        Sat, 19 Jul 2025 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752913893; x=1753518693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYeiPstx8G4zT7r66Bg123DPljs72eu5NDsA8rg2E6A=;
        b=OpGkc63i8U3tEgbDCIRgkcL8S/+2622jXw/k956O4mLMQVmr1B/QmL3/XF0LIeWKPs
         bWg9DkpBGkscVWwsq0MPSn0rJWbAOB3HP1YjKk88JXXSGP+x91+wnTiXw6xMrEFmqPH6
         2JlkbT7nHHYZYg2j5DooWeMbs0bXtRe7egOoFmMY4RqO9OmwWpR9WaUwkHNc6ANxsX5X
         gtJlIduC3jI+651MmIFp2FlDtgFgOER9NATl7ppi5cLCSQFB4PxBn+Yl0R9W+jblHCh2
         LM3xQejsJttBvDcYmWCr3r/LrAikWgbn/Y1HXq/7R5UJ0/QTBMIELomDiB6v6A2cyXun
         +jtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752913893; x=1753518693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYeiPstx8G4zT7r66Bg123DPljs72eu5NDsA8rg2E6A=;
        b=qMkowswvTS7pdkOCFAaXOXVqkInCtXkHnC3TKKWSEPCj/T2n5bp06hpuAhHYRld4wm
         CfBYvGJcpODT9jXYZ72m4dGDDrW5K+5ppwxZMpt1RoVn1xOQBYpJypnH6SPptCyrr8kw
         87GrM9gvQCBlboyLp+NKIrBQbsdmeJyzLlbia45Pb38neXbLfXicZ+DKiS/LX2dpW7P3
         8PYY9/LwN6KCS4BcslWVyXqMGYqls1m3vMoxGAXqCv3xy4owIO/EVILMn2CqPVaz7ztc
         cCVOLiBfUMX+F2woITJpQVD+NFE+a14CghmZrBZKB4Z36J+tvkIAirisnp7/vNdU31KH
         szIA==
X-Forwarded-Encrypted: i=1; AJvYcCVwLwxh5OR1qM89wSYl/P+dOwCZCxUqfMGff1/gjV8MjkO0lNG9D4QwAl/HPO1+oRzwElMFJnf9vBAzfo907RHi@vger.kernel.org, AJvYcCWIPZZl28wz/RvEszNZgLaeF938T7mbTMk5vOqCI/0M5GT2qCv3vJR9+xCcEnYa/0YHw1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOwg1qhQwoDO4ImZgBN/qHWDub11CRKxd3vCUQQ62Dl6oqQl9Z
	RPYuXjeFkLCsSqGy5wwqcSUrQtIA2lDk41nlcBe0psop5ByyT2bPFWvnAEX2als3
X-Gm-Gg: ASbGncsooLb7KjL35prZmgv3KWFmXmBKrGk8k5QMSL33l6+73ys15ccEFsGok33o153
	FKtLn9TKb9vRaZzdxTLsKH0zyj4R6BjS3NuQ7AT6IsCyV4r7dljlHIKTMm2Kb76bjc4S9qiICFz
	xPj1PHQ/DmyqCxxXDcaUAsCmEJEIUYZy5vBL+cvcJWvaeBnqSA4GGpn0pnUO3CL+2NFK9Wh8fyb
	dUBnEYFK8YZl8opsOPOljZZTEE5RbFxluhlI34Izk8SVvODK/nk4xJ8c2Wy0QbWF/rSEAwNps3m
	oROUjNarj5UlKAcYsfxgXi7xPoTdE1u7PkzzvFUOAIbbPgWpzD61mlQXSAijXPymWFOR8sN1rrG
	iUxF6R2vWGEnDjV3IgDjh
X-Google-Smtp-Source: AGHT+IH7Be2yRh0tE92ZeXYaf2ZnJuLKal6AhTYANeAi4DOP3FGAX+WhVVOI/BXXTWAlCNOfBq62Bw==
X-Received: by 2002:a5d:5f02:0:b0:3a4:f520:8bfc with SMTP id ffacd0b85a97d-3b613e984aemr6814065f8f.36.1752913893041;
        Sat, 19 Jul 2025 01:31:33 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74029bsm40664615e9.22.2025.07.19.01.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 01:31:32 -0700 (PDT)
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
Subject: [PATCH net-next V6 4/5] selftests: drv-net: Test tail-adjustment support
Date: Sat, 19 Jul 2025 01:30:58 -0700
Message-ID: <20250719083059.3209169-5-mohsin.bashr@gmail.com>
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

Add test to validate support for the two cases of tail adjustment: 1)
tail extension, and 2) tail shrinking across different frame sizes and
offset values. For each of the two cases, test both the single and
multi-buffer cases by choosing appropriate packet size.

The negative offset value result in growing of tailroom (shrinking of
payload) while the positive offset result in shrinking of tailroom
(growing of payload).

Since the support for tail adjustment varies across drivers, classify the
test as pass if at least one combination of packet size and offset from a
pre-selected list results in a successful run. In case of an unsuccessful
run, report the failure and highlight the packet size and offset values
that caused the test to fail, as well as the values that resulted in the
last successful run.

Note: The growing part of this test for netdevsim may appear flaky when
the offset value is larger than 1. This behavior occurs because tailroom
is not explicitly reserved for netdevsim, with 1 being the typical
tailroom value. However, in certain cases, such as payload being the last
in the page with additional available space, the truesize is expanded.
This also result increases the tailroom causing the test to pass
intermittently. In contrast, when tailrrom is explicitly reserved, such
as in the of fbnic, the test results are deterministic.

./drivers/net/xdp.py
TAP version 13
1..7
ok 1 xdp.test_xdp_native_pass_sb
ok 2 xdp.test_xdp_native_pass_mb
ok 3 xdp.test_xdp_native_drop_sb
ok 4 xdp.test_xdp_native_drop_mb
ok 5 xdp.test_xdp_native_tx_mb
\# Failed run: ... successful run: ... offset 1. Reason: Adjustment failed
ok 6 xdp.test_xdp_native_adjst_tail_grow_data
ok 7 xdp.test_xdp_native_adjst_tail_shrnk_data
\# Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/xdp.py    | 178 ++++++++++++++-
 .../selftests/net/lib/xdp_native.bpf.c        | 206 +++++++++++++++++-
 2 files changed, 380 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index d42dbee78431..85b5db0a1121 100755
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
+        if offset > 0:
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
+            if offset > 0:
+                expected_data = test_str + (offset * chr(int(tag, 16)))
+            else:
+                expected_data = test_str[0:pkt_sz + offset]
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
+    offset_lst = [1, 16, 32, 64, 128, 256]
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
index d3c66c891589..7bb2dff86d8f 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -10,15 +10,22 @@
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 
+#define MAX_ADJST_OFFSET 256
+#define MAX_PAYLOAD_LEN 5000
+#define MAX_HDR_LEN 64
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
@@ -26,22 +33,28 @@ enum {
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
 
+static __u32 min(__u32 a, __u32 b)
+{
+	return a < b ? a : b;
+}
+
 static void record_stats(struct xdp_md *ctx, __u32 stat_type)
 {
 	__u64 *count;
@@ -195,6 +208,193 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 	return XDP_PASS;
 }
 
+static void *update_pkt(struct xdp_md *ctx, __s16 offset, __u32 *udp_csum)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	struct udphdr *udph = NULL;
+	struct ethhdr *eth = data;
+	__u32 len, len_new;
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
+		iph->tot_len = bpf_htons(bpf_ntohs(iph->tot_len) + offset);
+
+		udph = (void *)eth + sizeof(*iph) + sizeof(*eth);
+		if (!udph || udph + 1 > (struct udphdr *)data_end)
+			return NULL;
+
+		len_new = bpf_htons(bpf_ntohs(udph->len) + offset);
+	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
+		struct ipv6hdr *ipv6h = data + sizeof(*eth);
+		__u16 payload_len;
+
+		if (ipv6h + 1 > (struct ipv6hdr *)data_end)
+			return NULL;
+
+		udph = (void *)eth + sizeof(*ipv6h) + sizeof(*eth);
+		if (!udph || udph + 1 > (struct udphdr *)data_end)
+			return NULL;
+
+		*udp_csum = ~((__u32)udph->check);
+
+		len = ipv6h->payload_len;
+		len_new = bpf_htons(bpf_ntohs(len) + offset);
+		ipv6h->payload_len = len_new;
+
+		*udp_csum = bpf_csum_diff(&len, sizeof(len), &len_new,
+					  sizeof(len_new), *udp_csum);
+
+		len = udph->len;
+		len_new = bpf_htons(bpf_ntohs(udph->len) + offset);
+		*udp_csum = bpf_csum_diff(&len, sizeof(len), &len_new,
+					  sizeof(len_new), *udp_csum);
+	} else {
+		return NULL;
+	}
+
+	udph->len = len_new;
+
+	return udph;
+}
+
+static __u16 csum_fold_helper(__u32 csum)
+{
+	return ~((csum & 0xffff) + (csum >> 16)) ? : 0xffff;
+}
+
+static int xdp_adjst_tail_shrnk_data(struct xdp_md *ctx, __u16 offset,
+				     __u32 hdr_len)
+{
+	char tmp_buff[MAX_ADJST_OFFSET];
+	__u32 buff_pos, udp_csum = 0;
+	struct udphdr *udph = NULL;
+	__u32 buff_len;
+
+	udph = update_pkt(ctx, 0 - offset, &udp_csum);
+	if (!udph)
+		return -1;
+
+	buff_len = bpf_xdp_get_buff_len(ctx);
+
+	offset = (offset & 0x1ff) >= MAX_ADJST_OFFSET ? MAX_ADJST_OFFSET :
+				     offset & 0xff;
+	if (offset == 0)
+		return -1;
+
+	/* Make sure we have enough data to avoid eating the header */
+	if (buff_len - offset < hdr_len)
+		return -1;
+
+	buff_pos = buff_len - offset;
+	if (bpf_xdp_load_bytes(ctx, buff_pos, tmp_buff, offset) < 0)
+		return -1;
+
+	udp_csum = bpf_csum_diff((__be32 *)tmp_buff, offset, 0, 0, udp_csum);
+	udph->check = (__u16)csum_fold_helper(udp_csum);
+
+	if (bpf_xdp_adjust_tail(ctx, 0 - offset) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int xdp_adjst_tail_grow_data(struct xdp_md *ctx, __u16 offset)
+{
+	char tmp_buff[MAX_ADJST_OFFSET];
+	__u32 buff_pos, udp_csum = 0;
+	__u32 buff_len, hdr_len, key;
+	struct udphdr *udph;
+	__s32 *val;
+	__u8 tag;
+
+	/* Proceed to update the packet headers before attempting to adjuste
+	 * the tail. Once the tail is adjusted we lose access to the offset
+	 * amount of data at the end of the packet which is crucial to update
+	 * the checksum.
+	 * Since any failure beyond this would abort the packet, we should
+	 * not worry about passing a packet up the stack with wrong headers
+	 */
+	udph = update_pkt(ctx, offset, &udp_csum);
+	if (!udph)
+		return -1;
+
+	key = XDP_ADJST_TAG;
+	val = bpf_map_lookup_elem(&map_xdp_setup, &key);
+	if (!val)
+		return -1;
+
+	tag = (__u8)(*val);
+
+	for (int i = 0; i < MAX_ADJST_OFFSET; i++)
+		__builtin_memcpy(&tmp_buff[i], &tag, 1);
+
+	offset = (offset & 0x1ff) >= MAX_ADJST_OFFSET ? MAX_ADJST_OFFSET :
+				     offset & 0xff;
+	if (offset == 0)
+		return -1;
+
+	udp_csum = bpf_csum_diff(0, 0, (__be32 *)tmp_buff, offset, udp_csum);
+	udph->check = (__u16)csum_fold_helper(udp_csum);
+
+	buff_len = bpf_xdp_get_buff_len(ctx);
+
+	if (bpf_xdp_adjust_tail(ctx, offset) < 0) {
+		bpf_printk("Failed to adjust tail\n");
+		return -1;
+	}
+
+	if (bpf_xdp_store_bytes(ctx, buff_len, tmp_buff, offset) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int xdp_adjst_tail(struct xdp_md *ctx, __u16 port)
+{
+	void *data = (void *)(long)ctx->data;
+	struct udphdr *udph = NULL;
+	__s32 *adjust_offset, *val;
+	__u32 key, hdr_len;
+	void *offset_ptr;
+	__u8 tag;
+	int ret;
+
+	udph = filter_udphdr(ctx, port);
+	if (!udph)
+		return XDP_PASS;
+
+	hdr_len = (void *)udph - data + sizeof(struct udphdr);
+	key = XDP_ADJST_OFFSET;
+	adjust_offset = bpf_map_lookup_elem(&map_xdp_setup, &key);
+	if (!adjust_offset)
+		return XDP_PASS;
+
+	if (*adjust_offset < 0)
+		ret = xdp_adjst_tail_shrnk_data(ctx,
+						(__u16)(0 - *adjust_offset),
+						hdr_len);
+	else
+		ret = xdp_adjst_tail_grow_data(ctx, (__u16)(*adjust_offset));
+	if (ret)
+		goto abort_pkt;
+
+	record_stats(ctx, STATS_PASS);
+	return XDP_PASS;
+
+abort_pkt:
+	record_stats(ctx, STATS_ABORT);
+	return XDP_ABORTED;
+}
+
 static int xdp_prog_common(struct xdp_md *ctx)
 {
 	__u32 key, *port;
@@ -217,6 +417,8 @@ static int xdp_prog_common(struct xdp_md *ctx)
 		return xdp_mode_drop_handler(ctx, (__u16)(*port));
 	case XDP_MODE_TX:
 		return xdp_mode_tx_handler(ctx, (__u16)(*port));
+	case XDP_MODE_TAIL_ADJST:
+		return xdp_adjst_tail(ctx, (__u16)(*port));
 	}
 
 	/* Default action is to simple pass */
-- 
2.47.1


