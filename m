Return-Path: <linux-kselftest+bounces-22328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25E89D3494
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 08:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BCF286BBD
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 07:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4281A00ED;
	Wed, 20 Nov 2024 07:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eyD5cAII"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC45619DFA7;
	Wed, 20 Nov 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088623; cv=none; b=rPk0wL6BC7f7TuLeMjjl9k1Tcfu/ULQg6a9z8s/OjJoCc5ffezpiCm7YWdYZ4Jh0kDicJz71EhskwlloUKoFEBjUFFGfaJZ+ktmP0rVjF+ciXyWTVZzOe/8zfK3Xm3mR5hLR7wS/nj9Z47ULlnIgvaCEqoqAaWhEH4g0HrarDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088623; c=relaxed/simple;
	bh=4X4eEn8xrnT9XC/jIUQrtNekfi2jE8KN7byNdLLgl5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJzh7YDVQZF5OBKit3mV0PsZ39b686j+cSdoA8I3WAEpHmrNdMyct0L8PT7PD+h3MeSZlONpHckzb0fYSiIB6ShWxK8BBxuWsXgxOdDld2LoxyL4Vr4KRFZdfzuwjzTXBDoa1fnWI7xRpN3DXJSjm1yj9glvBfMczNtixeGp1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eyD5cAII; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61684240004;
	Wed, 20 Nov 2024 07:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732088619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3D+5CGYU5e/Rb+CQ7gbOD7+RcgF0KKqtZUpNrfXlIPY=;
	b=eyD5cAII2NSQP8eCR3emPdF5rcnFKOCOikdGVavKG1p21s+elxBGq1YmSUQsgY+uwMm+Ds
	FOtesdbNJfJdEmLO96VG40fU9ccN750DMYFWHYv41dVnImYf2hNbfgVIV9sLhfjZHAewQq
	yAPzTRXymIQHMh73VrdY3w7gX7D+cNcjMRu/G4GnAbPMV2lXhabWh454VmqYxsOc8d/3WU
	hAL0QhCCn2A2dwe8UJZNQ3doW2aTihdAP4vjUI5u6uaXD+FiNN470aF045Alk52uk87hWo
	Y5olDvLa3M87ctwhBMK2I4ClNAWGg3AtQLa6cmt7SKVEh2Q4jZrOGAXu2f06bA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 20 Nov 2024 08:43:20 +0100
Subject: [PATCH bpf-next v3 10/14] selftests/bpf: document pseudo-header
 checksum helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-flow_dissector-v3-10-45b46494f937@bootlin.com>
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

network_helpers.h provides helpers to compute checksum for pseudo
headers but no helpers to compute the global checksums.

Before adding those, clarify csum_tcpudp_magic and csum_ipv6_magic
purpose by adding some documentation.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- instead of renaming the helpers, keep the original name (which is in
  sync with kernel helpers), and rather add documentation

Changes in v2:
- new patch
---
 tools/testing/selftests/bpf/network_helpers.h | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 5ef909f766eb9ac2dd5be67b99245b4676ce4f5f..6ca636643ea2b77fb5cc459b03bf7f8c4f749377 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -128,6 +128,21 @@ static inline __sum16 build_ip_csum(struct iphdr *iph)
 	return csum_fold(sum);
 }
 
+/**
+ * csum_tcpudp_magic - compute IP pseudo-header checksum
+ *
+ * Compute the IPv4 pseudo header checksum. The helper can take a
+ * accumulated sum from the transport layer to accumulate it and directly
+ * return the transport layer
+ *
+ * @saddr: IP source address
+ * @daddr: IP dest address
+ * @len: IP data size
+ * @proto: transport layer protocol
+ * @csum: The accumulated partial sum to add to the computation
+ *
+ * Returns the folded sum
+ */
 static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
 					__u32 len, __u8 proto,
 					__wsum csum)
@@ -143,6 +158,21 @@ static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
 	return csum_fold((__u32)s);
 }
 
+/**
+ * csum_ipv6_magic - compute IPv6 pseudo-header checksum
+ *
+ * Compute the ipv6 pseudo header checksum. The helper can take a
+ * accumulated sum from the transport layer to accumulate it and directly
+ * return the transport layer
+ *
+ * @saddr: IPv6 source address
+ * @daddr: IPv6 dest address
+ * @len: IPv6 data size
+ * @proto: transport layer protocol
+ * @csum: The accumulated partial sum to add to the computation
+ *
+ * Returns the folded sum
+ */
 static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 				      const struct in6_addr *daddr,
 					__u32 len, __u8 proto,

-- 
2.47.0


