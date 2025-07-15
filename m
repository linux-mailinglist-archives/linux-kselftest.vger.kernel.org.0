Return-Path: <linux-kselftest+bounces-37387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17142B06856
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 23:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB531AA0869
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 21:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD632C15BD;
	Tue, 15 Jul 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiRHJ9Zh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696B2BEFF2;
	Tue, 15 Jul 2025 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613576; cv=none; b=bkAEs1+8uUckgPLb5MDh/UDHvawk98sEaFbU4tq01Px0c0I1pwNOCEvq5SnnVteU0oEh/btp6HJZ2yP9K6RJXv+OGrj3zto+Nla4vil/S0bPzQBEkV1PNw1IAgUaXRn301gchAqLQjYKh1EaiRn1rSfKJ2L2tnyWK+fdPzu/RT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613576; c=relaxed/simple;
	bh=B0uDFBWhMLiOQt1P0y4cEBhweDPEM6JqqckSMNeXITE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOuXC8OY1O0CydcuRvsskuOpMrYCb7YXPpjYx5HmEbB2MekG/+H9nwoRR0QgK8DGySxvWRaDQf37HqDXoHuBa31SBS6iu8VyIQ6XgDN2NwP0qxKDwZaXpKv4HbI+jQllfSV1CLJrZJmBG3AbuExaqvk6W5jPHbTmYg2wr/5niH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiRHJ9Zh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so20959785e9.2;
        Tue, 15 Jul 2025 14:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752613572; x=1753218372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNTSorGhe9i+sp8Ybr0CDpGpLTbKDEyQzBf6s4Xcw/U=;
        b=LiRHJ9ZhQy1NptjK2quUsPBRknXF6ctGjDBnuIhKs9ihVo4UK7QYRn4WvWFFqGoPSm
         AM40rCfUy1rNjLLnJV8oC7YqT3bZ9f6F62Y4iwnekrrTLR3oMlQxQrGF3FIE3+ssutvy
         yOFazz4+RAxddXmMGqEK82mjUUAp6fDrY+BEqyrky4NnhTx9ST0U9IYIxi/bjdKw+crM
         uueJyOwkyN0p5rDHwt8KFB9zFLAwFu2E9N8yOO3qwJi/oMqwZO2a+yyUto/fiHvudFF/
         lfsjPonE+N+f4cacRQMO203Ml/Liyl3G+IzoquBf7Fc7JTiVw1pAjD9dSSWvXDEK6z9b
         7haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752613572; x=1753218372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNTSorGhe9i+sp8Ybr0CDpGpLTbKDEyQzBf6s4Xcw/U=;
        b=SvjQdkIE49V+rpHIOoZ5AaJ+4nfr1O47GtBdyARJavsXiMoiKO0JnIoH3Khm3RqRSj
         dNUAQHqAvC6+ZHuG1oGCsc9QzIZHx/SSNU0Z+yqfCRClcW2vINJKGuYBnwS0ZJUobI7E
         CBeP/rsWlbhXYTXKEd9G+thhy3emcX/9f7CsBxVq2bbtDHtxoYVqATbwFJ51yhFq3JKs
         7bHConyq3OCSiTQYr1/9w1/sVyPNX0pN6uSvb+h+KS2QlPSRIDCu+W9VfmiXaDaMylK+
         ZBtoH+KST6izGQijFHd0nQAYuMWOYrNksHzDHCxuZq4S47qzNxKG46nAmrWjfLUtAwnU
         dKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7gKWVDOVTK6uHvaWTt/t4p/HSeLqmdAiIBTTVSZUIVXsLr8A8ovboN1sTLB0QxbLTbzdKa31L/1GbGe2Yafwg@vger.kernel.org, AJvYcCXwmjzWiZw2y8PBlnKTHstgyS4wShakgEgoHaeiRZaND2Fb7khD/86Gm4E0uDHBd4Bg8mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDsqXD3iuPjJhpBm+r2mRK/lS/NCkT5Bax8ZxEWt0YVwVVKsD
	F45+xJbNbzn74y0FVa4KZqQQz++F1npe+1uVi9iUibFogwVWwnq9UGEXHBexD2Xh
X-Gm-Gg: ASbGncuuFMNv+pFr/Od35u3ez/3Fc+cXJccoaxH9s3BDK26Zg43nHF25PPS6hzn4oCw
	BZOEb8uAWgC3ZvCbNf3ahHVciMT4VNs5CamPfxrEklxKjGByJuCYiT2//QignIXBgLGYC9RmIuD
	yCjaBiTQpifXdjFz7ReUbcBsNUbtNOC6CSLJWo8ohy/FTpW2WnEwvg35/eU5cYWbdw4LVvrQ3Y1
	UH4+sOXRMofTiVK+IVFV1EBepR9Tt6NIiw8Vu0ytVPZDOdkXJO/fr6omnowBVZ8MWxFMohNEKJm
	VdtzYuVKl0RT+KSc4hAdHeZ/CjkIm+bFquUQF0peCE0zbpcQEZLw3UmXIfoQsQWBLYcarOsFKs9
	yHzPnn7H3O2J8EnNgHfSH
X-Google-Smtp-Source: AGHT+IENKG0UWtpE51WYWxJAYKTSoxDD9/ai4pcRD0fYyFp4WAqVt00bcvLB0au2k2kXM7i92d3V9w==
X-Received: by 2002:a05:600c:1c10:b0:456:1b6b:daaa with SMTP id 5b1f17b1804b1-4562e041759mr3129435e9.29.1752613571969;
        Tue, 15 Jul 2025 14:06:11 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:40::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886113sm1051595e9.23.2025.07.15.14.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 14:06:11 -0700 (PDT)
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
Subject: [PATCH net-next V5 5/5] selftests: drv-net: Test head-adjustment support
Date: Tue, 15 Jul 2025 14:05:53 -0700
Message-ID: <20250715210553.1568963-6-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250715210553.1568963-1-mohsin.bashr@gmail.com>
References: <20250715210553.1568963-1-mohsin.bashr@gmail.com>
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

