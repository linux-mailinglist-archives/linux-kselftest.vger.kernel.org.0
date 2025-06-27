Return-Path: <linux-kselftest+bounces-35994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66832AEBEB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A495B3BCD99
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879F32ED851;
	Fri, 27 Jun 2025 17:55:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3FF2ECD3C;
	Fri, 27 Jun 2025 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046959; cv=none; b=bGQA9cII+mQTEIJb/Sg1sKS6qgc3XBY4bs87NQrR57ynjhB4TRr6osfZ/kKgvr50sBcOK+ZzCS/bgdwvxHDqnExbNtfCNwWnxxA6Dw3D9AJwXWeqBGAN8TaG+fiQ/8XSnLbJvIrUJw6DWQD+MX4pqw/GUjPte8D2SAPybtNNt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046959; c=relaxed/simple;
	bh=S45p4GYDOIgPeogkQywbhpuBDiWH/N8B6jk1HuoCwrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FhbPUtkrXKK2/0YG1zLeRhDA6wieTVuh/TWpQU9zWJCLeLKbAIOX4ExBbJxpcSGlG5xOeWCLXMPrDHBW85kEr97ZSiVgRqBIIrh5JMI44swxtfADkIPm/dE1fOUVOunfWxCYFILiNjLTOg+kbCqy6VUO0lLvVV+XNQFmN4y2IZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so196099a12.1;
        Fri, 27 Jun 2025 10:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751046956; x=1751651756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNF6KD9tDOu5iPqaXILqcxFXrB8p2Oad18HGGU/SHQ0=;
        b=gEEx8cID50tQeEyofdIWrVJ1ZHwrPnvsiZiDIbk7ywAeLlIUuxs595evNQd3wWN6bC
         CCqD9Q+9H2FPKHisYXTXAH4Z5DCWJGDRkiEDWywTJWt/Z9jSw3GhEmnsQNQVSkXWkfAO
         vrFgSsFBmKKJwuSRPaLIdG29kUIql6X0FWhXAKhABI1fOp3KV9Vc16Lnd+JFzQ+HEHwI
         ju4WHovYf0xEsvtIqJz4KI9T6wnDjhpC+VhBURjtzsJnKNFR3BCa8kaYj/LQr60oOCKl
         SaG8X4pu/m2G0FZpfA284rzIrj7F0OTl6cM5iBs418085ZWB+JHa/BhHg8x47ybqM55X
         qNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCYnhzMLSMdr/+15bV8k/3Qrw2J8GygvdPwTlBQA23MAC/9TdOAvbhWmviDWGr14cpjwPw9MNX0fSSYKE=@vger.kernel.org, AJvYcCWtwnv7ab4vLqOLeVTuBP4D22g5EFDgIZiPS0Hqz84de7WiCcjp1hS6f0DQ34mnVrShJFUvBt3053JqiyIooXSg@vger.kernel.org
X-Gm-Message-State: AOJu0YyTtVNr3NMPgMV6TJawOsEycuvvq5TIhpuyzcmLHqDOy6EK3ZbB
	F2Mi+UgaSt1RV+YSz0YLlCuH7OlCb6hEBUbiuyOzmjnhW8AvIJINGXUc
X-Gm-Gg: ASbGncsSIBOjibmAFl3LxFNspWEMNyWC8aa+2VeQ+kRqJag1l2hkWYNCbJLWqUGMt4o
	ccxo9dZQl+HmZvfMctLFKg1qQ2kSSafqdFO3xMtf6CcOlyGFBnIqE+HV+TpQ24miTFC1+ovX6g0
	zkI0STL/ybGEPvX9eoQErbRylS3TKsWOPCwWy2I9C/VWOg8vzk5c94eTDZUe2xmSV8IwIdhxzjJ
	OyaH4TWmUFjl989HuOJbnli3hnMXZL6p43sn2Ay02dffI+Xb/Zu5izRjsuRWr0hbx5F0vCBXptA
	Nn8R/J2hiMQ5yWaS6u3FIy6ZpCEDN6cQC/3KcAYmqWPfFykyLuwV
X-Google-Smtp-Source: AGHT+IH7BFosMcHC5XQWY/5DZOwgTmEHaiCP6wgFtBzyVXn9MYvGe/fJQaWszE0lHmU8P3n7sa+wFg==
X-Received: by 2002:a05:6402:3591:b0:608:6189:eb59 with SMTP id 4fb4d7f45d1cf-60c88c4d6e3mr3624767a12.13.1751046955679;
        Fri, 27 Jun 2025 10:55:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828e1a96sm1778572a12.19.2025.06.27.10.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:55:55 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 27 Jun 2025 10:55:49 -0700
