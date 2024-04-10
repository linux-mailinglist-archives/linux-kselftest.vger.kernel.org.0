Return-Path: <linux-kselftest+bounces-7572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8646589FBBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E771C22B63
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFA5174EE0;
	Wed, 10 Apr 2024 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzBCYgFT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF116F0D8;
	Wed, 10 Apr 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763340; cv=none; b=bs4eMYIeaqOY1jrIA9EB2P790FtFzkOeiPz2sy2YahXP+2mj61lNs2a7+MjhJ/Wj+y45GjzT7PUza8+4eZ5ptdxB9BVrYNtNSseg0/H7KLPTcFh7WOSnZV9HRJCjRg4BEaV7NR/eqFK8/TZzFZfy/rgG5iLwH9oVxKjiWdWRyc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763340; c=relaxed/simple;
	bh=pD4qzKqcpUuSaHV7ouYV9btcuo6kjLpBp9xdnY0xgig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gecIRqwSvRkTRBMZocWyQIJfytsByxplMEYC2A22BB2WWNBrTovLTD7m82QxHU9bLsD8asC4uC/QVFgjnowEl/pQUFDkz4gMWLvuiq9yXyAHjjgHaEaTlKcPx8USSjKIsyYZMi4a7LVQMihv1ANsEp2jhrbtFQOoVA04IYb06Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzBCYgFT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-417c5763d3fso2136175e9.1;
        Wed, 10 Apr 2024 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712763337; x=1713368137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4x4IBe/lFW1aP700dLN9QduvfOFnUhVQ5zJ3YbImhg=;
        b=YzBCYgFT8Rgew9SntbVqNCtr9z0aEDyrOmJocber1OxsK3bbR2VWqX06uNeEkvvtM9
         6Iq4q+TpHEL91sNXx6YRE45YhJTu5u3m2jf6iAyl7PF8I5FnAYvUtuyfIZ7ZF181gdes
         VtUs+9vGBx1izb3UwTUeZ1b7kN1ormIghM5QlxTJOlrtzV0j7XItJ6TtKNBfZTaj2nCp
         nF36CFW/sFUr5FG2OOuyjdAo5xfvSosPFuL/u9p1NVmuaOp/eUGTn2gp+llEkDk4AocV
         wLhAN3ZX1Bj7zSQEWrXMfrnp0iZ3p+A0emQ71Z0okm6TqKC/9SGJVuca0avJWYCy6+kD
         y6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763337; x=1713368137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4x4IBe/lFW1aP700dLN9QduvfOFnUhVQ5zJ3YbImhg=;
        b=gylwuf9i4ciLY0khRpJrnXMn8Dq2E8zWW1DiPDH9oPmOWuXgx2JMGtVaYiNw1oFAyw
         X6kDVQijg/7R+dzmJr7EAftYWzirsAOHukT6tv+NArk6iv0CqmSCE1W7KuIlckCOrmXO
         PfCu1n3Hb7qEppbPSSLEG5Zin163T6q7zydsqoorqZvKXXk+CbW/BZ9G7eAz5Fw1riNH
         hnddw2p8OXTUY7pvRUc9JFN1zSDjp+s89Qg61g6rbyYtmpu1iLI7jUl/PDbMh3t3C4RK
         FbsYbt5n+661tq2px8ArU86gh9rV2AiEQQJNdwveClQMTM7+yn+RiipECx1r546YOVVP
         9xEA==
X-Forwarded-Encrypted: i=1; AJvYcCU44n1kxE4N8j5U3SIdZ3eb7WNoC0i1Oc7p8lViakFjh+Kp3QygT/M7tXikuT47hGp/GKNvi2/aremdR9TLiuabY7mWix47h9GvlVr34di1SJLp5n6p/WVFk+/Z6+gk2Bem4SKFcWHSkQLF3icDnVmJbMmGfyMPiE4w+s2c6JIe+HuIPWVQ
X-Gm-Message-State: AOJu0YzWRTEt86zjA1NZQnHuOIqpQiM3p0yrqcf1UcinC4YZBiXKnA3B
	pfH6dzSKxS5KmzMSE75gqrEPSdlMzNv6kOGKeLgAcyJGo58pLqbm
