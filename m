Return-Path: <linux-kselftest+bounces-35992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041C2AEBEAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6BD565DD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE42C2EBDD6;
	Fri, 27 Jun 2025 17:55:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54ED2EACEE;
	Fri, 27 Jun 2025 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046956; cv=none; b=jlZmNElxQIVb7eS85oNHJedYQE9DhoBPytVjZ92P9jFNOqIMl3SaFIOjmq5OrVFZ1qLCC4opWzUuS7HGZLlB8lSzr1oI4ROeRIo9nszjR3ayL3XSh87bZFAN0tZoUZOu8ivziQha05LFa6HOAgXlde738LdQZc4WQbvPDZA6Iiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046956; c=relaxed/simple;
	bh=jbCjWV/h7n2SHM7aPePgMluwf8TLq/orMZ98gJOmxn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b1SY7MKMAUioKpRuKL6PB3D6GEUlpY9scuXDwgaoidBXfzY87LeOX5DU0AYO42uCl0NBvOmRunkuHiwixwVWjxi3EG1deNEmnV+ZlZldBHSYhOBAbvSMkgErP3k1khCd6IZDwNPsJCV3/xTlIS3Sr7+RbpSKtkN0vVnMH8cXWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso163856a12.1;
        Fri, 27 Jun 2025 10:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751046953; x=1751651753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdAqTjFNYTelvz4grTCp7T82BdTogW49IVN7Iv0xIeg=;
        b=QX04v4xjtAn0oG4rdBB+F6EUklbhmdJKaUUhfZWOTzBz0N9hDrrTQd7Ef96XyWuw3d
         En3LNnR35GoofDitKL1M8LGtZt9PNYLwrUCd9Zt3XTVenJXglSTczPOIMom9QzDfoevW
         1cdyI/xmg27CmwJlFtPQUZC4yRWCYqKNDpyRKTlyMB98RnHeY3FPuiWj8ttW0WFeH1yx
         Fb+3a1yWaQtyHlKD/UkPdmmdnFm0cbUGvlv5VnCNf8RORLz1y/EN2Qg+HdW4OKW2ob34
         PmROalnm6fKF1Bc5P7MGibnrTSakNmFyhErqz5Zx2iT3osDiyV2m+9HXtryO+uwV0Klx
         JZeA==
X-Forwarded-Encrypted: i=1; AJvYcCUn+LLVauE8lcpokO7hrSzaUbf8ybJ2KCp0xY/Frgca//Zr5YV3qhyP1qcfF65HAIpMKByFFWqz+o2/NZE2lIyu@vger.kernel.org, AJvYcCV23uLXcks/bX67RY3TMQF5D2jZ4jTsAVYFxxAPVMtIYQDW8B2NJDaM10NCNR+Tk/t4oYwNFqWQr3uKjbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrmYguiF9ZveGqLp/0JGcqrt8hBb5cQPFsksKkuNHRrkEn7mgX
	IGVKctn2X7zr+59zgjxZhloNec2CfIoadOAztOhbjG90mD0EY6ge4HfN
X-Gm-Gg: ASbGnctfppDSr+invxuWyE6I3NwX/fltWiYdSb/ofgZPRqewrQb7DnFhra0ujJ3v+0p
	/7wx0Wu1L5DvkCxbTk6YM7X1O0x0bP8m5woDQ5MELjP41GtNxfbPKPsDROOD++JrYYwBl7J24kZ
	LXU0eM8l25mB8NOSkkRC7i0hlK6R4QIPpdvCbnS8cxJwz5fMZ3Bu4uyokRNufIp+zdIe02YoS1a
	tL08TVLhs6YmtR3JQGcTuCh4nvLnOUcENgcabAyaOecazuj9Cn7rXDVDMjWQuFWxEI9Xajt6L3m
	wdmvL6b3mAFx/wDUu/Gxc5e/yYHzFPSC5H4G5KfBFHRbLZL7Ulb2
X-Google-Smtp-Source: AGHT+IHscVx//xOJEJlpDsWzjwH1+b1+1wS2JE2Cjxc1bD4rSPBviqLSG885/ydsRTnSkUL0jLTryA==
X-Received: by 2002:a17:906:4fc7:b0:ae3:6390:6ad3 with SMTP id a640c23a62f3a-ae363907084mr218911766b.22.1751046952999;
        Fri, 27 Jun 2025 10:55:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bcedsm165603166b.133.2025.06.27.10.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:55:52 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 27 Jun 2025 10:55:47 -0700
