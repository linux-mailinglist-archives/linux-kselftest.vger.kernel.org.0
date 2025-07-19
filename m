Return-Path: <linux-kselftest+bounces-37619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF1DB0AEBC
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 10:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8E61C2209A
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 08:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA57238C21;
	Sat, 19 Jul 2025 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQqbG2Xp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7130239562;
	Sat, 19 Jul 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752913900; cv=none; b=oqsS3KPrsiZDrFTHcpyzg2DDQaosYz+ZHWju3NAW9Kh5UlwKta82pjMfWweu3eS1qWNCIVY7TGtsC3KBaJMJyn/hYHYQwSgUySypeE8ZR/P2pgPB0XaqZwbik8EXNkIDGgqfyKHf23ZpeZGhOosuByk+9xr2EFVmtbux/JNl6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752913900; c=relaxed/simple;
	bh=iH8ItoasH1gDaQiUxl4+YF41U4VkVXOT+Mi0Dz79yuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPo3fjZFQtLoZVHS6oClGy0uY2p2wzd7unbbKu69xIYWrOGQXPfthz1Bxm+EyJTbDy2OUeTlc0jYUy6KIkshRUqMw6KZgtsUMhz11ed1P2PhlSRiWLyMqVtu8VGV14w4hN77+t5wS7KOA7b1pnpqULRqsuOxtE6sY0GWqpeCQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQqbG2Xp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so22602475e9.0;
        Sat, 19 Jul 2025 01:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752913896; x=1753518696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUckn10WlK4XE41fAiCWrfhz3MjSrJu7ubH6Em5MS6k=;
        b=BQqbG2Xp93b34IHiNpfOMrUk1FHInYnuiDKqJg8sSuNMVyck25MMtKublhrzJCor8n
         CWRpAXBhvq0srTgZEWYZ17lZf0HGql4TtwXQ8goMwYMKQhRw/cSb+Q1VkP/0mZu9bcyQ
         X4AC7i7fIELP55dp/jScxI9f+eQY0Jmho12Yh7ceQYuom3yowuUBoIgAd32ESqon/dl7
         ks5INowW3Qlpeqz+G7qaAjdLvrKuXiTY1/Pnxnn041pKpcDgB/UFRukQ7Pw2N7DKtF6P
         livmxtGzhCL2WcMTnUL2Z9vzP0pMKg1Vho7/P2RPB0D1xreteJj6eqoJ9JKF0vxF5qDj
         ekyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752913896; x=1753518696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUckn10WlK4XE41fAiCWrfhz3MjSrJu7ubH6Em5MS6k=;
        b=Tbl+KkWVLr5MKmsTbCgqDNxWDhlsjX4xd3IfiiL9K1U82vL4c9o6KYwuwm0cmeKLsb
         AFf0oNgt6eKZWXC8OAjPtszJ0Za8IhWqfsf3lH7SfAzc+J8EoIYR2oZdu9IHkOraq7rr
         TxFiFB5fTXzTU7OjueB00DG+yVIZIzHXJRczF3WGOYtTDd9nQPx0vhotSiXCxNtzdwI8
         Q4c/dlSaAd3J5/M5eG++q2YLKMVdP9jozPuC82a23ZTpZna/FFWrpuSO3q+eFlHv8v14
         fPbWd40kTGPr4m1LmeigpeOX9YpEgF2hil4N1WrPMdxJk+wNflaZWkRQHcI+hjJHoBpq
         yP3w==
X-Forwarded-Encrypted: i=1; AJvYcCWynvTblB89HNkWuPef6Z+o6XidEFKBFUSS2UtWTh4xouS400l8WTla1u/7I6zZQKawcFwpWrO4pjBtoczG+qSg@vger.kernel.org, AJvYcCXWgJgGYQUyfV36gE40DK7tXUKmQqlynb+N3+hMb6a3QWkN7GzFZfB2+gzSoOKlWfn9RT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSmMWa2qL2yrxaIxrDbOu7beCw+SCMN02fRW2/d3F+34DwYK5D
	P43wp+ququvW5TAUc2Gr2ojnKfEa2iRHHYtdjFROXSuGmpa0GmNslHBHRTZpAqul
