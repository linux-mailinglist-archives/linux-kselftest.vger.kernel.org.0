Return-Path: <linux-kselftest+bounces-37035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967F5B00B9C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 20:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0971C169838
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C762FD581;
	Thu, 10 Jul 2025 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNJvSPe3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056B2FD5A4;
	Thu, 10 Jul 2025 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752173120; cv=none; b=LsBtPUn/HiUvjyFds6w8YhkuGtLbp/fXbZw0AlnrvLujBTVxT0+jHTQnXWtr7LDhaOzuYyhsmL5fnHChsxrn0ceO/X4Kr+ZLZ6PU6dlApM5JQ5LxwN/J1HM/wzRP6/MwmkXtjJK3xqfdstgGBu8aZoumyoyNxJsBM6cWJn9IwoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752173120; c=relaxed/simple;
	bh=yc4dCqit8c1EW35oMNHPA0g6mSxNZDHiNjjEZrWLTDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3QzIJ/jrlxoGcQpzTf3R/T/b8lDOXLUtpjzQuc5JHGT01gzXlu7CUkPUyh7sorN4Sp1mZneWc2wQDpZ2LfdxZ6cMXz4mtedOB1CWpSxvzlmaDDPeFezXHOsSaDsw3jEDZDFRGQ26sXkdVphCNkw8vVfP5N2IsF5kQpYaNq/X5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNJvSPe3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so1102564f8f.3;
        Thu, 10 Jul 2025 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752173115; x=1752777915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnky0mBG4k4AwXvtSU0n+igqEIO6Cs61NwU7C/GDbzQ=;
        b=kNJvSPe3InlFOEwsjFGby5XU3UzHPGDrtbkU/Yw5E10jnGmGFOiXVVJ2Y7AyqB7MKb
         4TJACzQBTNY4qX7WPVdzZ+4wKhyUb+J17R6vBuKaHN9UycLJWBVRO7jN861UZS0YzQ6t
         vXAE7PjjQaUc8BLUHILUBYoLotfZoZgFB55z5snSm1+oT2KE5SO/17KYdvraI369khYv
         s+sQidXV/KMyGKKfEJXn7uDCIwNTuuy5MrI8tS5Qay1ZvRcLQvnczZABolYZJCnPjSjf
         ZxeCmDMf5Co0va6P3LJgwfC4E7g6yYa1K4BZjTqTk9FKTfFDREMc4rxJBKvJsdDr0SNr
         FLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752173115; x=1752777915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnky0mBG4k4AwXvtSU0n+igqEIO6Cs61NwU7C/GDbzQ=;
        b=NSC3ZNEtqlAE6moPKeJpiFusSrWFOLx6ogFwvyhJLqL9iQe/FPJ+Qmb6053NXlXmlb
         njcnFKI9QryyhTxV1CuxGjMumPWPKleHFXiv/uWb2Sz0sYl/yLa3+UG4fgQOKodkO1US
         giK2LDam0o4yngP8Xl4Exwnz+mteQc+9JFoO1m4urEvy96e+cMEtBsO0z/p0O4oFpTBt
         thUyLDalSkYhIJ8NuHQ9sURkUhwYz2/gU2Txg6oYxJYmFNb5EIRSG/tReF93kkDyOGuW
         1RtSteR1V6FTJs12KQV1PXJzxOEzUTT75IOoS0JNEKLGNgkZ4XjJ4jH2xpErB5PfObaA
         cG7w==
X-Forwarded-Encrypted: i=1; AJvYcCVKIWveVrqmpDd9rmhyZjxh2LyPYvkS3vjVD/DyVqO7imoJCZRUnIuxRpmNNwDt/eCOt2g=@vger.kernel.org, AJvYcCXGIbcQ9hZZxkRfvR/LIukHYNgXrK5Vq4lOjGlyTRk/1HrmVcJOk3tGs/bYTk74Kl+y8WBlLWN0dqyFKoHCv4MJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxFz4VUvhawPxdzybHG+RI1K4yzky2Et68FR2u7yKI4oVZFXL0W
	Xscc4eu+//z3QQciaJOzoz9mzaSyskEbbxKjt+dL0TIa8pjSbQMEZnkgL5nrveVg
