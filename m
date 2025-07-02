Return-Path: <linux-kselftest+bounces-36290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF953AF1135
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DA63B4A5D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E5B2580CF;
	Wed,  2 Jul 2025 10:06:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F378254B18;
	Wed,  2 Jul 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450812; cv=none; b=p7qPUoMsnZiAl7GzhhLw+OJHCTVfHr9tsZAaDyh6qdn2vLeMdSP4TzVJX/pFNLa97EJbj2f7MGFkpduaeFjbpuWp1SsgMZtNN4ugqIga17mtI3pgkTiyibJ2q+3lcu7g5FxpVi9iZib7XsrCE/fpd9n6+sRKdqYPCVMUeAjKNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450812; c=relaxed/simple;
	bh=S45p4GYDOIgPeogkQywbhpuBDiWH/N8B6jk1HuoCwrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEA9Y+ILB1LTZminMBj4t7rMH6Ft4tKINwJc+GRVxxCzS+Rj0jH0G/9Nmr4NKbBbF0T/G7KNnchfnDXVEy6+NTADl/kDbDUo0VMUYrJB9LpWcTY3QMPWr4aLt2vfqMz/pFzpnhLirs6kppOjsnJLjVGnV+303EL8znOSLH2X0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae360b6249fso855317866b.1;
        Wed, 02 Jul 2025 03:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450809; x=1752055609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNF6KD9tDOu5iPqaXILqcxFXrB8p2Oad18HGGU/SHQ0=;
        b=XwHWm7y3OZHpzQIpK0POGFobiKaeBkCBtO4sVH3jT7e5bTmUSy6/cAH+l6F7IJtyU/
         BEG6lWH7HNk+W0nuFehmLNlT1AYPiwbD3nkk1lvpbtfPvbJzeaHwXpY8MFYCxyewE2i4
         2EbX8GAHBfD+WigY0yaxilsLTFnX70mxuahlw8GYt6FZRZXldWdpUXeuXNdk7uhHRxM6
         09NSB7+Ee/DwMYAvD1KcnNGl7BE1/IXvgbZO/JdxzCycxhawrnazDxHLA7vf8hDa/bj3
         HHTfIMMm9XZD43smj0FKgtjDmXi6qxw53ejEpSeJcciW47i550br8ZknyUQDn3X1X5VY
         S6sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqh0ncG1GEfv47bnx5zO3lPeNqoA8HkvLRlsuHPeE2gLPsxsbdosIMaWFGavui6DcooTLs75jzy/hv3hQ=@vger.kernel.org, AJvYcCWGQSLMjtvmk/DbOlnDf4n2yf65at5Tb+LY02/jgvcn8rTVk0E3bN2OSnVe2Nmx6nJcevXYTdJlT/nqlgkvpXfC@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+8v0L2bJuZQ16ihI/RRbbpjb1ByBGMnwrxjNzXu1MMD314NM
	o7ZEal0+gx2ZqX6gebMAXNeArxQQApHSQo5iY2HvOKnPX0Q9wbY8ZoZ6
X-Gm-Gg: ASbGnct0cp0zM3+qaOubUwjBFH4tYLYkYoC6CoZg1pVP83TSgxjmIawGz8eRbT9GHEJ
	bfQ3wqMXHSo1dBVxTPN9s35xvPCubNFWocVync/vjpsfJ122MuyR7FGasYjGcWt1ScSmQ4oK7Uw
	1nk/qWzQEbbBtmns2zVnTrgLRRUN81rwK+35ZlKkFtE/AOP6oc0gllV6iDxpVvp5FEeVo9OJGXX
	XPwXq8QRRSJN3cRNQJi73esezmFk+S3FGwPpRQLsoSUIEYNz7HZ0mid7HCZtnbOh2QNI8j+M0up
	0CYxHvvSeVEwmuMDCCJiFcHIAFBVQbgLpbkxMhcCmww2Gj8decL6pg==
X-Google-Smtp-Source: AGHT+IEJrK5XzqrzJ4clbVrArMK+eIMUJ7/XFvME5fCNNH1oypj1tCzwunYcNTOceK/+ETZIusPKqw==
X-Received: by 2002:a17:907:7f86:b0:ae0:c539:b89a with SMTP id a640c23a62f3a-ae3c2b5c41bmr216849866b.19.1751450808755;
        Wed, 02 Jul 2025 03:06:48 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60e26b7ac4esm3292426a12.7.2025.07.02.03.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:06:48 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 02 Jul 2025 03:06:35 -0700
Subject: [PATCH net-next v2 3/7] netpoll: factor out IPv6 header setup into
 push_ipv6() helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-netpoll_untagle_ip-v2-3-13cf3db24e2b@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2665; i=leitao@debian.org;
 h=from:subject:message-id; bh=S45p4GYDOIgPeogkQywbhpuBDiWH/N8B6jk1HuoCwrY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZQSyU+E0jTrWiXIiy637YsXp55CdyqkPSMv3X
 cJ873Q8tY6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGUEsgAKCRA1o5Of/Hh3
 bZxqD/9zqGFE16TouDilN3ybC7ba9L7l22PP57M8SHRqTuQuHLPzseuA23/dgCjxRl7X4qWLlOA
 vi7E04J6DOLHIjbL0y1a1HDuImEQaRG/RLWtO1lCDk7jWYGQ2EfChUpMm7IqpqwZfg5VXytukEo
 +ERNHe3DeEMOlf7Omd39HBhXXVHfbeGIaWzHH3JQETBlL9Z6OD615SYiqCHGphIG+tR3DKp2tgt
 UuAJILxdZ9x5uAzlK+SRrxekflPeDfzitgyByALRANMZX8/wY6DiIAW6uSq4VB+BMwHHYkmG/wK
 xG4NxjBIVYLVWPYAkeT3e84rR76L5hxOpPaxYxeRnswqUYJUWXlz8OG9cyIMDWlQhd4LN/k5Xhh
 CCfhNV/p/vR62TzV6U3dBPy6N0VgFG8FMztX4+xZrpnsh5TfwNmnUGyuC+APfkahtTEs2HBkEgj
 Fb+Rpv/Srt9IVFBGGEBu4Lwlp2irFy+3s/MshHCd3oiF/d0EoV+uivmqqm3zInlJC8yOUzeWuJg
 F4twpemzhW5EFX6u3ag/UGE70Z9fczcMt0EtN7FkCOInUuTXfLwIL2yYMb4/wlLhbKP5HH366P4
 k4FJsPpfTHLTsicYC1ybwrQl2raR1NWaQ4tsU4X9WqmzJpgVA3oEE5eaGUFbv9fUfCK4arIbT1a
 T0g5wfTCQBh2kgg==
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


