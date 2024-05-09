Return-Path: <linux-kselftest+bounces-9818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB048C152C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 21:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5256FB21A78
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E097F492;
	Thu,  9 May 2024 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpBfWe7R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056B07F483;
	Thu,  9 May 2024 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715281750; cv=none; b=NKm4UbSxYW/4syaYa1+QV3yUJxObmqmdQtXgRCzD4dnaiKvXWJdWhRvx1eu7XyCeL8tQo4OgQdFXJP2VFPFTEw3K7dGgdZpzByp7QATVNKLwec1sr2ou+hZ+Jr/EKDAGQYEY07Ce/pDUKmIERyqFnDI+QzL+TkFQD+winshx/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715281750; c=relaxed/simple;
	bh=Xy+szPMVOgGXeangC+05cKGHrayik0ZN+XVHmH4+zX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gkvPEzKs2ndaOvtvNTWVHAswZB/ZWaRURF1pGs44C6No1t8+KqqR1bm9s0cJS44VtFnxNt2UJc2cdgkFDd6bUL4/FLJ/toowBPzdQhwVIWbTZ0Wh4de5lrZFfc294czCdis49NidgjA6Ldl5a2yMRh7me8SlpbsrYhOgx/Ug0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpBfWe7R; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34db6a299b2so845161f8f.3;
        Thu, 09 May 2024 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715281747; x=1715886547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7pOq9UK8WtmmMfWYqgQZ2SX1wQUMxWBtDdkilJw7XM=;
        b=VpBfWe7RJU/Rt42/tJFzkjYEn5xY3SxXdqBUZ2oXOJaEljCGHaU+SuBqCClmhvaqLT
         KGpIZ7zT5Lnc7RKHjYAxlvZyippFLw6QCGttPTGNNE3YEG6MkbIHGZHKLIMMqsu5m1l9
         exK7W9OE+jquD+eq0stfgIQdG9AWt1bpcV3F81f7Q6HQsbJ1PVVpYNtaxCQitKvusxlG
         vWW2m2ywHcnssrVv33+SY1TkZg8gSMTC8AYuYSK6CZZQWW9HMdyvwz+tQDs17sEADGXC
         2kFqxgwPlRTUgh8TPhKmWfMDc1VeMgV0WkkJj/o6Gf5qSml+Ni9gGYnyDHH5e9G2nRk9
         4Ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715281747; x=1715886547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7pOq9UK8WtmmMfWYqgQZ2SX1wQUMxWBtDdkilJw7XM=;
        b=YLxmMmo623aOqe+1ignezV1jese+TiolwRwtj4h9cQXNJSeERSNxMzKkPc2fD3QEMM
         mYpTS36rDyGTAGkxZA3PAAQrknwhtLHfWvPZUOyy5OBZdW4CFO84ISTyAcfxbIERX9sX
         WsG+K0VFoY9PwKvc9obOQj1H3o9G1y00PRDbijj0YLpyuhAE8oEiDm7CDaT/btIdqaG+
         WyEGCx13CjZolD0TeynmpsYrxAu5nrUGyORwkVCR4ZYfBsaA8gYT4vgjlsADN6VdukJZ
         c1JRBNP7uqI+eyfm/6tlHj35Cc0M8xhQFBI0XurpkEC9t6Nflb0fMX/qT6sRgORiMZCi
         brgw==
X-Forwarded-Encrypted: i=1; AJvYcCVmwT6AIMnoToFHRBSKlf3XRUxKpnLB3ukxBrBBhVSV1L07UAzmhgqcBAVDwDf2LuK09rr2WaX1SrfgiYig9eh01Wip1FM9tc5NXkz1fpZcThADK1XNU9NCeqAYmFA35utEz5YDNO1vT7t6BPv3GkCZwBtyrvcSlTZ3qde7UYkBIpYBr8wX
X-Gm-Message-State: AOJu0YyZ2HVRCAquojZXiR6E4yxcVSoi5s5XXW31zThm6+4xwmaK/J9L
	eyDmuKCWWDzMYbrrWcTwMadFf3QbETUx/9ETkp9bF+m8+J5k0qnStJ1P1g==
X-Google-Smtp-Source: AGHT+IFUSRXtevfO9+GD9THbP60hoipd9OSGDFpwis81jus9XjZsDjj9AtXmrHGfUIUEmtW9DTUsHA==
X-Received: by 2002:a05:6000:b41:b0:34d:9c4d:e6fd with SMTP id ffacd0b85a97d-3504a61c775mr331980f8f.4.1715281747290;
        Thu, 09 May 2024 12:09:07 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bccesm2440768f8f.5.2024.05.09.12.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 12:09:07 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	dsahern@kernel.org,
	alexander.duyck@gmail.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v10 1/3] net: gro: use cb instead of skb->network_header
Date: Thu,  9 May 2024 21:08:17 +0200
Message-Id: <20240509190819.2985-2-richardbgobert@gmail.com>
In-Reply-To: <20240509190819.2985-1-richardbgobert@gmail.com>
References: <20240509190819.2985-1-richardbgobert@gmail.com>
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
index 5df8bf318197..cbc1b0aaf295 100644
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
index c90704befd7b..2809667ac924 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -463,7 +463,8 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct tcphdr *th = tcp_hdr(skb);
 
 	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
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
index d59f58cbd306..23971903e66d 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -72,7 +72,8 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
 {
-	const struct ipv6hdr *iph = ipv6_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + offset);
 	struct tcphdr *th = tcp_hdr(skb);
 
 	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
-- 
2.36.1


