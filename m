Return-Path: <linux-kselftest+bounces-5312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AC4860487
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 22:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE28F1F2231A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 21:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F49712D1F6;
	Thu, 22 Feb 2024 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fvr9zekl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2788E12D1EF;
	Thu, 22 Feb 2024 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636359; cv=none; b=F/JGHyNC+TJUaRl1PP8HPDIZf6R+J7SDAkTnw/tbhReVzC8LGIbg8KwOMbAUwK6LwaIoBz+lQvSg19vEuoDgY33nxlabxplvsfkrKbJ5bFFixHzEo8XIjWOESy17OirjWA5lI2R2NPIwpEL5MdwOjtfpYsTmuopyIRSc2SRKscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636359; c=relaxed/simple;
	bh=ulEVuUbmlIOcbZS/uX1ZSKeGuYNvg2+eTJ9Hnw8+geA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TjLq+ABPrDxFWr9S47peIM44g6rkpF/sU9mv52G6KdLJLXmpmV6AVSTDC8trzoPUT2GeR0fLG+s+DJYVBsq1s0N4SMfr4qNyxIPb97cR5ZOJn8siqLhFSbBVZHt6h/nPmc7Ifm75aIm6J80q0woqD8s2+TEoMxeUVOjlOdzqRKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fvr9zekl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3394b892691so140031f8f.1;
        Thu, 22 Feb 2024 13:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708636355; x=1709241155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uZ886B2wbGi6D6+tgsf/RlPsYxVtxW0DFUXrxIudv4=;
        b=Fvr9zekl590HUyFChrkJQNwqepa0YjKPUBOcfMoCbb89eUxRkEvJ4IGKCo83Mf7v7e
         tSANNIgmlxzeGji0PYTCNfxfLdwL2Grogk3pFIQFYifvSfdx1YEPgECg2hB2Ey4fDqPM
         +vUduVhxfF+8/R+v7vI4TMPjWxGzmJckI5aWJfLIq9iF7S+qDXzyDgE4JMxRPDyHlpKx
         LCsHpjC0rUmBnhbYO7CVLPOCgzHu09lx+TLSWZCokRTKdOL+tLcz015OgG8dKwSU08IP
         oMHhpxgRQSs9SJVpRkE63WdB6lBaIIqTuUgdOndSar1ailbncwqe1iovmOb349I/R1tK
         37nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708636355; x=1709241155;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8uZ886B2wbGi6D6+tgsf/RlPsYxVtxW0DFUXrxIudv4=;
        b=uenomkQrIhXMdYrw1GEyJUrIfJOgCVYwngiMfuq6yLkA53/x87IfbYj5wbsMCi/Yh4
         fKiTIRcF37ruBKfaV+ql/EeIqjql1/XQGooa25WwKBiYmFvEM7dx2QaXHrh7jOlt99in
         0lQFyh1Lh2fPzrTcbp9oDjNJMHc5gwx3w0HdoKKya9+NZvqFQr+rNwKGV9zbFguthAfu
         jLPYGvImAJI1mr0BS6CGndTKPQXIiatOILuHswA8XAskoWXEcPtrIYK8CMP2cDYS02Mu
         FRHb9Py0jVEbXGLZSofC0PxQr0BZf6oBI4/eb0PXHrQ7RxXeXjlkSFLicn2g02yhOtpn
         bNCg==
X-Forwarded-Encrypted: i=1; AJvYcCXsf5dB9poRP7k9sQ6/grDR3OkPhDi7r/WLJ8WiIsTdaHgPJ4E+oaN2Gy/ne6r1gdXCfSZ/3uhuVfNZLGp98rVDi5jyzH2rTEgMzylDPBIE+0InfcnBg0pe/fRUKkObatBHwPQJFa2F6v8asOgPHH4FDbflEt9FQbtfb1Anv1zp8AKVSItw
X-Gm-Message-State: AOJu0YxYcRWJssLjnlKpjE3y874gGKqo1PxqmP8NVc4PFHsj2lmaNRW4
	Dn10LeAy1H3O0z2jL4PkuTB7gx3OWviWlDzf1/w7LBaV+osIX5Jm