Subject: [PATCH net-next 1/7] netpoll: Improve code clarity with explicit
 struct size calculations
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-netpoll_untagle_ip-v1-1-61a21692f84a@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2146; i=leitao@debian.org;
 h=from:subject:message-id; bh=jbCjWV/h7n2SHM7aPePgMluwf8TLq/orMZ98gJOmxn8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoXtslurJE24JlCTTK6aAUL62RGQwEwDEUPhVPS
 iyLMnv+qq2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaF7bJQAKCRA1o5Of/Hh3
 bVOyD/0Wyr6x5W73Q58nAyfPEj+M7Vbjt9FHIfElBUu5ZUdcQZNf6e5RLqV9NCWNnBP7+C7vdKG
 yCWRwU7aMQe0im1dPBFmO1Dto/KpYmhx0ELyhFp4Ff7d0kC+pSWt3ZqnaDcywiYh0bz3y0ZwCBB
 nk8pmoOI7aodEHCIFCBTz2/4qiSBnzo0MzqCVvOtbET5RTMfta2vNgSxoT/696e9jABSArgaWT4
 ZQqCNDzFG09V6PiI5jUcHOCJ0zgJIj4aOPzdiWWr03caeogFXe6evzAAiLJlqjRS/EcEyWgoR19
 tJq44n1Mds9twGhRaxQuBBfVk7XQTgmsBUwqCmPvf3YigTSqOOgAFQhmPS5RQ1sIt3aHUq4OWZh
 7J1C75rP7GRfbM5lTp8CQ1vE57qYplzUmnp48tOANuYVbdedr6Hq25UK/RoEgqRrj//11PzQhg6
 BUtaleVHdXrpF2Y49D2qQCES83OdCP/aY9GtTNqDiziUiCEFeiNeGzRR8eBbpnO+WvhlJLb1PqI
 d/HK1mmNGDN1wo/D8Q3Ma02ilv7INoj9242MIAbcbJeo2rB08vU0NGDEuB/y1giC/5tK5not/3N
 BmKbZhVlN5d29AkHfwq1boDu4VUBPvWaAWPY1ceTPIws62NODNSwG91zz/4UEgytv+gjqJShTEZ
 3o3tCPTF9iwPK6g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace pointer-dereference sizeof() operations with explicit struct names
for improved readability and maintainability. This change:

1. Replaces `sizeof(*udph)` with `sizeof(struct udphdr)`
2. Replaces `sizeof(*ip6h)` with `sizeof(struct ipv6hdr)`
3. Replaces `sizeof(*iph)` with `sizeof(struct iphdr)`

This will make it easy to move code in the upcoming patches.

No functional changes are introduced by this patch.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 54f9d505895f6..ac0ae9630654a 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -402,11 +402,11 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		WARN_ON_ONCE(!irqs_disabled());
 
-	udp_len = len + sizeof(*udph);
+	udp_len = len + sizeof(struct udphdr);
 	if (np->ipv6)
-		ip_len = udp_len + sizeof(*ip6h);
+		ip_len = udp_len + sizeof(struct ipv6hdr);
 	else
-		ip_len = udp_len + sizeof(*iph);
+		ip_len = udp_len + sizeof(struct iphdr);
 
 	total_len = ip_len + LL_RESERVED_SPACE(np->dev);
 
@@ -418,7 +418,7 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	skb_copy_to_linear_data(skb, msg, len);
 	skb_put(skb, len);
 
-	skb_push(skb, sizeof(*udph));
+	skb_push(skb, sizeof(struct udphdr));
 	skb_reset_transport_header(skb);
 	udph = udp_hdr(skb);
 	udph->source = htons(np->local_port);
@@ -434,7 +434,7 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 		if (udph->check == 0)
 			udph->check = CSUM_MANGLED_0;
 
-		skb_push(skb, sizeof(*ip6h));
+		skb_push(skb, sizeof(struct ipv6hdr));
 		skb_reset_network_header(skb);
 		ip6h = ipv6_hdr(skb);
 
@@ -461,7 +461,7 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 		if (udph->check == 0)
 			udph->check = CSUM_MANGLED_0;
 
-		skb_push(skb, sizeof(*iph));
+		skb_push(skb, sizeof(struct iphdr));
 		skb_reset_network_header(skb);
 		iph = ip_hdr(skb);
 

-- 
2.47.1


