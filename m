Return-Path: <linux-kselftest+bounces-9819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AE28C152F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 21:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AFA5B22232
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 19:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20097EF1D;
	Thu,  9 May 2024 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bILk1JP/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC8653;
	Thu,  9 May 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715281771; cv=none; b=GNWWl3RhnJyFlGRNoQqKQB3SHMr3/LvZadBPtuzpvKUmhYld+YQYLiMuXe6oz+2nG273LXFyBKmp2LqCE2CKc9aRhTLF7CaifNTzczIL88/ZiNqx8Nirb4yGTiRbOq4uAiEAv9HJZnEu8jku/J/6Z4qjy6jGPJJYB80rYjBh3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715281771; c=relaxed/simple;
	bh=6JEa1GNWMlzHa0ArQFyHgaRqlZSPvgU80UZN0JDyaqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LxT8V8igvVvb/g0YrCot/ddZArlyT0wf/M8q4fpXEiFcJ8iLsA06ozLmyVdMQnPU+zUWeigX3wcQvo+Z8TM2Z6th7KxjyLGVNUiqLRyb4LokZi1vC0CBDH9wg++EK/m9qQMSgp40dSEFi6/xY8MB3a1D9MhadHjBdQkAtebtAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bILk1JP/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41c7ac6f635so7904405e9.3;
        Thu, 09 May 2024 12:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715281768; x=1715886568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMrjJSOEtA2W+WOLhPkmUYGknaDBbDyUCohfVuFK/Do=;
        b=bILk1JP/zJOheSkXOQdMboKwCSoATXXLw6APB6wLOH3H6BO0/C/OsuyqjFP7qjhJbG
         e3v2N9BumQs3VSma68+86Qiw0623JW5MsrLQVcjC2rEEy6LHdGuVA/J0DnOrU0I/H2ly
         i+c1lR9DiR/9Hp0PNNz1zQ7cdN34GdkvX6qwmZz8cHX0EiJCb8hdosAJR5BlxdUq2Uho
         WRLIXcOtnPPpeo0NubHTl+nKmuxEmweJvJPg/vlc6L6ICiK6rmeWIqBybp6UHjWFDhm1
         CRP+ihST3CTfSDUQ++i4M0eLKTL8z92RiZihR+u+OE160tSSTeKgsgMz/u0tSthgzyLv
         1IHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715281768; x=1715886568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMrjJSOEtA2W+WOLhPkmUYGknaDBbDyUCohfVuFK/Do=;
        b=Plw/+1ZISZXFA3PFB9RrQMwLRt86jIpewjnS3aN6/wHh5sj5nq4H9Nk9S+S6lw0WQj
         CEKj0dADm1LI7aZlvk/QwUSmI/QRVzs7yJ7QL7g7Fjvj8JSTTxr3bpV8VZLZ3ysmVbpH
         yrYkL9VyWhr8llwMngaj5+81LzC7n2eSXACIblTdwnw6W8ShTR2WSWlfHGGQ3DL5G3hv
         ENvyF/O2wJqRRMqhFS8JI7Gkye9n7OY1BHnjpbbccsqjNbqQ6biWJqRYA8GAZYNsXfbC
         3sU/WtAU3Chc3JWOI+IrAmEFGucpygji/SWqDLYeGzJa8hp/CEipXmWqor/Ov9yGwfr1
         +Fnw==
X-Forwarded-Encrypted: i=1; AJvYcCUDVlw5V+EhfWH3D2Z1W9hX4poKNDfpiePEVokYzZBq6S1FxjmmyDJhhWjEoBFQ3N+rtpBDuaVSl0Bw9AqXKBaW7AthrB+XUamsj+ULFqFdPRcxjQYOPrmQDqPpjrxvjlMGHgpi/Uqxa+vV4fkuRPsKCsNZfKrokfedF2uxBngMGYr/oXU5
X-Gm-Message-State: AOJu0YxoUG8MKTGS1xwyg71rEHMdfgbwg29WvK9ifxkr56sMjwNxLXVk
	YF5MMHR5d9NdaKIizh2qDx0j4OSBJddzONj88J3DvhjonLp5dW1i