X-Google-Smtp-Source: AGHT+IHT5PsC047o/u3D4yrVTBQYfRa0oFqzo8/IqrmGohwIxUIGmayvAhMTj5uXkm46pqPdtYVnGA==
X-Received: by 2002:a5d:46c8:0:b0:33d:4dbd:d05e with SMTP id g8-20020a5d46c8000000b0033d4dbdd05emr3462949wrs.22.1708636355232;
        Thu, 22 Feb 2024 13:12:35 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id ay28-20020a5d6f1c000000b0033d60cba289sm214669wrb.68.2024.02.22.13.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 13:12:35 -0800 (PST)
Message-ID: <ebf471d8-f026-475e-bf40-cd24c8735dcc@gmail.com>
Date: Thu, 22 Feb 2024 22:12:12 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next 3/3] net: gro: move L3 flush checks to
 tcp_gro_receive
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org,
 liujian56@huawei.com, horms@kernel.org, aleksander.lobakin@intel.com,
 linyunsheng@huawei.com, therbert@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <e1d22505-c5f8-4c02-a997-64248480338b@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <e1d22505-c5f8-4c02-a997-64248480338b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

{inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
iph->id, ...) against all packets in a loop. These flush checks are
relevant only to tcp flows, and as such they're used to determine whether
the packets can be merged later in tcp_gro_receive.

These checks are not relevant to UDP packets. Furthermore, they need to be
done only once in tcp_gro_receive and only against the found p skb, since
they only affect flush and not same_flow.

Leveraging the initial commit in the series, correct network header offsets
are saved for both outer and inner network headers - allowing these checks
to be done only once, in tcp_gro_receive. As a result,
NAPI_GRO_CB(p)->flush is not used at all. In addition - flush_id checks are
more declarative and contained in inet_gro_flush_id, thus removing the need
for flush_id in napi_gro_cb.

This results in less parsing code for UDP flows and non-loop flush tests
for TCP flows.

For example, running 64 IP/UDP netperf connections:
./super_netperf.sh 64 -H 1.1.1.2 -t UDP_STREAM -l 120

Running perf top for 90s we can see that relatively less time is spent on
inet_gro_receive:

net-next:

	Samples: 330K of event 'cycles:P', 4000 Hz, Event count (approx.): 45945660156 lost: 0/0 drop: 0/0
	   1.43%  [kernel]                  [k] inet_gro_receive

patch applied:

	Samples: 295K of event 'cycles:P', 4000 Hz, Event count (approx.): 44726408099 lost: 0/0 drop: 0/0
	   1.22%  [kernel]                  [k] inet_gro_receive

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h      |  9 ++----
 net/core/gro.c         |  3 --
 net/ipv4/af_inet.c     | 36 ---------------------
 net/ipv4/tcp_offload.c | 71 ++++++++++++++++++++++++++++++++++--------
 net/ipv6/ip6_offload.c | 11 -------
 5 files changed, 61 insertions(+), 69 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 89502a7e35ed..e6db591cdc32 100644
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
index 0759277dc14e..b7dced5bcef7 100644
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
@@ -466,7 +464,6 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
 					sizeof(u32))); /* Avoid slow unaligned acc */
 	*(u32 *)&NAPI_GRO_CB(skb)->zeroed = 0;
 	NAPI_GRO_CB(skb)->flush = skb_has_frag_list(skb);