X-Google-Smtp-Source: AGHT+IHoqFgdZSiILnYwhl9dCzr/qZl4oRB6baJ8FwkK1pf+Jc3CknSdJ+abTMN289u4B5jcrOJwoA==
X-Received: by 2002:a05:600c:a4b:b0:414:726:87d9 with SMTP id c11-20020a05600c0a4b00b00414072687d9mr2852609wmq.12.1712763336943;
        Wed, 10 Apr 2024 08:35:36 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b0041632fcf272sm2630547wmq.22.2024.04.10.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:35:36 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	dsahern@kernel.org,
	aduyck@mirantis.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v6 4/6] net: gro: add {inner_}network_offset to napi_gro_cb
Date: Wed, 10 Apr 2024 17:34:21 +0200
Message-Id: <20240410153423.107381-5-richardbgobert@gmail.com>
In-Reply-To: <20240410153423.107381-1-richardbgobert@gmail.com>
References: <20240410153423.107381-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds network_offset and inner_network_offset to napi_gro_cb, and
makes sure both are set correctly. In the common path there's only one
write (skb_gro_reset_offset).

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 drivers/net/geneve.c           |  1 +
 drivers/net/vxlan/vxlan_core.c |  1 +
 include/net/gro.h              | 18 ++++++++++++++++--
 net/8021q/vlan_core.c          |  2 ++
 net/core/gro.c                 |  1 +
 net/ethernet/eth.c             |  1 +
 net/ipv4/af_inet.c             |  5 +----
 net/ipv4/gre_offload.c         |  1 +
 net/ipv6/ip6_offload.c         |  8 ++++----
 9 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 9c18a39b0d0c..a6256ea1f5bc 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -545,6 +545,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 	if (!ptype)
 		goto out;
 
+	NAPI_GRO_CB(skb)->inner_network_offset = hlen;
 	pp = call_gro_receive(ptype->callbacks.gro_receive, head, skb);
 	flush = 0;
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 6fb182d9d6e7..9fb93c3953c1 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -754,6 +754,7 @@ static struct sk_buff *vxlan_gpe_gro_receive(struct sock *sk,
 
 	vh = vxlan_gro_prepare_receive(sk, head, skb, &grc);
 	if (vh) {
+		NAPI_GRO_CB(skb)->inner_network_offset = skb_gro_offset(skb);
 		if (!vxlan_parse_gpe_proto(vh, &protocol))
 			goto out;
 		ptype = gro_find_receive_by_type(protocol);
diff --git a/include/net/gro.h b/include/net/gro.h
index ebead1d642b4..a1cc8e8c2ebd 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -87,6 +87,15 @@ struct napi_gro_cb {
 
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
@@ -172,12 +181,17 @@ static inline void *skb_gro_header(struct sk_buff *skb, unsigned int hlen,
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
index b129cd201937..b2156e6cc4ad 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -371,6 +371,7 @@ static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
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
index 5a747d91cd0a..6546bf376b24 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1568,10 +1568,6 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	NAPI_GRO_CB(skb)->is_atomic = !!(iph->frag_off & htons(IP_DF));
 	NAPI_GRO_CB(skb)->flush |= flush;
-	skb_set_network_header(skb, off);
-	/* The above will be needed by the transport layer if there is one
-	 * immediately following this IP hdr.
-	 */
 
 	/* Note : No need to call skb_gro_postpull_rcsum() here,
 	 * as we already checked checksum over ipv4 header was 0
@@ -1597,6 +1593,7 @@ static struct sk_buff *ipip_gro_receive(struct list_head *head,
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
index 10ddbbc0e46d..ba41939537f2 100644
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


