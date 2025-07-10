Return-Path: <linux-kselftest+bounces-37037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A8EB00BA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 20:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FB55A073E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927022FCFF2;
	Thu, 10 Jul 2025 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7+D0aTy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB222FD861;
	Thu, 10 Jul 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752173124; cv=none; b=MY9FLggsDOZInTmDsodoUrG83POLl7ppjP5T9OTTCbRr7TWEwBXRNXS0TRHUfrGgR7QsQC4UUxMJ33ZxYo5zTYnbWJN1CSx+X4hFnM3QqLFbm6Hqy2N8uIBlk1Fsopn3owAoaM3sZ9gBkQ07pzYQNlA2tXXKl03MGxu1LLSqKlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752173124; c=relaxed/simple;
	bh=+Zi9V5xrtTxh+Iu1D/HZHND8+nyNqWaKSL4aUsU4OWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBgjyacsfggBy6F6CCiebmk7L/9tAdfhZW24RVrL8xxm5xWKks344wd/NGfrfjKyPR/TWJiJ+eheyjv7xaoiOgfbIWQkL0sUM58aldQV/FW/mdqQe/d775VPoQ9M82jwApVTCwUaSjYqD4ZmtJoDTx9pcMkMZ7HTKIKXMtvhPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7+D0aTy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so1284905f8f.0;
        Thu, 10 Jul 2025 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752173120; x=1752777920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llwJe6QbrKI1OYMHC+BQZWZXCr/Kihw4SFrPpmPjIdE=;
        b=T7+D0aTy13sgYhS5VvlMRgi448c0Iu1r6XRSH4iIrCKjlVswwZEXp6VGgoHbEMua0j
         D7R8jU3j7ZvMJjLIfwSwmD2fwnCkVu/YiCSelZQmbL0gkoFIBdfaE3uEfl0QJRBlp9a0
         CzNB/DQtDeedMMGmZ1b1GvwQYh75FTGhd8kv8iFEg/6P8JIPOuO0PGFJt65RQdUkM4V6
         lAjzh4EraPGqtaS0QbJfpiHCwlPeD/Bst/q4Siv5RH2x+BDOxaLZDmdIa4BueO6phkW0
         /KuCsKHYmEu5Rtz61sZXF/NVp4A+1NmVsdOPR/hZQxJLzJtTxzK9qg0V9FqTRS0I5Wu7
         eprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752173121; x=1752777921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llwJe6QbrKI1OYMHC+BQZWZXCr/Kihw4SFrPpmPjIdE=;
        b=W4RdAAOO7VNCPQKhkbbBLaIV2tcu0qgWQWEVz8cb5Nnzdr81Y/qOYGITZJtsRn7Mcr
         ffoyX8ORrnvEFL0FkaGUi48tTBe8SEqVuW1QLKcHSmvW7iUL/v1VAQxnzsO+X0g3yRGt
         mNoNCdkYSIi6hXYGocTQK3WhGZJeiUow+f7zudx8vWRJAsyvhEIMotjLvvVR2BMD60cZ
         I6lgpcfYA063V9EZ5xLZZRwnSHM0cx+FTX36DWL9QS3u9CBdGPtifTrD5wiBvkNzU7bK
         pYdtNgL0zTIQ2fjr1KHuS38tH0wRw9L2ewMo6bwEZk52qH4NbH9gYSlHjF1wPM9ljU6/
         KrRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN419Co9uCSBVgZl4SF1S7nXcZRE+s4CKHPxn68qAPrcBT6FdRP3Ql/fmNirBpQJi9CMk=@vger.kernel.org, AJvYcCVSU1zcb4YzBiKE7aaty0vrKC/QtMMo3WdEuMSG2yJn0fCC1blYJ8oQUlatSC4qDR9DGopZjUSMVcJa5tGQ4d5I@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gMMEgAcXqQxAoB+sXJ2hxmTpPmbZ5Rf1OkkX3pMjMMP5N4yU
	BUOX2NdBrlYnALiWpihp4RrV7f26JnjvCjdu7aA505/4EEZqPojaJrDcXR8c5gCM
X-Gm-Gg: ASbGnctrqo5w4azgpr8V+qgyGSwR7J3SB8uufAWrpqfIVdUDe9jERCGha//Jz8xyfrj
	Pjqbedc1ftxFPryadr+5hl8XUTidtYaQA7myiqP3fvOhuFRvYRo12g3kt/F5PjVyevb1hTW8veU
	Jivz3zVxrxe7Dt+miFYnzSLF+ifLDZyU/7X5mcA7LEVN1SwQjuNpR/80t/AtaV9aqn5W87iKp/Q
	a2OrxTQB+T9fM245JJSoKiuVmmOeYcKyx+wcpHcSy6Bdv4vUbF2AAphFNTK373R68/e6vqX3Mj1
	IsejqU7smWMjc2+vP8yafsfcgILGWwQ7IL4QEJ3JL/NlpZq6dNf00AJhZvQ=
