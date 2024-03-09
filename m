Return-Path: <linux-kselftest+bounces-6144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515708771F9
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 16:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABC41F2159A
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B254044391;
	Sat,  9 Mar 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzoS3RaS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A123BBCC;
	Sat,  9 Mar 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709998514; cv=none; b=kPomwjoONXqANUhdOynRdEz8621VctlCGKHjizQOjtG1OK7NFrFYR3tNHOC7C3xeNG7hmN4m9shUhYk4aMtDjlUqP8Odk0M+6LdfNCHB0jfQXFQMsmhyPfnTNULw5fi9XTXplG+yZh4CLRkCQjCR3+DYgFqpCpAq92tDWjC58WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709998514; c=relaxed/simple;
	bh=LlXnxtaYIM9zfwx7U2jZVAwynJNW2FZS5Ovo3PqDSiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gh+tsW+lW5huDZfyT/U/hZ5jH2tbFackKqLIgzjyLGcZTDTnw6w5ef0J6nF4wZfGsjcpvMMcrCl6vJWunh47D/Hl5Ad+GM7iUKHIwIem8VJMLtbkjVm70h+DhXL1vCPLZplZWrkCV19st+QbvcctSGlao5Ge6147P/UlIc3elBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzoS3RaS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4131ad76f05so9876455e9.0;
        Sat, 09 Mar 2024 07:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709998511; x=1710603311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJAtax3ZwpbB1qeVzq9Rm9GeuFxipf4n1zk7zLFbVLY=;
        b=CzoS3RaS/ehJnmua9Nu6jUFhJtP57dEgZPWt3z0iqbw/9Bk3LQx5Rq9vNTCqX0f7eh
         Vvj9VOxf5qsFsPejVE44ecjMlPyxHXv2a8/br2T2u4OOB7IxoC2JXPCnZlTq3AOM/2+w
         G+THY9XjSWXVR53XT2rdL+LKJxRrafKX71XgLlQsdDyUf7iAS9KExIWESnv69E6fbN90
         IcPK+XHpJvVD03hDdRLP76eyGmqxNSCyPQ78cSLPRYeJKMMRIXAunKK7Ia+5n7AI7HUU
         0k+g7jikgAtvsklQqH7HMu9ndb2N+rq2tXORFk8ltdfEZYnMKHT4KfIcFU4lmraDvFvb
         m8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709998511; x=1710603311;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gJAtax3ZwpbB1qeVzq9Rm9GeuFxipf4n1zk7zLFbVLY=;
        b=hwtFNG4OCoK3pTVRE9grpf/7jhQXMD7N1CoRgpxFcjWiTSMuJkUwoW1UBRWpqENR8L
         uWKmlguXBwUC5fTJPENgNemIHIvO9klQPGAWAIMfP+A/YNhzW4KNWMldVuPcunLfNd6C
         NDfXiyLaIscNrbLZXCA/eN9ES8Wd8uVD3AsyLcS5gCStjbSlArqmjzHACPDP/IlsdnSC
         644JppvVYqZEndmyC7MdlKIDIc8V2H90YLEjq8c/anl6o8V09FgMbm/n8A1WtguevXE9
         YzyyWo6bupoG0UjAda1dTorsITtO1rbT0TxIwZzFrPY+q/ULxIW4aP3b9v9uGfEYjSf0
         ABew==
X-Forwarded-Encrypted: i=1; AJvYcCV5uw0xNa/BOpBbb+5Hdgya4+RlUnycd5j2ki8b4FU0PgZdbmig9tkpb7mp38ONKays7OrqSHj9b7y+GqOSQw0x+HG1L6ZpS/7X13N6MMzxTI3payly/I+bpVK5apZFiw50FTnK8W8k0aRYmYSTY3Ewi+4mVpn9tskeILG+66eNiQ55hOHe
X-Gm-Message-State: AOJu0Yw3CeaATtt9adc8+Qgh/4JFTNLp8Z+IY22MP00nu7J/dUn2q31e
	3ZaY6H2s2aZQH4BfSMsZ8DtG38Eg5hS0M6I0QUMXdOTRZ5yKp1jS
