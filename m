Return-Path: <linux-kselftest+bounces-36289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A92AF1130
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4077E3A408E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94C225522B;
	Wed,  2 Jul 2025 10:06:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06944253938;
	Wed,  2 Jul 2025 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450810; cv=none; b=pcmSTN4I4CM4EOdyD4aiT6AzfkpIKpVjp1oDUZGKzePqdtoQW/5NF7tl9iMgCWljJH8t0rbTDYWliZbZKnyOOjZOAFQ45y03RFx79xlxhbFWT7jbWjZBwY5zWnkYnjgXMt6Rnm4H6L/x1KqrQ7fpaEenDG4VaY0HwpeAfo1Ljjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450810; c=relaxed/simple;
	bh=z6ZyZPgKMyV5y5bQXJoqji7LE1KbrdDAaxyolHnuv6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TRo0dz3tiz8jh9H+LwGto13o84/6qCWd9zh1JNXqiHgGmfBzNkvd+YyKJNxqj4rnGUMFYuLKOG5aIDu6PXPw1IA+qX4gEUKExn+ezF8qmz+hB3SAhiQeeKLCnsiWoWymhPFwhp/voz8+YEHuEP44rXci9jphImX33G5E69KJYlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so14336453a12.2;
        Wed, 02 Jul 2025 03:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450807; x=1752055607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qUEhiAZpONXJUUW9QytxIAnMQmTyOeLbTuh7J5BUSs=;
        b=ooYEe9QfTVwYiKKXOS8kn+tbE76yaIwCwhAguKAvM4G58KPG71+W3SmJqcVbF0UGEt
         DjPa9bx7rUea/w0Vur1WFOQJjmnELxYEj2oeIHkY2Sbvt3Q0i6OLYngePzBA04Y+uAMg
         +9aBLgbs58isFotmNzP/HtRSpUdjF4/IesKWgKYtQu/Yt29CyErSthHCOL2NxWYVY8Wo
         YSHptZ60vNxtNYwV8heYDvKuvbfwcuP5jMAWPjh4asBozCRUHrvgNy4G9bnjuEktlEHE
         Y+1MZSJpEqAUYI116pNTX8Qc3zfPFbDN5UZiU/0j0jpJlFG17QBW5pB64ErD8knBOBTC
         AEgw==
X-Forwarded-Encrypted: i=1; AJvYcCV76uTJ1mOt5Ks9kkMjrfAh67r1HLJZWkwH5k2nm1XlTNN7MtNcpFcJQbnmG1L4akyUyDsYaC/Og5G8SyIGowaj@vger.kernel.org, AJvYcCXsbvBi3/RWgg8tTFoVLPu1zUx93lt5W7YwsIPIBwj+46Gr/Y/KgMZkQDYdBh2NGa2kGT+GssZNIvzhinE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGtuvdaoyAYjmY23T64CbDIRxgV0hbXYP7Ham6UF2H/58SNnVg
	cY4TwVDkqknCW9pN3u2l6m/+BP8pCEVU3EmwjZn3K3FhdrELbYgx7FWY69WJqA==
X-Gm-Gg: ASbGnctiTEealxOcoZnuuHVWaxKdcqADRKMqPL6v5+5aauCxR71++av5StjhMhN4ZCE
	ASvGsBxniNMvHuovnPavGphwfAMNvuIBpGTPL/IGH3YKcm9AnY33wYa93up9QrEcacXKelJ/517
	1zpunBd2WKsfir1231GesxADiK1XqYkNDuGFPrURyXhYf6WJDhU7j97dquolvfzpiCoKxsk4f34
	ka179QvrZmBXyzTjn92J/QsnRxfHLn1UCD7k9AWQw9UJnouS054DnBt66JdNUFqpFWoBqpNqzVd
	tUWjgFLg/up4FpCqlyAe98bRiZigFwMvW2+Ji39xRgR4nqgqMSuzKA==
X-Google-Smtp-Source: AGHT+IGi1P4JMcBZ7a2p0fE6Ncl0MFuNfZT+kiv+/pAZHdjnD5GYj+VXot80czFpuCROV0SK54qFuA==
X-Received: by 2002:a05:6402:35d4:b0:601:f4ff:c637 with SMTP id 4fb4d7f45d1cf-60e52d19fadmr1790007a12.16.1751450807064;
        Wed, 02 Jul 2025 03:06:47 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319f4dfsm8995534a12.41.2025.07.02.03.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:06:46 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 02 Jul 2025 03:06:34 -0700
