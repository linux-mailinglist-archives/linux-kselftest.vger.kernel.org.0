Return-Path: <linux-kselftest+bounces-6143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7D78771F2
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 16:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41F41C20863
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 15:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EDA4437B;
	Sat,  9 Mar 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvdMfDsA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE440873;
	Sat,  9 Mar 2024 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709998400; cv=none; b=aY4UcuvVzlyFcMvHkEa9EFoeN0tE7nhDjVONcEAMMa/G01cpz+SShi73ua89WE+DP3ud71+fjDgAySkffRKkenHARB2Kp3N26k6/WpODZgjMrAZ4Pct8jTv6jYz8o3zHH3GSX5XxuE9v0+s/WECEnWFhXrJbS7mwowBkmIM7gcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709998400; c=relaxed/simple;
	bh=NWI9PpDu0ZBdVdr6GBiwJZy8aM+aUEyWsnarZ/YDbJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qkeTercFgcRJXKJlubkXazkCF1Lhu4brgq+zGwv1A8Bjf9kYLplMGtyeALiwdrF/KRBrMjGq1IMgzoiIgBap1uXwrFsiLxI5a/8yN1aBNmQubKom0c6ZNK2q/ASzzdQHiBUZon40PM0L6yhebZd7HodCvQ+OIoo7rp28xMRdgro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvdMfDsA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d6f26ff33so2083492f8f.0;
        Sat, 09 Mar 2024 07:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709998397; x=1710603197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIr9SvtFFnceHI9eN51NyJQH4qfpwTvPm7+BU/JL5KE=;
        b=CvdMfDsA6qyruhj5A2eeOr6SPq7/50UGOoyFPT7W8kKWIrY0x6Pv+JAxqitwKyOgRt
         S3x3dRwEeQZMVflXfRb5Yco8YqDMIqWzJStMJbEnsrpKFuWkSSvbo8w9DzK6stLJr5SI
         uKwFelQ2mKXjHj940VG3bhiTs9zoWNN5ebMuBkS8rYYt5tq2goP4i2tbnegS3fL568Vn
         JDvkF8MI700PNK8zRAYMwOd3TcQzsGRfoBPD46vebUXzYBFugmMfXk7WqnppxhXrNMPl
         EuVFLPrAtXOmNZpstV0t5kkGOYvnvWC8hIXErXVUzJQv/8cmFIjLe8AyhTur8zf1hAvh
         KX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709998397; x=1710603197;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lIr9SvtFFnceHI9eN51NyJQH4qfpwTvPm7+BU/JL5KE=;
        b=UQfuo/ZPoIeGExDoWZ++DV7erRJuQQ6zWQgsL1slcQqVr2iuoqvWfH2pJDx5bxdqOG
         MBCecPHOweYKGFON2857R20hMRNHlIGJuvPE9JKr61NjdXi0jTeuq+xWwvUYMLl+uQYv
         Fx6cQ1kdH7BBwhyf/9ahdA04gAU7rBqPpXnu1d+GlZT5jbAg6PuTO7Nu8VbI/qvjvWag
         jQrdUuyzJ/gG/DnypHTE9KyLaysRsUbvlwOLa+0eRljXt0fHWEkHT5SqcjbdOWVXw/jG
         spg2+ZmkeznWnRJJw/L8RZY7XyL+z0A/Z0ENg8ur4tvxd/D1RPzEBryoZkag/buzsEbq
         V9Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWMSFL+BDOAKO53uG8VsXnmYgGqA0n9CBq92g+5Ie7KepHLSpfOZHpVv2EE7O9qedvSOt2EkNQk+7CC0AkhiW7RBgSP95GZTWo/rNYX9ODhWZThqBIQ0Pd5WkNa1ZS7wProhj1C+7xO9wBtEsIV469+rd4hRJQOC9vMyM2R7eyJneHgYuVo
X-Gm-Message-State: AOJu0Ywh2cQzELZZ6uhECzqrUw6EeND9tZShUxXWXHA2sxdf5V7WqyY7
	TlHn9paUZoyicRhGKSV6XtgGJLFYBcYvekXvna6egv1VaxiQ/35V
X-Google-Smtp-Source: AGHT+IHWeztmxaU/p7o0jn7d12aCnejK8hkIzZPOPvUZjqouwxo8u2IwiFbvIrh/hcUO40KA5+cKHg==
X-Received: by 2002:a5d:5704:0:b0:33e:737c:792a with SMTP id a4-20020a5d5704000000b0033e737c792amr1390505wrv.68.1709998397013;
        Sat, 09 Mar 2024 07:33:17 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0041308e57a28sm2879463wms.23.2024.03.09.07.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 07:33:16 -0800 (PST)
Message-ID: <6868adc7-9004-42c1-940b-cc230a65a39f@gmail.com>
Date: Sat, 9 Mar 2024 16:33:01 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next v3 3/4] net: gro: add {inner_}network_offset to
 napi_gro_cb
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

