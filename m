Return-Path: <linux-kselftest+bounces-9512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9548BCB0B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 11:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C6D1C21669
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 09:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17A4142635;
	Mon,  6 May 2024 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lllKlgxf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26F41422DD;
	Mon,  6 May 2024 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988860; cv=none; b=qavmFaSsY9F/1DZv9DqMTnHa/wlDFvkcARgtCM2urJtCHpHgYgflGwlmEBU7G6bW3tAa0pm3eMFdRl/epQ9q4fdfSG8LhOjg9HwB9ZvydODCqbfRQSlNOP+x9aqgltXbpUaCsnWouN7u+9H5ajh4FweIFQbADI1/1IKHI4pDysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988860; c=relaxed/simple;
	bh=9sh7rHa1zaoLPu9N17bHQ5wa5CD6b1ETBOSTvR5soa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QLcXN3+vqBrTsU5x8+m/QEpOgjQS0NZKWQ6Q6HT6fh0us/XjosZnmvD+U4IDAAMaQTw+SE8AaWcSQiBSsgBQmIFA010Yhu22DfrHGnADJQH5EWwXSMM891MZYehN6ImOd++CWgy2Ag3cD/nCHyNTmg6nZVX+/lwoDmIOgxWPGps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lllKlgxf; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f0b6b682fso1738034e87.1;
        Mon, 06 May 2024 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714988857; x=1715593657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0zbUy76iL9lY1l5voQgJ3c+Z/VI10ocBZ49GywIStw=;
        b=lllKlgxft046t4XhNhBwIihy/8hHc1CA8mY2qRPQGoq0yVTJz8Kr6/MEMW2XQOZWiQ
         JoM2PIZQOn2u+o+HNxa3LvM+pre4tAYbHh+e52BDGbUxiNC7OvSkwebM2KYVr5PGUtWV
         gFp86RyaifgPlp5S9ONo9iRvBnWxJd7L/n3zpnPf9mzSq0QX/uyYKQv0AjAY3SjAQoNl
         5dki+tYw0q9Fd6Lq20PhOUoJ3Yp3WjXqJlYprU6OswYjHq2Kljm6zXrtkItRmm0NGPsj
         BEdz/xum4lCix8kkutv+w7OaA+vujikWj7jjCR6y5g7WppkBc7rxHumc96KmNYMXduY9
         jG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988857; x=1715593657;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p0zbUy76iL9lY1l5voQgJ3c+Z/VI10ocBZ49GywIStw=;
        b=drYByLStK3cLR927ZYFPReQiY9vQ5dE2nRxYhYg8o8m7Xp1mwvNmnsVrnqx9RTxqbv
         6LiiQNHzT2dY4sZTL3Zu32tqhk1NIuQ9Jz5PUMDgbbrOqBNbOgqlDoSRtWjS3zmCX1lF
         kMs8+B/LnpklJHPLnVwslZlAzNVB+1bYqUzw+tZYLy+VCEByI0vqcCLZ/PFHlOMfCkXX
         +k5zB/VF3X7Y1hze54UxsRwOp+TzWbXjo5snOffrk66YZFtzwPJ4aR1GE13m9CsdmeGD
         /XZdPQXyR9eB4ZGFWrO31AB4ti6Oq5HAGbKTANwC3IoqUSSqNGB1MZFWh2lMoNek+bAj
         8BRA==
X-Forwarded-Encrypted: i=1; AJvYcCWRtLvmVh3lUyESX0vRMz6+F1fiiWRO7QfqFkklU0NobxR1PEmfhSqII7+S4ud9KLBa2w7lz5clHSbYSGNR8Vd7O1JpXRpHpvY2vKXJ4yPR7dHmNpbuPf7+f26HGu8+1+SSbb8p3ommOkcK9XSo+IHR/VYDOCmEVZdqeieQXW6pM8ks587g
X-Gm-Message-State: AOJu0YwdExLGbGp9JnOSKQ1a01xqudmrjc+A1nut9k4a0l/xpW3kjGaN
	oyQyzKxXy+qzKy+4Wog/OT36MByqFFFgFWssx4V2QSfFRZxYVTox
