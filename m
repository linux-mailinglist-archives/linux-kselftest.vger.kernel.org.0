Return-Path: <linux-kselftest+bounces-35995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC173AEBEB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAA8645665
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2831E2EE288;
	Fri, 27 Jun 2025 17:56:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE112ED175;
	Fri, 27 Jun 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046961; cv=none; b=kOvf26BfyV6zjHXO5FXTZhl7QQ5Mlawoe+Emrz4nDhAn5nq+WFV5AcN94xe4ur4EkISS0CMnYU6zz4kGOBbbpN/iAn4av2c4Rtc4YQm7KiQSlriYBFBm/dE1Jrk680849ukCFjVkBKo/2yaq9A1/dlVY8H5eAGnHRQWlhsTuPbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046961; c=relaxed/simple;
	bh=pcZpkL8/Vo5GDdA9GSNr5ZwCPZLTyJlooFlI1HTfP/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BnLe22hYq+b/Kq1ugaZvHLKQQ1GK6ufeWflaZiZ/8AB2owkBtQlgmWUt9pLB4ffnR1Qa6ecr+Y/XGOXZEQXfYFk/Rbfy4te4ZPajjr/BEiHQ+B4804QqK63Naj7kA2L7RAjFAJjRm/3q4YqbUPF+sRk6O6ddDPs2HU0MMufXReQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso4504757a12.0;
        Fri, 27 Jun 2025 10:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751046957; x=1751651757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClXLLoPFou/Zs3D5ISq3qOrdQw3SSzyGRonA8OwAUwc=;
        b=gxrvtbrXQdkFIvvWiJdeUdn4c68OPmtVlKdD+P/HSGcKswigGI4gu+tpzA4abTYVwB
         hpKOiTSjy0n3RfbwRdSx7tJ5u5QFj4Fyvt/IRCj5Z7XcI9cTXl6wsimzS+GZ2FVXLyjD
         3KLt5xzRh8DOHaEnenq5w5UleoimYMByUR72+pLJjNWyhtmoDsnpMzNYYjuOuNp8eFba
         6TzUAY+rAcIaqXuDAIHXmh06ThnGOugV1goudHa1ju0YJqWznZJGO5EdpnHqHSVnIDot
         pUJhtQt9Abf/lkQHWm6Umji67WWb8QXiYAH5dWeGaECgO8qcfB3hoiHpxysL9x3E44ax
         qt6g==
X-Forwarded-Encrypted: i=1; AJvYcCWN4fi4D0as+tNnXTHCOXZtrK6ilCc2PuDcvZu7Ho0HaXvbDb4IKigWr9XPD675HggYYy4SAPv9Xi5xZKA=@vger.kernel.org, AJvYcCWylobvY8lTQGHXPboSbHMzOgUPoIxN9t9Wul49GBjJIYKnYxaWO7k+mfns/lRuhjHjyfoporXEe8/XdiFxtCso@vger.kernel.org
X-Gm-Message-State: AOJu0YzfxhwnEUg+wYQGowCfKSZ+cLZNv/235KvYd6thtOCQUil4Eu3/
	nae35jEfZfcnuZ5FfDFkUDhq2JkGIw1elC0Z52Jy7/jlFXOI0Lv0hD76
X-Gm-Gg: ASbGnctzyK1+t0oGyYNsvN9kYbFoXMhE9BmHchHtupVUTXjNb3NSiUwiRvYsHe5JUmf
	PJuJZQbV1P+xOs33umCRnnorMQTPSMMAlD3xgSfRNPfr6FKnhRqYPCmVgcKWZln91HzTO+kjOZH
	gv5z6rYje4pqYXkPdb+dnB5JnmkWIV4ZCLBe0yKOZonQ6x9sqpJtCgMCMkH5GNoB9DzR8ZO3WQ0
	1wWC4FIH8f4kXVLUlBqBYXdAxvDg9Sjc+VXiR0cu3+a0oleBDjltQ9j+fxHUKwFHTY/Yypb+jSe
	WK56oTzeAroOm1qOeyNlu3m8FmRJswzHZ0AYdSAa18HqnFDI7xtm
X-Google-Smtp-Source: AGHT+IGL04zs6hP3O1ukERCqbY/aQnu4iEblvY6W6NTE2uJj/3CMybdWq1mxRT2Q6XIgZB3mik06rA==
X-Received: by 2002:a17:907:d16:b0:ae0:c6e5:9738 with SMTP id a640c23a62f3a-ae3501fc1edmr401143566b.55.1751046957147;
        Fri, 27 Jun 2025 10:55:57 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bdafsm162009566b.143.2025.06.27.10.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:55:56 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 27 Jun 2025 10:55:50 -0700
Subject: [PATCH net-next 4/7] netpoll: factor out IPv4 header setup into
 push_ipv4() helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-netpoll_untagle_ip-v1-4-61a21692f84a@debian.org>
References: <20250627-netpoll_untagle_ip-v1-0-61a21692f84a@debian.org>
In-Reply-To: <20250627-netpoll_untagle_ip-v1-0-61a21692f84a@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3390; i=leitao@debian.org;
 h=from:subject:message-id; bh=pcZpkL8/Vo5GDdA9GSNr5ZwCPZLTyJlooFlI1HTfP/A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoXtslgIbwZAltg6AAIY6pwiupMhATLK1D/ITh7
 rvhcXszEv2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaF7bJQAKCRA1o5Of/Hh3
 bXh7D/9RjnmmaQLFxg0BW5FdR9GZM0U54oEEC0evGxZAPHT0ZPGp2zXkQHsU1r1oUnKDYI6IfT8
 Wf7b4cIOrbteN89wLjSLt2TPQtQulwvU8FbLOQi/J21UlSR6VTiSqYaIA+ysvU06jLaIXQCBfCB
 V081FFKt8S3d4sd4hxM4vMDdw2364JF+SozmxxIFy6dTABJMNdtR4KnYARCiQ4GoiJfqy0xpiZS
 FZVuFcbhSSXcvauilQ9M0uMaQ+NEGNWXrhHc8J8x25vEzq8zBtMFP3p056t5S+J2asMAoYAtFLt
 nGJ9jk4IijBO6VoJBCaTy2+BbVglxRy9zBpjs5E6atkhcl98o1s0QhYde65hphZBrtAHpJDC3G+
 tZwgh/zUGEY1ZrSjP5NmkCesY0SP8aZtv6w3Nyk4/LKTdTPKR1m4asr7zYMGZTfoty5oHa9jLID
 CrlvCoKbeVd7Rh63g+gSq2E7egb+M4kLHEwgZkT/+0tiAxkK6f7lJcdk54+XWMz8b0b+gypxQkn
 i09xsAaCYVuutJ8G3flhEnArK3iRhudCDVQwJMP/3N8KcxgiGAJaXBziJeyd06jOOkIfC+zoxzZ
 oykeuGl2IeOQk4xck0ozTGKZ7BzDQf5ufbeCsAvgBXmGLD3XNpNCvdELHGpsst6EqDwqiEWY+Rx
 HYvKDy7YZw8QGLA==
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


