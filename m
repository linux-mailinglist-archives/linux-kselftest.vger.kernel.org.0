Return-Path: <linux-kselftest+bounces-36291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CA1AF1133
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BD04A4222
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B795025BEF0;
	Wed,  2 Jul 2025 10:06:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FB1253B67;
	Wed,  2 Jul 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450813; cv=none; b=FcETcaztHdul+8mwoTF+sjSxlhTC5Nm97jfjL2yFSsK4Avs3rTrAU9FTuid66SmPRusUlcG4FRgeFdH7ZOR1DM2RKZZ1xrZjojPQEWx0cbX4V/xsbyJRVs8P1pwoTsIvzGPHOrHFK99lLaL9KhhtkbvXnSfob6o7bRRPCnjGJto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450813; c=relaxed/simple;
	bh=pcZpkL8/Vo5GDdA9GSNr5ZwCPZLTyJlooFlI1HTfP/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dDh6sHiA5CxyjuiMgPLeySBF0W4Jc7R/toIHCeeLZhmgOqMMjqOFgF9Q//M46oZGT05sKHP9cxfeCxufflewni+uLbR/0iHQEHvzduKIYmsH9Ur4JOVZQ1lAJ9SN9cjX6sEBNyfdUm60KuTSFBdZa8aRGBB5Urk03yOUTu48t40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ade5a0442dfso1263295766b.1;
        Wed, 02 Jul 2025 03:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450810; x=1752055610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClXLLoPFou/Zs3D5ISq3qOrdQw3SSzyGRonA8OwAUwc=;
        b=J34wp9yFUiBui2jdeUYKG3a6sGKMmqOkarsbbv78Yhleolv6sAuanyF4ZVs8yBIoua
         P0q8EWVLW3VxouwHk6in6WvL9pjjzE/0YnROLd/cVbLqRlUx6OBCFv8gSG9qDwSdikMC
         wnivlWdzgd/dVXU3M5PeHOpocbpiEdQxWpoe18nwk07/Wyau2tz7gjScPFLbdifLWp2t
         ZGojOAKVlSesb9zqCl/d4MqFZuUXuwBbimlVuLofF5KauGwLismAUdjTSA9OeJ7CYret
         sLpJEX36f3YpdUtLAjwFiJoTiJa1iwctEwBTldKfYu9mhKygiIGbMGbP8tEMt0NnGLyX
         bBNA==
X-Forwarded-Encrypted: i=1; AJvYcCWYJ27FrcNH2q6gbxcvCE1owDz7qyguexlRzxIiHMiNgzpAkH5ORx18scaBzKdf//geOlt6X2ik6PgKXwdZiScP@vger.kernel.org, AJvYcCWrNQRsd2Q+a0iWK2zRrN25oU7T8xY5p/60BO9Ji+V3tVSDbbxhBfLAOWfKRkscztrfdfR0Oq4YWQff/po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7pM7Nah6T9/s4f3OiquvfGHrQJC+0siNTKLbyo1hD9IL44k83
	dyKj3B3a2oVWZEA4Odv4HFe98KLsvZqOXIn1NJ6SjqlVKS9iu7siuy/4
X-Gm-Gg: ASbGncvLzzbII1lmAViagiMcb8cRokWPWpfuQqa4enMXT/+Q4nkJqdsRFmmjf9K+Xx7
	8TNd/CXg3+7KfAcTc4sO9vFH/Ab/RPQF8q/eVaXqTjQvP3UoJCF2Dbgr8BPK8bw7dbx2ARkcV2Y
	/WtxSoXZig9tq483R87QmjLye5RNzM1G2L0/Oz16wVIb+cZJdYJBJZhdf9Im29JPgKQHQSerKJy
	lPKdZQNr88aevHOQ6w1/EnwyFnTHwCXGD4XRGzV7B6HcCFqWEv6moW3c+7ZGam5VCg98kf6FTEq
	1RH/yM0Jc4cvpZUlAR7Rs5hGtIV0bBTVY6hHUJK/Crbt0W942g==
X-Google-Smtp-Source: AGHT+IEBHeDW/qHjY84o72AomKdwJUaEgc1blIazAL28t7JSVyH+PhHW6nJKpfvZZGaHrIhK7QDc+Q==
X-Received: by 2002:a17:907:1ca3:b0:ae3:6d27:5246 with SMTP id a640c23a62f3a-ae3c2ce1f13mr207594066b.48.1751450810136;
        Wed, 02 Jul 2025 03:06:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca2159sm1071326566b.178.2025.07.02.03.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:06:49 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 02 Jul 2025 03:06:36 -0700
Subject: [PATCH net-next v2 4/7] netpoll: factor out IPv4 header setup into
 push_ipv4() helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-netpoll_untagle_ip-v2-4-13cf3db24e2b@debian.org>