./drivers/net/xdp.py
TAP version 13
1..9
ok 1 xdp.test_xdp_native_pass_sb
ok 2 xdp.test_xdp_native_pass_mb
ok 3 xdp.test_xdp_native_drop_sb
ok 4 xdp.test_xdp_native_drop_mb
ok 5 xdp.test_xdp_native_tx_mb
\# Failed run: pkt_sz 2048, ... offset -256. Reason: Adjustment failed
ok 6 xdp.test_xdp_native_adjst_tail_grow_data
ok 7 xdp.test_xdp_native_adjst_tail_shrnk_data
\# Failed run: pkt_sz 512, ... offset -128. Reason: Adjustment failed
ok 8 xdp.test_xdp_native_adjst_head_grow_data
\# Failed run: pkt_sz (2048) > HDS threshold (1536) and offset 64 > 48
ok 9 xdp.test_xdp_native_adjst_head_shrnk_data
\# Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/xdp.py    | 147 ++++++++++++++-
 .../selftests/net/lib/xdp_native.bpf.c        | 167 ++++++++++++++++++
 2 files changed, 313 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index 8d80f6860b8b..89c70daa3e69 100755
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
+    # Positive value indicates data part is growing by the corresponding value
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
+    # Negative value indicates data part is shrinking by the corresponding value
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
index 1383d465266c..93c0a74d37ef 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -25,6 +25,7 @@ enum {
 	XDP_MODE_DROP = 1,
 	XDP_MODE_TX = 2,
 	XDP_MODE_TAIL_ADJST = 3,
+	XDP_MODE_HEAD_ADJST = 4,
 } xdp_map_modes;
 
 enum {
@@ -328,6 +329,170 @@ static int xdp_tail_ext(struct xdp_md *ctx, __u16 port)
 	return XDP_ABORTED;
 }
 
+static int xdp_adjst_head_shrnk_data(struct xdp_md *ctx, __u64 hdr_len,
+				     const __u32 size)
+{
+	char tmp_buff[MAX_ADJST_OFFSET];
+	void *data, *data_end;
+	void *offset_ptr;
+
+	data = (void *)(long)ctx->data;
+	data_end = (void *)(long)ctx->data_end;
+
+	/* Update the length information in the IP and UDP headers before
+	 * adjusting the headroom. This simplifies accessing the relevant
+	 * fields in the IP and UDP headers for fragmented packets. Any
+	 * failure beyond this point will result in the packet being aborted,
+	 * so we don't need to worry about incorrect length information for
+	 * passed packets.
+	 */
+	update_pkt(data, data_end, (__s16)(0 - size));
+
+	if (bpf_xdp_load_bytes(ctx, 0, tmp_buff, MAX_ADJST_OFFSET) < 0)
+		return -1;
+
+	if (bpf_xdp_adjust_head(ctx, size) < 0)
+		return -1;
+
+	if (size > MAX_ADJST_OFFSET)
+		return -1;
+
+	if (hdr_len > MAX_ADJST_OFFSET || hdr_len == 0)
+		return -1;
+
+	/* Added here to handle clang complain about negative value */
+	hdr_len = (hdr_len & 0x1ff) >= 256 ? 256 : hdr_len & 0xff;
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
+				    const __u32 size)
+{
+	char tmp_buff[MAX_ADJST_OFFSET];
+	void *data, *data_end;
+	void *offset_ptr;
+	__s32 *val;
+	__u32 key;
+	__u8 tag;
+
+	if (hdr_len > MAX_ADJST_OFFSET || hdr_len == 0)
+		return -1;
+
+	/* Added here to handle clang complain about negative value */
+	hdr_len = (hdr_len & 0x1ff) >= 256 ? 256 : hdr_len & 0xff;
+
+	if (hdr_len == 0)
+		return -1;
+
+	if (bpf_xdp_load_bytes(ctx, 0, tmp_buff, hdr_len) < 0)
+		return -1;
+
+	if (size > MAX_ADJST_OFFSET)
+		return -1;
+
+	if (bpf_xdp_adjust_head(ctx, 0 - size) < 0)
+		return -1;
+
+	if (bpf_xdp_store_bytes(ctx, 0, tmp_buff, hdr_len) < 0)
+		return -1;
+
+	data = (void *)(long)ctx->data;
+	data_end = (void *)(long)ctx->data_end;
+
+	offset_ptr = data + hdr_len;
+	if (offset_ptr > data_end)
+		return -1;
+
+	key = XDP_ADJST_TAG;
+	val = bpf_map_lookup_elem(&map_xdp_setup, &key);
+	if (!val)
+		return -1;
+
+	tag = (__u8)(*val);
+
+	for (int i = 0; i < min(MAX_ADJST_OFFSET, size); i++) {
+		if (offset_ptr + 1 > data_end)
+			return -1;
+
+		__builtin_memcpy(offset_ptr, &tag, 1);
+		offset_ptr++;
+	}
+
+	update_pkt(data, data_end, (__s16)(size));
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
@@ -352,6 +517,8 @@ static int xdp_prog_common(struct xdp_md *ctx)
 		return xdp_mode_tx_handler(ctx, (__u16)(*port));
 	case XDP_MODE_TAIL_ADJST:
 		return xdp_tail_ext(ctx, (__u16)(*port));
+	case XDP_MODE_HEAD_ADJST:
+		return xdp_head_adjst(ctx, (__u16)(*port));
 	}
 
 	/* Default action is to simple pass */
-- 
2.47.1


