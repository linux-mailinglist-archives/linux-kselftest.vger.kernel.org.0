Return-Path: <linux-kselftest+bounces-7402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D6289C6CE
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8439A1F23D87
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 14:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35DF8662A;
	Mon,  8 Apr 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG+4oe3v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153586640;
	Mon,  8 Apr 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585941; cv=none; b=Dj5YwYAexcudfYB/y9Zp+sQ1AuG0sjyDvrkRQcicbVDdWpsnH7f/QALzHvRGFlxC2hvladd4xCV9wxIaVx9V0KJWsthN7B4RkUL/o2BL1SKH4jNYEUtSIqvYyI3VIeSjRCMMNSuvBKx1T+uk+F+cO+DwE3w5JOiIQH/NbQN8Skk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585941; c=relaxed/simple;
	bh=RBQp93NZ4OEckX6fz5oK+ftdX0xXnoCJ54hhn/l8+Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7fqBCAfG6ZbNHKRFwReDRvYRhXqbN8sk021dx527jphh16ccESMX8s3o/99shMqNj7T+xrZ01dv3E1Bry2oWMOMp6f1PPASgelCXNg+g+uMcfBanR1NjV2Xf1Ro/3PPqwp4U0s9VlB7yBpwwqfd3J4+fGqjB8jXnRD0cNE8wxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RG+4oe3v; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41649860cecso10125475e9.0;
        Mon, 08 Apr 2024 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712585938; x=1713190738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOPPw2ZfhS4uOREmA/b/YwD06mbwBoxHA5gZH2OlWrM=;
        b=RG+4oe3vrFfiCo7FX7WS0x1vFWUyHeOqRxneS8aiCB8Xrdvu9wgNxb4Yr33HBR0ZM9
         JsGY3fdG0Kx/0hvWJeLlWZwk1kL8w+jAbqAHPoeCp+FWK1vRSmfc41cnmfgscU0cNOai
         ss1iCT6pScX6FHRCiSPePPwTUm0ZiYTUi6i7H/e6bkPbf1x/7kUoXBB9ESgqx7aw1trD
         Fj1xjxFs+PZ9ji45MIAeX4ZBYph4/7lCytjZJVG07zDI3CJmM0DnkqRpxyhOH4Y4d5S7
         MYko6AhQr1JELuU3uCcv81nDdzECG8lTwIAUkuoa60VNXovgy0aYyrVl+v/BrI/AcAxh
         9NwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585938; x=1713190738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOPPw2ZfhS4uOREmA/b/YwD06mbwBoxHA5gZH2OlWrM=;
        b=qcOPaGtFDzgSFHM157wBptETngoF883wic0Y8eHVhAJ1ugmTbvVl4NNO6avOGk2mnC
         aYnbSHm2EFZvqLQzDmQ9cOTBZK9Zy+i5M4YyQtzAs5Iitw1Ig/NGDlnsJE6MjWpWq4v0
         THMzydLmaDMFAGG+fAj2nP9HUis95BgKvlQMxKE50aXvKVac/8XXhIvTPrII84R6JB8L
         irqelFZdoWYQNZJPjdRZzpvo8DsLkWrPXzW3oIW913ZibMdIZDVsCJADzFI0tNpShcgr
         aotTn590KK4CuH26tM6jGhJSpB63zqYf7oQjIStt9/emAzXVFuQzXwG/kJtb9Y3hwBgv
         U5Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWxjnh/HTUEs18Qjpo84iOJhB2JiiqgWytz9vT0CfZTD+YyDbcE3Tl1CKTPFZUUR/S1hVA5cJiVZWknMiPSg87Acpzmpy6BGN3PuoFYOIgDubTzg4xT2kOSKC449laZHofNjdRTEXrk9fNqSsi1d/kJQD2zipAOfUD1xPP7i0TsrG9sITRq
X-Gm-Message-State: AOJu0Yx71j74Pf2fhL0t2mgsDFfvaLk9Wfy64c4hbfiuPw2aB+tqjgSw
	lQDY3qMOWIIuKMUtnZ5dxnEzUPpaXfK4hTuJcmHuBDxFx/etm8TB
X-Google-Smtp-Source: AGHT+IG6YVmoN466QY3gWW/KS21JRE4e36u+ZtHqAXVAcLDL4B5Gao6B19nDkxFJTRXWoF15rq52rA==
X-Received: by 2002:a05:600c:19ce:b0:416:32b8:8f3b with SMTP id u14-20020a05600c19ce00b0041632b88f3bmr6693729wmq.17.1712585937994;
        Mon, 08 Apr 2024 07:18:57 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id bi21-20020a05600c3d9500b0041673efc980sm3489059wmb.4.2024.04.08.07.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:18:57 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 4/6] net: gro: add {inner_}network_offset to napi_gro_cb
Date: Mon,  8 Apr 2024 16:17:18 +0200
Message-Id: <20240408141720.98832-5-richardbgobert@gmail.com>
In-Reply-To: <20240408141720.98832-1-richardbgobert@gmail.com>
References: <20240408141720.98832-1-richardbgobert@gmail.com>
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


