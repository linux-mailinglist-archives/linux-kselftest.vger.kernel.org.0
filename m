Return-Path: <linux-kselftest+bounces-37180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7A1B0284A
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 02:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675F7542CAE
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 00:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC277263F;
	Sat, 12 Jul 2025 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWsDmnUb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D8A6AA7;
	Sat, 12 Jul 2025 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752280027; cv=none; b=Yb1Fr/J0wse0kwphYC/4DlBxcbK7HL5do7PkYwhX9FVDAM4xNCnNgS1ozX0mwjr3N6MtrXFTIIiLE+D9q5xatwVZkJaIT89uSB55XCbBWj2afGLxJcUWF7Y3hXJfMpW/N49bhGsz2qkw6QE2KT9dqQwpvQHK42FWQDmB+WapEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752280027; c=relaxed/simple;
	bh=mk9MPv6vobxatC2Skhf61Kel45+nrcByqqSPoQvF0tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ff0eLCMyvRJkeD92cbk09QnKGvtD+NgyqaM9zg4kPwU/YmtWxIlLE1oL/a1Q2U+6z6Uu441nbowp0+n7JTNuKu6T8A+mDxEDSLk5Csnw4+Oq1DjtP4UCcyUXkzPqgqIV9RpVmhlPOAxGIODN8eNoR+LWdOedBHF7S19cVM3F8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWsDmnUb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so2318606f8f.0;
        Fri, 11 Jul 2025 17:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752280023; x=1752884823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRDPn9rqsdjVeaP89nCI2TIZNHwnZNz7NGJoatKCggo=;
        b=RWsDmnUbpJE1rcMUWWjYYihi7rYawUXrB2lsQ+8P4wWFk2F8sbqtf/JV0EWRVp9Cys
         9DrOr7H1OUn3BNSw4wyLGshJOowIT2QC9vOcC8+4vtxRdL0D2/+QVsYIjNIcWtDRVvME
         vQYTqqiIRiWU+83PAm6mDLkCsdvmgXYUQi6Ou8+839jS4PDrtveiBsLOL4CFiGMJ3/T6
         jgWlZDARqwInhtWfskTYOuKAAGlR87ccrN9A06MsRNc0FrRWhAhD5bwRvpBubJHYEVe/
         88T1YVzwuE3HKFMCr2vtR4eTS3HyT9Wa+MgdPo67kfFokjeBxhkp9e6WjE+R3IV8FIIb
         xiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752280023; x=1752884823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRDPn9rqsdjVeaP89nCI2TIZNHwnZNz7NGJoatKCggo=;
        b=QBsGoUWJeHBYfF/CPrTNVpM+BvM2luEKMK4pV4CYluUAMVK00A2tkYajElAasstSdB
         Wi6MSIkA3KyEOU0Gr7VKcE2yn5RifKJJ68dyunUl3zk5HEM3IV35O10F92cRjOJlmu4p
         g1vAFBqx5/GAUvd+zLjNTUFxHdS7/mFZkkWC/IodWp5tUd2sDAxfbk8ecIKmIzKiPQTV
         b7V+oOrQJX06HKO1/yAvfYA8tNcuh9/jMgshXGhjyfPCttrzQ1lsruMh9hWCZ404TaPo
         904w4Dg85G2JuLufP6XZVAZPigb0on/XAWZQws0VoG4kPQbN2cLfxLMaGiHQ9BH3eXWN
         VT+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHtE3b1tPNT9NDuznnyp7gDGa7EZ1+6e2FT1QgR+mMK4Bcb60VyO7vbPmWPB+asgZFauw=@vger.kernel.org, AJvYcCWL+In+Yuq3GAfKR4BswQ+nawmgMaNUWFNPTI18ioHqeWgmUVw4KjLAtP6GwH4PNGqLrVVKqe1Rsvhee6aXG7wR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/PlcmiA8pJmYnVxb6Uzdwb8pzQQAmfVM1ozbFyx4r+qUZQty
	yArs3f/jcrTpcWMY6DPAUgmv30oFZPNk2b75SOmy7JqmOtBmQK0Zgd47BeK3BFHy
X-Gm-Gg: ASbGnctmDuyFksoCWD3y9SUFodUdwjehsjxV03cY83KhBCOYYKUOVefGHt1wLhegnxH
	nqWbxcScQOT2nevUruPS9oFA73TN5f845+bIdVjyCvRmRVdrE+2w06skMbo77JgpRC/l9XhVfsl
	PebeUEqOQyLcgazUJjE6+ZTzFgbWkaD6cPZeW9m2BeIXTb6b5Iy0FGa0xI9n06oMduXgUd4m5Wq
	4yB1zvvDC0YtkLupoyNXPnJ0Hf3WdBxgSTAuu2f5HQgBaHcIRp4athD+3fQ9zSsn1sbKLNw1XuC
	5oD9ZCAyemxmTac+hc/vMXk2NcayFsqgqbUDve809k39PcqfV+ZuuIezAUSkxRpYSCwFUABlvcE
	DWt4mf5npGVQn+lST2lzi
X-Google-Smtp-Source: AGHT+IEjTjpzqY5jq/cLWtP4lBQ2WLceJPGVeAp2nxtBMGoDWdBNQN+rsHnrvZ2fyfpYixb2UIM1gA==
X-Received: by 2002:a05:6000:65c:b0:3a4:ce5c:5e8d with SMTP id ffacd0b85a97d-3b5e7f34dd1mr7955427f8f.20.1752280023368;
        Fri, 11 Jul 2025 17:27:03 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:71::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd537932sm61345335e9.20.2025.07.11.17.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:27:02 -0700 (PDT)
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
Subject: [PATCH net-next V3 2/4] selftests: drv-net: Test XDP_TX support
Date: Fri, 11 Jul 2025 17:26:46 -0700
Message-ID: <20250712002648.2385849-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250712002648.2385849-1-mohsin.bashr@gmail.com>
References: <20250712002648.2385849-1-mohsin.bashr@gmail.com>
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