This patch adds network_offset and inner_network_offset to napi_gro_cb, and
makes sure both are set correctly. In the common path there's only one
write (skb_gro_reset_offset).

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h      | 18 ++++++++++++++++--
 net/8021q/vlan_core.c  |  2 ++
 net/core/gro.c         |  1 +
 net/ethernet/eth.c     |  1 +
 net/ipv4/af_inet.c     |  5 +----
 net/ipv4/gre_offload.c |  1 +
 net/ipv6/ip6_offload.c |  8 ++++----
 7 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index cb7282bf3d63..9d1389269509 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -86,6 +86,15 @@ struct napi_gro_cb {
 
 	/* used to support CHECKSUM_COMPLETE for tunneling protocols */
 	__wsum	csum;
+
+	/* L3 offsets */
+	union {
+		struct {
+			u16 network_offset;
+			u16 inner_network_offset;
+		};
+		u16 network_offsets[2];
+	};
 };
 
 #define NAPI_GRO_CB(skb) ((struct napi_gro_cb *)(skb)->cb)
@@ -171,12 +180,17 @@ static inline void *skb_gro_header(struct sk_buff *skb, unsigned int hlen,
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
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index 247704cf70af..355cafe23329 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -478,6 +478,8 @@ static struct sk_buff *vlan_gro_receive(struct list_head *head,
 	if (unlikely(!vhdr))
 		goto out;
 
+	NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = hlen;
+
 	type = vhdr->h_vlan_encapsulated_proto;
 
 	ptype = gro_find_receive_by_type(type);
diff --git a/net/core/gro.c b/net/core/gro.c
index 7da3df2c634f..2b42138f816c 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -373,6 +373,7 @@ static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
 	const skb_frag_t *frag0;
 	unsigned int headlen;
 
+	NAPI_GRO_CB(skb)->network_offset = 0;
 	NAPI_GRO_CB(skb)->data_offset = 0;
 	headlen = skb_headlen(skb);
 	NAPI_GRO_CB(skb)->frag0 = skb->data;
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 7515e6bcbb7d..e3eca605bcc7 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -441,6 +441,7 @@ struct sk_buff *eth_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	skb_gro_pull(skb, sizeof(*eh));
 	skb_gro_postpull_rcsum(skb, eh, sizeof(*eh));
+	NAPI_GRO_CB(skb)->inner_network_offset = hlen;
 
 	pp = indirect_call_gro_receive_inet(ptype->callbacks.gro_receive,
 					    ipv6_gro_receive, inet_gro_receive,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 9334b563a88b..c6bb21c27aee 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1567,10 +1567,6 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	NAPI_GRO_CB(skb)->is_atomic = !!(iph->frag_off & htons(IP_DF));
 	NAPI_GRO_CB(skb)->flush |= flush;
-	skb_set_network_header(skb, off);
-	/* The above will be needed by the transport layer if there is one
-	 * immediately following this IP hdr.
-	 */
 
 	/* Note : No need to call skb_gro_postpull_rcsum() here,
 	 * as we already checked checksum over ipv4 header was 0
@@ -1596,6 +1592,7 @@ static struct sk_buff *ipip_gro_receive(struct list_head *head,
 	}
 
 	NAPI_GRO_CB(skb)->encap_mark = 1;
+	NAPI_GRO_CB(skb)->inner_network_offset = skb_gro_offset(skb);
 
 	return inet_gro_receive(head, skb);
 }
diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
index d4520c3f7c09..ae596285d78c 100644
--- a/net/ipv4/gre_offload.c
+++ b/net/ipv4/gre_offload.c
@@ -224,6 +224,7 @@ static struct sk_buff *gre_gro_receive(struct list_head *head,
 	/* Adjusted NAPI_GRO_CB(skb)->csum after skb_gro_pull()*/
 	skb_gro_postpull_rcsum(skb, greh, grehlen);
 
+	NAPI_GRO_CB(skb)->inner_network_offset = hlen;
 	pp = call_gro_receive(ptype->callbacks.gro_receive, head, skb);
 	flush = 0;
 
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index e3a05b84c76a..d9d3a6bed510 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -67,7 +67,7 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
 		off += len;
 	}
 
-	skb_gro_pull(skb, off - skb_network_offset(skb));
+	skb_gro_pull(skb, off - skb_gro_network_offset(skb));
 	return proto;
 }
 
@@ -236,8 +236,6 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 	if (unlikely(!iph))
 		goto out;
 
-	skb_set_network_header(skb, off);
-
 	flush += ntohs(iph->payload_len) != skb->len - hlen;
 
 	proto = iph->nexthdr;
@@ -259,7 +257,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 	NAPI_GRO_CB(skb)->proto = proto;
 
 	flush--;
-	nlen = skb_network_header_len(skb);
+	nlen = skb_gro_offset(skb) - off;
 
 	list_for_each_entry(p, head, list) {
 		const struct ipv6hdr *iph2;
@@ -327,6 +325,7 @@ static struct sk_buff *sit_ip6ip6_gro_receive(struct list_head *head,
 	}
 
 	NAPI_GRO_CB(skb)->encap_mark = 1;
+	NAPI_GRO_CB(skb)->inner_network_offset = skb_gro_offset(skb);
 
 	return ipv6_gro_receive(head, skb);
 }
@@ -342,6 +341,7 @@ static struct sk_buff *ip4ip6_gro_receive(struct list_head *head,
 	}
 
 	NAPI_GRO_CB(skb)->encap_mark = 1;
+	NAPI_GRO_CB(skb)->inner_network_offset = skb_gro_offset(skb);
 
 	return inet_gro_receive(head, skb);
 }
-- 
2.36.1