X-Google-Smtp-Source: AGHT+IGGPqr5mpUnVBkw1z3Y6OVjkMi5bwSVrfA6ryMEn2dsPJ2bkdjlrqELin/s+pltnnCF4UHCOQ==
X-Received: by 2002:a05:6512:10cc:b0:51a:d9a3:dbf5 with SMTP id k12-20020a05651210cc00b0051ad9a3dbf5mr11420390lfg.47.1714988856386;
        Mon, 06 May 2024 02:47:36 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c3b8c00b0041bf87e702asm15535867wms.10.2024.05.06.02.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 02:47:36 -0700 (PDT)
Message-ID: <1ed21e6d-7cbc-43e3-8933-fc40562b70b2@gmail.com>
Date: Mon, 6 May 2024 11:47:09 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next v8 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
To: davem@davemloft.net, edumazet@google.com,
 willemdebruijn.kernel@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, alobakin@pm.me, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240506093550.128210-1-richardbgobert@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <20240506093550.128210-1-richardbgobert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

{inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
iph->id, ...) against all packets in a loop. These flush checks are used in
all merging UDP and TCP flows.

These checks need to be done only once and only against the found p skb,
since they only affect flush and not same_flow.

This patch leverages correct network header offsets from the cb for both
outer and inner network headers - allowing these checks to be done only
once, in tcp_gro_receive and udp_gro_receive_segment. As a result,
NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id checks are
more declarative and contained in inet_gro_flush, thus removing the need
for flush_id in napi_gro_cb.

This results in less parsing code for non-loop flush tests for TCP and UDP
flows.

To make sure results are not within noise range - I've made netfilter drop
all TCP packets, and measured CPU performance in GRO (in this case GRO is
responsible for about 50% of the CPU utilization).

perf top while replaying 64 parallel IP/TCP streams merging in GRO:
(gro_network_flush is compiled inline to tcp_gro_receive)
net-next:
        6.94% [kernel] [k] inet_gro_receive
        3.02% [kernel] [k] tcp_gro_receive

patch applied:
        4.27% [kernel] [k] tcp_gro_receive
        4.22% [kernel] [k] inet_gro_receive

perf top while replaying 64 parallel IP/IP/TCP streams merging in GRO (same
results for any encapsulation, in this case inet_gro_receive is top
offender in net-next)
net-next:
        10.09% [kernel] [k] inet_gro_receive
        2.08% [kernel] [k] tcp_gro_receive

patch applied:
        6.97% [kernel] [k] inet_gro_receive
        3.68% [kernel] [k] tcp_gro_receive

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h      | 66 ++++++++++++++++++++++++++++++++++++++----
 net/core/gro.c         |  3 --
 net/ipv4/af_inet.c     | 41 +-------------------------
 net/ipv4/tcp_offload.c | 15 ++--------
 net/ipv4/udp_offload.c | 10 ++-----
 net/ipv6/ip6_offload.c | 11 -------
 6 files changed, 65 insertions(+), 81 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 1faff23b66e8..0565dd716ab7 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -36,15 +36,15 @@ struct napi_gro_cb {
 	/* This is non-zero if the packet cannot be merged with the new skb. */
 	u16	flush;
 
-	/* Save the IP ID here and check when we get to the transport layer */
-	u16	flush_id;
-
 	/* Number of segments aggregated. */
 	u16	count;
 
 	/* Used in ipv6_gro_receive() and foo-over-udp and esp-in-udp */
 	u16	proto;
 
+	/* used to support CHECKSUM_COMPLETE for tunneling protocols */
+	__wsum	csum;
+
 /* Used in napi_gro_cb::free */
 #define NAPI_GRO_FREE             1
 #define NAPI_GRO_FREE_STOLEN_HEAD 2
@@ -85,9 +85,6 @@ struct napi_gro_cb {
 		u8	is_flist:1;
 	);
 
-	/* used to support CHECKSUM_COMPLETE for tunneling protocols */
-	__wsum	csum;
-
 	/* L3 offsets */
 	union {
 		struct {
@@ -442,6 +439,63 @@ static inline __wsum ip6_gro_compute_pseudo(const struct sk_buff *skb,
 					    skb_gro_len(skb), proto, 0));
 }
 
+static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
+				 struct sk_buff *p, bool outer)
+{
+	const u32 id = ntohl(*(__be32 *)&iph->id);
+	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
+	const u16 flush_id = (id >> 16) - (id2 >> 16);
+	const u16 count = NAPI_GRO_CB(p)->count;
+	const u32 df = id & IP_DF;
+	u32 is_atomic;
+	int flush;
+
+	/* All fields must match except length and checksum. */
+	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
+
+	if (outer && df)
+		return flush;
+
+	/* When we receive our second frame we can make a decision on if we
+	 * continue this flow as an atomic flow with a fixed ID or if we use
+	 * an incrementing ID.
+	 */
+	NAPI_GRO_CB(p)->is_atomic |= (count == 1 && df && flush_id == 0);
+	is_atomic = (df && NAPI_GRO_CB(p)->is_atomic) - 1;
+
+	return flush | (flush_id ^ (count & is_atomic));
+}
+
+static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr *iph2)
+{
+	/* <Version:4><Traffic_Class:8><Flow_Label:20> */
+	__be32 first_word = *(__be32 *)iph ^ *(__be32 *)iph2;
+
+	/* Flush if Traffic Class fields are different. */
+	return !!((first_word & htonl(0x0FF00000)) |
+		(__force __be32)(iph->hop_limit ^ iph2->hop_limit));
+}
+
+static inline int gro_network_flush(const void *th, const void *th2, struct sk_buff *p, int off)
+{
+	const bool encap_mark = NAPI_GRO_CB(p)->encap_mark;
+	int flush = 0;
+	int i;
+
+	for (i = 0; i <= encap_mark; i++) {
+		const u16 diff = off - NAPI_GRO_CB(p)->network_offsets[i];
+		const void *nh = th - diff;
+		const void *nh2 = th2 - diff;
+
+		if (((struct iphdr *)nh)->version == 6)
+			flush |= ipv6_gro_flush(nh, nh2);
+		else
+			flush |= inet_gro_flush(nh, nh2, p, i != encap_mark);
+	}
+
+	return flush;
+}
+
 int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb);
 
 /* Pass the currently batched GRO_NORMAL SKBs up to the stack. */
