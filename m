Return-Path: <linux-kselftest+bounces-37385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 685C8B0684F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 23:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC01189FE13
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 21:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD442C158C;
	Tue, 15 Jul 2025 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgcSB83+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DEC2C08CD;
	Tue, 15 Jul 2025 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613571; cv=none; b=r3S3lbRb0RPAm9jFPNvcmmqyT8zDQSXIoF4bapE/2eAXPDoQldQFDaCR9snubh63VlStGTrNaK9fHZOBsmsFqanh7Szl6OxSl7AAES5ImQae7cCWiXvF8RjXpJR3ExWoqCBBr6jJJraPzNI/+1MJVl3OY0mt1gEmpApcw3lV14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613571; c=relaxed/simple;
	bh=tBxpO3cRyOuCL8G37Sn15tbHWRu/mNO4LgJABiVIXl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cU1+yROT+nBnczLi9vC0hYfNq4p2oGeBy+9bM+PUb6Ei++grE3COH116ptWLyJI2WnB8wpxMK+yiwp1fovT63WEBQdefQBT1Z4CqMM1StOy/110gy29A/bQvSbHXiqPhs/amk6znk8ZLY0Zg+3A2Rw+gaYu4Ari5GvAlfy6q/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgcSB83+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a588da60dfso3965181f8f.1;
        Tue, 15 Jul 2025 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752613567; x=1753218367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPWOVcXvs9CEmKnXCM8lPHRr6aF4201bjUdGHF9ZM9o=;
        b=SgcSB83+svTQf/BQ9FD5EhrpGvK5fndTaF1zSU84L4x1d+KA5PfhTBBvPP1GPG9IfY
         jp8eSQS8JsB3E2RVoY63x0ZtvNwnJfjoL11wzAdRXFqFnlsZhgwmfVWQw+BeC4mx8u+8
         21IPBBdV0ml0LOe2waqXmiZYfVjaWJVilRYCzkbvL9gGT8IVEm1rsfN4X1Nq0CrNane7
         z4bItNFZBq7r3CNKnmxtkupX82JVFswRcGabRtLXUB+rTjhCUi1dCM8AiYmVbVgueGn6
         E2cfXZGMKdvPdQsSUn6mSRL4+Sr4i7CFPkACJrlkT5roNSsAvlWK0GkDn51NBGsoiA3P
         KDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752613567; x=1753218367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPWOVcXvs9CEmKnXCM8lPHRr6aF4201bjUdGHF9ZM9o=;
        b=i2TfxDOBhGsR4GugoHpHkcQWREKgMkNkI2YIfi+f/I8DXbfdx1NqCnxeNCSncWCq55
         KO5wsshnZlLaijRjuOQZd305CxT+RrkTcXqG8geZygnjyZErgkpYEn45E2Hc1dWKMHIW
         lVkfGtyMRaazN0VK8MmHBVaMGYKPDRRgivM4VBi1UY/fNgNf7+m32LEy1TclhGxonaTc
         vZ+L5MNKTYMy2PxNMOS6FffCDVYqYN/feujtndf7X/IibS/sRbAtBFX4K1xo7GNlS3QC
         17FLJVTVXhvz1Lk+sDJtZwaAmCPnSKEDyku5di8UhrJ1lIZEXV2IaGrEuhoXmA+Sjhkt
         oVag==
X-Forwarded-Encrypted: i=1; AJvYcCU781fmbteYqT9m++gUX7ozdtV7Yhc2jvM/bthlBM56FavpEePeA+TNCH3cFERGKVDrmweIQTsq3eW6oqgDv8pw@vger.kernel.org, AJvYcCXWBo2bTkyzHcemx5hiPR1zyGcGzN+c1PrT6GJDJIIhak1bNjRijBMepAD4jcpWO78LJYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx51FdfRli+z7Vr8upx697uuQGxdYYLNgexAOectcGTGzUyi7xT
	jv62szJgujXt4yitPrJX86uN4pcntjzf6ydhKSvYFdhArI1DP69If6+IeqYOoEQ3
X-Gm-Gg: ASbGncvBSnVUODT/P9L2sUJd2cZ1C03hKM+BNgwSvYouQMZVPB6Ub60nTZo2hUwffbN
	Iag8eW0Asy/o+fFe4BIqHxv+D7uRVsUcO6QkLJd5vxlLc7xBJksUw5wN243JM8cOHjAPfiYH4Qe
	jQOO+4CCDdmalUiwKmz9o+DMKbmCrMeBe4CNlS+poYrhycDXkyRng0wsIPkhyXtAPfgjALWtgea
	0qu0Wd4W0rKWE5UgNUtgGFpVDXfrHnm9KVO26SDxcFfBI69PZF0MsIx9KvdJDVVgnp4GK9QwS9f
	VVzyiVhqFQ7vOGGj91E3pMXbyANUQy2hA3Tpn4HT9KB8JxhqyHNmt2VwUrE8aIswb28nAf8LOCj
	fn1sWkJ9BuZmuBDhySRo=
X-Google-Smtp-Source: AGHT+IEOJFESc0uuR1dDwkEbHVXO6yQQ8SLGPCcN4gVU+dA+Oqt03Jggt955X93XR4ZJJAN7UUSkOg==
X-Received: by 2002:a5d:5f46:0:b0:3a5:2d42:aa17 with SMTP id ffacd0b85a97d-3b60e5127efmr44261f8f.31.1752613566957;
        Tue, 15 Jul 2025 14:06:06 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:7::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b60e3ed902sm86145f8f.91.2025.07.15.14.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 14:06:06 -0700 (PDT)
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
Subject: [PATCH net-next V5 3/5] selftests: drv-net: Test XDP_TX support
Date: Tue, 15 Jul 2025 14:05:51 -0700
Message-ID: <20250715210553.1568963-4-mohsin.bashr@gmail.com>
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
index 79a8156ed416..b1611e5178a4 100755
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