Subject: [PATCH net-next 3/7] netpoll: factor out IPv6 header setup into
 push_ipv6() helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-netpoll_untagle_ip-v1-3-61a21692f84a@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2665; i=leitao@debian.org;
 h=from:subject:message-id; bh=S45p4GYDOIgPeogkQywbhpuBDiWH/N8B6jk1HuoCwrY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoXtslnekpDe+3IWlXZAbUCpJ4wH3Xm0gxWxsSD
 vq4qKkj5syJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaF7bJQAKCRA1o5Of/Hh3
 baOyD/9kd/tbLcnADpDL0hv1g88VCxBs3HuMJg/wPIkfSM6B8xNZg7UqcwCcslVHCf17UNpDzNK
 hxWnt3BoV8r5mXyHoIUQ6iaHDyB7chGMpyZFoMvfUXJQRG9uYU5HWbodUBqvCB/tlr2j2P1mE1B
 TLwjnXXnDR2gyngMsGI0fidZQLzDFoPLS7cepJ0dWM6VfM4/xf4T+iaGAskJejmzyko6YwcduD6
 Miw7J/g7GZeWC94Di0j1QPUhFcz2nYRu16OOL/lrjhVlWlvfoeIA+tMwU4AVD8a7ul+e83wtesx
 2fedaNPQ/WS6FDnWRjLXWQk3Kxec2ur4EFizS+CLNEJv5qSmyaojDnQsf71c4RWotWc3JlPiLIk
 ZZNkvpIAzftpiCSPI7YpF/TBjNQ0JoustQau7+cDOw3LNby3xkLSffq96ZLPw1tr6T3DIuQVL10
 feYXct6GQ0Sl4z3dczFzFtdGYa94FZGfqg0AM30oJzAtFdMR15Pw7156TAi6lfzurkfIHXs2nA8
 3iumy3/1yMtwWe0TAWQNNHI49RoHE4+OIsllsTRP8jlDBXgekrvK7NU0ADWfpYQkrFu2uXdV4Pp
 oBfVDm7Layn7JDyC//+u0KzXpdr1uMVv4mB5VKy0uiuF/89kmjnKzV+GX1vEGBd8bn6ivI88ACj
 ZhLCOVqpB4SI6mA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move IPv6 header construction from netpoll_send_udp() into a new
static helper function, push_ipv6(). This refactoring reduces code
duplication and improves readability in netpoll_send_udp().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 49 +++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 24e6ad2da8096..247a73762fc2c 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -414,6 +414,33 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
+static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
+{
+	struct ipv6hdr *ip6h;
+	struct ethhdr *eth;
+
+	skb_push(skb, sizeof(struct ipv6hdr));
+	skb_reset_network_header(skb);
+	ip6h = ipv6_hdr(skb);
+
+	/* ip6h->version = 6; ip6h->priority = 0; */
+	*(unsigned char *)ip6h = 0x60;
+	ip6h->flow_lbl[0] = 0;
+	ip6h->flow_lbl[1] = 0;
+	ip6h->flow_lbl[2] = 0;
+
+	ip6h->payload_len = htons(sizeof(struct udphdr) + len);
+	ip6h->nexthdr = IPPROTO_UDP;
+	ip6h->hop_limit = 32;
+	ip6h->saddr = np->local_ip.in6;
+	ip6h->daddr = np->remote_ip.in6;
+
+	eth = skb_push(skb, ETH_HLEN);
+	skb_reset_mac_header(skb);
+	skb->protocol = htons(ETH_P_IPV6);
+	eth->h_proto = htons(ETH_P_IPV6);
+}
+
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 {
 	int total_len, ip_len, udp_len;
@@ -422,7 +449,6 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	struct iphdr *iph;
 	struct ethhdr *eth;
 	static atomic_t ip_ident;
-	struct ipv6hdr *ip6h;
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		WARN_ON_ONCE(!irqs_disabled());
@@ -452,25 +478,8 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 
 	netpoll_udp_checksum(np, skb, len);
 	if (np->ipv6) {
-		skb_push(skb, sizeof(struct ipv6hdr));
-		skb_reset_network_header(skb);
-		ip6h = ipv6_hdr(skb);
-
-		/* ip6h->version = 6; ip6h->priority = 0; */
-		*(unsigned char *)ip6h = 0x60;
-		ip6h->flow_lbl[0] = 0;
-		ip6h->flow_lbl[1] = 0;
-		ip6h->flow_lbl[2] = 0;
-
-		ip6h->payload_len = htons(sizeof(struct udphdr) + len);
-		ip6h->nexthdr = IPPROTO_UDP;
-		ip6h->hop_limit = 32;
-		ip6h->saddr = np->local_ip.in6;
-		ip6h->daddr = np->remote_ip.in6;
-
-		eth = skb_push(skb, ETH_HLEN);
-		skb_reset_mac_header(skb);
-		skb->protocol = eth->h_proto = htons(ETH_P_IPV6);
+		push_ipv6(np, skb, len);
+		eth = eth_hdr(skb);
 	} else {
 		skb_push(skb, sizeof(struct iphdr));
 		skb_reset_network_header(skb);

-- 
2.47.1


