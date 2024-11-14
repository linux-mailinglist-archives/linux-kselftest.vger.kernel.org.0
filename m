Return-Path: <linux-kselftest+bounces-22059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1021D9C94D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 22:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5396CB24B83
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 21:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68A01BE852;
	Thu, 14 Nov 2024 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jduz5Pvh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B431BD000;
	Thu, 14 Nov 2024 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621090; cv=none; b=lAYJAYTMq08Wv4+3G5v04mF/swWTGKadkM8+VFX7EkMMwr1lkjwoEUlI+SYhSQU1wXmHqEoh6HPPFugFZOzeZjuOxRbzggIbkJIsubQhX0M893pztaaQDgmQFuK4F/vi+TBKWbAmy8EvYuE+ZW8uimlxTip1fPqWpCOgNPaxxy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621090; c=relaxed/simple;
	bh=ba9vakCoZKL2hMG8Tp95yDBI7AKEOlZdSZvBA1DO9QA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dl1atWFnga+nBcs9aaWcd9t6J9Or7hIo+/NZEJSZvX3axJT0yY6GwQATvqfqOcOAoJ1ZDYYxJ2976bgagcCCoc1viM3J9VCD5wUPjn/8F/apl55eL4/tpNZWkqZL3aSnSsYSZOhC/GpnVUZToT5DTHy4g4IVeGswravzKaMtJN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jduz5Pvh; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 265F320007;
	Thu, 14 Nov 2024 21:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731621085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhLe2ACkshLEO1WMC1uloL6sErxxOPC8/HMUT5amenw=;
	b=jduz5Pvhw0z+0JjJkBrTTwqSYlo2VzRJtl1+gERwe258YpYfKVV1qTuf0xb5RAN17gKQzd
	vMhFvgerUx7f6oaEPND1ZSi/4kJjJzzm3PeBclaUrRr0x0xDLsnlIrL2lV55tmGkp5wkeF
	5bM+zfAkkIgSxzuW/EXDGIn3IFzTvn7oJI4i0n3LOOHfjBqhF/xfjBj8d8uKTJrqjayDX1
	0MPecY7lKwe2kynOycZih2zuPeq0GXcHducH77iotj/wP00BSce1/j55wRIAbgKV01+TnU
	L7+yy3D8PLmSm3rZ3+M0MZkpRl97tahPaarROwStc+xZPwynJc4jpKLLzl4Icw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 14 Nov 2024 22:50:41 +0100
Subject: [PATCH bpf-next v2 10/13] selftests/bpf: rename pseudo headers
 checksum computation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241114-flow_dissector-v2-10-ee4a3be3de65@bootlin.com>
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

network_helpers.h provides helpers to compute checksum for pseudo
headers but no helpers to compute the global checksums.

Before adding those, rename the pseudo header checksum helper to clarify
their role.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- new patch
---
 tools/testing/selftests/bpf/network_helpers.h         | 14 +++++++-------
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c |  5 +++--
 tools/testing/selftests/bpf/xdp_hw_metadata.c         | 12 ++++++++----
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index c9b72960c651ab9fb249f6eb9e153b8416b7a488..6d1ae56080c56a65c437899c32566f0e4c496c33 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -127,9 +127,9 @@ static inline __sum16 build_ip_csum(struct iphdr *iph)
 	return csum_fold(sum);
 }
 
-static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-					__u32 len, __u8 proto,
-					__wsum csum)
+static inline __sum16 build_ipv4_pseudo_header_csum(__be32 saddr, __be32 daddr,
+						    __u32 len, __u8 proto,
+						    __wsum csum)
 {
 	__u64 s = csum;
 
@@ -142,10 +142,10 @@ static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
 	return csum_fold((__u32)s);
 }
 
-static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
-				      const struct in6_addr *daddr,
-					__u32 len, __u8 proto,
-					__wsum csum)
+static inline __sum16
+build_ipv6_pseudo_header_csum(const struct in6_addr *saddr,
+			      const struct in6_addr *daddr, __u32 len,
+			      __u8 proto, __wsum csum)
 {
 	__u64 s = csum;
 	int i;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 7f8e161655336127e5bd7a573d1a09db85a92f53..0e69390ac0c2d8959c614e7d29fea1c31910cf9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -180,8 +180,9 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	udph->source = htons(UDP_SOURCE_PORT);
 	udph->dest = htons(dst_port);
 	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
-	udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
-					 ntohs(udph->len), IPPROTO_UDP, 0);
+	udph->check = ~build_ipv4_pseudo_header_csum(iph->saddr, iph->daddr,
+						     ntohs(udph->len),
+						     IPPROTO_UDP, 0);
 
 	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
 
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 6f9956eed797f30b9611596909ef2954654eab18..0ef3c020cc9f77a0a149859493468313071ad66b 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -378,11 +378,15 @@ static void ping_pong(struct xsk *xsk, void *rx_packet, clockid_t clock_id)
 
 	want_csum = udph->check;
 	if (ip6h)
-		udph->check = ~csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
-					       ntohs(udph->len), IPPROTO_UDP, 0);
+		udph->check = ~build_ipv6_pseudo_header_csum(&ip6h->saddr,
+							     &ip6h->daddr,
+							     ntohs(udph->len),
+							     IPPROTO_UDP, 0);
 	else
-		udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
-						 ntohs(udph->len), IPPROTO_UDP, 0);
+		udph->check = ~build_ipv4_pseudo_header_csum(iph->saddr,
+							     iph->daddr,
+							     ntohs(udph->len),
+							     IPPROTO_UDP, 0);
 
 	meta->flags |= XDP_TXMD_FLAGS_CHECKSUM;
 	if (iph)

-- 
2.47.0


