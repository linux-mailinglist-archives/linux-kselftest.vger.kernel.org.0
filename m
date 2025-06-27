Return-Path: <linux-kselftest+bounces-35993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B27AEBEB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732D33AEA23
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3732ECE98;
	Fri, 27 Jun 2025 17:55:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9872EBBBC;
	Fri, 27 Jun 2025 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046958; cv=none; b=QjV2avjbGrXZhZy1kDg+JOlXdsHHOBYxQWLMLPjlT+KDbei9SKwNpjXXL48xZKrueNIpMF9A/2Hjo6LAxWN68P3K7DuKpMw+uGAQ++PoANxi5igkaHLDSBGPmh50f010djrdRddyr3eM6s9zD+qAU4ieRego1norxTo0m0wT/Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046958; c=relaxed/simple;
	bh=z6ZyZPgKMyV5y5bQXJoqji7LE1KbrdDAaxyolHnuv6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SkE2N0f2VJFMt1ZvXZ7qs+AGHFFIz76f/g2mAsYMFkbAjELXSsXyY0zL8bJHS+lW1363azHiiRHtElwNgAaXHlhNZZiBWSaPfWFoeAD2H84u5BMmNTY6L6XiEjFGocQUlDWOyIB8Z+VYWOhaiPhhpxH3BVeZKfP11G7/q2SmEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so175812a12.3;
        Fri, 27 Jun 2025 10:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751046955; x=1751651755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qUEhiAZpONXJUUW9QytxIAnMQmTyOeLbTuh7J5BUSs=;
        b=PljvCDtqhGQr1FQqm6LbK+evDK/RyhwwT4j03EC87frWo654nbesi9YyvmdFA5C8ZR
         UY4+Xi2K5FSPLE8p/SpFwNBe+En+euVqUrynXq/DpUU5vmKVG4NBFACsmFrPjix9jUUV
         eKZrOa4qTvysoc+fjTNlEExyMO7aPl1/EOcogw7o1sBqiBmpZVK4u8ZLT9EsIKSN3bM5
         iGFJ10ADMzjEbsI0YKrlOOQ/fUrsFkS1TbBnhsb37xxURAxmSPTXWAR6g0m3//f1Bn9V
         UR200Bun0gR5Djhx/NyAJudhaGbuoq4HOK0lmeHH2BXcUsZRY/KvyFyjvIw+Iotb/4+9
         9K2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjzKC+qskvLIonJGGYsE++NDu3UZE/xu45wA2lOSQ2N56QpXe1VFWCkzuBrfikADOhjp/KTBZIt9r0sGw69R6x@vger.kernel.org, AJvYcCXtq+Lowa8cnJ992R4xsGgRd2NQumuz4Ge90pEnUJ7zNdPPJhng24HBDV5TRni0o/21WHnUMBd27I8L5Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvePV85RTpZRle+3l8N2VrNfKm4qASfnrDEUd7yqGVQpU6ZfB
	Rd1drL196G6C38RkXQkhp5qaiAj8GmZPOQiSTN/nr4lGM7RpMmoMudgSCe4/0g==
X-Gm-Gg: ASbGncv0UUQ1Kgq9fgVoAr9e+Wxh7Utti5fcfc/0qEkGiLwHB2I0/ZSXuZCR1nu19y7
	lvV3vi6XqF7fw0eUrPrQvNCgrjIs/Zd3dnd1O6VDsr7oB+kCRKe0PqtvFDaWPh7kMtSP4neUdPa
	O/PaOeHQRq+XnfZx7BNfAdgJnb06ypwV0dLOClTInV5ZIRD7XBii5JuI4YpPNiF9RujRTGwMUZA
	78GICSoPQ+ANGWHNc6YJcJQSJeqgJOyGwQlE7uE42ZVq+ajcIfFzC9argvaAzDgW7ZgkCso139+
	ua3cqwF1Jg4CKBmu/hSMlY0UH/yZ+wmitqcq2s/toUn5OjVQ4HxNhVElf9IcQgfF
X-Google-Smtp-Source: AGHT+IGNWtFfexKYAG6FZcn39pGTc3OLycGN6dxns+/+zG5bybQtNGUpDZWMCvpTFQRN2rJq91KImg==
X-Received: by 2002:a17:907:7f14:b0:ae0:c561:b806 with SMTP id a640c23a62f3a-ae3500f276fmr398235366b.37.1751046954380;
        Fri, 27 Jun 2025 10:55:54 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae360e6ce54sm108646066b.37.2025.06.27.10.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:55:53 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 27 Jun 2025 10:55:48 -0700
Subject: [PATCH net-next 2/7] netpoll: factor out UDP checksum calculation
 into helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-netpoll_untagle_ip-v1-2-61a21692f84a@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=leitao@debian.org;
 h=from:subject:message-id; bh=z6ZyZPgKMyV5y5bQXJoqji7LE1KbrdDAaxyolHnuv6Y=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoXtslVEuPoOCcrE4gQ+5/idXTrnhBg2GM1tKgP
 nFYRVb9zaeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaF7bJQAKCRA1o5Of/Hh3
 bSiAD/0ZPLuRf/HOdCFM0OqmJQ5MwsWT/X8oMNnCWSe4utM75IVmJwtzyFHZTfkS+/BKmIq/rgT
 LIg85XStfawMmpELEtXaBcDo/I9Ai1YVVXS6c7N5MZ9KHKuOKJB90GQ9QTC8cJLlBZjsCIf6f19
 mFuStCOzD0tsX0EbzeQFEf2K7HsDUWfOiW2HEUADv2btvVKzGkcoY9MyLQUXO5AyX7UIO6gw0jh
 K6z/nkNYbykoH7Iv9ei01yav6JXb/n1C3upbZBbyPyn3ksHyndvg+PUpL5UV5BPV2q0STNIB/Ds
 weMMvzuXg+4OCjE+PEP03dQSyATvG8c5U7PRAAZ0VY126I5zjqNIjdS2hDYhf3I4083V9ZpeKDT
 gBLc1L3lfIELNta6yX60L6c9WowDkpfHWD+xD31z6J2xX+xkcThdZuq+Wg6nWquVsPQnyWt90DJ
 rSBa7rwla46hD0ss0rY8K5h3nzK8r3Qhu0O+cf/O8LwP18UO+NLPZxxSugmKmjvqagxlXmYQ+u1
 mnTqDic2ql8R2NiIkSZTDL2Hn8d4wnNcDr/245wdVojMPmH9KffuN4ss/3gKmHEQrto8a7u9IjU
 cr9v1a5qe+pgjE5ydWbs+J5gUHdCdOY8KbVEsLtFTePuGdN8y79hTPhShYvU5mhMEoBCbjI1G6D
 EIphQgeXTRuL/Qg==
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