X-Google-Smtp-Source: AGHT+IG+dy7S+C4bGzKO0kxc+T8POjIXuqeNOokb1b8sNsX139jqeKqOjg+pbmtBQJ3lksRFXdmk/g==
X-Received: by 2002:a05:6000:401e:b0:3b5:d726:f16c with SMTP id ffacd0b85a97d-3b5f18a634fmr588423f8f.47.1752173120356;
        Thu, 10 Jul 2025 11:45:20 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc229asm2538150f8f.35.2025.07.10.11.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 11:45:19 -0700 (PDT)
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
Subject: [PATCH net-next 5/5] selftests: drv-net: Test head-adjustment support
Date: Thu, 10 Jul 2025 11:43:51 -0700
Message-ID: <20250710184351.63797-6-mohsin.bashr@gmail.com>
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
 tools/testing/selftests/drivers/net/xdp.py    | 147 ++++++++++++++++-
 .../selftests/net/lib/xdp_native.bpf.c        | 155 ++++++++++++++++++
 2 files changed, 301 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index b62e41c0e708..648fda231728 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -12,7 +12,7 @@ from dataclasses import dataclass
 from enum import Enum
 
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ne, ksft_pr
-from lib.py import KsftFailEx, KsftSkipEx, NetDrvEpEnv
+from lib.py import KsftFailEx, KsftSkipEx, NetDrvEpEnv, EthtoolFamily, NlError
 from lib.py import bkg, cmd, rand_port
 from lib.py import ip, bpftool, defer
 
@@ -31,6 +31,7 @@ class XDPAction(Enum):
     DROP = 1  # Drop the packet
     TX = 2    # Route the packet to the remote host
     TAIL_ADJST = 3  # Adjust the tail of the packet
+    HEAD_ADJST = 4  # Adjust the head of the packet
 
 
 class XDPStats(Enum):
@@ -490,6 +491,147 @@ def test_xdp_native_adjst_tail_shrnk_data(cfg):
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
@@ -500,6 +642,7 @@ def main():
     function to execute the tests.
     """
     with NetDrvEpEnv(__file__) as cfg:
+        cfg.netnl = EthtoolFamily()
         ksft_run(
             [
                 test_xdp_native_pass_sb,
@@ -509,6 +652,8 @@ def main():
                 test_xdp_native_tx_mb,
                 test_xdp_native_adjst_tail_grow_data,
                 test_xdp_native_adjst_tail_shrnk_data,
+                test_xdp_native_adjst_head_grow_data,
+                test_xdp_native_adjst_head_shrnk_data,
             ],
             args=(cfg,))
     ksft_exit()
diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index 68341e6f5fba..2560c43219d8 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -27,6 +27,7 @@ enum {
 	XDP_MODE_DROP = 1,
 	XDP_MODE_TX = 2,
 	XDP_MODE_TAIL_ADJST = 3,
+	XDP_MODE_HEAD_ADJST = 4,
 } xdp_map_modes;
 
 enum {
@@ -324,6 +325,158 @@ static int xdp_tail_ext(struct xdp_md *ctx, __u16 port)
 	return XDP_ABORTED;
 }
 
+static int xdp_adjst_head_shrnk_data(struct xdp_md *ctx, const __u32 hdr_len,
+				const __u32 size)
+{
+	char tmp_buff[MAX_ADJST_OFFSET];
+	void *data, *data_end;
+	void *offset_ptr;
+
+	data = (void *)(long)ctx->data;
+	data_end = (void *)(long)ctx->data_end;
+
+	/* Update the length information in the IP and UDP headers before adjusting
+	 * the headroom. This simplifies accessing the relevant fields in the IP and
+	 * UDP headers for fragmented packets. Any failure beyond this point will
+	 * result in the packet being aborted, so we don't need to worry about
+	 * incorrect length information for passed packets.
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
+	if (hdr_len == 0 || hdr_len > MAX_ADJST_OFFSET)
+		return -1;
+
+	if (bpf_xdp_store_bytes(ctx, 0, tmp_buff, hdr_len) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int xdp_adjst_head_grow_data(struct xdp_md *ctx, const __u32 hdr_len,
+			       const __u32 size)
+{
+	char tmp_buff[MAX_ADJST_OFFSET];
+	void *data, *data_end;
+	void *offset_ptr;
+	__s32 *val;
+	__u32 key;
+	__u8 tag;
+
+	if (hdr_len > MAX_ADJST_OFFSET || hdr_len <= 0)
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
+
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
@@ -348,6 +501,8 @@ static int xdp_prog_common(struct xdp_md *ctx)
 		return xdp_mode_tx_handler(ctx, (__u16)(*port));
 	case XDP_MODE_TAIL_ADJST:
 		return xdp_tail_ext(ctx, (__u16)(*port));
+	case XDP_MODE_HEAD_ADJST:
+		return xdp_head_adjst(ctx, (__u16)(*port));
 	}
 
 	/* Default action is to simple pass */
-- 
2.47.1


