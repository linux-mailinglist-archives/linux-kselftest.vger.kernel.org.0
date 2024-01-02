Return-Path: <linux-kselftest+bounces-2562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 166BF821C7D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 14:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB9EB21402
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 13:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D0F9FC;
	Tue,  2 Jan 2024 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih3D4CVK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F81F9EB;
	Tue,  2 Jan 2024 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33679c49fe5so8174511f8f.3;
        Tue, 02 Jan 2024 05:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704201662; x=1704806462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5PNTurghlPI/wU+fXieHZ4gaYw2koYqIseDXj5bnCo=;
        b=ih3D4CVKHytliUvNDPFK4SOlu0n3djAwJpOO1shEhTQBKvPTLtLQgQSs9HWIxNCSnf
         TU4p6PlqnR5APTuS4vKNeEi7X5JyqlpIaldDR6zlKLII80U9f5lEE+Bh4bOudKik7Gm2
         iwHU09tSJC4Jlo1ItAfzVqj/BNiVaEKX/hfRYETGGzkIAwH/4PYCvz1sTL1+VlSesM47
         kMxfzFbmKCvBCz1lwFi9QskHipaEm9yLaaE22ZuntJ74JhBjcFzAU1lFn9NdJbruXUva
         sjOnuVSztFBKXlkVVChzjCYZ2lD98w7wJg7RzJ6LDlxZdqnkPAgJyJQ4zc44+wpcbDjp
         QO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704201662; x=1704806462;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j5PNTurghlPI/wU+fXieHZ4gaYw2koYqIseDXj5bnCo=;
        b=BPHKLjc4PNsqAzprxrA64mKDLXvwrz4K4fjEzYDyn43bJMyBmIxPpRSOVlI0t76OHm
         S67VFAEt7s8/xfuYDarO/VmubbdERW3x3/W2rbji7hyPPa839nLQOd5PYlOhUUs9E4bp
         0DgmCJWIGOzj4poiFYRrizIe6KMkM79KbWa698LbpqwC5YC2nxkmBVhKvH+4dsZJAiQc
         0UkWQXtEoUuu96RhQhDw+JxNSqhji4HlkFB4ukVr1n22YH7etusQHpEsGM8F3zs+sc7i
         1OE6obnahH+8tvhIhYL0KMfJhU3F6oQ7LTOsrHg2z5YabEYeosFTqeJmGuMd8Mt5OnNu
         CcMw==
X-Gm-Message-State: AOJu0YxYQ43VWcrCfQDICPrDjz8A+ooHXbwMf9y1fs3RAn97P0vR/dsq
	eNkiDCLIonRYTOrqpiwxMCQkrE9pcGRY4IzJ
X-Google-Smtp-Source: AGHT+IFLlUav8GWe5NG2HjLMQrfHBduQLQfTxbhgX8wDmq3p883iCjfMT51YVL92baFsVky4mXKolQ==
X-Received: by 2002:a5d:4482:0:b0:336:7f81:d825 with SMTP id j2-20020a5d4482000000b003367f81d825mr9192600wrq.56.1704201662000;
        Tue, 02 Jan 2024 05:21:02 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4948000000b003367a5b6b69sm28254743wrs.106.2024.01.02.05.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 05:21:01 -0800 (PST)
Message-ID: <27d4cc21-1ce5-4417-bd0c-6dd43a92e4aa@gmail.com>
Date: Tue, 2 Jan 2024 14:20:55 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next v2 1/3] net: gso: add HBH extension header offload
 support
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <127b8199-1cd4-42d7-9b2b-875abaad93fe@gmail.com>
In-Reply-To: <127b8199-1cd4-42d7-9b2b-875abaad93fe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This commit adds net_offload to IPv6 Hop-by-Hop extension headers (as it
is done for routing and dstopts) since it is supported in GSO and GRO.
This allows to remove specific HBH conditionals in GSO and GRO when
pulling and parsing an incoming packet.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv6/exthdrs_offload.c | 11 +++++++++++
 net/ipv6/ip6_offload.c     | 25 +++++++++++--------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/exthdrs_offload.c b/net/ipv6/exthdrs_offload.c
index 06750d65d480..4c00398f4dca 100644
--- a/net/ipv6/exthdrs_offload.c
+++ b/net/ipv6/exthdrs_offload.c
@@ -16,6 +16,10 @@ static const struct net_offload dstopt_offload = {
 	.flags		=	INET6_PROTO_GSO_EXTHDR,
 };
 
+static const struct net_offload hbh_offload = {
+	.flags		=	INET6_PROTO_GSO_EXTHDR,
+};
+
 int __init ipv6_exthdrs_offload_init(void)
 {
 	int ret;
@@ -28,9 +32,16 @@ int __init ipv6_exthdrs_offload_init(void)
 	if (ret)
 		goto out_rt;
 
+	ret = inet6_add_offload(&hbh_offload, IPPROTO_HOPOPTS);
+	if (ret)
+		goto out_dstopts;
+
 out:
 	return ret;
 
+out_dstopts:
+	inet6_del_offload(&dstopt_offload, IPPROTO_DSTOPTS);
+
 out_rt:
 	inet6_del_offload(&rthdr_offload, IPPROTO_ROUTING);
 	goto out;
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index d6314287338d..0e0b5fed0995 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -45,15 +45,13 @@ static int ipv6_gso_pull_exthdrs(struct sk_buff *skb, int proto)
 		struct ipv6_opt_hdr *opth;
 		int len;
 
-		if (proto != NEXTHDR_HOP) {
-			ops = rcu_dereference(inet6_offloads[proto]);
+		ops = rcu_dereference(inet6_offloads[proto]);
 
-			if (unlikely(!ops))
-				break;
+		if (unlikely(!ops))
+			break;
 
-			if (!(ops->flags & INET6_PROTO_GSO_EXTHDR))
-				break;
-		}
+		if (!(ops->flags & INET6_PROTO_GSO_EXTHDR))
+			break;
 
 		if (unlikely(!pskb_may_pull(skb, 8)))
 			break;
@@ -171,13 +169,12 @@ static int ipv6_exthdrs_len(struct ipv6hdr *iph,
 
 	proto = iph->nexthdr;
 	for (;;) {
-		if (proto != NEXTHDR_HOP) {
-			*opps = rcu_dereference(inet6_offloads[proto]);
-			if (unlikely(!(*opps)))
-				break;
-			if (!((*opps)->flags & INET6_PROTO_GSO_EXTHDR))
-				break;
-		}
+		*opps = rcu_dereference(inet6_offloads[proto]);
+		if (unlikely(!(*opps)))
+			break;
+		if (!((*opps)->flags & INET6_PROTO_GSO_EXTHDR))
+			break;
+
 		opth = (void *)opth + optlen;
 		optlen = ipv6_optlen(opth);
 		len += optlen;
-- 
2.36.1


