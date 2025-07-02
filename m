Return-Path: <linux-kselftest+bounces-36293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46301AF1138
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A391C24725
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8791260592;
	Wed,  2 Jul 2025 10:06:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FE725DB0D;
	Wed,  2 Jul 2025 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450816; cv=none; b=NVXxicR11dbZoe5e4e3JoBmyMKO3w/f92zkoFZKQfp3m/Vy/v0DtaXcw5qhw82XYY00TIinMIMTNIBxBDvV4CUKulDYJXL5rtKElezNZjG/t88bcFXyg+hkyzX2T/3PvWfXPNjme88PDPA9R9jvvH/T8vxv/ciCHJaOCq/91Uw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450816; c=relaxed/simple;
	bh=BWXMBrzktLJVPVW0gEBEfBlMgYZkbD9tXz+iG00Ovik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIorDTJZG1AYjVnPn+KfgbU7PyoL1t6xAhafUVnrm4/u5RbX/oLlbW1o0DyguULwqM+eUNx9hxqR2ZWt93Xolo0UoEb/e3ARqoMSCI1a+UN9xTt2TlIqM2ihsF7KTFhFAvGcbdkYeCLn5I/1zZYU+aC8zzvjczk3qPOiBXGEo9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so8737726a12.0;
        Wed, 02 Jul 2025 03:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450813; x=1752055613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bh7hV7ctYhjTTncRGyylmO0Rhxv+CmqALT9eq61GbDc=;
        b=SCyxasgoOeBZZU8QISm9EQP83wvXnOGngbVnWvtvboFmXCd2b2KS2M32BBT2AU+mrS
         p8p0UJvUSA96ych7ZnDJybAUTQiUDEp6HVrN+lLGoHe6J1pih6N9iWlVfxlhb6vudwlP
         jQRiV14rnGJoQgSL0e+Rsasi/H7uBMJ4I1j4qxowyXVoiJGOP/ajQD1ucL7weGHEA82i
         E6brOFeXY5trRJ+WIgSTUK1Wct1py229G9opKYdV8zf75YvyKehelzHMwuW9SUDwMA3y
         FCiP8uwpyVmSFhFCW5BKb0jEq82soXR/SStftyzbmUvMka8s6P1Hu1EDYwPDAFl2V6Se
         cuKA==
X-Forwarded-Encrypted: i=1; AJvYcCVBODul753GkPRQxzKAzEuMk6Ddv4K6MnTQVk/naiILwD6gbvVU2AtZtqwKk8t2j8NF6r4hzcWL2BMHmnJvyga+@vger.kernel.org, AJvYcCWOZW3so8+n8cEloJkE2TJ5e0OeOWWwQVJktV8GjUMKoU2OR1xQQrU3jl/6aSYgVdb9rJHFjmEh2YGt/ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZK6Ct02E6cHHVrcy5TZtSRzjWv72WHdVSKngia5yQb7geWsCd
	P0V6y9VuSoCE+Pi7shHRWkx22aBvQgdPJORN8ACduMXfu0uev7ff8P64
X-Gm-Gg: ASbGncvK1kgnDR+YwZSzfdodF+KqDoCyImKBXKslydn5KG0cQZg33ri4gUNILAlVofx
	cqNonWUQQrl62lUqGAQzI5ZBF7eT7TYVQEKY0K2AklnyY3RO8KzruJ7HWZ8YGqv0HTe5vjTtXE3
	ls0QqYwpo2wQXjJHnBiCbsRezbUlyZLQWNYpCtKTSKLk36B9PmaDA5QVUSHgpRYB4Nc9OwpsUoX
	uAlnW0QBD18nmAUOPM/41UqjyrBC5Sqxuyr84HTAqhLOs5EH78LNyagAsQ1Nyj/n2ss6pUwsgfJ
	mlSKSXcmW0R3/BeIObIVehlIOvmnE62mvDgKMbpPKbgqs0n8KqWJ2g==
X-Google-Smtp-Source: AGHT+IFDOSH/fmcOYJ7xuZSfDeU/TGgSuwONn32IlSEXUtYp2uXLPWT364bDENeL0HYNFD3MaHcBJA==
X-Received: by 2002:a50:9f08:0:b0:608:f493:871c with SMTP id 4fb4d7f45d1cf-60e52cd1564mr1471797a12.14.1751450812923;
        Wed, 02 Jul 2025 03:06:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828e3b49sm9050377a12.22.2025.07.02.03.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:06:52 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 02 Jul 2025 03:06:38 -0700
