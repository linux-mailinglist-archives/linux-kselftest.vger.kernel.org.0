Return-Path: <linux-kselftest+bounces-6049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6243874FF9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 14:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503691F22808
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 13:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD7D12C7F2;
	Thu,  7 Mar 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XraYcgVO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB821126F3E;
	Thu,  7 Mar 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818213; cv=none; b=dZ+n3SmWPapswrgf0+QrT6KGtg9R4hvy+GNg7K0iUWUJ197YBsfdcPQDl9ZW9Rjpb4TFxE32x6mL6AgfNFsGLlD61sgNbAzitvbi1u1DC1vT0POZh/xXXVuMgJSmMKrBswtLRrEfofZMMnryN69lT0VPzr6SziwRJF5ZRDgYtg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818213; c=relaxed/simple;
	bh=vkOMxHXD4nuVLrv6WmdabNYOCP9l1guIXj+KW4LR1do=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=hpKZHh7eHozq+9SV8k4Jv5VAzK3nv8+PQJnQvHqMM11D04i6ekHAeGCqp47J/9AOl6c1AnuMQboFKwWP3F1HugyL76lrCLhexskTM3LECXYIG3rjcPTM5suM0S1zPyE/cncQGVK+aYt8lD2Nm1pq85jCN6G4QlO8ap+friGL2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XraYcgVO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4130fefef75so4809155e9.2;
        Thu, 07 Mar 2024 05:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709818210; x=1710423010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doHNYzpPaU/Jmbsj3ODm0NABIpGT3fJO+db8zfVfSF4=;
        b=XraYcgVOPnatI3ONhaT+eASEIROHPgRFlVjFLJb2G1UvczoDA2yCpkJOR8g5kol+Vy
         W9at145oa9raBPLIrqEpRwkgzlHdiwWIcx9v2+OcZlx7pYSwR2A1CT/bhIxEgAJ7368N
         HF8YJZ6SH0v2jZgbRl+MmxbS4mi7/m8OuDkFA0LJDzlhmSHQNxCJi/jFuApn3tD59VQn
         V/58wOV8a9STfo94b/OI5K781NTUQnYk6xAC6S2Kmpqz5kBjQHQ0WivoFt/3+miqsSfE
         RjoDdR5z2N1UGf6RmMC7d0SwktNLeDOrFbzhA4RKl+feaSg85yJw5bmnU7f0alKX79Pm
         sDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709818210; x=1710423010;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=doHNYzpPaU/Jmbsj3ODm0NABIpGT3fJO+db8zfVfSF4=;
        b=eyRSHcA9ibHt6lXC7bT1j5C/UZHV3woLhe1r/65HWCNV/xiXsV9RBXgqEXs37HrRjP
         28P2mYtqG7yWD87GYjt+ai3RXBGaKG4fBP1MsTGg8rpXp/i5/5G0qHmstLPfywH+NmHs
         RyFRdK8DbNNAYXZcb4+7KVKAljt0G1yIJHqpna4RFYYY9tniW2G3apL4VdjvcDlWst2M
         zAJIpRkJ9Wx4crunFEz3yuC6MCZ89r7bMk8s8PVKuSiHuoviF/EPf18p8W6/VDQkJePN
         kvEn8ZApXyzj19VRE+nxWqE/qIVNrsIfQMg0llJvMrHEEtxuY4S5ov1rXrOA4P0UB4b/
         ox0A==
X-Forwarded-Encrypted: i=1; AJvYcCVwVQ4jFeoX7sB5DvonbdVMcfHFpFXnrQCLjRD0wbqZ3+OAA5shCq0L2WzDJyeWW2gZJAId8Yl4A1qU10b9611Ho3zZJoQi7F+xMfM1wgJcSFP1ub4+KmzN6L9az8jH8BldNPj0W8BQXl/pRGiTwZCrPtfs0aLZdJNsg9vmznUWvlxqvthe
X-Gm-Message-State: AOJu0YxuHrLpjxrKo1jqYi8w7Sa3tjA3GrIQgMTqcFSyOqS2Y/43H/pn
	HtGQAzkbZ9HWhMJbLqY26SGQyGjhNxfC9l2jaX94ATo92JgQljWk
X-Google-Smtp-Source: AGHT+IGOXKOB/DpTDS46ZigfIY/sMM7eU8fn4aIS5/XqrPkFg4EAFhMM+QDivPnj6Mw6HerQOFA2fA==
X-Received: by 2002:a05:600c:4fc3:b0:412:dc02:9824 with SMTP id o3-20020a05600c4fc300b00412dc029824mr10431099wmq.9.1709818209866;
        Thu, 07 Mar 2024 05:30:09 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id m37-20020a05600c3b2500b0041312c0cc45sm1208587wms.0.2024.03.07.05.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 05:30:09 -0800 (PST)
Message-ID: <a0d6798b-ad9e-4b12-bd07-9d4e22a64df6@gmail.com>
Date: Thu, 7 Mar 2024 14:29:38 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next v2 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
 shuah@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <2ce1600b-e733-448b-91ac-9d0ae2b866a4@gmail.com>
In-Reply-To: <2ce1600b-e733-448b-91ac-9d0ae2b866a4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

{inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
iph->id, ...) against all packets in a loop. These flush checks are
relevant only to tcp flows, and as such they're used to determine whether
the packets can be merged later in tcp_gro_receive.

These checks are not relevant to UDP packets. Furthermore, they need to be
done only once in tcp_gro_receive and only against the found p skb, since
they only affect flush and not same_flow.

