Return-Path: <linux-kselftest+bounces-6586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A71988AEA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4432E26B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B1D12AACE;
	Mon, 25 Mar 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+ABMuRo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD3B12AAC5;
	Mon, 25 Mar 2024 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391234; cv=none; b=LFhtXS3UtUOGJrIQFu8BJSCrOPU1RTMvCyTl5d0UZ73BO2dFlbKFP+v6nbEfBT4O5LBN4OLEUszk31P0DsD65mbbn/2p9SFCBuHjYB0HSBzzOKcbfvCCayY3lV4OYBWHRanFs2eeNCTg/FaTWoZb9L5Gyk3B8HWbY+HwxaA38l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391234; c=relaxed/simple;
	bh=ol63l56YFab5jFd2pzaUDz5aILsGrOUw1QWgI2eJtXc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UKgFEHcPJF4Y+KtzhTcOs5gvV70XzBzJUc/m0unG1kCrdYM9xNseVnXi4kELenatNDMrjrC1EVo26HC1mWrtmuWcaafeIkXwvzC1VqdgFZneM8bybt6xJqsqtYrZJYwTX2k0c2yTqt05tlZuuhL9f1F1BQnMWAiqvsM3DYKbyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+ABMuRo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34005b5927eso3260234f8f.1;
        Mon, 25 Mar 2024 11:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711391231; x=1711996031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBXASsilwyOlY1A3LxWDSzKvFd+WPeU0u7F86czp8t0=;
        b=X+ABMuRoetGeAwyx6yF7j7Ycfa41HOGdVGGRhu16Wtxvp8ZpPVefHVgUHId4Jpjm4M
         eKfZAL3jbIaY/r2eaKiHmyeThKI8YNDbAugzKUOsd+7BYBOtNd2jIrrWSo7JC02G3IeJ
         oClNCt5LmIgitdkHYe0oEg/U9wfn0rxaWx71FK+jNIpInNFKUUsvUpW91BncrWSaJort
         t9doxvkkfRHg9xAaLFWM2YSFbaEfXOZyIb0RmfcPR93E+Mq75UBZRCxsLY2REJNVkN/b
         ns9zErrLM9ZVeQCwuxqQ8iCoNc/d6d4HTUAAUWRWxb8wOHvIIIju67CGhThUHQWpHXt8
         StLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391231; x=1711996031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBXASsilwyOlY1A3LxWDSzKvFd+WPeU0u7F86czp8t0=;
        b=wq4QWS8SnczQjO8rlQOc5ZHM+qGKhlj0tWb+imdMYSXVUe3dPw9yOcKW0CQ+FzfLN1
         /NdrbI1zjeCF7JQRSqQSSLS6iMs3D6rVqzgAWnYwHM98C1euncyl98JaTY2pYTTdwwEJ
         9UGButkLHVK1hQVD3+AydpHeRWz8K/rcQyBqSIqtpRMPxqgWNa6H844z0MRMtf60+U71
         wV1pnyO+2DWrKE7PkSPPHR+CHXKUoByegR+OaEk4EqObrMBUiDq/9Nbh0NRKXRYzPlxg
         uciiZowt20QxosLH6dD7UsUH7QtY1seNUpRaGT+Qzl+IZKW6gV0lks8ctHS0lN2BqOMn
         Y7+w==
X-Forwarded-Encrypted: i=1; AJvYcCULoKUs0EI2wwr0pJB1AkMdn5AayqRJzyDbLgyeFc4T3eRaSiYioGBWy1moYbZErBd7RfMmjJmkoDOo+igpxI9dltscyk8jnumZUr7+nyQEtNuPx+sDB7HyMyot90RjGbRNts2tkBIqHEgxNznwH5glcSUG3lFahGNcqzRhXcZlvu7q9skv
X-Gm-Message-State: AOJu0YwiuERKMvqJNzfMp4PHfsb4VjryofjfLXo/WdqSR5dN+s2b9blT
	uWfA4F8isQ4AKQ3+Iy2VGzyK4Lqm+F71L5DEnNgJFE7olJpcl7qR8e/bRbgO
X-Google-Smtp-Source: AGHT+IHAwZM84P0EZcMZOE2EPPGUfd4dw/SoraYIoP2PZ8tRd+lPJP+2k5AxQoFxglXHWnRvjnfZpg==
X-Received: by 2002:a5d:4246:0:b0:33e:9b42:ba5 with SMTP id s6-20020a5d4246000000b0033e9b420ba5mr4897466wrr.17.1711391231016;
        Mon, 25 Mar 2024 11:27:11 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id n10-20020adfe34a000000b0033de10c9efcsm10111989wrj.114.2024.03.25.11.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:27:10 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/4] net: gro: add {inner_}network_offset to napi_gro_cb
Date: Mon, 25 Mar 2024 19:25:42 +0100
Message-Id: <20240325182543.87683-4-richardbgobert@gmail.com>
In-Reply-To: <20240325182543.87683-1-richardbgobert@gmail.com>
References: <20240325182543.87683-1-richardbgobert@gmail.com>
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
 include/net/gro.h      | 18 ++++++++++++++++--
 net/8021q/vlan_core.c  |  2 ++
 net/core/gro.c         |  1 +
 net/ethernet/eth.c     |  1 +
 net/ipv4/af_inet.c     |  5 +----
 net/ipv4/gre_offload.c |  1 +
 net/ipv6/ip6_offload.c |  8 ++++----
 7 files changed, 26 insertions(+), 10 deletions(-)

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
index 167935396c50..7c468ed805f4 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -370,6 +370,7 @@ static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
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


