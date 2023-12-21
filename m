Return-Path: <linux-kselftest+bounces-2312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA2381BE88
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 19:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720D0285451
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 18:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CE664AA1;
	Thu, 21 Dec 2023 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCeeHp6E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E56518A;
	Thu, 21 Dec 2023 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d352c826eso13890875e9.0;
        Thu, 21 Dec 2023 10:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703184939; x=1703789739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzRL/kaIkL+FCfYHWzRmGBN8H4sfOu7t1rXgZsR+1BI=;
        b=OCeeHp6E/s9POgGBtHV81Ovrl6uILmF1bEqlnjjGr+6F6CVslAavmcNQ71qV5EOrgp
         FKeJy46mwowvvW7S8ssRyGso4V/BCTuzFb8swp9C+aZpLWw3IecDO/901jm7PcE7Y6EP
         jYvQ5xXR8xHaD0j3WRIszttescjdbaHNG3tKzCHRZCkqhu1aEkXVTMX5msA4zaQW2Fsx
         LstUcQaSWxd+0SBpJp0+Ide+kimeZ9/OA1pnW69KwyZtVbFRA6CGh8xs5CsmxKWrBPqL
         /TF4RAvTxPTWf9XOAyMukyymnhQYjcXZbvHCne/kLs0NbxQVV6gQUQed4kSUg3taP8el
         Ux2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703184939; x=1703789739;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MzRL/kaIkL+FCfYHWzRmGBN8H4sfOu7t1rXgZsR+1BI=;
        b=BsCh6K+WriuFnOhq1vpG3akSvhfzFggakma8+pT3s6H3j3r1EAmlCzp7FlXcfx79l3
         2vDjRsLaxm/UhFC/qogxmC/bFi57TetlhP0J3MQrbf3nEUsuKwA5gPhUzlFpK8QyyeRB
         JOlGMuW0NdMhD49gGInv260ERRe0g6mU6GgQNB2GAO6DNkUsJJVBJ/EThgaDSIL2pDy2
         cHKKmZBjagApKt8f5mNtAOG3J6DWasWB+aa3DANRY61fjQbz9H2I8chJBwr9GyGLU1w0
         Vyvw3gYD/52oRtSjU1cnrDVaq4ahIUxr0BtwZrU7SSghbeY8ZCEb8VOLSanfiYR1ed0d
         9PHg==
X-Gm-Message-State: AOJu0YxiLbfJ26l3XG3/A5NWqIxEdczLJ792/oKyjoZPQMV4FNCWrrwa
	KCwGFbYvooCwvLl4mROyhYI=
X-Google-Smtp-Source: AGHT+IGFUlVEOxzVfAgpmsAytp27NgQaIZj3k+0l8jqfEuwmqyRYB6ovrt47LAB8sA/sjM71fvPKBg==
X-Received: by 2002:a05:600c:3511:b0:40b:5e21:dd34 with SMTP id h17-20020a05600c351100b0040b5e21dd34mr103969wmq.98.1703184939049;
        Thu, 21 Dec 2023 10:55:39 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0040b4b2a15ebsm4317478wmb.28.2023.12.21.10.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 10:55:38 -0800 (PST)
Message-ID: <e8b01e54-b623-44ec-84d5-406ea3b0c80b@gmail.com>
Date: Thu, 21 Dec 2023 19:55:09 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next 1/3] net: gso: add HBH extension header offload
 support
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <f4eff69d-3917-4c42-8c6b-d09597ac4437@gmail.com>
In-Reply-To: <f4eff69d-3917-4c42-8c6b-d09597ac4437@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This commit adds net_offload to IPv6 Hop-by-Hop extension headers (as it
is done for routing and dstopts) since it is supported in GSO and GRO.
This allows to remove specific HBH conditionals in GSO and GRO when
pulling and parsing an incoming packet.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
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