-	NAPI_GRO_CB(skb)->is_atomic = 1;
 	NAPI_GRO_CB(skb)->count = 1;
 	if (unlikely(skb_is_gso(skb))) {
 		NAPI_GRO_CB(skb)->count = skb_shinfo(skb)->gso_segs;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c0f3c162bf73..fd7378ecc4e3 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1509,7 +1509,6 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	list_for_each_entry(p, head, list) {
 		struct iphdr *iph2;
-		u16 flush_id;
 
 		if (!NAPI_GRO_CB(p)->same_flow)
 			continue;
@@ -1526,43 +1525,8 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
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
 	if (NAPI_GRO_CB(skb)->encap_mark)
 		skb_set_inner_network_header(skb, off);
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 8bbcd3f502ac..962c1b900e11 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -178,6 +178,60 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	return segs;
 }
 
+static inline bool inet_gro_flush(struct iphdr *iph, struct iphdr *iph2)
+{
+	/* All fields must match except length and checksum. */
+	return (iph->ttl ^ iph2->ttl) |
+	       (iph->tos ^ iph2->tos) |
+	       ((iph->frag_off ^ iph2->frag_off) & htons(IP_DF));
+}
+
+static inline bool ipv6_gro_flush(struct ipv6hdr *iph, struct ipv6hdr *iph2)
+{
+	/* <Version:4><Traffic_Class:8><Flow_Label:20> */
+	__be32 first_word = *(__be32 *)iph ^ *(__be32 *)iph2;
+
+	/* Flush if Traffic Class fields are different. */
+	return (first_word & htonl(0x0FF00000)) |
+		(__force __be32)(iph->hop_limit ^ iph2->hop_limit);
+}
+
+static inline bool inet_gro_flush_id(struct sk_buff *p, struct iphdr *iph,
+				     struct iphdr *iph2)
+{
+	u16 flush_id = ntohs(iph->id) - ntohs(iph2->id);
+	u16 is_atomic = !!(iph->frag_off & htons(IP_DF));
+	u16 count_masked;
+
+	/* When we receive our second frame we can make a decision on if we
+	 * continue this flow as an atomic flow with a fixed ID or if we use
+	 * an incrementing ID.
+	 */
+	if (NAPI_GRO_CB(p)->count == 1)
+		NAPI_GRO_CB(p)->is_atomic = flush_id == 0;
+
+	/* Ignore outer IP ID value if based on atomic datagram. */
+	if (NAPI_GRO_CB(p)->encap_mark && is_atomic && iph2 == ip_hdr(p))
+		return false;
+
+	is_atomic &= NAPI_GRO_CB(p)->is_atomic;
+	count_masked = NAPI_GRO_CB(p)->count & ~(-is_atomic | is_atomic);
+
+	return flush_id ^ count_masked;
+}
+
+static bool tcp_gro_network_flush(struct sk_buff *p, struct sk_buff *skb,
+				  int offset)
+{
+	void *nh = (NAPI_GRO_CB(skb)->frag0 ?: skb->data) + offset;
+	void *nh2 = p->data + offset;
+
+	if (((struct iphdr *)nh)->version == 6)
+		return ipv6_gro_flush(nh, nh2);
+
+	return inet_gro_flush(nh, nh2) | inet_gro_flush_id(p, nh, nh2);
+}
+
 struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 {
 	struct sk_buff *pp = NULL;
@@ -232,8 +286,10 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 	goto out_check_final;
 
 found:
-	/* Include the IP ID check below from the inner most IP hdr */
-	flush = NAPI_GRO_CB(p)->flush;
+	flush = tcp_gro_network_flush(p, skb, skb_network_offset(skb));
+	if (NAPI_GRO_CB(skb)->encap_mark)
+		flush |= tcp_gro_network_flush(p, skb, skb_inner_network_offset(skb));
+
 	flush |= (__force int)(flags & TCP_FLAG_CWR);
 	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
@@ -242,17 +298,6 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
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
-
 	mss = skb_shinfo(p)->gso_size;
 
 	/* If skb is a GRO packet, make sure its gso_size matches prior packet mss.
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index db7e3db587b9..8bf93a0e9669 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -291,19 +291,8 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
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