X-Gm-Gg: ASbGncsBrsseMZE4oRxV02Ex8BPZrVe3dRTKAcn+2/7dMJ4e1xLr47YS3vdQkZ0DxS/
	zFXaVGlXmBEKPIUBsUSC0dXYZxSxYuwsqfeRbA3jLAx4eePCJqz5M0Vk9YxcSOn4jhhHN0Jf6+l
	1kUH9G+cqFPmBXu1esq5kTH4itDBv78Rfzk8Na3+1kcrDPG/yu3xZr7QSjnLIdvIfOH9LJ8VlUw
	PFBoOVzmi4K/eBAn3/doj2p+pVj09VaHlhivrkjYjmhJ9VFFqH/6SzRO4R4AS2dshZnOUVrEEyk
	+nDJ5DvkLC0X72T2IMtHUDA19hDW3zpa3ger0w1/cWwTW0GtF6t6xPrMrpNSDUlG3UdQitmD13P
	S1T1jPPp+e9E1VOoPnuA=
X-Google-Smtp-Source: AGHT+IH5Q26+H41r3NHPhRFJ9oFciblkZ+X5Ax24q1lTH2LOiioNMepoybfAnuVwZ5xwheWkV4g9Fg==
X-Received: by 2002:a05:600c:4e06:b0:456:2139:456a with SMTP id 5b1f17b1804b1-45634c82b45mr103429725e9.15.1752913895431;
        Sat, 19 Jul 2025 01:31:35 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c952sm4139356f8f.86.2025.07.19.01.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 01:31:34 -0700 (PDT)
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
Subject: [PATCH net-next V6 5/5] selftests: drv-net: Test head-adjustment support
Date: Sat, 19 Jul 2025 01:30:59 -0700
Message-ID: <20250719083059.3209169-6-mohsin.bashr@gmail.com>
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

Add test to validate the headroom adjustment support for both extension
and the shrinking cases. For the extension part, eat up space from
the start of payload data whereas, for the shrinking part, populate
the newly available space with a tag. In the user-space, validate that a
test string is manipulated accordingly.
The negative and positive offset values result in shrinking and growing of
headroom (growing and shrinking of payload) respectively.

TAP version 13
1..9
ok 1 xdp.test_xdp_native_pass_sb
ok 2 xdp.test_xdp_native_pass_mb
ok 3 xdp.test_xdp_native_drop_sb
ok 4 xdp.test_xdp_native_drop_mb
ok 5 xdp.test_xdp_native_tx_mb
\# Failed run: pkt_sz 512, ... offset 1. Reason: Adjustment failed
ok 6 xdp.test_xdp_native_adjst_tail_grow_data
ok 7 xdp.test_xdp_native_adjst_tail_shrnk_data
\# Failed run: pkt_sz 512, ... offset -128. Reason: Adjustment failed
ok 8 xdp.test_xdp_native_adjst_head_grow_data
\# Failed run: pkt_sz (512) > HDS threshold (0) and offset 64 > 48
ok 9 xdp.test_xdp_native_adjst_head_shrnk_data
\# Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/xdp.py    | 147 +++++++++++++-
 .../selftests/net/lib/xdp_native.bpf.c        | 181 ++++++++++++++++++
 2 files changed, 327 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index 85b5db0a1121..887d662ad128 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -12,7 +12,7 @@ from dataclasses import dataclass
 from enum import Enum
 
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ne, ksft_pr
-from lib.py import KsftFailEx, NetDrvEpEnv
+from lib.py import KsftFailEx, NetDrvEpEnv, EthtoolFamily, NlError
 from lib.py import bkg, cmd, rand_port
 from lib.py import ip, bpftool, defer
 
@@ -31,6 +31,7 @@ class XDPAction(Enum):
     DROP = 1  # Drop the packet
     TX = 2    # Route the packet to the remote host
     TAIL_ADJST = 3  # Adjust the tail of the packet
+    HEAD_ADJST = 4  # Adjust the head of the packet
 
 
 class XDPStats(Enum):
@@ -483,6 +484,147 @@ def test_xdp_native_adjst_tail_shrnk_data(cfg):
     _validate_res(res, offset_lst, pkt_sz_lst)
 
 