Subject: [PATCH net-next v2 2/7] netpoll: factor out UDP checksum
 calculation into helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-netpoll_untagle_ip-v2-2-13cf3db24e2b@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=leitao@debian.org;
 h=from:subject:message-id; bh=z6ZyZPgKMyV5y5bQXJoqji7LE1KbrdDAaxyolHnuv6Y=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZQSyv+Em8ezt6xanupTxc1wOZ+/b7ZvjABkP5
 5VOnXqPAHqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGUEsgAKCRA1o5Of/Hh3
 bQAUEACde+aTQWX8+OkzokaT1Rs/ZTZQ60U9Atr7ytHd5cFEBwjtWo9P/74udnSJJjaKGOSerPE
 +A7l8AM4X0JthHw5izk/crzdlLq2oe44ZP1Ce5ZkhWy3trigOQ4qXF2rlQY3XS1Lj5f8TiKxunk
 w23OdF1RBHD+qoCah2QVm/XJ7XpqiG8o0TKNO6cgRwS7nst1BmrTCzaZcBqx8+pPlI2AwW3BsIB
 9I6k71qjjmIpCnLEr+WiV5U5sZARP/JCmvYJRGv7GilyTcOq9HL+kHObtVJggCOGRLi4jAiR1O3
 IZ34NVQwJlXnXfp9im+bNV5E33gYGo0fQe6GCt3TZ/60Owr2oTEEPwShPufNwkJ7bKyYpeYmJmJ
 pgYxElLQOx4NgC0U1YIuKx/v9Azp6Pp4MImfL1Sh6X+yanhMKOoLp9RhnP9+NHhJlz4lQffgdwu
 TSbPurYveeP5gl3Qb6b6yF8WC7isv7KtzleEypZdHZNUt6DOp2BI2bEHUoA5PcfdB9dO9Jlc/RV
 gxaj3VDuXhTr8oe+wz4kgG1G0jgAbRgHV22lHdtQGLVtfM6e6TmpeNPvj8yQN0ITsdgvhIbSrRm
 L+8x+qCHk7PSnzvJZ2IZF9nVY3O2jUJkD8hmIxvriYh5B5hgCpk30z86vzjeR0Bhqmfl6xEn5UB
 V9JWLwzaF2fwkjg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract UDP checksum calculation logic from netpoll_send_udp()
into a new static helper function netpoll_udp_checksum(). This
reduces code duplication and improves readability for both IPv4
and IPv6 cases.

No functional change intended.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index ac0ae9630654a..24e6ad2da8096 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -372,6 +372,31 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	return ret;
 }
 
+static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
+				 int len)
+{
+	struct udphdr *udph;
+	int udp_len;
+
+	udp_len = len + sizeof(struct udphdr);
+	udph = udp_hdr(skb);
+
+	/* check needs to be set, since it will be consumed in csum_partial */
+	udph->check = 0;
+	if (np->ipv6)
+		udph->check = csum_ipv6_magic(&np->local_ip.in6,
+					      &np->remote_ip.in6,
+					      udp_len, IPPROTO_UDP,
+					      csum_partial(udph, udp_len, 0));
+	else
+		udph->check = csum_tcpudp_magic(np->local_ip.ip,
+						np->remote_ip.ip,
+						udp_len, IPPROTO_UDP,
+						csum_partial(udph, udp_len, 0));
+	if (udph->check == 0)
+		udph->check = CSUM_MANGLED_0;
+}
+
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	unsigned long flags;
@@ -425,15 +450,8 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	udph->dest = htons(np->remote_port);
 	udph->len = htons(udp_len);
 
-	udph->check = 0;
+	netpoll_udp_checksum(np, skb, len);
 	if (np->ipv6) {
-		udph->check = csum_ipv6_magic(&np->local_ip.in6,
-					      &np->remote_ip.in6,
-					      udp_len, IPPROTO_UDP,
-					      csum_partial(udph, udp_len, 0));
-		if (udph->check == 0)
-			udph->check = CSUM_MANGLED_0;
-
 		skb_push(skb, sizeof(struct ipv6hdr));
 		skb_reset_network_header(skb);
 		ip6h = ipv6_hdr(skb);
@@ -454,13 +472,6 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 		skb_reset_mac_header(skb);
 		skb->protocol = eth->h_proto = htons(ETH_P_IPV6);
 	} else {
-		udph->check = csum_tcpudp_magic(np->local_ip.ip,
-						np->remote_ip.ip,
-						udp_len, IPPROTO_UDP,
-						csum_partial(udph, udp_len, 0));
-		if (udph->check == 0)
-			udph->check = CSUM_MANGLED_0;
-
 		skb_push(skb, sizeof(struct iphdr));
 		skb_reset_network_header(skb);
 		iph = ip_hdr(skb);

-- 
2.47.1


