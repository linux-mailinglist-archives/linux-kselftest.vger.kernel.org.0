Return-Path: <linux-kselftest+bounces-25291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615D5A20809
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 11:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7781F165F70
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 10:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9911DF725;
	Tue, 28 Jan 2025 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GIWXBN2N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D41D5165;
	Tue, 28 Jan 2025 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058276; cv=none; b=ekZNLc9Rxi2T5s7d+H3aOMPl6dR1jhuQmmYl2z1E22PZhIPPJknot9ZVW7WlrD60k4in+xjgU+VS2gsZSSogz9o9gHmvRRMZp+msoAB3y2PfOIlGRELYAxDtPp75pwcfD0EnJsj1GRBlL1vgQbbH1cV2trzCE1jbIy29uEDwmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058276; c=relaxed/simple;
	bh=Sijj6u5rZHEBS3PMBd0uHMZC4TAtyKphWa43lOXf4Sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MDGdOIJYAIlH5VTeA99M/l4+twAG9v5fKPI4s9gxhNBPxSKgy3acDIBxoaxseWcgdG8Kh79W0zo3aH3fxyLhd8qhfRTUpxBGaf1RGkSJrH7R4zZL+G6rfO5DM1tinsiiy0s/zeDuhBL6hzHpCKq1Q0bR0FFcBNNM4WUACpc1kA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GIWXBN2N; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50A671C0010;
	Tue, 28 Jan 2025 09:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738058272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1kDN4Z29+t5ZuEiwiQ/w6M6YpetVpAoEvp8rHUOs9U=;
	b=GIWXBN2NEcKFOYLX+vGTMPkLjlIoxwMvRBNoaQgD+sB2BbozoXNmARnQCpDqj53XG6Pp0c
	hmp0Gz3tjdhpiLuQnSphPeXJIkrtKbu0BtR8n1zEqj7UYd3EwNWzc1ln/KL9zrESWypVb/
	arbEKukSo88DPUMH2WDhBbq1dVkrbvc3a3uloDWUirTd5WZ0VhadoCW0EiM1owb1Rfjbe+
	n6Obu8HdE3+aq6YnKCOX51nzfDXhpzGQgMIQy5yW5CxnhO/VZIuGmVbt9LAIiW71EANEzR
	t41JMAMZImWLvHFSzw1CZsJQYM5uDmGze2d/XWCzY+hbwLkUaoXIoM/WnbJvWA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 28 Jan 2025 10:57:35 +0100
Subject: [PATCH bpf-next v3 11/14] selftests/bpf: Optionally select
 broadcasting flags
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-redirect-multi-v3-11-c1ce69997c01@bootlin.com>
References: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
In-Reply-To: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

Broadcasting flags are hardcoded for each kind for protocol.

Create a redirect_flags map that allows to select the broadcasting flags
to use in the bpf_redirect_map(). The protocol ID is used as a key.
Set the old hardcoded values as default if the map isn't filled by the
BPF caller.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/progs/xdp_redirect_multi_kern.c  | 41 +++++++++++++++-------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c b/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
index 97b26a30b59a758f5a5f2152af509acef80031ce..bc2945ed8a8017021c2792671b4de9aa4928a3e4 100644
--- a/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
@@ -34,6 +34,14 @@ struct {
 	__uint(max_entries, 128);
 } mac_map SEC(".maps");
 
+/* map to store redirect flags for each protocol*/
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u16);
+	__type(value, __u64);
+	__uint(max_entries, 16);
+} redirect_flags SEC(".maps");
+
 SEC("xdp")
 int xdp_redirect_map_multi_prog(struct xdp_md *ctx)
 {
@@ -41,25 +49,34 @@ int xdp_redirect_map_multi_prog(struct xdp_md *ctx)
 	void *data = (void *)(long)ctx->data;
 	int if_index = ctx->ingress_ifindex;
 	struct ethhdr *eth = data;
+	__u64 *flags_from_map;
 	__u16 h_proto;
 	__u64 nh_off;
+	__u64 flags;
 
 	nh_off = sizeof(*eth);
 	if (data + nh_off > data_end)
 		return XDP_DROP;
 
-	h_proto = eth->h_proto;
-
-	/* Using IPv4 for (BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS) testing */
-	if (h_proto == bpf_htons(ETH_P_IP))
-		return bpf_redirect_map(&map_all, 0,
-					BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
-	/* Using IPv6 for none flag testing */
-	else if (h_proto == bpf_htons(ETH_P_IPV6))
-		return bpf_redirect_map(&map_all, if_index, 0);
-	/* All others for BPF_F_BROADCAST testing */
-	else
-		return bpf_redirect_map(&map_all, 0, BPF_F_BROADCAST);
+	h_proto = bpf_htons(eth->h_proto);
+
+	flags_from_map = bpf_map_lookup_elem(&redirect_flags, &h_proto);
+
+	/* Default flags for IPv4 : (BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS) */
+	if (h_proto == ETH_P_IP) {
+		flags = flags_from_map ? *flags_from_map : BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS;
+		return bpf_redirect_map(&map_all, 0, flags);
+	}
+	/* Default flags for IPv6 : 0 */
+	if (h_proto == ETH_P_IPV6) {
+		flags = flags_from_map ? *flags_from_map : 0;
+		return bpf_redirect_map(&map_all, if_index, flags);
+	}
+	/* Default flags for others BPF_F_BROADCAST : 0 */
+	else {
+		flags = flags_from_map ? *flags_from_map : BPF_F_BROADCAST;
+		return bpf_redirect_map(&map_all, 0, flags);
+	}
 }
 
 /* The following 2 progs are for 2nd devmap prog testing */

-- 
2.47.1


