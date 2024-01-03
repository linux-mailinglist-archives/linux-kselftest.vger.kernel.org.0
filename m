Return-Path: <linux-kselftest+bounces-2616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AC1822FC6
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 15:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451B81F23C3E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4422D1A70D;
	Wed,  3 Jan 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnlM7mNW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDA1A708;
	Wed,  3 Jan 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d858c56cbso35339575e9.2;
        Wed, 03 Jan 2024 06:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704293087; x=1704897887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DF5Tpjc7/qBP5rRrTOGZj1iy9dxk0+S2n9vSpuIQY2Y=;
        b=HnlM7mNW/jjZpunoLkbYJrH10sHqvSYaTc+JkrTAN+ARBJOofxtGsCGC82Oxxvhx2H
         o6ByQTutHY8wVBAu169CM0AqazWmsB//2HhUvEE/5hWPFOW4gnUxjaxa74aJk+gmsA2C
         s/DEW9ZYubFP/xGtZCHpUjFT3x35/fAh7v0dgn+lKVe0i/gfGY8e1UjFXlxc5j1zm3Bf
         JaMxkGCKItmanWsRSmi0pnkiM2s96UHXxyDY9fYoFE8qz1mgYC9mTFJWdWx4XKn4zcsY
         mWF7jB7tnANvLbS9dTYzYVHr1Dt14I51JDQi3CHxNWad1dbUW0sKNDHE3ZUDRHFO/1Nj
         Z+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704293087; x=1704897887;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DF5Tpjc7/qBP5rRrTOGZj1iy9dxk0+S2n9vSpuIQY2Y=;
        b=RVLF3D6fx/0pV+zXTbsFjqt8qShRZ2daNojD/Qw3jYExRkoICB8h8k3h30hMFseB4F
         1R9CZwIEcj3NU73n6gTRy4z8mC/IoLC9rbAqtXyCiOmGlVbvf7S09wjhJN9C4bR2se3y
         4Z4YG8RhwJtPwafygIkZ1rvgRPq3F+59DWiK4ro0c2d0d1UACBUlVn5dJHWJyoRyEjNt
         3lLJCuHunck4RwkRajQ+4SDASnU/StwWe3WqI2UVs9aC9sVpbIUIRkIH5Phr0tz9Op4b
         A96uTCAi0BHoTciydmegvAOZ+JSDwQQtZTh2lGDPz/CkXWg4DQnAIzIuegriF3nFcIAM
         m2RA==
X-Gm-Message-State: AOJu0YwAmoWD5+sp/0A6ZWcTTKzCh8ZLCc2d4l7sZ4GC1/lq8fhGu5BD
	u+LAZc4Jjf3PVdq/u5jnPYfGR5ZKtXG3Og==
X-Google-Smtp-Source: AGHT+IE4LGuUM464Dkji7Qyx/GfCoHeET9LTq9UXKsXvwyBB5+is1ieVd6YsH88aX6cNY17P8posBg==
X-Received: by 2002:a1c:7214:0:b0:40d:7be6:8e59 with SMTP id n20-20020a1c7214000000b0040d7be68e59mr4250351wmc.40.1704293086646;
        Wed, 03 Jan 2024 06:44:46 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b0040d87b9eec7sm2530443wmo.32.2024.01.03.06.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 06:44:46 -0800 (PST)
Message-ID: <504130f6-b56c-4dcc-882c-97942c59f5b7@gmail.com>
Date: Wed, 3 Jan 2024 15:44:21 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next v3 2/3] net: gro: parse ipv6 ext headers without
 frag0 invalidation
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <ac6fb684-c00e-449c-92c3-99358a927ade@gmail.com>
In-Reply-To: <ac6fb684-c00e-449c-92c3-99358a927ade@gmail.com>
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
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv6/ip6_offload.c | 51 +++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 0e0b5fed0995..cca64c7809be 100644
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
+		opth = skb_gro_header(skb, off + sizeof(*opth), off);
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


