Return-Path: <linux-kselftest+bounces-2563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09868821C86
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 14:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5B41C22002
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6DEF9FF;
	Tue,  2 Jan 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdl2jTYv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735AFBE5;
	Tue,  2 Jan 2024 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-336897b6bd6so9267405f8f.2;
        Tue, 02 Jan 2024 05:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704201904; x=1704806704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B6O9NOwtuteIYyicF8P0HuZgF44ilFnB7nwaX+Y1Si4=;
        b=Wdl2jTYv5SVXCDyZRPuTGJ87iDvWpzGLugZFQrhtzIIp+yZlCMtQT1amqsDFfXBU7R
         2pdXcy/ctCXX1mOu1OzHmcnKDS0JurhG2uVzEvwPqmLHWp5EDX/eWqpGJXOo8Dh2owPB
         /E5phEb/mOp+fJ++yGevE8WW4pDQzVwa3q9edzLe0nzDVMCeyFKipqDYaM9LLTbDhKDZ
         o+fXSkv27cjGVfB0d1UzcXYvhbyTgBnUD40WRezaJbbs7qMg6l07EBG6T+hUte0Hme5K
         zrmSkfJM/Yx4pDSIW0n6UBpXRlbsFM09xQwwl5n+nEOWKxFbfZs/EOrX6HB/tFexNILo
         CoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704201904; x=1704806704;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B6O9NOwtuteIYyicF8P0HuZgF44ilFnB7nwaX+Y1Si4=;
        b=AMnJv+rMZ7Z23wRqevRB7ufJbW1YXnauJI6jb6f6+or8aI51yluUOyXcl3atptdm7Y
         RALvJP8vIARo/f8A6R/I0mxJ5Gf7YY7/Hzkswlub1R2jYT5tsDtHQToe+D6BKkAKJFSD
         v6sF29GZtCwF8ftTUVXxymNrmFn6niRW3edNqwz2KgyO26OHRrhEKLfZLppcdZsBAQvT
         kvgnzUmWItEIPG0/CSC5UOuBye9Ftuj5BidYzWL1rUlAK7TjaihMtWetMj6KBfSJAEii
         Mtd/o03i0y0JXfULOFktgUQ4X8c2cDCiRmhQk5fjGS//dg4CABYJreazMEvoQG64uccg
         NXaQ==
X-Gm-Message-State: AOJu0YzyuQ+9jMAW5fzBBQAHumqDM3j2eWfpgJmOIq7+YRnin1KWLIfp
	zeKilBNK3KHEXVGbZ2KyQDU=
X-Google-Smtp-Source: AGHT+IHU+SO7b1fE1+XwQKpCy3gbwCpuSRN0P+3842bCNi2SaBuDV3wfdru03iIEALag45tVPEGY+A==
X-Received: by 2002:adf:efc5:0:b0:336:b52d:30cf with SMTP id i5-20020adfefc5000000b00336b52d30cfmr8039000wrp.61.1704201903880;
        Tue, 02 Jan 2024 05:25:03 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d650d000000b00336b702af06sm22777821wru.16.2024.01.02.05.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 05:25:03 -0800 (PST)
Message-ID: <90117449-1f4a-47d7-baf4-2ed6540bc436@gmail.com>
Date: Tue, 2 Jan 2024 14:24:56 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next v2 2/3] net: gro: parse ipv6 ext headers without
 frag0 invalidation
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <127b8199-1cd4-42d7-9b2b-875abaad93fe@gmail.com>
In-Reply-To: <127b8199-1cd4-42d7-9b2b-875abaad93fe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The existing code always pulls the IPv6 header and sets the transport
offset initially. Then optionally again pulls any extension headers in
ipv6_gso_pull_exthdrs and sets the transport offset again on return from
that call. skb->data is set at the start of the first extension header
before calling ipv6_gso_pull_exthdrs, and must disable the frag0
optimization because that function uses pskb_may_pull/pskb_pull instead of
skb_gro_ helpers. It sets the GRO offset to the TCP header with
skb_gro_pull and sets the transport header. Then returns skb->data to its
position before this block.

This commit introduces a new helper function - ipv6_gro_pull_exthdrs -
which is used in ipv6_gro_receive to pull ipv6 ext headers instead of
ipv6_gso_pull_exthdrs. Thus, there is no modification of skb->data, all
operations use skb_gro_* helpers, and the frag0 fast path can be taken for
IPv6 packets with ext headers.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/ipv6.h     |  1 +
 net/ipv6/ip6_offload.c | 51 +++++++++++++++++++++++++++++++++---------
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 78d38dd88aba..217240efa182 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -26,6 +26,7 @@ struct ip_tunnel_info;
 #define SIN6_LEN_RFC2133	24
 
 #define IPV6_MAXPLEN		65535
+#define IPV6_MIN_EXTHDR_LEN	8
 
 /*
  *	NextHeader field of IPv6 header
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 0e0b5fed0995..c07111d8f56a 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -37,6 +37,40 @@
 		INDIRECT_CALL_L4(cb, f2, f1, head, skb);	\
 })
 
+static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
+{
+	const struct net_offload *ops = NULL;
+	struct ipv6_opt_hdr *opth;
+
+	for (;;) {
+		int len;
+
+		ops = rcu_dereference(inet6_offloads[proto]);
+
+		if (unlikely(!ops))
+			break;
+
+		if (!(ops->flags & INET6_PROTO_GSO_EXTHDR))
+			break;
+
+		opth = skb_gro_header(skb, off + IPV6_MIN_EXTHDR_LEN, off);
+		if (unlikely(!opth))
+			break;
+
+		len = ipv6_optlen(opth);
+
+		opth = skb_gro_header(skb, off + len, off);
+		if (unlikely(!opth))
+			break;
+		proto = opth->nexthdr;
+
+		off += len;
+	}
+
+	skb_gro_pull(skb, off - skb_network_offset(skb));
+	return proto;
+}
+
 static int ipv6_gso_pull_exthdrs(struct sk_buff *skb, int proto)
 {
 	const struct net_offload *ops = NULL;
@@ -203,28 +237,25 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 		goto out;
 
 	skb_set_network_header(skb, off);
-	skb_gro_pull(skb, sizeof(*iph));
-	skb_set_transport_header(skb, skb_gro_offset(skb));
 
-	flush += ntohs(iph->payload_len) != skb_gro_len(skb);
+	flush += ntohs(iph->payload_len) != skb->len - hlen;
 
 	proto = iph->nexthdr;
 	ops = rcu_dereference(inet6_offloads[proto]);
 	if (!ops || !ops->callbacks.gro_receive) {
-		pskb_pull(skb, skb_gro_offset(skb));
-		skb_gro_frag0_invalidate(skb);
-		proto = ipv6_gso_pull_exthdrs(skb, proto);
-		skb_gro_pull(skb, -skb_transport_offset(skb));
-		skb_reset_transport_header(skb);
-		__skb_push(skb, skb_gro_offset(skb));
+		proto = ipv6_gro_pull_exthdrs(skb, hlen, proto);
 
 		ops = rcu_dereference(inet6_offloads[proto]);
 		if (!ops || !ops->callbacks.gro_receive)
 			goto out;
 
-		iph = ipv6_hdr(skb);
+		iph = skb_gro_network_header(skb);
+	} else {
+		skb_gro_pull(skb, sizeof(*iph));
 	}
 
+	skb_set_transport_header(skb, skb_gro_offset(skb));
+
 	NAPI_GRO_CB(skb)->proto = proto;
 
 	flush--;
-- 
2.36.1


