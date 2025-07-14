Return-Path: <linux-kselftest+bounces-37288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9332B04915
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5F03AFF1B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 21:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95310277CA3;
	Mon, 14 Jul 2025 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA7oSN/4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9F26FDB2;
	Mon, 14 Jul 2025 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527073; cv=none; b=igtB/lD5nRtWVEtpw/zoeTWWoRoQ6miFbPBdItXKJRBwB+LSFtkbx0M/JdGld/MZW1J/2sfn706YFG6U1aq+cUEwPTm2D7gAU8CgqaVmqIbrhGzTauiOXVVqLFqrd+g/rgEqEiMNqnBFtkNkYyasWe4qR/Ct6lAeg7UiDV+VoGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527073; c=relaxed/simple;
	bh=w5BfSVj7I/pFtSMm1cpj8UWfBTRLYbxpXzZlfS1mkdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oP3UjJvmtLP3972U4ANfpzSdWB7BFvXMF7ZNL6lJQThJp6heYOAm1TvQZGRE/kgBpIQ4VYtNgOXN/NCITW4phG5PkYzxbHk8NUBgLJW/xg81guNKZj5fnLJH5tHFbwYWlFY4YOAJn3wf9/hM/xrvNiz9SBkrqN1XJpvTepXmWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA7oSN/4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso2703256f8f.2;
        Mon, 14 Jul 2025 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752527069; x=1753131869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqErgbfk2NdwVHe+kbvti+EWERjWXh5EaL7MQZQqqyc=;
        b=iA7oSN/47pksVWMM112apKaTtAY8b9BNh8X2jqNfRYIWnUKHgbswnq/tqKu375FRMz
         vwtnW8MArh3I1hNEwQdNUrEzrwgSvTLoxMbrRuAT4LJzwe2PZpKBeMSeSU9Fz5iWKsIU
         2PeLY9PYD0aTtL6R9S/dc1HCCUQb1bz5JYrOCGHE0usRNKahIKilcLzV6iiFnojigsa1
         lY2W1IAbUxch7IqKQ2nAJwtRNOO+2S8apvbHzmHbliD5fy+yVB/48FwODT7Tip5pvN3z
         oRnqBTiwbFSxZdjMw/Y+bKm9HdWAFB0rlJ+6AEzWJyv8ImbZF84eFkbBHHJ0qvBA4bKL
         3AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752527069; x=1753131869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqErgbfk2NdwVHe+kbvti+EWERjWXh5EaL7MQZQqqyc=;
        b=iRI/7mRe+jvW+6wSacDQNo5qAFetkgW6xHPlZqlGMPqoTDQ0PnairA0rNviy+8kBLm
         ZlIIpvlv1SIpV2QjP7t7FrW3Fj2rgaH94Ir/fhybtNuoI4TJEGmr8CANleuF1OAm0Laz
         OrqNrDa++CsQV0uHfMkAq8cOT8++y/qBzPbOnabS1BM2CWh1Rov0WJXVvbFPE/FST1an
         aRCBCzBTKHnGPYo17aM6Ly7IslEjkDJmspyY54eNKldGR3hYP0nCf20j6SZIr6vB27uw
         NnHsBeWL848jMiLkW6EOVj4jE/47lx/m7FS6XMcU/UfJLXRa3BaSqpxvGPh/r+XE8S/D
         b0BA==
X-Forwarded-Encrypted: i=1; AJvYcCVjtoboG+Cl5hd6V/O5pYtsrf5NvZgTDULklTwmvZuz1OiW6mrgVcetlquKVVZJ889+Yq6sLkrcdWQttoO/gpt3@vger.kernel.org, AJvYcCXZekVCSfgdD4iy8/fN16+k/4B8hZ45Tfyj+18E9WYaU//iBNwk1OTwRsGzFDO5LolKvyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsXYtYpegfe2zapLRrfQmS6nUZ+E200oJcSkuQZv2p1DYnd2f3
	Mz+BYr+Ek6NIjAahJsziXxLGIar0+OzQiD9Rnh+7qu5sGMA6xg5IEYq4gzTN3qLf
X-Gm-Gg: ASbGncs16hyDXYEI21bK6evPPpIZN9XoUpEuPt5Rm6D+mJOGWh7lqkLz14HZ+F4pzV0
	E4PAZFEv2lz40vqnAiwVNr04WCn7KZ9XzwxFB9Usv5k7oD0n8xJLKAavO6B8mKl0sKzaAytrdKI
	gK6juuiXDjM41iK0mGOSwxJF/q/inkasOvU8EdhYp+a7o/nRMDbl0/0W6N4uMDd1TL1VBrie4JX
	ChRUza0fgzqsbZzi0uPC+Ag0U5WMPghHgjvE35B7DfiV+J+fyFFElekHcvkPzwNIQYbay13XoYO
	J/mugNRQS7z38X0Da6CygIYD+BQkiHv3tyhRM0Wp8yhFviNOrwQFJjxZCAZAqxIG4Wm/R8uuJre
	royx4BYm0+GUGDRWCCuv0XYYon95L8To=
X-Google-Smtp-Source: AGHT+IHZqIcN05geTJTpVci//sQcZyB52IOXQfWqUCjIAKi+ug8wWmw1Y90c1UQ6e8z/BFQEK16cZQ==
X-Received: by 2002:a5d:64cc:0:b0:3a4:d98d:76b9 with SMTP id ffacd0b85a97d-3b5f358567emr9646742f8f.41.1752527069140;
        Mon, 14 Jul 2025 14:04:29 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd55b1absm143251065e9.40.2025.07.14.14.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 14:04:28 -0700 (PDT)
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
Subject: [PATCH net-next V4 5/5] selftests: drv-net: Test head-adjustment support
Date: Mon, 14 Jul 2025 14:03:52 -0700
Message-ID: <20250714210352.1115230-6-mohsin.bashr@gmail.com>
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
 .../selftests/net/lib/xdp_native.bpf.c        | 168 ++++++++++++++++++
 2 files changed, 314 insertions(+), 1 deletion(-)

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
index 1b196a809a07..e4465ed5a59f 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -27,6 +27,7 @@ enum {
 	XDP_MODE_DROP = 1,
 	XDP_MODE_TX = 2,
 	XDP_MODE_TAIL_ADJST = 3,
+	XDP_MODE_HEAD_ADJST = 4,
 } xdp_map_modes;
 
 enum {
@@ -325,6 +326,171 @@ static int xdp_tail_ext(struct xdp_md *ctx, __u16 port)
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
@@ -349,6 +515,8 @@ static int xdp_prog_common(struct xdp_md *ctx)
 		return xdp_mode_tx_handler(ctx, (__u16)(*port));
 	case XDP_MODE_TAIL_ADJST:
 		return xdp_tail_ext(ctx, (__u16)(*port));
+	case XDP_MODE_HEAD_ADJST:
+		return xdp_head_adjst(ctx, (__u16)(*port));
 	}
 
 	/* Default action is to simple pass */
-- 
2.47.1