diff --git a/net/core/gro.c b/net/core/gro.c
index 99a45a5211c9..3e9422c23bc9 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -331,8 +331,6 @@ static void gro_list_prepare(const struct list_head *head,
 	list_for_each_entry(p, head, list) {
 		unsigned long diffs;
 
-		NAPI_GRO_CB(p)->flush = 0;
-
 		if (hash != skb_get_hash_raw(p)) {
 			NAPI_GRO_CB(p)->same_flow = 0;
 			continue;
@@ -472,7 +470,6 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
 					sizeof(u32))); /* Avoid slow unaligned acc */
 	*(u32 *)&NAPI_GRO_CB(skb)->zeroed = 0;
 	NAPI_GRO_CB(skb)->flush = skb_has_frag_list(skb);
-	NAPI_GRO_CB(skb)->is_atomic = 1;
 	NAPI_GRO_CB(skb)->count = 1;
 	if (unlikely(skb_is_gso(skb))) {
 		NAPI_GRO_CB(skb)->count = skb_shinfo(skb)->gso_segs;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 428196e1541f..44564d009e95 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1482,7 +1482,6 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 	struct sk_buff *p;
 	unsigned int hlen;
 	unsigned int off;
-	unsigned int id;
 	int flush = 1;
 	int proto;
 
@@ -1508,13 +1507,10 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 		goto out;
 
 	NAPI_GRO_CB(skb)->proto = proto;
-	id = ntohl(*(__be32 *)&iph->id);
-	flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (id & ~IP_DF));
-	id >>= 16;
+	flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
 
 	list_for_each_entry(p, head, list) {
 		struct iphdr *iph2;
-		u16 flush_id;
 
 		if (!NAPI_GRO_CB(p)->same_flow)
 			continue;
@@ -1531,43 +1527,8 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 			NAPI_GRO_CB(p)->same_flow = 0;
 			continue;
 		}
-
-		/* All fields must match except length and checksum. */
-		NAPI_GRO_CB(p)->flush |=
-			(iph->ttl ^ iph2->ttl) |
-			(iph->tos ^ iph2->tos) |
-			((iph->frag_off ^ iph2->frag_off) & htons(IP_DF));
-
-		NAPI_GRO_CB(p)->flush |= flush;
-
-		/* We need to store of the IP ID check to be included later
-		 * when we can verify that this packet does in fact belong
-		 * to a given flow.
-		 */
-		flush_id = (u16)(id - ntohs(iph2->id));
-
-		/* This bit of code makes it much easier for us to identify
-		 * the cases where we are doing atomic vs non-atomic IP ID
-		 * checks.  Specifically an atomic check can return IP ID
-		 * values 0 - 0xFFFF, while a non-atomic check can only
-		 * return 0 or 0xFFFF.
-		 */
-		if (!NAPI_GRO_CB(p)->is_atomic ||
-		    !(iph->frag_off & htons(IP_DF))) {
-			flush_id ^= NAPI_GRO_CB(p)->count;
-			flush_id = flush_id ? 0xFFFF : 0;
-		}
-
-		/* If the previous IP ID value was based on an atomic
-		 * datagram we can overwrite the value and ignore it.
-		 */
-		if (NAPI_GRO_CB(skb)->is_atomic)
-			NAPI_GRO_CB(p)->flush_id = flush_id;
-		else
-			NAPI_GRO_CB(p)->flush_id |= flush_id;
 	}
 
