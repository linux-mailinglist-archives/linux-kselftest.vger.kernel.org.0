Return-Path: <linux-kselftest+bounces-22055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 528719C94C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 22:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B5428297D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 21:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188761B6CF4;
	Thu, 14 Nov 2024 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MzJ+jTee"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720EB1B3943;
	Thu, 14 Nov 2024 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621084; cv=none; b=fPVlz2dT+YoYb/f+qrC1ZyI0PilnPZVwjb+NPMr99AwRUdd/SCvuV+zZnmw61iE9tXxWics8ni3DXFNVzaLVKXVmXDMcaDZxg65gBsiIEw9pEjNR09K1fCDlFS8as6lNbHZydg18puX7t6CrnTqFuglRb1ExUD9kIRp9FjyOlTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621084; c=relaxed/simple;
	bh=sBwofpHGPxIgVgqwQBY1QNihju84VLTkpwk6kZZqpVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gntsKOX51DYsm1FVA57dzsX+w97SGOs/Aao5jqvsS2GLxJoh9u8uJmG60fgUrjv7GRHEG0lN617h8eLfGcgad6hUQIJwiHqqNe8ZnoCPQaze5a1CkusgvwUvK3RacKlwU8S9tKAQGumO9ESiTSWawDBUhV0OeUg/Og+uDnPZ21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MzJ+jTee; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 651CF20008;
	Thu, 14 Nov 2024 21:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731621079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hjkzoqn9KjCq7LJ+7XsizIbeAtjAbVDPbU8HyaT2l/A=;
	b=MzJ+jTeeVY/rq79mLNM+BDIOq7Olk2afqXpgC2YcVgRuuUWWv9pD0LcapNXfAWTQUhgD/3
	tdQU7Q84aPbW51/4geziObyaznSV4S+w5BKGNY3XBRqzVZIQc5jz00M+6Fb64KOEP3f8Ph
	mGA/dWriquBI6tv5tOcOXG3G5YfVHzjbvay6C3qUxzs+6CcvVOBNseUxj7ForuFCSmYrsi
	jxk1iyc4hwG1QSx6KejfURbO3wGqtys7P5db2fkuC6R7Pj+2wwPkmfc1tjWj0BqA1SbAiA
	APB3BdFdan9OCosBbyxQ7RTnUWIo9YP18mG/guC/Dtn6Gqq5zrE5hnmxum8oaQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 14 Nov 2024 22:50:37 +0100
Subject: [PATCH bpf-next v2 06/13] selftests/bpf: add gre packets testing
 to flow_dissector
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241114-flow_dissector-v2-6-ee4a3be3de65@bootlin.com>
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
In-Reply-To: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

The bpf_flow program is able to handle GRE headers in IP packets. Add a
few test data input simulating those GRE packets, with 2 different
cases:
- parse GRE and the encapsulated packet
- parse GRE only

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- fetch Acked-by tag
---
 .../selftests/bpf/prog_tests/flow_dissector.c      | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 29182009cda944e617a26e450902e63c2f7787ce..1e17254376ec440816670a564f128a7c0275c618 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -63,6 +63,19 @@ struct dvlan_ipv6_pkt {
 	struct tcphdr tcp;
 } __packed;
 
+struct gre_base_hdr {
+	__be16 flags;
+	__be16 protocol;
+} gre_base_hdr;
+
+struct gre_minimal_pkt {
+	struct ethhdr eth;
+	struct iphdr iph;
+	struct gre_base_hdr gre_hdr;
+	struct iphdr iph_inner;
+	struct tcphdr tcp;
+} __packed;
+
 struct test {
 	const char *name;
 	union {
@@ -72,6 +85,7 @@ struct test {
 		struct ipv6_pkt ipv6;
 		struct ipv6_frag_pkt ipv6_frag;
 		struct dvlan_ipv6_pkt dvlan_ipv6;
+		struct gre_minimal_pkt gre_minimal;
 	} pkt;
 	struct bpf_flow_keys keys;
 	__u32 flags;
@@ -417,6 +431,68 @@ struct test tests[] = {
 		},
 		.retval = BPF_FLOW_DISSECTOR_CONTINUE,
 	},
+	{
+		.name = "ip-gre",
+		.pkt.gre_minimal = {
+			.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
+			.iph.ihl = 5,
+			.iph.protocol = IPPROTO_GRE,
+			.iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
+			.gre_hdr = {
+				.flags = 0,
+				.protocol = __bpf_constant_htons(ETH_P_IP),
+			},
+			.iph_inner.ihl = 5,
+			.iph_inner.protocol = IPPROTO_TCP,
+			.iph_inner.tot_len =
+				__bpf_constant_htons(MAGIC_BYTES -
+				sizeof(struct iphdr)),
+			.tcp.doff = 5,
+			.tcp.source = 80,
+			.tcp.dest = 8080,
+		},
+		.keys = {
+			.nhoff = ETH_HLEN,
+			.thoff = ETH_HLEN + sizeof(struct iphdr) * 2 +
+				 sizeof(struct gre_base_hdr),
+			.addr_proto = ETH_P_IP,
+			.ip_proto = IPPROTO_TCP,
+			.n_proto = __bpf_constant_htons(ETH_P_IP),
+			.is_encap = true,
+			.sport = 80,
+			.dport = 8080,
+		},
+		.retval = BPF_OK,
+	},
+	{
+		.name = "ip-gre-no-encap",
+		.pkt.ipip = {
+			.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
+			.iph.ihl = 5,
+			.iph.protocol = IPPROTO_GRE,
+			.iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
+			.iph_inner.ihl = 5,
+			.iph_inner.protocol = IPPROTO_TCP,
+			.iph_inner.tot_len =
+				__bpf_constant_htons(MAGIC_BYTES -
+				sizeof(struct iphdr)),
+			.tcp.doff = 5,
+			.tcp.source = 80,
+			.tcp.dest = 8080,
+		},
+		.keys = {
+			.flags = BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP,
+			.nhoff = ETH_HLEN,
+			.thoff = ETH_HLEN + sizeof(struct iphdr)
+				 + sizeof(struct gre_base_hdr),
+			.addr_proto = ETH_P_IP,
+			.ip_proto = IPPROTO_GRE,
+			.n_proto = __bpf_constant_htons(ETH_P_IP),
+			.is_encap = true,
+		},
+		.flags = BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP,
+		.retval = BPF_OK,
+	},
 };
 
 static int create_tap(const char *ifname)

-- 
2.47.0


