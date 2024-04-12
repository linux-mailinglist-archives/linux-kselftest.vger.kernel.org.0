Return-Path: <linux-kselftest+bounces-7812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075208A32EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885F81F218E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7DC1487F4;
	Fri, 12 Apr 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgRQyAqu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72885C52;
	Fri, 12 Apr 2024 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937383; cv=none; b=j0kPsJJsCpOGNajVu2Wo4ICmny08UMF35pxkzED8AFipD3lVEBwQltoZjwR+pOJXpvKeh4hIZPxQWT60uC2U2+BAwDBPVaAL79g8rAGYs100dLjliNhscdmUuHD2RgQ1Mo8BQ19tRnh/xRq1zw/jwBs0JG0sVBW+N2W3jHVyWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937383; c=relaxed/simple;
	bh=pD4qzKqcpUuSaHV7ouYV9btcuo6kjLpBp9xdnY0xgig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C757NbVROWKguFShnbmPdwi3cdmLvjf+Gi821IyM0fNxNnN3u+KJdH5MU4FarP48jBgpbkBpX93v1H1SDQs4oXIKItFRvS7vF6ozSBbc6pZsz4pZO9wMcfiSRDPLGYSc6+ape9nIRK6eOOcP9+1IhpcsxaBObTQi/WhDYJvsk3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgRQyAqu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-346b09d474dso967550f8f.2;
        Fri, 12 Apr 2024 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712937380; x=1713542180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4x4IBe/lFW1aP700dLN9QduvfOFnUhVQ5zJ3YbImhg=;
        b=cgRQyAquDy7WT3KhkPrkCFETbSQr0aOJufiFmzo/CjpUgvQsywCOkT3JY4CqLM81j8
         8ajd05Rz7DOWxf78xkAFVtOwA1yHGZ3JjBOKXDTPhWUrxkiA3zpc/ua1uzKfKbc51//H
         HajE6b3JPi9E5+PkcL3GhaNQZzKhufe2X3k5QlFkSjlk0Cyf2seynDO5k4HawcqycZBI
         novaR021sqD//FXTud8oVbTcHLCCGhMp0GPD3xRZflAZ4cQGEtwNe9S+7Ji0qIh86DfC
         S9DuN0i+GdfxtuP/l9hf6F4cemYLjFjt/TorbXy5ix2x5W8ITaz6UDYpvt7xl+F6tgTc
         cKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712937380; x=1713542180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4x4IBe/lFW1aP700dLN9QduvfOFnUhVQ5zJ3YbImhg=;
        b=ldUgDGLx+S6DehhXR5pNEKJ6dDfWnlstCLHcLlgGaijJvLprNvL20l/SW64t3jelQO
         G5NuTsH5S8tr9IFsnem7uX59yBNbHSa6M9e5vXi3HQhXRWLEQ7rnwGZmOlkdH0LHw/6c
         pXYqfUryC+2KPZ1zz91R2mQcQ3ATRRNntyKjqIhdCWh82NrUNgmvLEgO9iYGzm8A5ARo
         C+0qc2KrETmhkSdnSCRecLETm9Zz/UM55DecwsCOdri8F7GaoA7/u5WJU3NUGIuD93Wz
         QBbsOYyiSdafgB8Wjr6zIeRLUgQVpBuEefRQ+pP12VReNkjXp3d4rbmKwUYG+J1Z5Y36
         /Ybw==
X-Forwarded-Encrypted: i=1; AJvYcCUdSohA+mW9WhVG4rtd3HS5txBe1KQAHbmvEN6uDdO31uCKsBQieGIpMaLNKHLYHAZlnf5+LXYZqHxazeGjDaXSxuAeygidmRZUBeTpLJACBTiFrlaOWq02K9TFvX1O+unFTcDyjAvnNM1L/ei0iW7WDVQsTueYRKxqJK60gBxSsRih2Iwo
X-Gm-Message-State: AOJu0YzCq4eNDa1MG3HiRT/3zeJdTe34KGQD3v1I+oL+/QrDAhhcuCd8
	s7B2mCFZpzJWQQl7SGOhT/BpRm8kdz7aOjsA0lxZvG8ePG1n5WSJ
X-Google-Smtp-Source: AGHT+IFXJ+6cYb43EVXQiPNLfQN7kIN9J7biAWRvskbgVz2UdAWbSgp1Dm2imUE5CFFg3v43VRt1Dw==
X-Received: by 2002:a05:6000:178e:b0:346:f800:b7f with SMTP id e14-20020a056000178e00b00346f8000b7fmr3004539wrg.7.1712937380365;
        Fri, 12 Apr 2024 08:56:20 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id x11-20020adfcc0b000000b0034658db39d7sm4560461wrh.8.2024.04.12.08.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:56:20 -0700 (PDT)
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
Subject: [PATCH net-next v7 1/3] net: gro: add {inner_}network_offset to napi_gro_cb
Date: Fri, 12 Apr 2024 17:55:31 +0200
Message-Id: <20240412155533.115507-2-richardbgobert@gmail.com>
In-Reply-To: <20240412155533.115507-1-richardbgobert@gmail.com>
References: <20240412155533.115507-1-richardbgobert@gmail.com>
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


