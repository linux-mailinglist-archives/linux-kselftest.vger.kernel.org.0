Return-Path: <linux-kselftest+bounces-9619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B079A8BE91D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 18:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43F51C20809
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D5116D4F1;
	Tue,  7 May 2024 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aursnnQ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C416D304;
	Tue,  7 May 2024 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099365; cv=none; b=SY/ZkPJdyYVFHlzc1xGE9kngwYlW9QCWGSaf8sp2GN4xW5coy1OvBQgjJnYskqiu/N2HQxG8rugthaEwrMaGqweZHNWxuOe0cG+XRFJaqG41f7yYUw2W8xbXD0jYAZ1VssXHtSV2KHVM+APbzOJa5raVuGUK+U6QziD3wwmeObU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099365; c=relaxed/simple;
	bh=JzWG+TVT24xjUV+BtqvHafFb5mVQUUD55uKYF3ryVwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jkw533WSiWA3FEEnQVqc+38yLDZ+cQCMVEKsddiRJIJhCzRwLsvDZok8bBTXsTpstmGCka/T9uo4C3rHNsIN1VoEolqiZpyvHhMMsV0qdLBpFFPWBD7lcYvVyP/ksGRz4XQ9n54H5Yy9Q0T3BBmaTeHI2cBdixpbiuY2MKtBeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aursnnQ/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34d96054375so2047128f8f.2;
        Tue, 07 May 2024 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715099362; x=1715704162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEZf3QdtDW8MX2mGFJXyG0+aloiqU19g1Raki3JNYco=;
        b=aursnnQ/ixMLBGtPF248OSuCMa046/dp7Hy2XhmeFXRmHniZkrwQ8wc/EgmslYQ2qS
         96sWQA23uI9A7dQP1G17Z4DxJL2H+XPeJeCT1WyKsS3lB8m6wHln5pvyfCta8nKnlP6t
         2sb7OP8a7zQ9Pt3RuQSEoE9ia2L1VnsFggWjPQuYCs0W78rAJr+07OkdlrlhqnZfABpD
         hMuHSan+xycKN/IgP3qcwo5D3HDvjEekLt1ivM9RmrDVU0+54Ds3/3VqgNuPaGA8GKRQ
         l+PbTDV1dQdsV5w58F3pAwWENnrVHzBX1BMLslDisa3JlnmiP/tZo0ZxR955PBzf3qXk
         gWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099362; x=1715704162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEZf3QdtDW8MX2mGFJXyG0+aloiqU19g1Raki3JNYco=;
        b=VLV0NzZSKWfUvyw9BY1XvI4Wgp2egk4T94Zjj6W/048kK8Ns6PLYFNjICK/Tm8phA/
         COVGe3aIF6gFUdzonjeE5KZq72r+dLZ0+Mh/8f2MgzKJjrLJETjn3ufQLqYSwctlh8Wq
         jaRqGqCV0PmMY9+l6XzPus658dNcPIwi8GigwzFXydXwkZDE17yj2utm+2y5xIAS10X2
         wgbWa5Wu1zWoMIkPL5mh2WNsWeTQUrGIr0vIJzIcOLfx1bqGwIyV446ewOzBIS6sObbb
         BebteNyeC50Skep9Z9hE2guhPNXLcm/EYHqVPLXO9y6Lrh4CzQPxdgocvKYJeIgkLQKN
         OSPg==
X-Forwarded-Encrypted: i=1; AJvYcCVoPNm0c0LRGtlueQdP8KjnP7wo9zwfDcfeFFZ1+lGshouDeDfq1S3PsDo+3/dsSzsQjlik4iFAWsaMyjJiEm5AJAW229bUQJzGN/qWiCPuH4kOEXzWM1HHxJw4p4KCOACZVOu5izN0yZdKpUHXvdfIuGt6rGZ+eJ+/6Qcv3emxuJ8os3Uv
X-Gm-Message-State: AOJu0Yw2Cy7gxekqD4G7tSz0/elZfwtWrbj/W0FuLpioP3jkTMbOgcRt
	E+AVClHTBnHObk/xosJp03VsQZUsDtyA9oN1D76pf8tZEak5mPSV
