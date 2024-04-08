Return-Path: <linux-kselftest+bounces-7403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4784789C6D7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2086281BB9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6631E129E93;
	Mon,  8 Apr 2024 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK8Cy7Ll"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1786D12BEA0;
	Mon,  8 Apr 2024 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585954; cv=none; b=IZcNXN89aY7yXVTfUCvJF6qkX4jJl02+QbXp8uDb54a9zuXHbohNLQaXbKlwEX1MUi3KdLFRri0GdZMY7NETt1ZEp/mgdriwo82bjIGZ3rUbzZ9L2QdpU+aunGhIN+Gkw6gJnvxxYYXvbCqUX7x8ZAwfhy75n10tkn9D8NCIehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585954; c=relaxed/simple;
	bh=l0G9K2M/VOCbWzDBIFNuQyfGx7MraJMudAGdwEH/xYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUI4qDASU1aftwzPQMAm+jbr5ydBYhMgSMzBRxBrHsGXyyIT6Wn2ML3WMl+geIS9d7lfQi7A1qI4mzhR1ofSBaYTt7fBZPL5dgwq55D5goJCg+OfFODZ22Y9bpyBqmqACNwuY2D8BkNvleqGqJirrp9vR10Ovg6wtgmPPcQwZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK8Cy7Ll; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d886dd4f18so14979271fa.1;
        Mon, 08 Apr 2024 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712585950; x=1713190750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EgyXhfkkC9c1XH+YB+JpD4WxDiRaPbll8NtlZzng/U=;
        b=bK8Cy7LlEJ4iCpEmlxTZ+TzySQf1aZrQbSj+DphaZ9GpZpJTmAYhQWNYHrZsnTOuGx
         qxz3XwuHAww1FX3sqYAbEDAdEadylK0xGYFGGQyl12rjhEQRnWhFN9CpM2oExXG0d6vg
         LDzg+m3UqSFSegKlAeeMcOAEYo6IPME3BZGQSM1bN77HgQN3x8wENc67QyTLQGnqEJF/
         NqNxb1+l3imfRY7rPc9VosV3/BGGLV8FWP9BnhQC/r+4l6Gm7Gk74Zrw2mRqATsKoYF/
         MBHHlNb9p7osPu3eMJKZMjX81D08BKwNJnHjkNu5wN2xLN24b0PZRSpRjrKqt7BYP0YC
         +w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585950; x=1713190750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EgyXhfkkC9c1XH+YB+JpD4WxDiRaPbll8NtlZzng/U=;
        b=GFVjg6aQnCfE4AKmGrjZR8T7Vo7pRXiq0/roiSODGF8SnsGQZnhrYSlUjj7LQyS85p
         fZTb+l1pngPq12mZuNYqd6Y9uPPN83VolXwCsw921kIKsdWmcCNJO48Al2BM1qhuVvjR
         Jv6XiB7stP/+7y9d0Dl22UJbwslH0uS2owKRkS+op+/Qh66MX4Db+5A1CDpHB5VhPV9R
         1lq38DORf6UvCuV/1IKf/IkddbICVdfEkBX5fo5kwdEokAQqWRLys4+HpCyAxDE7S3/b
         N/5VsTaHe50e8m3WLS1NfQRRk2AG7wOVW8318EN3XpLMgEuP7wz+7QV/QqhxX/K4NFUS
         9B2A==
X-Forwarded-Encrypted: i=1; AJvYcCW33STIHGze/94YZgXb5MKKCXPjBFvBN2YMV1bBwf5sOhDM2o+EUMwgW339IE+NyJRVzXrjydEaVuNEV/Girg6kFleaT8+evibzxtHw9zy4jURTtW+YgZQsP+0+5OlGbg3iK2W97JVVDGLX850datX2B9BfPKB8pEqtKEAEKdqudS5IrdLK
X-Gm-Message-State: AOJu0YyfVyD+aDDktWLuKoxbrIw6VMAdQQIezq7WrLX2fQaQwgnR6mSH
	5eYXuGMXEsDdCPqtIsXgh9Ig0leOJd7O2SzlJ0kP4+gum48hcXfh
X-Google-Smtp-Source: AGHT+IGCfCGU7wVW9CsT6+NG0JT0/MeDmGAiifirFN/WeHMgeMoJ79KASh0K0iHrq0KbD2heqr1nvw==
X-Received: by 2002:a2e:a49c:0:b0:2d8:5e21:8ec5 with SMTP id h28-20020a2ea49c000000b002d85e218ec5mr5904529lji.48.1712585950116;
        Mon, 08 Apr 2024 07:19:10 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b004168efc77d1sm1265072wmb.39.2024.04.08.07.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:19:09 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 5/6] net: gro: move L3 flush checks to tcp_gro_receive
Date: Mon,  8 Apr 2024 16:17:19 +0200
Message-Id: <20240408141720.98832-6-richardbgobert@gmail.com>
In-Reply-To: <20240408141720.98832-1-richardbgobert@gmail.com>
References: <20240408141720.98832-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

{inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
iph->id, ...) against all packets in a loop. These flush checks are used
currently only in tcp flows in GRO.

These checks need to be done only once in tcp_gro_receive and only against
the found p skb, since they only affect flush and not same_flow.

Leveraging the previous commit in the series, in which correct network
header offsets are saved for both outer and inner network headers -
allowing these checks to be done only once, in tcp_gro_receive. As a
result, NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id
checks are more declarative and contained in inet_gro_flush, thus removing
the need for flush_id in napi_gro_cb.

This results in less parsing code for UDP flows and non-loop flush tests
for TCP flows.

To make sure results are not within noise range - I've made netfilter drop
all TCP packets, and measured CPU performance in GRO (in this case GRO is
responsible for about 50% of the CPU utilization). gro_network_flush is
compiled inline to tcp_gro_receive.

perf top while replaying 64 parallel IP/TCP streams merging in GRO
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

perf top -g while running 64 IP/UDP netperf connections NOT merging in GRO
(udp_gro_receive is included because of -g, in this case GRO is just
overhead)
net-next:
	1.26% [kernel] [k] inet_gro_receive

patch applied:
	0.85% [kernel] [k] inet_gro_receive

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h      | 66 ++++++++++++++++++++++++++++++++++++++----
 net/core/gro.c         |  4 ---
 net/ipv4/af_inet.c     | 41 +-------------------------
 net/ipv4/tcp_offload.c | 15 ++--------
 net/ipv4/udp_offload.c | 16 +++-------
 net/ipv6/ip6_offload.c | 11 -------
 6 files changed, 67 insertions(+), 86 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index a1cc8e8c2ebd..116f09a9df3d 100644
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
@@ -443,6 +440,63 @@ static inline __wsum ip6_gro_compute_pseudo(const struct sk_buff *skb,
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
+	is_atomic = NAPI_GRO_CB(p)->is_atomic - 1;
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
index b2156e6cc4ad..3bfdfefe4a24 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -89,7 +89,6 @@ void dev_remove_offload(struct packet_offload *po)
 }
 EXPORT_SYMBOL(dev_remove_offload);
 
-
 int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 {
 	struct skb_shared_info *pinfo, *skbinfo = skb_shinfo(skb);
@@ -330,8 +329,6 @@ static void gro_list_prepare(const struct list_head *head,
 	list_for_each_entry(p, head, list) {
 		unsigned long diffs;
 
-		NAPI_GRO_CB(p)->flush = 0;
-
 		if (hash != skb_get_hash_raw(p)) {
 			NAPI_GRO_CB(p)->same_flow = 0;
 			continue;
@@ -471,7 +468,6 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
 					sizeof(u32))); /* Avoid slow unaligned acc */
 	*(u32 *)&NAPI_GRO_CB(skb)->zeroed = 0;
 	NAPI_GRO_CB(skb)->flush = skb_has_frag_list(skb);
-	NAPI_GRO_CB(skb)->is_atomic = 1;
 	NAPI_GRO_CB(skb)->count = 1;
 	if (unlikely(skb_is_gso(skb))) {
 		NAPI_GRO_CB(skb)->count = skb_shinfo(skb)->gso_segs;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 6546bf376b24..af094aecf38c 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1481,7 +1481,6 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 	struct sk_buff *p;
 	unsigned int hlen;
 	unsigned int off;
-	unsigned int id;
 	int flush = 1;
 	int proto;
 
@@ -1507,13 +1506,10 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
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
@@ -1530,43 +1526,8 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
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
 
 	/* Note : No need to call skb_gro_postpull_rcsum() here,
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 7f045b881dd4..1b10ab3b0f6a 100644
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
index ad4c88fe7d15..c5a5155904cf 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -466,12 +466,12 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 					       struct sk_buff *skb)
 {
 	struct udphdr *uh = udp_gro_udphdr(skb);
+	int off = skb_gro_offset(skb);
 	struct sk_buff *pp = NULL;
 	struct udphdr *uh2;
 	struct sk_buff *p;
 	unsigned int ulen;
 	int ret = 0;
-	int flush;
 
 	/* requires non zero csum, for symmetry with GSO */
 	if (!uh->check) {
@@ -529,17 +529,9 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 				skb_gro_postpull_rcsum(skb, uh,
 						       sizeof(struct udphdr));
 
-				flush = NAPI_GRO_CB(p)->flush;
-
-				if (NAPI_GRO_CB(p)->flush_id != 1 ||
-				    NAPI_GRO_CB(p)->count != 1 ||
-				    !NAPI_GRO_CB(p)->is_atomic)
-					flush |= NAPI_GRO_CB(p)->flush_id;
-				else
-					NAPI_GRO_CB(p)->is_atomic = false;
-
-				if (flush || skb_gro_receive(p, skb))
-					ret = 1;
+				ret = gro_network_flush(uh, uh2, p, off);
+				if (!ret)
+					ret = skb_gro_receive(p, skb);
 			}
 		}
 
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index ba41939537f2..c9a6bc1afc9a 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -288,19 +288,8 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
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


