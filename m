Return-Path: <linux-kselftest+bounces-22330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A43DB9D34A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 08:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391551F23944
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 07:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4876F1A264A;
	Wed, 20 Nov 2024 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RiK4oBMf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5891A0731;
	Wed, 20 Nov 2024 07:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088626; cv=none; b=atn7b7EwlM7InlsbrUZtbTwA8uF2tyhMr2ZxzXlHV7N7RCs77dwi5c+NpoAnqQUi6qFEiBo5H/4+yz97z+Kbl33t6PGxHEEegELgBDE7YPYzB6zxJAwz+v5coGFm2V/YtSjJXU9pGGPYN5kE5ACxbohnGSZ2bBWHfjz+Z+HSD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088626; c=relaxed/simple;
	bh=FVYhgVeURP8mF5EiKITLrPtuzr/WORCsEsePlgvAQWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YbRjpeX3x+Moq/YQK/GJ+8l57qH0vBDaKuLgRRTn6Ux3jfTUyWixYPL19gpFtH1REMChFIKSbp7OYaQ9J0hu9iempo949SAtYoMb39ZfeuCw3rZ2AMLZQbbGvsI+CZtrvUul9UEV/JgmGawZuOYhyycEmXlEIDftasKCek687Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RiK4oBMf; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C7534240005;
	Wed, 20 Nov 2024 07:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732088622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4tsdzmcSvpGE0kiX9FqApjzjA1QKlCC/JxJ6336bXg=;
	b=RiK4oBMf3RK/SaX3msxqKgkxzugwjKE+ov1Ixi5EmRoA+3EFumjobCUE4AE2awnaMu7Ap6
	uE+kvKXUlFIbApJcIRI9Dm6e6ljW5tLKihqQ713O20RdDOBvLt3m4rEEfc3qKCI9+Q823r
	P2p1lAyV1I78SIefEduL8vfByDfgu4NUDe3sndJ64rwqOhzZ7TOCy+5AUUT3zZZNvjW/tV
	Nn1XCJ8NOab+J7mmoJY1qawr8O2rsSL9rYm3Dst3jBLNW3HnDgWH7Dm4gtyv9O/O6/VpZt
	9PAuv0492WAatAvzlnrkvYswNTVtQ7Off/70LDF1MnroxvNdk6OibqBi2TO4zA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 20 Nov 2024 08:43:22 +0100
Subject: [PATCH bpf-next v3 12/14] selftests/bpf: add network helpers to
 generate udp checksums
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-flow_dissector-v3-12-45b46494f937@bootlin.com>
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

network_helpers.c provides some helpers to generate ip checksums or ip
pseudo-header checksums, but not for upper layers (eg: udp checksums)

Add helpers for udp checksum to allow manually building udp packets.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- reuse pseudo-header checksum helper in the new helpers
- reduce parameters list (eg: it does not make sense to passe the l4
  protocol in a udp-specific helper)

Changes in v2:
- new patch
---
 tools/testing/selftests/bpf/network_helpers.h | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 6ca636643ea2b77fb5cc459b03bf7f8c4f749377..479f678af191e9fa8a7129e050a25bf9ed0cf37e 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -13,6 +13,7 @@ typedef __u16 __sum16;
 #include <linux/sockios.h>
 #include <linux/err.h>
 #include <netinet/tcp.h>
+#include <netinet/udp.h>
 #include <bpf/bpf_endian.h>
 #include <net/if.h>
 
@@ -192,6 +193,47 @@ static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	return csum_fold((__u32)s);
 }
 
+/**
+ * build_udp_v4_csum - compute UDP checksum for UDP over IPv4
+ *
+ * Compute the checksum to embed in UDP header, composed of the sum of IP
+ * pseudo-header checksum, UDP header checksum and UDP data checksum
+ * @iph IP header
+ * @udph UDP header, which must be immediately followed by UDP data
+ *
+ * Returns the total checksum
+ */
+
+static inline __sum16 build_udp_v4_csum(const struct iphdr *iph,
+					const struct udphdr *udph)
+{
+	unsigned long sum;
+
+	sum = csum_partial(udph, ntohs(udph->len), 0);
+	return csum_tcpudp_magic(iph->saddr, iph->daddr, ntohs(udph->len),
+				 IPPROTO_UDP, sum);
+}
+
+/**
+ * build_udp_v6_csum - compute UDP checksum for UDP over IPv6
+ *
+ * Compute the checksum to embed in UDP header, composed of the sum of IPv6
+ * pseudo-header checksum, UDP header checksum and UDP data checksum
+ * @ip6h IPv6 header
+ * @udph UDP header, which must be immediately followed by UDP data
+ *
+ * Returns the total checksum
+ */
+static inline __sum16 build_udp_v6_csum(const struct ipv6hdr *ip6h,
+					const struct udphdr *udph)
+{
+	unsigned long sum;
+
+	sum = csum_partial(udph, ntohs(udph->len), 0);
+	return csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr, ntohs(udph->len),
+			       IPPROTO_UDP, sum);
+}
+
 struct tmonitor_ctx;
 
 #ifdef TRAFFIC_MONITOR

-- 
2.47.0


