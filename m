Return-Path: <linux-kselftest+bounces-21938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CED9C72FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 15:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1810EB2E23F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB2A2038CB;
	Wed, 13 Nov 2024 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SIAiOolz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E920265A;
	Wed, 13 Nov 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506050; cv=none; b=XEd2KKoVbeD9afHQCcYo+5fN/g+ptbR2ktOmRZ6SDsXEDa5IgBQvfUd7acRw020VpN6ON/ChWxB2zvr1sWrxoSjxiCrjQLvtlawVb3GyqENBiKNkqA4bc3l2uvPRdZrNZzu4VjiDhlj+oI6LXVZMkiC0Pll3FovX5G7sAIvsI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506050; c=relaxed/simple;
	bh=GCHtMt4Fw9AAM7R0KRvvLjnehulBKQfM0eUof2yhdxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V2GerRz4+l+SC+FDBu8jG7LTFWqDTn0Cs+CSZcfJ2W/zFcSykqIbx1Scct49MzWSwq2F0mFQzVCSIel4U57eTQLtQDL7Hna3W+qh+uoNmtcGN/sHiXZ/YQyJrAk3vned12DvAbbsESRYDq7U0+jdH3hPvjCrSClUg32L97lVUwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SIAiOolz; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1168120005;
	Wed, 13 Nov 2024 13:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731506046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOaCr7A3LSnXjzXtLcfdOSspe/hUz9oHOCWScbif1cw=;
	b=SIAiOolzZ/JQYdbkoYsfrHd3mn3ZmMQaORPMfwy+zTDAeXr/ur6uUnsCd6///fb9A95PRm
	/XqEaTKNhPv46JaTbik8+Ub+BvT22Tjh83UmLtxtIrlWAP20SEZ03OJuqvGorR0si+gxAX
	vr1EuAzVOQ2MIQsfn77NM/49hreU/4ofI7+UZDt7UbfXc9ePPvCjLT0TV26nfEUkhhFZcr
	ojmAtLPdsEDJufCl6yNnY9MsHW9Q6CxsbPViXKh8uWe5rHe7sNtyiEkMHScilYMFMQv5/8
	HHeXlwbvJqJmyBsUZrIif42lOT2Ukx1hdU9LUXNZpARk+TsH0oC+bQteZ/n8iQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 13 Nov 2024 14:53:29 +0100
Subject: [PATCH bpf-next 06/10] selftests/bpf: add gre packets testing to
 flow_dissector
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241113-flow_dissector-v1-6-27c4df0592dc@bootlin.com>
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
In-Reply-To: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

The bpf_flow program is able to handle GRE headers in IP packets. Add a
few test data input simulating those GRE packets, with 2 different
cases:
- parse GRE and the encapsulated packet
- parse GRE only

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../selftests/bpf/prog_tests/flow_dissector.c      | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 8ab3268ef4c92fc33ac40e8f8f963a4d8b6551a8..05f3953c6266efdedeb74a81969ccfdabf009ccd 100644
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