-	NAPI_GRO_CB(skb)->is_atomic = !!(iph->frag_off & htons(IP_DF));
 	NAPI_GRO_CB(skb)->flush |= flush;
 	NAPI_GRO_CB(skb)->inner_network_offset = off;
 
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index b70ae50e658d..625b4800b3ed 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -232,9 +232,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 	goto out_check_final;
 
 found:
-	/* Include the IP ID check below from the inner most IP hdr */
-	flush = NAPI_GRO_CB(p)->flush;
-	flush |= (__force int)(flags & TCP_FLAG_CWR);
+	flush = (__force int)(flags & TCP_FLAG_CWR);
 	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
@@ -242,16 +240,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 		flush |= *(u32 *)((u8 *)th + i) ^
 			 *(u32 *)((u8 *)th2 + i);
 
-	/* When we receive our second frame we can made a decision on if we
-	 * continue this flow as an atomic flow with a fixed ID or if we use
-	 * an incrementing ID.
-	 */
-	if (NAPI_GRO_CB(p)->flush_id != 1 ||
-	    NAPI_GRO_CB(p)->count != 1 ||
-	    !NAPI_GRO_CB(p)->is_atomic)
-		flush |= NAPI_GRO_CB(p)->flush_id;
-	else
-		NAPI_GRO_CB(p)->is_atomic = false;
+	flush |= gro_network_flush(th, th2, p, off);
 
 	mss = skb_shinfo(p)->gso_size;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 8721fe5beca2..5d9696eaab8a 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -466,6 +466,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 					       struct sk_buff *skb)
 {
 	struct udphdr *uh = udp_gro_udphdr(skb);
+	int off = skb_gro_offset(skb);
 	struct sk_buff *pp = NULL;
 	struct udphdr *uh2;
 	struct sk_buff *p;
@@ -505,14 +506,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 			return p;
 		}
 
-		flush = NAPI_GRO_CB(p)->flush;
-
-		if (NAPI_GRO_CB(p)->flush_id != 1 ||
-		    NAPI_GRO_CB(p)->count != 1 ||
-		    !NAPI_GRO_CB(p)->is_atomic)
-			flush |= NAPI_GRO_CB(p)->flush_id;
-		else
-			NAPI_GRO_CB(p)->is_atomic = false;
+		flush = gro_network_flush(uh, uh2, p, off);
 
 		/* Terminate the flow on len mismatch or if it grow "too much".
 		 * Under small packet flood GRO count could elsewhere grow a lot
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 5d6b875a4638..72991a02cb30 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -290,19 +290,8 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 				   nlen - sizeof(struct ipv6hdr)))
 				goto not_same_flow;
 		}
-		/* flush if Traffic Class fields are different */
-		NAPI_GRO_CB(p)->flush |= !!((first_word & htonl(0x0FF00000)) |
-			(__force __be32)(iph->hop_limit ^ iph2->hop_limit));
-		NAPI_GRO_CB(p)->flush |= flush;
-
-		/* If the previous IP ID value was based on an atomic
-		 * datagram we can overwrite the value and ignore it.
-		 */
-		if (NAPI_GRO_CB(skb)->is_atomic)
-			NAPI_GRO_CB(p)->flush_id = 0;
 	}
 
-	NAPI_GRO_CB(skb)->is_atomic = true;
 	NAPI_GRO_CB(skb)->flush |= flush;
 
 	skb_gro_postpull_rcsum(skb, iph, nlen);
-- 
2.36.1