+def get_hds_thresh(cfg):
+    """
+    Retrieves the header data split (HDS) threshold for a network interface.
+
+    Args:
+        cfg: Configuration object containing network settings.
+
+    Returns:
+        The HDS threshold value. If the threshold is not supported or an error occurs,
+        a default value of 1500 is returned.
+    """
+    netnl = cfg.netnl
+    hds_thresh = 1500
+
+    try:
+        rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+        if 'hds-thresh' not in rings:
+            ksft_pr(f'hds-thresh not supported. Using default: {hds_thresh}')
+            return hds_thresh
+        hds_thresh = rings['hds-thresh']
+    except NlError as e:
+        ksft_pr(f"Failed to get rings: {e}. Using default: {hds_thresh}")
+
+    return hds_thresh
+
+
+def _test_xdp_native_head_adjst(cfg, prog, pkt_sz_lst, offset_lst):
+    """
+    Tests the XDP head adjustment action for a multi-buffer case.
+
+    Args:
+        cfg: Configuration object containing network settings.
+        netnl: Network namespace or link object (not used in this function).
+
+    This function sets up the packet size and offset lists, then performs
+    the head adjustment test by sending and receiving UDP packets.
+    """
+    cfg.require_cmd("socat", remote=True)
+
+    prog_info = _load_xdp_prog(cfg, BPFProgInfo(prog, "xdp_native.bpf.o", "xdp.frags", 9000))
+    port = rand_port()
+
+    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.HEAD_ADJST.value)
+    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+
+    hds_thresh = get_hds_thresh(cfg)
+    for offset in offset_lst:
+        for pkt_sz in pkt_sz_lst:
+            # The "head" buffer must contain at least the Ethernet header
+            # after we eat into it. We send large-enough packets, but if HDS
+            # is enabled head will only contain headers. Don't try to eat
+            # more than 28 bytes (UDPv4 + eth hdr left: (14 + 20 + 8) - 14)
+            l2_cut_off = 28 if cfg.addr_ipver == 4 else 48
+            if pkt_sz > hds_thresh and offset > l2_cut_off:
+                ksft_pr(
+                f"Failed run: pkt_sz ({pkt_sz}) > HDS threshold ({hds_thresh}) and "
+                f"offset {offset} > {l2_cut_off}"
+                )
+                return {"status": "pass"}
+
+            test_str = ''.join(random.choice(string.ascii_lowercase) for _ in range(pkt_sz))
+            tag = format(random.randint(65, 90), '02x')
+
+            _set_xdp_map("map_xdp_setup",
+                     TestConfig.ADJST_OFFSET.value,
+                     offset)
+            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
+            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)
+
+            recvd_str = _exchg_udp(cfg, port, test_str)
+
+            # Check for failures around adjustment and data exchange
+            failure = _check_for_failures(recvd_str, _get_stats(prog_info['maps']['map_xdp_stats']))
+            if failure is not None:
+                return {
+                    "status": "fail",
+                    "reason": failure,
+                    "offset": offset,
+                    "pkt_sz": pkt_sz
+                }
+
+            # Validate data content based on offset direction
+            expected_data = None
+            if offset < 0:
+                expected_data = chr(int(tag, 16)) * (0 - offset) + test_str
+            else:
+                expected_data = test_str[offset:]
+
+            if recvd_str != expected_data:
+                return {
+                    "status": "fail",
+                    "reason": "Data mismatch",
+                    "offset": offset,
+                    "pkt_sz": pkt_sz
+                }
+
+    return {"status": "pass"}
+
+
+def test_xdp_native_adjst_head_grow_data(cfg):
+    """
+    Tests the XDP headroom growth support.
+
+    Args:
+        cfg: Configuration object containing network settings.
+
+    This function sets up the packet size and offset lists, then calls the
+    _test_xdp_native_head_adjst_mb function to perform the actual test. The
+    test is passed if the headroom is successfully extended for given packet
+    sizes and offsets.
+    """
+    pkt_sz_lst = [512, 1024, 2048]
+
+    # Negative values result in headroom shrinking, resulting in growing of payload
+    offset_lst = [-16, -32, -64, -128, -256]
+    res = _test_xdp_native_head_adjst(cfg, "xdp_prog_frags", pkt_sz_lst, offset_lst)
+
+    _validate_res(res, offset_lst, pkt_sz_lst)
+
+
+def test_xdp_native_adjst_head_shrnk_data(cfg):
+    """
+    Tests the XDP headroom shrinking support.
+
+    Args:
+        cfg: Configuration object containing network settings.
+
+    This function sets up the packet size and offset lists, then calls the
+    _test_xdp_native_head_adjst_mb function to perform the actual test. The
+    test is passed if the headroom is successfully shrunk for given packet
+    sizes and offsets.
+    """
+    pkt_sz_lst = [512, 1024, 2048]
+
+    # Positive values result in headroom growing, resulting in shrinking of payload
+    offset_lst = [16, 32, 64, 128, 256]
+    res = _test_xdp_native_head_adjst(cfg, "xdp_prog_frags", pkt_sz_lst, offset_lst)
+
+    _validate_res(res, offset_lst, pkt_sz_lst)
+
+
 def main():
     """
     Main function to execute the XDP tests.
@@ -493,6 +635,7 @@ def main():
     function to execute the tests.
     """
     with NetDrvEpEnv(__file__) as cfg:
