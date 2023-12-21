Return-Path: <linux-kselftest+bounces-2313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C573181BE8F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 19:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4CD1F23769
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 18:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0BB6518D;
	Thu, 21 Dec 2023 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5bmne/a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44A11733;
	Thu, 21 Dec 2023 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d4103aed7so7877555e9.3;
        Thu, 21 Dec 2023 10:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703185104; x=1703789904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHklhKkIDpRGAbC6EyVSS7Ick/sDdM+0PSLDLsMKiVc=;
        b=d5bmne/a4VJxS+hiGc2Yr83v6DnHjuSi75qggz918SXOjma6FXGn9xOiF/ziNlRfF2
         vvYbwNwK0MjcgpMpOX7WOH8SfqclxgEshPOVmIzguxU3LvYt9dZrIXDscph6sY+SVHkJ
         cbjXHYsRiN2u8OXNGn8TT5/d2FhzyrWRAgVy3kXcVlVnnqSP5YVakblBLujr8UnGLrKG
         vZgb0IUfD/VRKnnbPzrjaxfCtIi0lH4AeRwsi/OjVQ8AfXQMfoER5tSygxx1NQCx8tjO
         PoA/LCGndHInAeC25zDmii5zmvWR5ZGS8ubWdqsxhral1rH5LoD3lFwtQ5/Cy6MlKze5
         0RuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703185104; x=1703789904;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nHklhKkIDpRGAbC6EyVSS7Ick/sDdM+0PSLDLsMKiVc=;
        b=qWDjOM2wrHTfwfIBBr/1DuVOIlCaIqAfZxj83t6jJY8XM0OidGMvTsrc+btE9JZRJW
         JdYnQJ1xZv1c8TwffDejQk5L2xjwruBuwQG4X5VFuMtMKwXBEZr9NYvjFITAzOj+PWD4
         rKeHyydrOgd+vI6IXr9GKE8JZTZcgqZMFdXaVLif/RtVe+4dq193HD4Fbxnmt+R4Eya/
         FO7FFEq/rHvggLYv9XMbr+DW77S3zau0qmlToUbBtfz4ypvUwdB/ISJ9JqKM2p2sicbF
         g3tmW7vHj+o/xFkPtqDWTze52vwvGNdUQ/V3KncVU5I9/TqdMOXoa1qlRxOY/RPKq+jh
         NDaw==
X-Gm-Message-State: AOJu0YzLZ93hT1ln8VXu6N5xHKtE7015loQu6sGBHUJeqLM2JtsTwzRH
	XDRHfY4dzjdq6yCtgHvOTl4=
X-Google-Smtp-Source: AGHT+IEZRGhr19YcFmW2jepDNMeTHfZ2bFIrwD4JzHi58QljsW8CqhwZmLFiGx8I968xig1nuKm0UQ==
X-Received: by 2002:a05:600c:4496:b0:40d:41d4:d29e with SMTP id e22-20020a05600c449600b0040d41d4d29emr104917wmo.187.1703185103884;
        Thu, 21 Dec 2023 10:58:23 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b004053e9276easm11868269wmo.32.2023.12.21.10.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 10:58:23 -0800 (PST)
Message-ID: <32febbc9-e603-4400-addd-bdb97ce56c1d@gmail.com>
Date: Thu, 21 Dec 2023 19:57:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next 2/3] net: gro: parse ipv6 ext headers without frag0
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <f4eff69d-3917-4c42-8c6b-d09597ac4437@gmail.com>
In-Reply-To: <f4eff69d-3917-4c42-8c6b-d09597ac4437@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This commit utilizes a new helper function, ipv6_gro_pull_exthdrs, which
is used in ipv6_gro_receive to pull ipv6 ext headers instead of
ipv6_gso_pull_exthdrs. To use ipv6_gso_pull_exthdr, pskb_pull and
__skb_push must be used, and frag0 must be invalidated. This commit
removes unnecessary code around the call to ipv6_gso_pull_exthdrs and
enables the frag0 fast path in IPv6 packets with ext headers.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 net/ipv6/ip6_offload.c | 51 +++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 0e0b5fed0995..a3b8d9127dbb 100644
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
+		opth = skb_gro_header(skb, off + 8, off);
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


