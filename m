Return-Path: <linux-kselftest+bounces-37286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7DCB04913
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4B71AA0A43
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 21:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADA12586EF;
	Mon, 14 Jul 2025 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6Z9jH21"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2926FDB2;
	Mon, 14 Jul 2025 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527067; cv=none; b=PViPkbaDClR2Q2/9S3EYwRKMPBAJwcMwQXxMjoyaoNv2l9f5qlpvKWrBWW9791YP7ihzZuBpDds/a14/5uLvUN28D/BNGQpivNWtG5U1rQkVJQ2JGj2AB/KmBzPSdBHtKTXsgbfm4xo4aK5Dx+7ljwU7cQoIfnstl/wjWPKaUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527067; c=relaxed/simple;
	bh=aaAFKbE40OSW3RvOM4TdhaZPadwysqGLLvuP/SL21cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zij9kCOpPtkXiOsTclSgLcBhmIgBRttVFIRn+xkPF6tM/ZoiNrNT/+CnX2TG6eU53b5fFKbhYqobHNlltYCU1AlPVmV971InHerjmz5o9y7JfXlcJGEB95DW0mFJ6lHrgTeUCOAzv2SAaFfKVtmyADBXEiBvFln3zQ3GNuZo/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6Z9jH21; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso49454535e9.3;
        Mon, 14 Jul 2025 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752527063; x=1753131863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxwlHC+RZYp+e7Z0v2JJnTJlMm/+tyC3t696/CHzUSY=;
        b=I6Z9jH21KNR3mChlE78ipDBClOoqMN22IKeSzKRcWts5HzrPUe3w4JnoMkqBbsv9O8
         aZuWciooMgIqpMQCsCGVXOKpj7J4WEz7IEhL1zmC0FHCR1oWoO1DguMFOiJFTwzAi3JN
         eVSlbnLKo0QgDdoVXBxkuvVpK4WqBeRI4HRHBoS8Pmr9jgZ80hVtaoPI3p/fduINBJz1
         XteKXWTlHDN+Nm8NC8ORR4FPlxirBPmuW9FJT3zpPpYJUTWMcIkSO/uFNnqbTho6ga42
         92pTwbo+mSADtURXCbKoYF4Igh2mnN4vJIV4VUumFqf0SHkZ7DDRVhP0k3GcqMXLM/Kd
         oBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752527063; x=1753131863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxwlHC+RZYp+e7Z0v2JJnTJlMm/+tyC3t696/CHzUSY=;
        b=XEtbW6o2u5gEfryRNFI7eJhXzpkt+46ub3PyIACIxrIkHWRkmqLwsxeIr8feXZtCxC
         NBpkulaHYFK+7paRIkFKC6MXPUqHMETp6dQ4Q+YpBPnGjeSzjcW/yhHXMoHn57808rED
         te+1YlGklPhp3HU5/OMk+YZm0RBtY3tOGLXA7pnIOyGVsTiQn3yoH+y+icLrvPVb0ORy
         SavGw22+6SIzv2HMQ1YQDq1Y/smkL8R+Bpbu8U4nkKI/w+L4czk8RbrRQq+R/vD3DD6R
         vHeWxB3Qkyl+W5WGFsYjQKB5AZbXz7LW5pH8YF2PEN4yBgFp3TT4oDqaEqUgfR0aVrf6
         dQEg==
X-Forwarded-Encrypted: i=1; AJvYcCV4OgffLuIFnvxhTk2F/72txRzaMvAtd9ma9VLMurAbj7S8+BtD8lA4RuPDSTB/V9NH6K4=@vger.kernel.org, AJvYcCW3gXR0ZDwyCHPZWV+/PU/sSTYnSj8O6eZ/37Fa9Ndfgayxt6PnVWmJV8C1PRWqW9NXxFy1eYBtKS8IiHTFaQhH@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjuJMlRegUVyiyFyyo9hXwfZMA7St+b8oYVzIYMirnD+4LYZq
	t2nfYPErq8GIEhNiF1ewaNu+xI/ksa2HLVDvuZYfiSPr33PBnddkaxdc+1m1fqJF
X-Gm-Gg: ASbGncu6HwmmrpAN/SKpo/aZB+1BbClx+cA3825BDx9TlTS3Q0dSdmf8Y2JD1hPPU6b
	fKmXKZNZlKBhqkQ0lcB1duIcPrWV8EFnwQ0LUvPCQOcNoA4xYDzJhfx2Ir7Uvxy2/CKcfKHbC5V
	ymnQkwMWAxg2NYop3p0+qNXX9hJynNiumHS95w8DlGgNvaxphD6hYyKKSVQAv0pPdLbxiizk6W9
	PzeeUvP+t4Sbr/LjMNPqXNYnkp3gWApBx2otYx8esQ7vS3AFvF1tdbkjjLmYdX46TX+2X2EG9IV
	QOp9nysbmtVZVWmJ1s39TTmgNyIFlS6SnQ2jfUwtY6Enon39bYHlrPi4jf5fNTD6UqHD3Qk8U0/
	5j6od2RHPdAciuUhD
X-Google-Smtp-Source: AGHT+IEogMpQfDRqcpiIR/p4FG1EZFJNDEiS/PBVd/E4268wyqj2U9ygJEYhJsI9Fic5kHsKT46vcg==
X-Received: by 2002:a05:600c:3507:b0:441:a715:664a with SMTP id 5b1f17b1804b1-4562741795bmr1298365e9.20.1752527062774;
        Mon, 14 Jul 2025 14:04:22 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2087sm13547225f8f.30.2025.07.14.14.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 14:04:22 -0700 (PDT)
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
Subject: [PATCH net-next V4 3/5] selftests: drv-net: Test XDP_TX support
Date: Mon, 14 Jul 2025 14:03:50 -0700
Message-ID: <20250714210352.1115230-4-mohsin.bashr@gmail.com>
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
index 90b34b2a4fef..84376710d3fe 100644
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