X-Gm-Gg: ASbGncvRjFwSLFN2BAUKCH6/l4edBCVnt3qnju3TLHsPIs74gJv2YPO/6X6tEocGUM+
	c9coZmHk9l8c06GJgPaFxhVRgr6oFpfza3lx2P5Aco32g0g/h633YERBkUpVRzz8rpWTMq814qy
	v+qqZtvbZaSrJ5+EbWzyMmsAkBannFvLAgNppPD534AXn1oKRyAvlz0P9U0D/zDPY1Y54MSWmGV
	ABQ9mBXK2ACMokl7QRhmCXZS+IFj1oB77o3XCk5CSIqNeyIVsL4kdaMOeWnjNqIzSBqqXybFmEN
	hvrJfy5tepoDdc/xq/U+PpGSOnlMutDxjVolob2QLKdPprSP8BuvbE9t6vgt
X-Google-Smtp-Source: AGHT+IEK88iqd2fJ+xNFZnZt7SurbYz/rxyTVnOIneIre7s/SgAiLjnBI4YPUVaRkLClZGi3bYDWJw==
X-Received: by 2002:a05:6000:2283:b0:3a4:d6ed:8e00 with SMTP id ffacd0b85a97d-3b5f188d547mr638343f8f.33.1752173115069;
        Thu, 10 Jul 2025 11:45:15 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:44::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc21fdsm2523281f8f.33.2025.07.10.11.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 11:45:14 -0700 (PDT)
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
Subject: [PATCH net-next 3/5] selftests: drv-net: Test XDP_TX support
Date: Thu, 10 Jul 2025 11:43:49 -0700
Message-ID: <20250710184351.63797-4-mohsin.bashr@gmail.com>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/xdp.py    | 34 ++++++++
 .../selftests/net/lib/xdp_native.bpf.c        | 79 +++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index ac7eaaecef14..e05b78592989 100755
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
@@ -187,6 +189,8 @@ def _get_stats(xdp_map_id):
             stats_formatted[XDPStats.PASS.value] = val
         elif stats_dump[key]["formatted"]["key"] == XDPStats.DROP.value:
             stats_formatted[XDPStats.DROP.value] = val
+        elif stats_dump[key]["formatted"]["key"] == XDPStats.TX.value:
+            stats_formatted[XDPStats.TX.value] = val
 
     return stats_formatted
 
@@ -285,6 +289,35 @@ def test_xdp_native_drop_mb(cfg):
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
@@ -301,6 +334,7 @@ def main():
                 test_xdp_native_pass_mb,
                 test_xdp_native_drop_sb,
                 test_xdp_native_drop_mb,
+                test_xdp_native_tx_mb,
             ],
             args=(cfg,))
     ksft_exit()
diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index 90b34b2a4fef..1eaae1502623 100644
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
@@ -117,6 +119,81 @@ static int xdp_mode_drop_handler(struct xdp_md *ctx, __u16 port)
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
+		     iph->protocol != IPPROTO_UDP)
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
+			ipv6h->nexthdr != IPPROTO_UDP)
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
+		__builtin_memcpy(&ipv6h->saddr, &ipv6h->daddr, sizeof(tmp_ipv6));
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
@@ -137,6 +214,8 @@ static int xdp_prog_common(struct xdp_md *ctx)
 		return xdp_mode_pass(ctx, (__u16)(*port));
 	case XDP_MODE_DROP:
 		return xdp_mode_drop_handler(ctx, (__u16)(*port));
+	case XDP_MODE_TX:
+		return xdp_mode_tx_handler(ctx, (__u16)(*port));
 	}
 
 	/* Default action is to simple pass */
-- 
2.47.1