X-Google-Smtp-Source: AGHT+IFBrRQrSXMbG9wKr15tpJDto9Vjg6ilQT7Kem7TZzJWhnSOUDQRDf6xOwDGzDRn3Lw5E6jFig==
X-Received: by 2002:adf:f4c3:0:b0:34f:5d07:ebd1 with SMTP id ffacd0b85a97d-34fca6214d3mr194693f8f.56.1715099361786;
        Tue, 07 May 2024 09:29:21 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d47ca000000b0034d9e5411ebsm13371417wrc.45.2024.05.07.09.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:29:21 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: richardbgobert@gmail.com
Cc: alexander.duyck@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net-next v9 1/3] net: gro: use cb instead of skb->network_header
Date: Tue,  7 May 2024 18:28:07 +0200
Message-Id: <20240507162807.130396-1-richardbgobert@gmail.com>
In-Reply-To: <20240507162349.130277-1-richardbgobert@gmail.com>
References: <20240507162349.130277-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch converts references of skb->network_header to napi_gro_cb's
network_offset and inner_network_offset.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h        | 9 +++++++--
 net/ipv4/af_inet.c       | 4 ----
 net/ipv4/tcp_offload.c   | 3 ++-
 net/ipv6/ip6_offload.c   | 5 ++---
 net/ipv6/tcpv6_offload.c | 3 ++-
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index c1d4ca0463a1..3dafa0f31ae1 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -181,12 +181,17 @@ static inline void *skb_gro_header(struct sk_buff *skb, unsigned int hlen,
 	return ptr;
 }
 
+static inline int skb_gro_receive_network_offset(const struct sk_buff *skb)
+{
+	return NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark];
+}
+
 static inline void *skb_gro_network_header(const struct sk_buff *skb)
 {
 	if (skb_gro_may_pull(skb, skb_gro_offset(skb)))
-		return skb_gro_header_fast(skb, skb_network_offset(skb));
+		return skb_gro_header_fast(skb, skb_gro_receive_network_offset(skb));
 
-	return skb_network_header(skb);
+	return skb->data + skb_gro_receive_network_offset(skb);
 }
 
 static inline __wsum inet_gro_compute_pseudo(const struct sk_buff *skb,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index a7bad18bc8b5..428196e1541f 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1569,10 +1569,6 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	NAPI_GRO_CB(skb)->is_atomic = !!(iph->frag_off & htons(IP_DF));
 	NAPI_GRO_CB(skb)->flush |= flush;
-	skb_set_network_header(skb, off);
-	/* The above will be needed by the transport layer if there is one
-	 * immediately following this IP hdr.
-	 */
 	NAPI_GRO_CB(skb)->inner_network_offset = off;
 
 	/* Note : No need to call skb_gro_postpull_rcsum() here,
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fab0973f995b..b70ae50e658d 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -330,7 +330,8 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct tcphdr *th = tcp_hdr(skb);
 
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index c8b909a9904f..288c7c6ea50f 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -67,7 +67,7 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
 		off += len;
 	}
 
-	skb_gro_pull(skb, off - skb_network_offset(skb));
+	skb_gro_pull(skb, off - skb_gro_receive_network_offset(skb));
 	return proto;
 }
 
@@ -236,7 +236,6 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 	if (unlikely(!iph))
 		goto out;
 
-	skb_set_network_header(skb, off);
 	NAPI_GRO_CB(skb)->inner_network_offset = off;
 
 	flush += ntohs(iph->payload_len) != skb->len - hlen;
@@ -260,7 +259,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 	NAPI_GRO_CB(skb)->proto = proto;
 
 	flush--;
-	nlen = skb_network_header_len(skb);
+	nlen = skb_gro_offset(skb) - off;
 
 	list_for_each_entry(p, head, list) {
 		const struct ipv6hdr *iph2;
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index 4b07d1e6c952..e70d60e0f86f 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -29,7 +29,8 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
 {
-	const struct ipv6hdr *iph = ipv6_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + offset);
 	struct tcphdr *th = tcp_hdr(skb);
 
 	th->check = ~tcp_v6_check(skb->len - thoff, &iph->saddr,
-- 
2.36.1


