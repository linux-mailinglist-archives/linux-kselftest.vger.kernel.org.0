Return-Path: <linux-kselftest+bounces-37617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CAAB0AEB8
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 10:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7074E567CCA
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 08:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF933238C0F;
	Sat, 19 Jul 2025 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQXJIMsP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8822343C7;
	Sat, 19 Jul 2025 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752913894; cv=none; b=ol6pS7Q2T6MC9wzmfzzwnNoPfxUwiBvTydNAJ3JgRc2s4RuN7Oyid2l2h5/ze3bHgTVVfrb+rvdICF+OqsrDCMLJtEVkpy8yurgR1EEPxQBZ7hHvxSNxpviGH+gAYVQ3GbyshwfMFg+rL3OxBIu79+uEZJQqmga1l4rH37l1uqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752913894; c=relaxed/simple;
	bh=xL6RfvcyHScdiyE0WyVSv0i5OJ3ZQ9RQR1uYATJ8e30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmTTM3SvRLQAHsUiyCWqsZOu2EIyD3kwsXFaC5Bxn84uv/dpK4R02u8BSFBNGBaxCSaLTuBGFH2kxUNu31xGs605sRnOyxf4iFvjRwh9k3TGlxRZojBx87gVLx0VyaIssYTY23jqo1CP3iO92wknDQKFDf3cKzo2/RV5oH2ZlsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQXJIMsP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso2577420f8f.1;
        Sat, 19 Jul 2025 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752913891; x=1753518691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJalLDqP/640AXYSMgBa1GIRuzgmI7kdp3Eb/Zkwwyg=;
        b=BQXJIMsP7OuZLOPfBMrf6GGqekQiCeCr+CtXmDfzcR2AWnMCCBRPas5yizfFRX+ssM
         hXBrVgwfLqaUrMNnHLQgaMpQPNrQJAtCUlewWobHB6VhVJu7/1GSkSA44Q8hdiRXdMEI
         b3DHcicNdmCGt73qB6l0FJeu1EGBTGr+/VPjCm7g9kSbOWMJ9OoiTOPykuUKGaj41L+v
         VdxHjButishKWhCx4kNayiF0IQMr1CApZYFXtBg6zRpALT6KrjsI1ZVjVwlN7M2MXdS8
         Irzdqd4W9RXEU8GmDg27IyI18L4/u0pn+qBOrKJo2ZHFreitHEOSmJdlh77qOfIcynfz
         5kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752913891; x=1753518691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJalLDqP/640AXYSMgBa1GIRuzgmI7kdp3Eb/Zkwwyg=;
        b=Hbae/+wFp25yfYOHMGcqTcImibJURoLpLM88bZpBY/B7bn+CKoZZ6DORQ1tox2tQ6A
         pmzHxWWtB8bgBpss3GdowBWU1fU0XFJlmjRjv2Us4IK3dZNqMKc1HyzveRbJSvQboks5
         eGj3Rj2YNsY/pCQ5tgodhztxFWvDhtMoXPgGys1o+HMyzylxtV7So1nhWq4eCQoFCD0H
         McHDNDGs/ki5KLPKL1LNTdGsfm8/HcP0NHWocaiGy+Xk/zldTHW+ZPo517BI1YiVPA6m
         m+eBRMGxRUZanhkGI0NdE+TuRb9SDCRgGkN5jT/aPYcDZRoLCdt3WQ84wzBSUPJ0U+GD
         HhsA==
X-Forwarded-Encrypted: i=1; AJvYcCUGJW+5GCKzzDe6fpYKGXJVvivVKJ7S7tfqFUA1medrc0F6er3myF4L3HtZ4t4r2Xewa8NdIvzxJL9MtOIY/wVt@vger.kernel.org, AJvYcCWI6XgfbvhLXN95MoJcWlIQgbx/wB4GZI4xT/SCp7xQN+vPzqSMsxqtGNLZr7TLGL6tVA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygmMCfeYYGseVkv0Ox8NlHCyioip9P9Ai5vvHOht3Q/Y7SF+Py
	D0rrd4KRPqMVA+mAPfdP05RyOlUK5NfLKUIZ0cYh7tgb1hQc28sMSXgNUTEu2u0b