Subject: [PATCH net-next v2 6/7] netpoll: move Ethernet setup to push_eth()
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-netpoll_untagle_ip-v2-6-13cf3db24e2b@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2865; i=leitao@debian.org;
 h=from:subject:message-id; bh=BWXMBrzktLJVPVW0gEBEfBlMgYZkbD9tXz+iG00Ovik=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZQSyyq+B+OlGSkSZHokNTuleYo55kMw3rzKuV
 V0rb4PYQfKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGUEsgAKCRA1o5Of/Hh3
 beYxEACvKiY3H0DVJa6SeQpEncR2LdDUT9M5erAZpoPo2hyo3KPwYeIoQeabKqU1JR9eBE+GgJ8
 n3v8UTOfgzfJJKW4L3SwUUYQA0rVSXR9mQ06sDYrNYvAu/+z9zP5hAx/OBL3n17zuZ9Wv3Zaw0S
 4/xTlWkXIdb5q9KD7sx7GASQqOninvM9ZB+86ThWv8aob2TLf3CJbEhEMDeGoshprTC9SKunnor
 X8OT1v3uzE+VIGdL54g6ahs8US3FZI7OJBiDbGM3fr7G3l57R4+nKrxX2D3i0RH2LSaSCxiTypF
 87tOBD1+rSZZ+sDvAZUtDLjjGEyZ1qSg5mt9TKiQIs+Of8AYtFT5k6+//bhjWLEvJ7IPNKkKt/y
 kCbVrY75IY/3aknotaGba8DfXX865SouBEt6y7YFXX1Po85JVqxvPgEmEiMBbok9QgXPr/emLEs
 XNNOUR4kuFkOrzttuCuqxiFL0aYJUiqkfnQ8FrNzFX9hLovVsVFIZwLwElapzcuw/fl5Z2bHzeN
 AqiDYxmT38Trzslx8mfVI25frLlYaZqo9ORrqO0UaGxefuqqFw1tTd2UYPnN+r0BDRzQzvNd78g
 r4Am23L1w0e1vFmtsmVbxVAIKKEynhZV0oe6aXSRTqBCBY/eJxa23XlAOjQ9eiGp0iFRj/2tLRm
 IDwAwwepfAIH5/g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Refactor Ethernet header population into dedicated function, completing
the layered abstraction with:

- push_eth() for link layer
- push_udp() for transport
- push_ipv4()/push_ipv6() for network

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 70035e27d91cc..a1da97b5b30b6 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -417,7 +417,6 @@ EXPORT_SYMBOL(netpoll_send_skb);
 static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
 {
 	struct ipv6hdr *ip6h;
-	struct ethhdr *eth;
 
 	skb_push(skb, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
@@ -435,16 +434,12 @@ static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
 	ip6h->saddr = np->local_ip.in6;
 	ip6h->daddr = np->remote_ip.in6;
 
-	eth = skb_push(skb, ETH_HLEN);
-	skb_reset_mac_header(skb);
 	skb->protocol = htons(ETH_P_IPV6);
-	eth->h_proto = htons(ETH_P_IPV6);
 }
 
 static void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
 {
 	static atomic_t ip_ident;
-	struct ethhdr *eth;
 	struct iphdr *iph;
 	int ip_len;
 
@@ -466,11 +461,7 @@ static void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
 	put_unaligned(np->local_ip.ip, &iph->saddr);
 	put_unaligned(np->remote_ip.ip, &iph->daddr);
 	iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
-
-	eth = skb_push(skb, ETH_HLEN);
-	skb_reset_mac_header(skb);
 	skb->protocol = htons(ETH_P_IP);
-	eth->h_proto = htons(ETH_P_IP);
 }
 
 static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
@@ -491,11 +482,24 @@ static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
 	netpoll_udp_checksum(np, skb, len);
 }
 
+static void push_eth(struct netpoll *np, struct sk_buff *skb)
+{
+	struct ethhdr *eth;
+
+	eth = skb_push(skb, ETH_HLEN);
+	skb_reset_mac_header(skb);
+	ether_addr_copy(eth->h_source, np->dev->dev_addr);
+	ether_addr_copy(eth->h_dest, np->remote_mac);
+	if (np->ipv6)
+		eth->h_proto = htons(ETH_P_IPV6);
+	else
+		eth->h_proto = htons(ETH_P_IP);
+}
+
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 {
 	int total_len, ip_len, udp_len;
 	struct sk_buff *skb;
-	struct ethhdr *eth;
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		WARN_ON_ONCE(!irqs_disabled());
@@ -521,11 +525,7 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 		push_ipv6(np, skb, len);
 	else
 		push_ipv4(np, skb, len);
-
-	eth = eth_hdr(skb);
-	ether_addr_copy(eth->h_source, np->dev->dev_addr);
-	ether_addr_copy(eth->h_dest, np->remote_mac);
-
+	push_eth(np, skb);
 	skb->dev = np->dev;
 
 	return (int)netpoll_send_skb(np, skb);

-- 
2.47.1