X-Google-Smtp-Source: AGHT+IFn8SaOca0RymiIDlqkgScGUDw5Em/8plmTmdQzFSr2cjxCVa4qSL07HNhtkWZFlCRxFWlclg==
X-Received: by 2002:a05:600c:34c7:b0:413:1741:2a21 with SMTP id d7-20020a05600c34c700b0041317412a21mr1957298wmq.1.1709998510824;
        Sat, 09 Mar 2024 07:35:10 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b0041313d4c852sm2865312wmr.19.2024.03.09.07.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 07:35:10 -0800 (PST)
Message-ID: <88831c36-a589-429f-8e8b-2ecb66a30263@gmail.com>
Date: Sat, 9 Mar 2024 16:34:53 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next v3 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
 xeb@mail.ru, shuah@kernel.org, idosch@nvidia.com, razor@blackwall.org,
 amcohen@nvidia.com, petrm@nvidia.com, jbenc@redhat.com, bpoirier@nvidia.com,
 b.galvani@gmail.com, gavinl@nvidia.com, liujian56@huawei.com,
 horms@kernel.org, linyunsheng@huawei.com, therbert@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

{inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
iph->id, ...) against all packets in a loop. These flush checks are
relevant only to tcp flows, and as such they're used to determine whether
the packets can be merged later in tcp_gro_receive.

These checks are not relevant to UDP packets. Furthermore, they need to be
done only once in tcp_gro_receive and only against the found p skb, since
they only affect flush and not same_flow.

Levaraging the previous commit in the series, in which correct network
header offsets are saved for both outer and inner network headers -
allowing these checks to be done only once, in tcp_gro_receive. As a
result, NAPI_GRO_CB(p)->flush is not used at all. In addition - flush_id
checks are more declerative and contained in inet_gro_flush, thus removing
the need for flush_id in napi_gro_cb.

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
 net/ipv4/tcp_offload.c | 72 ++++++++++++++++++++++++++++++++++--------
 net/ipv6/ip6_offload.c | 11 -------
 5 files changed, 62 insertions(+), 69 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 9d1389269509..34e50f77f744 100644
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
@@ -84,9 +84,6 @@ struct napi_gro_cb {
 		u8	is_flist:1;
 	);
 
-	/* used to support CHECKSUM_COMPLETE for tunneling protocols */
-	__wsum	csum;
-
 	/* L3 offsets */
 	union {
 		struct {
diff --git a/net/core/gro.c b/net/core/gro.c
index 2b42138f816c..128d7b9c8dfb 100644
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
@@ -473,7 +471,6 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
 					sizeof(u32))); /* Avoid slow unaligned acc */
 	*(u32 *)&NAPI_GRO_CB(skb)->zeroed = 0;
 	NAPI_GRO_CB(skb)->flush = skb_has_frag_list(skb);
-	NAPI_GRO_CB(skb)->is_atomic = 1;
 	NAPI_GRO_CB(skb)->count = 1;
 	if (unlikely(skb_is_gso(skb))) {
 		NAPI_GRO_CB(skb)->count = skb_shinfo(skb)->gso_segs;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c6bb21c27aee..5b74c6d2ed8b 100644
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
index fde800179b2e..c165e72555e1 100644
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
@@ -190,6 +239,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 	unsigned int mss = 1;
 	unsigned int hlen;
 	unsigned int off;
+	bool encap_mark;
 	int flush = 1;
 	int i;
 
@@ -232,9 +282,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 	goto out_check_final;
 
 found:
-	/* Include the IP ID check below from the inner most IP hdr */
-	flush = NAPI_GRO_CB(p)->flush;
-	flush |= (__force int)(flags & TCP_FLAG_CWR);
+	flush = (__force int)(flags & TCP_FLAG_CWR);
 	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
@@ -242,16 +290,14 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
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
+	for (i = 0; i <= encap_mark; i++) {
+		const u16 diff = off - NAPI_GRO_CB(skb)->network_offsets[i];
+
+		flush |= gro_network_flush((void *)th - diff,
+					   (void *)th2 - diff,
+					   p, i != encap_mark);
+	}
 
 	mss = skb_shinfo(p)->gso_size;
 
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index d9d3a6bed510..b1850c20d799 100644
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