References: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
In-Reply-To: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3390; i=leitao@debian.org;
 h=from:subject:message-id; bh=pcZpkL8/Vo5GDdA9GSNr5ZwCPZLTyJlooFlI1HTfP/A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZQSyh21HG91R+k7nQBnrk2vFjlUpfedC6xjcG
 nrf2hLy48CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGUEsgAKCRA1o5Of/Hh3
 bZRQEACOow4bSHX75KePeP2Jk+s0+FyI484nTmb0m7teSV9sbr99NwIv9EEJMFKaPqBHdkCcl95
 hsgcGwp7+TcHOLsgJSkNgxxrlnAqCwmFubfl6/8KOyRpNPL2RstfvTX7i/0VP6BYzcygDnN5ZY7
 znC2/LK9CLfvsSHf52Im4iNrGW2ZRWDRFTyP5SKJlzNzYJUtu9keOQmxCZi/496Q2XD+M4ZOuAL
 VBzKBpK4s24AbDcA859TTNUjdqiO7/+pQqgvPAXD6B9y23AyKsl6wEEynNb0okLoAaOHTVyRRIy
 TzhMAyug3Xk7eCxKchcaD7yLozlqDTs4iyEpnloUmBK8W7w6JmVqt6sicZBP6D3He1FbNcsBMCO
 rNhS9uyPHiOwrBDTqsIMPLRRUnINn4FapyBLzBc9tvHtKElbMlD6cfH0qDXcQP6lghbi9Rls1YS
 UXlFwdaXvBc4k0RUbrIb4j6QcHioweFfP1LHhDsiLS494xhzAjf5PWyGpz2qNt9Of548ZOtrA5O
 XQIHzfom8pzERJbpPAyxPcA5KouGQmSJLVwF4X9aQjlgddJ71HcuZQIqW2S2nD77D7ftYAvUAy8
 BKdglFEjFuId5oTlNrDOMOAKO6dCcacC429Np2wFXG+S6i3ssXUJDwX6g6JB9Gb4IUMWqQb+BfB
 P9YAeebJp1wWVpg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move IPv4 header construction from netpoll_send_udp() into a new
static helper function push_ipv4(). This completes the refactoring
started with IPv6 header handling, creating symmetric helper functions
for both IP versions.

Changes include:
1. Extracting IPv4 header setup logic into push_ipv4()
2. Replacing inline IPv4 code with helper call
3. Moving eth assignment after helper calls for consistency

The refactoring reduces code duplication and improves maintainability
by isolating IP version-specific logic.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 62 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 247a73762fc2c..ff64e94df5351 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -441,14 +441,44 @@ static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
 	eth->h_proto = htons(ETH_P_IPV6);
 }
 
+static void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
+{
+	static atomic_t ip_ident;
+	struct ethhdr *eth;
+	struct iphdr *iph;
+	int ip_len;
+
+	ip_len = len + sizeof(struct udphdr) + sizeof(struct iphdr);
+
+	skb_push(skb, sizeof(struct iphdr));
+	skb_reset_network_header(skb);
+	iph = ip_hdr(skb);
+
+	/* iph->version = 4; iph->ihl = 5; */
+	*(unsigned char *)iph = 0x45;
+	iph->tos = 0;
+	put_unaligned(htons(ip_len), &iph->tot_len);
+	iph->id = htons(atomic_inc_return(&ip_ident));
+	iph->frag_off = 0;
+	iph->ttl = 64;
+	iph->protocol = IPPROTO_UDP;
+	iph->check = 0;
+	put_unaligned(np->local_ip.ip, &iph->saddr);
+	put_unaligned(np->remote_ip.ip, &iph->daddr);
+	iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
+
+	eth = skb_push(skb, ETH_HLEN);
+	skb_reset_mac_header(skb);
+	skb->protocol = htons(ETH_P_IP);
+	eth->h_proto = htons(ETH_P_IP);
+}
+
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 {
 	int total_len, ip_len, udp_len;
 	struct sk_buff *skb;
 	struct udphdr *udph;
-	struct iphdr *iph;
 	struct ethhdr *eth;
-	static atomic_t ip_ident;
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		WARN_ON_ONCE(!irqs_disabled());
@@ -477,32 +507,12 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	udph->len = htons(udp_len);
 
 	netpoll_udp_checksum(np, skb, len);
-	if (np->ipv6) {
+	if (np->ipv6)
 		push_ipv6(np, skb, len);
-		eth = eth_hdr(skb);
-	} else {
-		skb_push(skb, sizeof(struct iphdr));
-		skb_reset_network_header(skb);
-		iph = ip_hdr(skb);
-
-		/* iph->version = 4; iph->ihl = 5; */
-		*(unsigned char *)iph = 0x45;
-		iph->tos      = 0;
-		put_unaligned(htons(ip_len), &(iph->tot_len));
-		iph->id       = htons(atomic_inc_return(&ip_ident));
-		iph->frag_off = 0;
-		iph->ttl      = 64;
-		iph->protocol = IPPROTO_UDP;
-		iph->check    = 0;
-		put_unaligned(np->local_ip.ip, &(iph->saddr));
-		put_unaligned(np->remote_ip.ip, &(iph->daddr));
-		iph->check    = ip_fast_csum((unsigned char *)iph, iph->ihl);
-
-		eth = skb_push(skb, ETH_HLEN);
-		skb_reset_mac_header(skb);
-		skb->protocol = eth->h_proto = htons(ETH_P_IP);
-	}
+	else
+		push_ipv4(np, skb, len);
 
+	eth = eth_hdr(skb);
 	ether_addr_copy(eth->h_source, np->dev->dev_addr);
 	ether_addr_copy(eth->h_dest, np->remote_mac);
 

-- 
2.47.1


