Return-Path: <linux-kselftest+bounces-35997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFDEAEBEB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8F4566667
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AEA2EE98B;
	Fri, 27 Jun 2025 17:56:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048932EE5FA;
	Fri, 27 Jun 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046963; cv=none; b=ctVdkuV+ZmuwCuHman35EuTtJ0SESuiAGo9+vFtC/xT9u+b8jGyaYN85jr+xyNrAEv5K0D7WcBZP0fTjQK/ePUFAtNPXvSYHRFHyU+2AwPK1jReR54v+NTthooIYJA+DmUTkqy0khraDZhYshrnh6xiJ4A8yRjlADJ5cWpUVGnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046963; c=relaxed/simple;
	bh=NHC97aT/kQf6DyeueUL+Np2VNwBSf75NdsGhKFItyvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K5JsRY5GvSfhlYcj/nGgzoMdAgcOjBwwwrGQqAvh21vhCSniFY4Sm3GWSX+tzsJA4U8q+WiEREwi61rpMhHY32lW9XWktYjXSMPCRb8UlQqtJoWs1Q7tx3QmorBX0Zer0z5DKl3274Uck9BLUmLNbKgomYmdN6p6MnbsKZR/4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so8775166b.3;
        Fri, 27 Jun 2025 10:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751046960; x=1751651760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+LjrrAqRFuNuvBnrVE1gGfY7DUJLU7K/HkAJCFE+ck=;
        b=eZaYwH4s6fTtc0vQ1Tdgw5q35/+6qlieK0pi0oV0j+NgxUStBmOXc9LqmG+gYPlAO6
         6cEqLyiK564mSy+2lG8p8Qo2fTJf4CiZ/8nJ+/9WAZ5KKOhMC0NsS77BJEoLJcl1aRtP
         A0bnO3u/aCq41RQoOq44jnKmqEjRV0YyjE/W9qQJcEn5S6mnXARL8RE9wEj1qzd8XLhi
         m1GTQzNq+B/3j/vvoynYNebrMoABC5ZR6XQvZhFkDMCq/5rZckSWXyzD6B2nwKeEYh7/
         ZaNYSrQwKsX+4JlWZV19XRmd1VbBVhNjyWjIhvjYHnmoSgT6laNoqdFuOH/KBY0O8X2p
         teIg==
X-Forwarded-Encrypted: i=1; AJvYcCWCj03ANWLf1HAVZO1t6+lW0swbgjCWZsFR54dTzjHk8AcI/H+ep4TbR8ZEvzM2HIMbottDfinD1yHgOfZbtanU@vger.kernel.org, AJvYcCXdFs8+5YuiQGwV/is3yY3gF3tMmyBYY1PkWYWZ4MY0fHZaWpP7KQRm/Mi1StX7Si3STsUJw5KKheCliqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXrFYaIdZZ1wPDz064PzhuhK+6S+tPWryTckLa7w1PoDcTwVEj
	mfL66xELeAlBL0/xEU11cPjMugR2/YiN0Zmj+5Ldo4CUcV6z6uj2BtpJ
X-Gm-Gg: ASbGncv2VNSQ0zb1uI/7SHyo7PUJu7+691EbPoYg5UV9Hca+2n1KsJ6YLths02P/2Le
	Y9zG8oZbJYA0rRbtRMe3yQ4BsF16itstOEe0ObAjiT9CPb61ae32srUkNDCGzjaYyW/KJ03PXRP
	KFHNXj258bYUMPhzM5qOEQb7IxAfmFgCOQpYZNpZus/kq7UCwwvG1KO4ZeEU9v2q8LWgTpywNGO
	mTm4osZI3v7WbG/hHRskwzFQeMLdu4as65+qTnV4TQJDIZXqJ7DVoG9pGp/QzajdZeg0SObKyCq
	y30MaUToN3p3eqLJnugc3W9ixrjwc7aJXr7MrsyKKr45HTg3eAy0
X-Google-Smtp-Source: AGHT+IHoCWnbMx61F0L6qkW6UFUeCy8IsXYPNmEsz1xXZrlI/h6vcdq2MP4uhKk+Uwk4ONrBIeo4SA==
X-Received: by 2002:a17:906:478f:b0:ade:c643:62ce with SMTP id a640c23a62f3a-ae35016e6d6mr424901366b.56.1751046959886;
        Fri, 27 Jun 2025 10:55:59 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bd2dsm165792766b.113.2025.06.27.10.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:55:59 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 27 Jun 2025 10:55:52 -0700
Subject: [PATCH net-next 6/7] netpoll: move Ethernet setup to push_eth()
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-netpoll_untagle_ip-v1-6-61a21692f84a@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=leitao@debian.org;
 h=from:subject:message-id; bh=NHC97aT/kQf6DyeueUL+Np2VNwBSf75NdsGhKFItyvo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoXtslHLWQv+0lSWBA0BmmBBQgeBqfXV4vlJrIw
 MqcXoc0LsuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaF7bJQAKCRA1o5Of/Hh3
 ba7PD/9cCOW9ZwZq7kh4XbZbxlwm5eTWdvbPKYYL6d9L17tgWVXymWgI/OVgzIzuFF+4/+THq2+
 xfFDzLwwQb55C0Za3sCSlet7Fa+XPzi9RyeYW5uCuHl3vZRqAPX4qWs+ITOQ4lNGb4fBUAxipmL
 SQ6bO3ucFJzoV+kM9g1MOXU/yQqRqJM2MrsBAHVGFiAaBDttKcdG6WQHOkf6b6nc1nZyRsi17E5
 E/8H9au0UR1Cb7BPzdcd6tLZCxFhFfEPBeEJBwDAqMADgaNdOOU7bILv0iwCvJ5HkBCaCDyh/gD
 Uw+yunJuW9bapleva6RPUiOObOxsbRyHhxKGVokviEG8QEvZATv/csKijEFbemhFQbVa4KOliJP
 hnnb9u4b6SmfropSmpiUNHELa8ohLJkKPibt25xv7JhhgOK7KxRv8yvzfy4Dzaeeev0us0fuaH7
 TcBFTa6vHYPo0nClXKIF8a4Tp+rG3ogsyFyeLVBBQTWZJuc+z+BAIgS66E7cNZze762MFXzMfsz
 E/Z8bgpILKNeAIQy0gvRUry73Zmar2KuHhcmsMG2llajwZ598RQB3elMHT+9/cPBOFJhru/evOF
 bNl86nKBDxKaI+jfC98Db5/u6wnlt1XJXUDWs1Y4MxhbUVJDv9YZqWnBtgaaoMjE8uxlqZhOKhK
 HlaofcfFd8c+pWQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Refactor Ethernet header population into dedicated function, completing
the layered abstraction with:

- push_eth() for link layer
- push_udp() for transport
- push_ipv4()/push_ipv6() for network

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 70035e27d91cc..9ab3cf78a393c 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -491,11 +491,19 @@ static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
 	netpoll_udp_checksum(np, skb, len);
 }
 
+static void push_eth(struct netpoll *np, struct sk_buff *skb)
+{
+	struct ethhdr *eth;
+
+	eth = eth_hdr(skb);
+	ether_addr_copy(eth->h_source, np->dev->dev_addr);
+	ether_addr_copy(eth->h_dest, np->remote_mac);
+}
+
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 {
 	int total_len, ip_len, udp_len;
 	struct sk_buff *skb;
-	struct ethhdr *eth;
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		WARN_ON_ONCE(!irqs_disabled());
@@ -521,11 +529,7 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
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