+        cfg.netnl = EthtoolFamily()
         ksft_run(
             [
                 test_xdp_native_pass_sb,
@@ -502,6 +645,8 @@ def main():
                 test_xdp_native_tx_mb,
                 test_xdp_native_adjst_tail_grow_data,
                 test_xdp_native_adjst_tail_shrnk_data,
+                test_xdp_native_adjst_head_grow_data,
+                test_xdp_native_adjst_head_shrnk_data,
             ],
             args=(cfg,))
     ksft_exit()
diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index 7bb2dff86d8f..521ba38f2ddd 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -26,6 +26,7 @@ enum {
 	XDP_MODE_DROP = 1,
 	XDP_MODE_TX = 2,
 	XDP_MODE_TAIL_ADJST = 3,
+	XDP_MODE_HEAD_ADJST = 4,
 } xdp_map_modes;
 
 enum {
@@ -395,6 +396,184 @@ static int xdp_adjst_tail(struct xdp_md *ctx, __u16 port)
 	return XDP_ABORTED;
 }
 
+static int xdp_adjst_head_shrnk_data(struct xdp_md *ctx, __u64 hdr_len,
+				     __u32 offset)
+{
+	char tmp_buff[MAX_ADJST_OFFSET];
+	struct udphdr *udph;
+	void *offset_ptr;
+	__u32 udp_csum = 0;
+
+	/* Update the length information in the IP and UDP headers before
+	 * adjusting the headroom. This simplifies accessing the relevant
+	 * fields in the IP and UDP headers for fragmented packets. Any
+	 * failure beyond this point will result in the packet being aborted,
+	 * so we don't need to worry about incorrect length information for
+	 * passed packets.
+	 */
+	udph = update_pkt(ctx, (__s16)(0 - offset), &udp_csum);
+	if (!udph)
+		return -1;
+
+	offset = (offset & 0x1ff) >= MAX_ADJST_OFFSET ? MAX_ADJST_OFFSET :
+				     offset & 0xff;
+	if (offset == 0)
+		return -1;
+
+	if (bpf_xdp_load_bytes(ctx, hdr_len, tmp_buff, offset) < 0)
+		return -1;
+
+	udp_csum = bpf_csum_diff((__be32 *)tmp_buff, offset, 0, 0, udp_csum);
+
+	udph->check = (__u16)csum_fold_helper(udp_csum);
+
+	if (bpf_xdp_load_bytes(ctx, 0, tmp_buff, MAX_ADJST_OFFSET) < 0)
+		return -1;
+
+	if (bpf_xdp_adjust_head(ctx, offset) < 0)
+		return -1;
+
+	if (offset > MAX_ADJST_OFFSET)
+		return -1;
+
+	if (hdr_len > MAX_ADJST_OFFSET || hdr_len == 0)
+		return -1;
+
+	/* Added here to handle clang complain about negative value */
+	hdr_len = hdr_len & 0xff;
+
+	if (hdr_len == 0)
+		return -1;
+
+	if (bpf_xdp_store_bytes(ctx, 0, tmp_buff, hdr_len) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int xdp_adjst_head_grow_data(struct xdp_md *ctx, __u64 hdr_len,
+				    __u32 offset)
+{
+	char hdr_buff[MAX_HDR_LEN];
+	char data_buff[MAX_ADJST_OFFSET];
+	void *offset_ptr;
+	__s32 *val;
+	__u32 key;
+	__u8 tag;
+	__u32 udp_csum = 0;
+	struct udphdr *udph;
+
+	udph = update_pkt(ctx, (__s16)(offset), &udp_csum);
+	if (!udph)
+		return -1;
+
+	key = XDP_ADJST_TAG;
+	val = bpf_map_lookup_elem(&map_xdp_setup, &key);
+	if (!val)
+		return -1;
+
+	tag = (__u8)(*val);
+	for (int i = 0; i < MAX_ADJST_OFFSET; i++)
+		__builtin_memcpy(&data_buff[i], &tag, 1);
+
+	offset = (offset & 0x1ff) >= MAX_ADJST_OFFSET ? MAX_ADJST_OFFSET :
+				     offset & 0xff;
+	if (offset == 0)
+		return -1;
+
+	udp_csum = bpf_csum_diff(0, 0, (__be32 *)data_buff, offset, udp_csum);
+	udph->check = (__u16)csum_fold_helper(udp_csum);
+
+	if (hdr_len > MAX_ADJST_OFFSET || hdr_len == 0)
+		return -1;
+
+	/* Added here to handle clang complain about negative value */
+	hdr_len = hdr_len & 0xff;
+
+	if (hdr_len == 0)
+		return -1;
+
+	if (bpf_xdp_load_bytes(ctx, 0, hdr_buff, hdr_len) < 0)
+		return -1;
+
+	if (offset > MAX_ADJST_OFFSET)
+		return -1;
+
+	if (bpf_xdp_adjust_head(ctx, 0 - offset) < 0)
+		return -1;
+
+	if (bpf_xdp_store_bytes(ctx, 0, hdr_buff, hdr_len) < 0)
+		return -1;
+
+	if (bpf_xdp_store_bytes(ctx, hdr_len, data_buff, offset) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int xdp_head_adjst(struct xdp_md *ctx, __u16 port)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	struct udphdr *udph_ptr = NULL;
+	__u32 key, size, hdr_len;
+	__s32 *val;
+	int res;
+
+	/* Filter packets based on UDP port */
+	udph_ptr = filter_udphdr(ctx, port);
+	if (!udph_ptr)
+		return XDP_PASS;
+
+	hdr_len = (void *)udph_ptr - data + sizeof(struct udphdr);
+
+	key = XDP_ADJST_OFFSET;
+	val = bpf_map_lookup_elem(&map_xdp_setup, &key);
+	if (!val)
+		return XDP_PASS;
+
+	switch (*val) {
+	case -16:
+	case 16:
+		size = 16;
+		break;
+	case -32:
+	case 32:
+		size = 32;
+		break;
+	case -64:
+	case 64:
+		size = 64;
+		break;
+	case -128:
+	case 128:
+		size = 128;
+		break;
+	case -256:
+	case 256:
+		size = 256;
+		break;
+	default:
+		bpf_printk("Invalid adjustment offset: %d\n", *val);
+		goto abort;
+	}
+
+	if (*val < 0)
+		res = xdp_adjst_head_grow_data(ctx, hdr_len, size);
+	else
+		res = xdp_adjst_head_shrnk_data(ctx, hdr_len, size);
+
+	if (res)
+		goto abort;
+
+	record_stats(ctx, STATS_PASS);
+	return XDP_PASS;
+
+abort:
+	record_stats(ctx, STATS_ABORT);
+	return XDP_ABORTED;
+}
+
 static int xdp_prog_common(struct xdp_md *ctx)
 {
 	__u32 key, *port;
@@ -419,6 +598,8 @@ static int xdp_prog_common(struct xdp_md *ctx)
 		return xdp_mode_tx_handler(ctx, (__u16)(*port));
 	case XDP_MODE_TAIL_ADJST:
 		return xdp_adjst_tail(ctx, (__u16)(*port));
+	case XDP_MODE_HEAD_ADJST:
+		return xdp_head_adjst(ctx, (__u16)(*port));
 	}
 
 	/* Default action is to simple pass */
-- 
2.47.1