X-Gm-Gg: ASbGncsjTXp9W5goRx6iiK0RPUzzcD3bJiFVkL/tZ/q8epfoPrIKD6SSw3TBhRApg/x
	J+Vdy+m+oAuF3fimgb5BHsSHldr4ppOAhGokhJCF+0OGQo/p9tgk/HshvsKubnABRWmc9S/aONj
	+CrtLJhYqnRVTcviZmk7KvRpaPp1fZNIDARE67MY/R/urwHbPlEgd4K1zGl39h/OeKHmJkEs8Vn
	UvzYB3V9nq/K/0iZFFhVIl2/E2f5tmndf8uanK2Dqb6kRC4097gYDIubivmI4K4PMgCWXwuzQDq
	rrq9xWLxKAgULjija3pb9vOjd+lcxGEhTU15WDHr45OTAYq+aNmKBSj23Z5vlXA0oXGrUBRrQlA
	0Wa5J8gcACZnf5lupUizu
X-Google-Smtp-Source: AGHT+IE1H5NNuApsbUOJGzEUJkKa2gnVVpnNcxvw7AwgkS+45efssXxRES98HUfoPqMnRntvcm1VbQ==
X-Received: by 2002:a05:6000:4819:b0:3a5:7967:cdb9 with SMTP id ffacd0b85a97d-3b60e52468emr11136368f8f.46.1752913890660;
        Sat, 19 Jul 2025 01:31:30 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d77bsm4152441f8f.70.2025.07.19.01.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 01:31:29 -0700 (PDT)
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
Subject: [PATCH net-next V6 3/5] selftests: drv-net: Test XDP_TX support
Date: Sat, 19 Jul 2025 01:30:57 -0700
Message-ID: <20250719083059.3209169-4-mohsin.bashr@gmail.com>
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

Add test to verify the XDP_TX functionality by generating traffic from a
remote node on a specific UDP port and redirecting it back to the sender.

./drivers/net/xdp.py
TAP version 13
1..5
ok 1 xdp.test_xdp_native_pass_sb
ok 2 xdp.test_xdp_native_pass_mb
ok 3 xdp.test_xdp_native_drop_sb
ok 4 xdp.test_xdp_native_drop_mb
ok 5 xdp.test_xdp_native_tx_mb
\# Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/xdp.py    | 34 ++++++++
 .../selftests/net/lib/xdp_native.bpf.c        | 80 +++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index 8ab1607edcd8..d42dbee78431 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -27,6 +27,7 @@ class XDPAction(Enum):
     """Enum for XDP actions."""
     PASS = 0  # Pass the packet up to the stack
     DROP = 1  # Drop the packet
+    TX = 2    # Route the packet to the remote host
 
 
 class XDPStats(Enum):
@@ -34,6 +35,7 @@ class XDPStats(Enum):
     RX = 0    # Count of valid packets received for testing
     PASS = 1  # Count of packets passed up to the stack
     DROP = 2  # Count of packets dropped
+    TX = 3    # Count of incoming packets routed to the remote host
 
 
 @dataclass
@@ -180,6 +182,8 @@ def _get_stats(xdp_map_id):
             stats_formatted[XDPStats.PASS.value] = val
         elif stats_dump[key]["formatted"]["key"] == XDPStats.DROP.value:
             stats_formatted[XDPStats.DROP.value] = val
+        elif stats_dump[key]["formatted"]["key"] == XDPStats.TX.value:
+            stats_formatted[XDPStats.TX.value] = val
 
     return stats_formatted
 
@@ -278,6 +282,35 @@ def test_xdp_native_drop_mb(cfg):
     _test_drop(cfg, bpf_info, 8000)
 
 
