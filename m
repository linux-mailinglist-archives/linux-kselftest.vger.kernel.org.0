Return-Path: <linux-kselftest+bounces-6587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D44E88AEA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11BF1C26F65
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C0212AAF9;
	Mon, 25 Mar 2024 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv7vYH+6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBDB4779D;
	Mon, 25 Mar 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391244; cv=none; b=i8dMGc7pym4hG3/4OOe+W9G658hzvi+d4KXOo+uRpe5mhVtHJ3PqesQo/qrtaaTJChXReHv47F+nN7zzoMslr85cTVn3i1mN4QHlwJfQpaMc3Ys1sapdEmqOP7uEEyH7f6pofaf1nE+bbXDSFm/1NjPy6b+sbUpqb4nBxIAdHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391244; c=relaxed/simple;
	bh=zPeew8jBAPw+CqVIPr+fTbu7R6EL+mUFdchKxCVilOk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ct/dvINXpojnxbiHgkgJmQ2p1Z7oAKr5mfcvW9OqR3IYO8LAW4xRn5srVmbl3pYigEJOPbx/P0D2LOrfqw6Hq70QG2+1tRNj5SB/0tT5j4zAJYmeEAUVGpxaajDr/4g7Wx/Hb5xgq6CNOlYQPM9NwJxFLtXpxzE7nwkuncXWK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv7vYH+6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41488e17e1cso6985135e9.0;
        Mon, 25 Mar 2024 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711391240; x=1711996040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BZhEnyWpNsK0BBdDmmAssPA7emcAcdAM4PGsihwRu0=;
        b=hv7vYH+63RlV217RakwJg4Nnv1Fn81qaGwMX3/FQVOic1lGAIsCWapp+DWwVrRP1ns
         emZl8lO8fRs66BCxS1foW837jGL7qJiAHGTrg0HA7jVJfMuLzAat2hQ3qTrthWKwgLEZ
         Ok/qxe10ltscJ0766oDM9Dh0uWXWyk7Ck+XrByJFavvNCjJot7eDtLC8IZK9r0D+xloH
         0lWkVhjh5ODI6jEhsc05QepRUGOEZ9maoAP5N+1UEl6vz9XM3+wiP+IREXvHRYi3ZCTC
         OqgxREnEuvjAa9rl8CbL78ImJDV1+4Prf2ZQYtCSgTg6Ws+rLte4+7Nq9pU7K0ukDGkm
         l9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391240; x=1711996040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BZhEnyWpNsK0BBdDmmAssPA7emcAcdAM4PGsihwRu0=;
        b=d3/0ej51MKF0dNtCnx5ZNOdoOl6dNd8m2C4d/UZ5tdiHNupcz/bIbAHq7JkFUlBQrS
         5hi41x6dYoOMQOelQg2Phy97eKVtmowACqtf4U6gjlIUL/gr76NGvalm7tCMxjWSgk6t
         sI3JIRXyuRzrpg10sJ8QW6ZrEdCkQlME5T8GutyfDSjVIuPiRPeninwU1e9Fd4kuSeof
         gruJXyrRS/aSaxVthfhHgYBVNXAHsV8qDSJqFGl2oc4uPxEb3SUW0tVuaj0NoLi0aPtD
         ulHZQDeMKQu0OKowl3CuUoJ/HCZL+Iv+kXyS8puTMTdM0kGiBJ9rE3wHt3s7tOjhlH3k
         v4tg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ+hM7zvLDNSPHiUmLhRGHBo8yoDpnJTXjZW11C/ZtaWksyEH5dY2h+VtX+4sqBym/Ng8NlVS+dhSRe39KbqBdMMYouPtmiH5qRWibQIsDc+Z0N/EVYpCIh2PUNSUSdO9UBtKfuMTlLnm+cYhmmNnNUHlzyMABKt6FsqxCP0mXKsf0E4qj
X-Gm-Message-State: AOJu0Yy5uYjXfKpPcAihbcs9DFfoaGDhOFWJbXs5Ro+v0UPnw3er5PR4
	pWdlwlDabJa08J/SUZsOSgUMSJt71LjSBhUhgQ/xxt6tAAqMRTIL
X-Google-Smtp-Source: AGHT+IGw2FyfG4pSRuTSSctf5dkimTl69ohf54hrclbjflJbxFgzV67IYwdAtL3tkviQC/nF97DVjQ==
X-Received: by 2002:a05:600c:5120:b0:414:65cb:7e99 with SMTP id o32-20020a05600c512000b0041465cb7e99mr309841wms.26.1711391240337;
        Mon, 25 Mar 2024 11:27:20 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b004147b5dd6f8sm9258475wms.9.2024.03.25.11.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:27:20 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	dsahern@kernel.org,
	xeb@mail.ru,
	shuah@kernel.org,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	petrm@nvidia.com,
	jbenc@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	liujian56@huawei.com,
	horms@kernel.org,
	linyunsheng@huawei.com,
	richardbgobert@gmail.com,
	therbert@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to tcp_gro_receive
Date: Mon, 25 Mar 2024 19:25:43 +0100
Message-Id: <20240325182543.87683-5-richardbgobert@gmail.com>
In-Reply-To: <20240325182543.87683-1-richardbgobert@gmail.com>
References: <20240325182543.87683-1-richardbgobert@gmail.com>
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

Levaraging the previous commit in the series, in which correct network
header offsets are saved for both outer and inner network headers -
allowing these checks to be done only once, in tcp_gro_receive. As a
result, NAPI_GRO_CB(p)->flush is not used at all. In addition - flush_id
checks are more declarative and contained in inet_gro_flush, thus removing
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
index a1cc8e8c2ebd..73e266194528 100644
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
diff --git a/net/core/gro.c b/net/core/gro.c
index 7c468ed805f4..f8cbc08197f7 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -329,8 +329,6 @@ static void gro_list_prepare(const struct list_head *head,
 	list_for_each_entry(p, head, list) {
 		unsigned long diffs;
 
-		NAPI_GRO_CB(p)->flush = 0;
-
 		if (hash != skb_get_hash_raw(p)) {
 			NAPI_GRO_CB(p)->same_flow = 0;
 			continue;
@@ -470,7 +468,6 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
 					sizeof(u32))); /* Avoid slow unaligned acc */
 	*(u32 *)&NAPI_GRO_CB(skb)->zeroed = 0;
 	NAPI_GRO_CB(skb)->flush = skb_has_frag_list(skb);
-	NAPI_GRO_CB(skb)->is_atomic = 1;
 	NAPI_GRO_CB(skb)->count = 1;
 	if (unlikely(skb_is_gso(skb))) {
 		NAPI_GRO_CB(skb)->count = skb_shinfo(skb)->gso_segs;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 6546bf376b24..9d7fd79ee915 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1513,7 +1513,6 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	list_for_each_entry(p, head, list) {
 		struct iphdr *iph2;
-		u16 flush_id;
 
 		if (!NAPI_GRO_CB(p)->same_flow)
 			continue;
@@ -1530,43 +1529,8 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
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
index a63af9a6b0f7..ed9947bb903d 100644
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
+	 * an incrementing ID.
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


