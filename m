Return-Path: <linux-kselftest+bounces-9511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFEA8BCACA
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 11:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283121C206A7
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6753B1428F8;
	Mon,  6 May 2024 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9u80tOW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD1D142636;
	Mon,  6 May 2024 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988208; cv=none; b=aqO/UZdvDOIhkjPLiZmBP3UWQ53wkeSMXCYoDcdqzMfMETRWTRZ5/NI2Kr01EJekfg3duJEfJaMrIEknK4mLh7jBJDW4afm6noUF7Zix3dHl/yaaoIMdLKIt35GQdRxwOqzXNJeAeM7FTt7qH/CrOoqjjJGAjcEID+7D8YenuPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988208; c=relaxed/simple;
	bh=QUoNVH8TVRS4fLCD6a7wzQLuK8966kObHh0ypbJd8oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Va1oemzdP295vh9oingWK0QTs6PnKBEOpGRhOo0G05o1Zv0pvSoBokIQWkuvFjhF7Erl9fSvUz31Cf2b4DXQHskRTWdmg9RkwDXcwy9ZqzbmBO7d6ItZiaCu47lxoOX3wmmNUjZcBzKQbhxOvb/FI8zD1gVTQ+USsHZkLs3BIaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9u80tOW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41b794510cdso13832225e9.2;
        Mon, 06 May 2024 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714988205; x=1715593005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNAW0+IkVNh9sXcKl7otQ29jy1GxPJurqkt5h0EfCUc=;
        b=m9u80tOWQoZdAi+CMuDmiVoi88J1+jeqORLphlpbph479auEMfmMWGm5hjjdq5Smas
         o7s/s0gomO2sbFpzOaL1OH+2Nsw2qAGjhuwgv372PDIFwdEVxQc9PgSXhM0dnl+f6Gzv
         TRSMW1bZPAh9WL5K+Dco7AHQ+rQjgFIqAkvJIKKpIu2f+KWY74EyItfxyHrYaQ3iorso
         m0d3mzOIfe1oMOPdDni+fAATfgtbOmeie4s/R4xtqyBm1eT7+RJFwe/fL4TSCEfBhubK
         OhBKiHOQHf4hYaxx6us9yXxmqW9t2l41xOiMDQ0RqRXzIyz7kWqeSzK0Lw1I7o24+Iqi
         hq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988205; x=1715593005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNAW0+IkVNh9sXcKl7otQ29jy1GxPJurqkt5h0EfCUc=;
        b=lPV217Ol207amrjy1P4vVzsH8jLGHejxxyxg1kGaEi6nlezIQw0fu0nGimgc7ZmA7g
         CcAGeH0v7GFzNPo9WI0izoAwyKkQpHlSlmNjMy1Thu92yulTnDhcU1Rpce6LtORkAvUK
         KUGe8CL1Guo1S+Rsdd2f+gtmlHe11SNWERIK5nW2SGTewlDdPWcFBj5XlXc80P2pHWGQ
         eqNVbOxIWKSgZks2tOSWk309BKH9MicxrSLNDHY+v/GMlgOb9WmwxuMuKad5pcR23aiw
         DNnxx9RIqo8Kk4qcO+8QZQS0D5X6j9mkP3w9X7k4zCJCTbGG40TPdMxdWwXtEhpKNudb
         KhQw==
X-Forwarded-Encrypted: i=1; AJvYcCXv9icRSnPncJo3hofUKoGMcc+r+wv4RWAljY8YdJQYHJ0fRvvq/ap5aiLqOzkbn897RCxNhSNJcuuoG6yB9Qa/A7VV/j81uGxprercFKQCl0mp8XKApPOv18HujqaO2kUN60sDSReYVcEETafP+arQnemtzqUp/DNe/T3mxx+KPMG+Wx9j
X-Gm-Message-State: AOJu0Yxvxy/lf5Arf/3XMndfMpL9+zfjccBliSUkg0aDp97Oe35shqRR
	xs2WCK4X3VKOWLbyoWct7MM3HE8ZLQ11l4U4uPdJ3chXQDJONuRB
X-Google-Smtp-Source: AGHT+IExJwJIQrS3FTLr/yKJ17F3rysqCjdVWT9qP2PcHZgVyWbGOdPro5GyjW7VJDcy2ILBryyNuQ==
X-Received: by 2002:a05:600c:3490:b0:41c:97e:20b9 with SMTP id a16-20020a05600c349000b0041c097e20b9mr6749301wmq.14.1714988204999;
        Mon, 06 May 2024 02:36:44 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b0041a9fc2a6b5sm19052040wms.20.2024.05.06.02.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 02:36:44 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	alobakin@pm.me,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v8 1/3] net: gro: use cb instead of skb->network_header
Date: Mon,  6 May 2024 11:35:48 +0200
Message-Id: <20240506093550.128210-2-richardbgobert@gmail.com>
In-Reply-To: <20240506093550.128210-1-richardbgobert@gmail.com>
References: <20240506093550.128210-1-richardbgobert@gmail.com>
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
index c1d4ca0463a1..1faff23b66e8 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -181,12 +181,17 @@ static inline void *skb_gro_header(struct sk_buff *skb, unsigned int hlen,
 	return ptr;
 }
 
+static inline int skb_gro_network_offset(const struct sk_buff *skb)
+{
+	return NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark];
+}
+
 static inline void *skb_gro_network_header(const struct sk_buff *skb)
 {
 	if (skb_gro_may_pull(skb, skb_gro_offset(skb)))
-		return skb_gro_header_fast(skb, skb_network_offset(skb));
+		return skb_gro_header_fast(skb, skb_gro_network_offset(skb));
 
-	return skb_network_header(skb);
+	return skb->data + skb_gro_network_offset(skb);
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
index c8b909a9904f..5d6b875a4638 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -67,7 +67,7 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
 		off += len;
 	}
 
-	skb_gro_pull(skb, off - skb_network_offset(skb));
+	skb_gro_pull(skb, off - skb_gro_network_offset(skb));
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