Leveraging the previous commit in the series, in which correct network header offsets
are saved for both outer and inner network headers - allowing these checks
to be done only once, in tcp_gro_receive. As a result,
NAPI_GRO_CB(p)->flush is not used at all. In addition - flush_id checks are
more declarative and contained in inet_gro_flush, thus removing the need
for flush_id in napi_gro_cb.

This results in less parsing code for UDP flows and non-loop flush tests
for TCP flows.

For example, running 40 IP/UDP netperf connections:
./super_netperf.sh 40 -H 1.1.1.2 -t UDP_STREAM -l 120

Running perf top for 90s we can see that relatively less time is spent
on inet_gro_receive when GRO is not coalescing UDP:

net-next:
   1.26%  [kernel]  [k] inet_gro_receive

patch applied:
   0.85%  [kernel]  [k] inet_gro_receive

udpgro_bench.sh single connection GRO improvement:
net-next:
   0.76%  [kernel]  [k] inet_gro_receive

patch applied:
   0.61%  [kernel]  [k] inet_gro_receive

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h      |  9 ++----
 net/core/gro.c         |  3 --
 net/ipv4/af_inet.c     | 36 ---------------------
 net/ipv4/tcp_offload.c | 73 ++++++++++++++++++++++++++++++++++--------
 net/ipv6/ip6_offload.c | 11 -------
 5 files changed, 63 insertions(+), 69 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 923cbcc4c2fa..835cfc38a7b7 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -35,15 +35,15 @@ struct napi_gro_cb {
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
@@ -83,9 +83,6 @@ struct napi_gro_cb {
 		/* GRO is done by frag_list pointer chaining. */
 		u8	is_flist:1;
 	);
-
-	/* used to support CHECKSUM_COMPLETE for tunneling protocols */
-	__wsum	csum;
 };
 
 #define NAPI_GRO_CB(skb) ((struct napi_gro_cb *)(skb)->cb)
diff --git a/net/core/gro.c b/net/core/gro.c
index 7da3df2c634f..4128c16e76a2 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -332,8 +332,6 @@ static void gro_list_prepare(const struct list_head *head,
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
index 09ab9ac4420b..a60301a43727 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1512,7 +1512,6 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	list_for_each_entry(p, head, list) {
 		struct iphdr *iph2;
-		u16 flush_id;
 
 		if (!NAPI_GRO_CB(p)->same_flow)
 			continue;
@@ -1529,43 +1528,8 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
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
index fde800179b2e..a9ea6c681fa6 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -178,6 +178,55 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	return segs;
 }
 
+static int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
+			  struct sk_buff *p, u32 outer)
+{
+	const u32 id = ntohl(*(__be32 *)&iph->id);
+	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
+	const int flush_id = ntohs(id >> 16) - ntohs(id2 >> 16);
+	const u16 count = NAPI_GRO_CB(p)->count;
+	const u32 df = id & IP_DF;
+	u32 is_atomic;
+	int flush;
+
+	/* All fields must match except length and checksum. */
+	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
+
+	/* When we receive our second frame we can make a decision on if we
+	 * continue this flow as an atomic flow with a fixed ID or if we use
+	 * an incremdfenting ID.
+	 */
+	if (count == 1) {
+		is_atomic = df && flush_id == 0;
+		NAPI_GRO_CB(p)->is_atomic = is_atomic;
+	} else {
+		is_atomic = df && NAPI_GRO_CB(p)->is_atomic;
+	}
+
+	/* Ignore outer IP ID value if based on atomic datagram. */
+	outer = (outer && df) - 1;
+	is_atomic--;
+
+	return flush | ((flush_id ^ (count & is_atomic)) & outer);
+}
+
+static int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr *iph2)
+{
+	/* <Version:4><Traffic_Class:8><Flow_Label:20> */
+	__be32 first_word = *(__be32 *)iph ^ *(__be32 *)iph2;
+
+	/* Flush if Traffic Class fields are different. */
+	return (first_word & htonl(0x0FF00000)) |
+		(__force __be32)(iph->hop_limit ^ iph2->hop_limit);
+}
+
+static int gro_network_flush(const void *nh, const void *nh2,
+			     struct sk_buff *p, u32 outer)
+{
+	return (((struct iphdr *)nh)->version == 6) ? ipv6_gro_flush(nh, nh2) :
+		inet_gro_flush(nh, nh2, p, outer);
+}
+
 struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 {
 	struct sk_buff *pp = NULL;
@@ -190,6 +239,8 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 	unsigned int mss = 1;
 	unsigned int hlen;
 	unsigned int off;
+	unsigned int netoff_diff;
+	bool encap_mark;
 	int flush = 1;
 	int i;
 
@@ -232,9 +283,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 	goto out_check_final;
 
 found:
-	/* Include the IP ID check below from the inner most IP hdr */
-	flush = NAPI_GRO_CB(p)->flush;
-	flush |= (__force int)(flags & TCP_FLAG_CWR);
+	flush = (__force int)(flags & TCP_FLAG_CWR);
 	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
@@ -242,16 +291,14 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
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
+	encap_mark = NAPI_GRO_CB(skb)->encap_mark;
+	netoff_diff = off - skb_network_offset(skb);
+	for (i = 0; i <= encap_mark; i++) {
+		flush |= gro_network_flush(((void *)th) - netoff_diff,
+					   ((void *)th2) - netoff_diff,
+					   p, i != encap_mark);
+		netoff_diff = off - skb_inner_network_offset(skb);
+	}
 
 	mss = skb_shinfo(p)->gso_size;
 
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 29601be9fa90..6e29ddfc0bc1 100644
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