X-Google-Smtp-Source: AGHT+IEgsY/NEnoz53dGzRl598UWYWy+eUcpedE38LtQeduj1cB209hUGrdB0t/5jxe0wO6F+5XZ3w==
X-Received: by 2002:a05:600c:1c29:b0:41b:39a3:cbf2 with SMTP id 5b1f17b1804b1-41fea931b48mr5707925e9.4.1715281767787;
        Thu, 09 May 2024 12:09:27 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce24efsm35735465e9.19.2024.05.09.12.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 12:09:27 -0700 (PDT)
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
Subject: [PATCH net-next v10 2/3] net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment
Date: Thu,  9 May 2024 21:08:18 +0200
Message-Id: <20240509190819.2985-3-richardbgobert@gmail.com>
In-Reply-To: <20240509190819.2985-1-richardbgobert@gmail.com>
References: <20240509190819.2985-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(gro_receive_network_flush is compiled inline to tcp_gro_receive)
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
 include/net/gro.h      | 76 +++++++++++++++++++++++++++++++++++++-----
 net/core/gro.c         |  3 --
 net/ipv4/af_inet.c     | 41 +----------------------
 net/ipv4/tcp_offload.c | 17 ++--------
 net/ipv4/udp_offload.c |  9 +----
 net/ipv6/ip6_offload.c | 11 ------
 6 files changed, 73 insertions(+), 84 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index cbc1b0aaf295..f13634b1f4c1 100644
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
@@ -75,8 +75,8 @@ struct napi_gro_cb {
 		/* Used in GRE, set in fou/gue_gro_receive */
 		u8	is_fou:1;
 
-		/* Used to determine if flush_id can be ignored */
-		u8	is_atomic:1;
+		/* Used to determine if ipid_offset can be ignored */
+		u8	ip_fixedid:1;
 
 		/* Number of gro_receive callbacks this packet already went through */
 		u8 recursion_counter:4;
@@ -85,9 +85,6 @@ struct napi_gro_cb {
 		u8	is_flist:1;
 	);
 
-	/* used to support CHECKSUM_COMPLETE for tunneling protocols */
-	__wsum	csum;
-
 	/* L3 offsets */
 	union {
 		struct {
@@ -442,6 +439,69 @@ static inline __wsum ip6_gro_compute_pseudo(const struct sk_buff *skb,
 					    skb_gro_len(skb), proto, 0));
 }
 
+static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
+				 struct sk_buff *p, bool outer)
+{
+	const u32 id = ntohl(*(__be32 *)&iph->id);
+	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
+	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
+	const u16 count = NAPI_GRO_CB(p)->count;
+	const u32 df = id & IP_DF;
+	int flush;
+
+	/* All fields must match except length and checksum. */
+	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
+
+	if (flush | (outer && df))
+		return flush;
+
+	/* When we receive our second frame we can make a decision on if we
+	 * continue this flow as an atomic flow with a fixed ID or if we use
+	 * an incrementing ID.
+	 */
+	if (count == 1 && df && !ipid_offset)
+		NAPI_GRO_CB(p)->ip_fixedid = true;
+
+	return ipid_offset ^ (count * !NAPI_GRO_CB(p)->ip_fixedid);
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
+static inline int __gro_receive_network_flush(const void *th, const void *th2,
+					      struct sk_buff *p, const u16 diff,
+					      bool outer)
+{
+	const void *nh = th - diff;
+	const void *nh2 = th2 - diff;
+
+	if (((struct iphdr *)nh)->version == 6)
+		return ipv6_gro_flush(nh, nh2);
+	else
+		return inet_gro_flush(nh, nh2, p, outer);
+}
+
+static inline int gro_receive_network_flush(const void *th, const void *th2,
+					    struct sk_buff *p)
+{
+	const bool encap_mark = NAPI_GRO_CB(p)->encap_mark;
+	int off = skb_transport_offset(p);
+	int flush;
+
+	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, encap_mark);
+	if (encap_mark)
+		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, false);
+
+	return flush;
+}
+
 int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb);
 int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb);
 
diff --git a/net/core/gro.c b/net/core/gro.c
index e2f84947fb74..b3b43de1a650 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -358,8 +358,6 @@ static void gro_list_prepare(const struct list_head *head,
 	list_for_each_entry(p, head, list) {
 		unsigned long diffs;
 
-		NAPI_GRO_CB(p)->flush = 0;
-
 		if (hash != skb_get_hash_raw(p)) {
 			NAPI_GRO_CB(p)->same_flow = 0;
 			continue;
@@ -499,7 +497,6 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
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
index 2809667ac924..4b791e74529e 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -313,10 +313,8 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	if (!p)
 		goto out_check_final;
 
-	/* Include the IP ID check below from the inner most IP hdr */
 	th2 = tcp_hdr(p);
-	flush = NAPI_GRO_CB(p)->flush;
-	flush |= (__force int)(flags & TCP_FLAG_CWR);
+	flush = (__force int)(flags & TCP_FLAG_CWR);
 	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
@@ -324,16 +322,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
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
+	flush |= gro_receive_network_flush(th, th2, p);
 
 	mss = skb_shinfo(p)->gso_size;
 
@@ -480,7 +469,7 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 				  iph->daddr, 0);
 
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
-			(NAPI_GRO_CB(skb)->is_atomic * SKB_GSO_TCP_FIXEDID);
+			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
 
 	tcp_gro_complete(skb);
 	return 0;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index f6d3c442e260..59448a2dbf2c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -478,14 +478,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
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
+		flush = gro_receive_network_flush(uh, uh2, p);
 
 		/* Terminate the flow on len mismatch or if it grow "too much".
 		 * Under small packet flood GRO count could elsewhere grow a lot
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 288c7c6ea50f..bd5aff97d8b1 100644
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


