Return-Path: <linux-kselftest+bounces-22060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC169C94DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 22:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A04282EDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 21:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DB11BFE0D;
	Thu, 14 Nov 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cavhCok6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FA1BD017;
	Thu, 14 Nov 2024 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621091; cv=none; b=GKOjWJSJWOD2bIqX4j25AveJjplvdmoPYUP/PD+zV6WIxZ6sUNW/l2xN/dmBV4kC539XqmsTYz1TVQcs7np+LMwjXH4EVxW++F49xRhq+0pllCQES+fcDr2a1DRH5SOqSHiS0UCt7RxctLiJFdh6XTowOmnXPU8K2Kqob9k7lw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621091; c=relaxed/simple;
	bh=/TYlIGh43uZ2oGRs63KqJs/W1ncn7lTXX8QwIUC4hn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmoHMlN1RXxKonO8Bf+Qayp1BWQEfsCxLkS5USPTTe3HU8F3mOFnZ0wO5y1UM0YyGkYUamzD4DZqAvlePRdqG6pT3gg/THcX3170zZ0m1T/wj7ebDTALQFGWh0kLHvBWpXYnWQuAlTWAcolb4R0GetEBpFeQNuK2mgjEz2mF2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cavhCok6; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9443720009;
	Thu, 14 Nov 2024 21:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731621086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YlAnjMfndBsvEIBw3VMVMMIUcV/hdFiV4FRyR/9nVXY=;
	b=cavhCok6bHGnjACLpehVRFJdXpjD1DVoq1cBrDug915ARYQFIQD89/tJRDatkaO5tG6+OV
	eEkI5n3gdE3at8HZYNupg00VJxKyvSwwvpILu0O+gH9as7EKye93W22tE6U665zX9dIO8R
	NDMRo6VGqDptgBkDWTkX1oKWgTIJQlktmBXD2Hz/MKu11+eB4jZU4G4LvYW3K5jRoHktqN
	epxLqYFxDc0r+7kzr+8tc71WT7zVFr+5PpFllzNEAunp8eqrq9akBVK9kW/KH8knWmVRPu
	Qh7pOK3eMWVIquAFsg9FETCr3QdFqEwmGiO3PZZiiEWfPEIWR1RgnGXpc0vilg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 14 Nov 2024 22:50:42 +0100
Subject: [PATCH bpf-next v2 11/13] selftests/bpf: add network helpers to
 generate udp checksums
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241114-flow_dissector-v2-11-ee4a3be3de65@bootlin.com>
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

network_helpers.c provides some helpers to generate ip checksums or ip
pseudo-header checksums, but not for upper layers (eg: udp checksums)

Add helpers for udp checksum to allow manually building udp packets.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- new patch
---
 tools/testing/selftests/bpf/network_helpers.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 6d1ae56080c56a65c437899c32566f0e4c496c33..fa82269f7a169a518ba210fa8641eba02f262333 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -161,6 +161,33 @@ build_ipv6_pseudo_header_csum(const struct in6_addr *saddr,
 	return csum_fold((__u32)s);
 }
 
+static inline __sum16 build_udp_v4_csum(const struct iphdr *iph, __u8 l4_proto,
+					__u16 l4_len, const void *l4_start,
+					int num_words)
+{
+	unsigned long pseudo_sum;
+	int num_u16 = sizeof(iph->saddr); /* halfwords: twice byte len */
+
+	pseudo_sum = add_csum_hword((void *)&iph->saddr, num_u16);
+	pseudo_sum += htons(l4_proto);
+	pseudo_sum += l4_len;
+	pseudo_sum += add_csum_hword(l4_start, num_words);
+	return csum_fold(pseudo_sum);
+}
+
+static inline __sum16 build_udp_v6_csum(const struct ipv6hdr *ip6h,
+					const void *l4_start, int num_words)
+{
+	unsigned long pseudo_sum;
+	int num_u16 = sizeof(ip6h->saddr); /* halfwords: twice byte len */
+
+	pseudo_sum = add_csum_hword((void *)&ip6h->saddr, num_u16);
+	pseudo_sum += htons(ip6h->nexthdr);
+	pseudo_sum += ip6h->payload_len;
+	pseudo_sum += add_csum_hword(l4_start, num_words);
+	return csum_fold(pseudo_sum);
+}
+
 struct tmonitor_ctx;
 
 #ifdef TRAFFIC_MONITOR

-- 
2.47.0