+def test_xdp_native_tx_mb(cfg):
+    """
+    Tests the XDP_TX action for a multi-buff case.
+
+    Args:
+        cfg: Configuration object containing network settings.
+    """
+    cfg.require_cmd("socat", remote=True)
+
+    bpf_info = BPFProgInfo("xdp_prog_frags", "xdp_native.bpf.o", "xdp.frags", 9000)
+    prog_info = _load_xdp_prog(cfg, bpf_info)
+    port = rand_port()
+
+    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.TX.value)
+    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+
+    test_string = ''.join(random.choice(string.ascii_lowercase) for _ in range(8000))
+    rx_udp = f"socat -{cfg.addr_ipver} -T 2 -u UDP-RECV:{port},reuseport STDOUT"
+    tx_udp = f"echo {test_string} | socat -t 2 -u STDIN UDP:{cfg.baddr}:{port}"
+
+    with bkg(rx_udp, host=cfg.remote, exit_wait=True) as rnc:
+        cmd(tx_udp, host=cfg.remote, shell=True)
+
+    stats = _get_stats(prog_info['maps']['map_xdp_stats'])
+
+    ksft_eq(rnc.stdout.strip(), test_string, "UDP packet exchange failed")
+    ksft_eq(stats[XDPStats.TX.value], 1, "TX stats mismatch")
+
+
 def main():
     """
     Main function to execute the XDP tests.
@@ -294,6 +327,7 @@ def main():
                 test_xdp_native_pass_mb,
                 test_xdp_native_drop_sb,
                 test_xdp_native_drop_mb,
+                test_xdp_native_tx_mb,
             ],
             args=(cfg,))
     ksft_exit()
diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index 90b34b2a4fef..d3c66c891589 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -18,12 +18,14 @@ enum {
 enum {
 	XDP_MODE_PASS = 0,
 	XDP_MODE_DROP = 1,
+	XDP_MODE_TX = 2,
 } xdp_map_modes;
 
 enum {
 	STATS_RX = 0,
 	STATS_PASS = 1,
 	STATS_DROP = 2,
+	STATS_TX = 3,
 } xdp_stats;
 
 struct {
@@ -117,6 +119,82 @@ static int xdp_mode_drop_handler(struct xdp_md *ctx, __u16 port)
 	return XDP_DROP;
 }
 
+static void swap_machdr(void *data)
+{
+	struct ethhdr *eth = data;
+	__u8 tmp_mac[ETH_ALEN];
+
+	__builtin_memcpy(tmp_mac, eth->h_source, ETH_ALEN);
+	__builtin_memcpy(eth->h_source, eth->h_dest, ETH_ALEN);
+	__builtin_memcpy(eth->h_dest, tmp_mac, ETH_ALEN);
+}
+
+static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	struct udphdr *udph = NULL;
+	struct ethhdr *eth = data;
+
+	if (data + sizeof(*eth) > data_end)
+		return XDP_PASS;
+
+	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		struct iphdr *iph = data + sizeof(*eth);
+		__be32 tmp_ip = iph->saddr;
+
+		if (iph + 1 > (struct iphdr *)data_end ||
+		    iph->protocol != IPPROTO_UDP)
+			return XDP_PASS;
+
+		udph = data + sizeof(*iph) + sizeof(*eth);
+
+		if (udph + 1 > (struct udphdr *)data_end)
+			return XDP_PASS;
+		if (udph->dest != bpf_htons(port))
+			return XDP_PASS;
+
+		record_stats(ctx, STATS_RX);
+		swap_machdr((void *)eth);
+
+		iph->saddr = iph->daddr;
+		iph->daddr = tmp_ip;
+
+		record_stats(ctx, STATS_TX);
+
+		return XDP_TX;
+
+	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
+		struct ipv6hdr *ipv6h = data + sizeof(*eth);
+		struct in6_addr tmp_ipv6;
+
+		if (ipv6h + 1 > (struct ipv6hdr *)data_end ||
+		    ipv6h->nexthdr != IPPROTO_UDP)
+			return XDP_PASS;
+
+		udph = data + sizeof(*ipv6h) + sizeof(*eth);
+
+		if (udph + 1 > (struct udphdr *)data_end)
+			return XDP_PASS;
+		if (udph->dest != bpf_htons(port))
+			return XDP_PASS;
+
+		record_stats(ctx, STATS_RX);
+		swap_machdr((void *)eth);
+
+		__builtin_memcpy(&tmp_ipv6, &ipv6h->saddr, sizeof(tmp_ipv6));
+		__builtin_memcpy(&ipv6h->saddr, &ipv6h->daddr,
+				 sizeof(tmp_ipv6));
+		__builtin_memcpy(&ipv6h->daddr, &tmp_ipv6, sizeof(tmp_ipv6));
+
+		record_stats(ctx, STATS_TX);
+
+		return XDP_TX;
+	}
+
+	return XDP_PASS;
+}
+
 static int xdp_prog_common(struct xdp_md *ctx)
 {
 	__u32 key, *port;
@@ -137,6 +215,8 @@ static int xdp_prog_common(struct xdp_md *ctx)
 		return xdp_mode_pass(ctx, (__u16)(*port));
 	case XDP_MODE_DROP:
 		return xdp_mode_drop_handler(ctx, (__u16)(*port));
+	case XDP_MODE_TX:
+		return xdp_mode_tx_handler(ctx, (__u16)(*port));
 	}
 
 	/* Default action is to simple pass */
-- 
2.47.1


