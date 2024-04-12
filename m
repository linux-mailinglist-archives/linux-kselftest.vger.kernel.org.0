Return-Path: <linux-kselftest+bounces-7813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844058A32F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1341D1F2191C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 15:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F9D1494C7;
	Fri, 12 Apr 2024 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmfzMTQE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B829148825;
	Fri, 12 Apr 2024 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937394; cv=none; b=K6Nrm18uBSmf21f0nE9JWVg7YXy/BEUgrrSDNrewBJ0SR/Vcv4j6HAOT0ti2QK6KsjMgTDhA8zaIkWgdBjObR5421uws1lmjkGLQ8WsIhbJ5UrgQugnsm3dzzA5ztPsE8rRFkpNnixjD3L6ueqTMYV9otb9Jg4hjwxYWN/dXDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937394; c=relaxed/simple;
	bh=wDput5u2+jzE+80lghbTjH6XJQ2ZtwFAHx9Gt7vdtXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N7vIq7nRXgC6ONritWwysqSiJv6tiUMn40p5P3EHNuesN3QvYwBAs9ol9LxAwTHKSQFmW/pTF68UrVgmhsWHEzqwJohIWPq9KhYaEW9DHzHJdDQMa0AMZiiKF2KEquGnCGesXazW8lhf5W8noqnyN9Qa3h4+wWjjJhgeiVrYwQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmfzMTQE; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d8b4778f5fso9417001fa.3;
        Fri, 12 Apr 2024 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712937391; x=1713542191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmq8iDC1hM23YnzeF2nUIuuxtPze10zMOs6EqEHnmNU=;
        b=LmfzMTQEAZYrZhVEZIXlYSTFYps4rEz+sDpcTRhaA0c8RvyYA6gwQFY47OxaVu7RFc
         Pa7I7rNFjFSCTGwRgakCljE14D1CScMIxe8Z2N5d+7d0MpudE6CrdtOYahvu4mzBPRoH
         qPDrIgJama30sa2q8e1vf8zCFZw141+qnNSCCmTBjopoDigMs9PFkeDJxoYzeRwtETuL
         ShN7OHrEW3BhR93/2ubxrdofZrPExst1j6hHu4+lOOgXHPkFrU53CRBp5kUdQ42027Uf
         eY7PSlgWzPZmq1m3a2doesNT+7ZLiMMEZzXmRTFJuQIIUlRy9r4BjLfQG/4v86Y0Pcbm
         UsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712937391; x=1713542191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmq8iDC1hM23YnzeF2nUIuuxtPze10zMOs6EqEHnmNU=;
        b=GkqKaErjbGBLyxTFmvhAc/v5ccJYN56NVj2l/SzZ4J3nqNImgBAl7IQSuwVNQai0mA
         yK4ZmGVrXkTG1cQ2EWzNMqqb2+4SWglQ1O1U+gnXYi7dPfZxbl/pRtPJQiE5AA8iWYFT
         cGP+Oku4xI0lg81j7f2L/06tdTKVMCU9RDMKVIiWyUPUPz+2yQ8GJ6e9h9ZL+b2tFwIN
         6eHJpNTvZ+g1JXAYP/b7EZzvoeM4qTdv3j48iWpOQLy/a2IvplwIO8KCyikqnv33b4ZM
         eZqxTB0Nkr10TDCKvrDNKxlLutdrpLn5LUT+3UXuxK8m/3JGLm8Eu3pdgOgG9u+Meg9n
         tZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOv0XF5253L3AgLkN1g0ekZs2T7OqKpmhakNNXqWZPX4uov29xQOHRPzI7pbJSzDAgNaJ91EimuocoZp1iyOkjQOfsiz8r7di01u145XovBRTtQZNhsRHwDiDfyLQhYcWFh/lkWx8sCmgXbNnYfcMZYucPECxfk1zhfrRU6thv4filqDXn
X-Gm-Message-State: AOJu0Yw+gtolM8irxu3CgVzhO0xrE0q5nNEjfr+T65bwp+6ZE6ox7dho
	ZYM5r0nNHB2ka4nO6PeanCkWItR19JhYYZexmuiAlzhm/sIqX2XZ
X-Google-Smtp-Source: AGHT+IECDoVe8TWjP/8J2X66woB61de/k6dlbGz3Aya1zlA0fy/Fa63cw9mVsHtRAKI9lZFg92pedw==
X-Received: by 2002:a2e:be1b:0:b0:2d8:55f0:476b with SMTP id z27-20020a2ebe1b000000b002d855f0476bmr2387210ljq.23.1712937390318;
        Fri, 12 Apr 2024 08:56:30 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c470700b00416b2cbad06sm9223907wmo.41.2024.04.12.08.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:56:30 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v7 2/3] net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment
Date: Fri, 12 Apr 2024 17:55:32 +0200
Message-Id: <20240412155533.115507-3-richardbgobert@gmail.com>
In-Reply-To: <20240412155533.115507-1-richardbgobert@gmail.com>
References: <20240412155533.115507-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

{inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
iph->id, ...) against all packets in a loop. These flush checks are used
currently in all tcp flows and in some UDP flows in GRO.

These checks need to be done only once and only against the found p skb,
since they only affect flush and not same_flow.

Leveraging the previous commit in the series, in which correct network
header offsets are saved for both outer and inner network headers -
allowing these checks to be done only once, in tcp_gro_receive and
udp_gro_receive_segment. As a result, NAPI_GRO_CB(p)->flush is not used at
all. In addition, flush_id checks are more declarative and contained in
inet_gro_flush, thus removing the need for flush_id in napi_gro_cb.

This results in less parsing code for UDP flows and non-loop flush tests
for TCP flows.

To make sure results are not within noise range - I've made netfilter drop
all TCP packets, and measured CPU performance in GRO (in this case GRO is
responsible for about 50% of the CPU utilization).

L3 flush/flush_id checks are not relevant to UDP connections where
skb_gro_receive_list is called. The only code change relevant to this flow
is inet_gro_receive. The rest of the code parsing this flow stays the
same.

All concurrent connections tested are with the same ip srcaddr and
dstaddr.

perf top while replaying 64 concurrent IP/UDP connections (UDP fwd flow):
net-next:
        3.03%  [kernel]  [k] inet_gro_receive

patch applied:
        2.78%  [kernel]  [k] inet_gro_receive

perf top while replaying encapsulated load - 64 concurrent IP/IP/UDP
connections (rx-gro-list and rx-udp-gro-forwarding are enabled):
net-next:
        10.50%  [kernel]  [k] inet_gro_receive

patch applied:
        8.19%  [kernel]  [k] inet_gro_receive

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
 net/core/gro.c         |  4 ---
 net/ipv4/af_inet.c     | 41 +-------------------------
 net/ipv4/tcp_offload.c | 15 ++--------
 net/ipv4/udp_offload.c | 16 +++-------
 net/ipv6/ip6_offload.c | 11 -------
 6 files changed, 67 insertions(+), 86 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index a1cc8e8c2ebd..c1f80f1156d6 100644
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


