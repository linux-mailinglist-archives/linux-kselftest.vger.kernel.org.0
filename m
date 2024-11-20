Return-Path: <linux-kselftest+bounces-22327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543809D3490
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 08:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7BEB23985
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 07:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBE919F406;
	Wed, 20 Nov 2024 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bNadP4C4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FAC19D063;
	Wed, 20 Nov 2024 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088622; cv=none; b=CfeOIKuQx3MIAuM7qG9VKjb7A1WRClgU+5kbbBEjNwlsjdwwzHoSm0Kolb7tFu2Fhc+EMuWsyILvvl1ztSExgkqX8KQDeAJxsOjLfDNlocXpkINwHXHeXHzhZcKDEhpjoWlOZVsURvPuqfJjZqTefSCiSRCgyifexNe5S5X6jeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088622; c=relaxed/simple;
	bh=a1Z4gClvuTUo5OkZJM3UqV+hEuNmuixd0dpk6Mu7XkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+D6yzdgQ2UJsKVg6qEEgZVUsldOP8m+v9dOM41kuvBtKpLoP7wE4kf6C7XNoWaZV6uLKbdH/wgYgWUEwgUVZ3tJ2Wq89HUJfgnwu5HzWJl4hPclMJhbz6v3ddwnWo5O24hEIGEIl4+0conzMmY3MnWThh9+YKbOE/c6ckCRLn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bNadP4C4; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B76C24000C;
	Wed, 20 Nov 2024 07:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732088618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeQXTSX3AXLNP8f+9FXvOzULwKf0ACJOa6kClw7gPRA=;
	b=bNadP4C48wgNVaFwXzsKwPM614SoH//3Wzkufx6Ob9lH5Zs4397OObX6Gp7cBQryzeeHd0
	fIt0GYUMbx1z/dJA8Vkavj0ElbeHX6huyMRLhtCECGYMzjLCyAs2QM9HnSsHJuk40jK/Bc
	9aoZrttkBgK+zzv6ZJXCOQkvn1aBxiI05jRzBtqXI3MbUNGvBmtzLxa8cmy1E3M32RbOfZ
	UA92m7b5ZLNoQrjOhn2Nt+9ndCAp6gG65NkRE9ahd6FYaZQl0IOjSELdp9D4T0dXVBYxHR
	5lOM3UuBA7VJbPLp4jXB94/t0wlpcI9BckO395bprtQWt7nLPhU4JZz9tcwLVg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 20 Nov 2024 08:43:19 +0100
Subject: [PATCH bpf-next v3 09/14] selftests/bpf: move ip checksum helper
 to network helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-flow_dissector-v3-9-45b46494f937@bootlin.com>
References: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
In-Reply-To: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
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

xdp_metadata test has a small helper computing ipv4 checksums to allow
manually building packets.

Move this helper to network_helpers to share it with other tests.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- use csum_partial for intermediate helper name to keep sync with the
  corresponding kernel helper
- provide byte count instead of half-word count to csum_partial

Changes in v2:
- new patch
---
 tools/testing/selftests/bpf/network_helpers.h      | 24 ++++++++++++++++++++++
 .../selftests/bpf/prog_tests/xdp_metadata.c        | 19 +----------------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index c72c16e1aff825439896b38e59962ffafe92dc71..5ef909f766eb9ac2dd5be67b99245b4676ce4f5f 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -104,6 +104,30 @@ static __u16 csum_fold(__u32 csum)
 	return (__u16)~csum;
 }
 
+static __wsum csum_partial(const void *buf, int len, __wsum sum)
+{
+	__u16 *p = (__u16 *)buf;
+	int num_u16 = len >> 1;
+	int i;
+
+	for (i = 0; i < num_u16; i++)
+		sum += p[i];
+
+	return sum;
+}
+
+static inline __sum16 build_ip_csum(struct iphdr *iph)
+{
+	__u32 sum = 0;
+	__u16 *p;
+
+	iph->check = 0;
+	p = (void *)iph;
+	sum = csum_partial(p, iph->ihl << 2, 0);
+
+	return csum_fold(sum);
+}
+
 static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
 					__u32 len, __u8 proto,
 					__wsum csum)
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index c87ee2bf558c1a7fb726cae0aa7b3d3735fb1aac..7f8e161655336127e5bd7a573d1a09db85a92f53 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -133,23 +133,6 @@ static void close_xsk(struct xsk *xsk)
 	munmap(xsk->umem_area, UMEM_SIZE);
 }
 
-static void ip_csum(struct iphdr *iph)
-{
-	__u32 sum = 0;
-	__u16 *p;
-	int i;
-
-	iph->check = 0;
-	p = (void *)iph;
-	for (i = 0; i < sizeof(*iph) / sizeof(*p); i++)
-		sum += p[i];
-
-	while (sum >> 16)
-		sum = (sum & 0xffff) + (sum >> 16);
-
-	iph->check = ~sum;
-}
-
 static int generate_packet(struct xsk *xsk, __u16 dst_port)
 {
 	struct xsk_tx_metadata *meta;
@@ -192,7 +175,7 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	iph->protocol = IPPROTO_UDP;
 	ASSERT_EQ(inet_pton(FAMILY, TX_ADDR, &iph->saddr), 1, "inet_pton(TX_ADDR)");
 	ASSERT_EQ(inet_pton(FAMILY, RX_ADDR, &iph->daddr), 1, "inet_pton(RX_ADDR)");
-	ip_csum(iph);
+	iph->check = build_ip_csum(iph);
 
 	udph->source = htons(UDP_SOURCE_PORT);
 	udph->dest = htons(dst_port);

-- 
2.47.0


