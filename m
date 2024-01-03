Return-Path: <linux-kselftest+bounces-2615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE32822FB9
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 15:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A771F21B35
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 14:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88371A59C;
	Wed,  3 Jan 2024 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq/cWEnI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8A51A703;
	Wed,  3 Jan 2024 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3368ac0f74dso8767499f8f.0;
        Wed, 03 Jan 2024 06:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704292868; x=1704897668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhUIcAiEUXzPSJT3qxxOxQiU0WD1wXx0pKqJFtc5p9E=;
        b=iq/cWEnI015RUcHibu3ssU7cgQ+eEBvDE8xaQYGNAfV44rJf0ftE6jT9zDxarH0X3s
         wJ0YFIVNdHHZehezVM8Sf/LmuqoBOQ+EOtlgptAgF7NcHsJPXsEdtsisjEMp+GEdy0n2
         TNC4n2p8jj0FF4XAGn795RKhBeu85Dbj0YDWJ5vf9aRc3W621+rTb65pWu7JelTSnhEq
         R3x2SHWmvOHsEkrqJ77aECP7sFwUJVmTYJeZFTcvT5yOrFrWMyqRUAleRADu9mmkbFTr
         SLjVaInheifXygmZEVFuClnsyDR1VilcphRmyGdWnjuZtP+V1abA2PhacEXO4ypmErjh
         A+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704292868; x=1704897668;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rhUIcAiEUXzPSJT3qxxOxQiU0WD1wXx0pKqJFtc5p9E=;
        b=MWMiZwDrl2vE/0ZsWeNYQDCEZXM447+dL+IHCXb4n9B+4/JffYWLa1JmzivlHa8Opg
         3LAXDu7umrevaItZFoQXK72zi8oDpFfSd5rjw21IE1AY5bLD7YPl6dF8e3UFQwwQJYBM
         7CjOu8j5I8wnuUyBV7BznfsRHgr118wcX7fJ3yJfqLmS0xbWEObvwwZ6gIQXg2B5UrP2
         EVH8a91PWzW9QojQILBwn63jB/mq2vr1lsgjrznKvmvcyLZ4at6re7yt8cqRRBUT3E/P
         AMrLYbD0VVAOjSfUE4BuQ/F8d6rkB9YPkZ+danXQqOmEWLzhA+sB6/rxOsVCBPIQ+sfv
         yqag==
X-Gm-Message-State: AOJu0YxFyNJBD+lEL6QBRz4vfPhA4lN6Sx9F9j50sLSGM9OJmFCMfsF6
	TigTYG3q0gaXpGRbjQKEBJQ=
X-Google-Smtp-Source: AGHT+IGYBh/yEQz6jZQyfnAwTa3hX4F6tq0xACU+4Z5g00NvEVBz9sNCjVyeDF2MEs+b+0TqrY9NBw==
X-Received: by 2002:a05:600c:470b:b0:40d:7246:da51 with SMTP id v11-20020a05600c470b00b0040d7246da51mr5301807wmo.93.1704292868372;
        Wed, 03 Jan 2024 06:41:08 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b0040d81c3343bsm2509483wmq.42.2024.01.03.06.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 06:41:08 -0800 (PST)
Message-ID: <d4f8825a-1d55-4b12-9d67-a254dbbfa6ae@gmail.com>
Date: Wed, 3 Jan 2024 15:40:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next v3 1/3] net: gso: add HBH extension header offload
 support
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <ac6fb684-c00e-449c-92c3-99358a927ade@gmail.com>
In-Reply-To: <ac6fb684-c00e-449c-92c3-99358a927ade@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This commit adds net_offload to IPv6 Hop-by-Hop extension headers (as it
is done for routing and dstopts) since it is supported in GSO and GRO.
This allows to remove specific HBH conditionals in GSO and GRO when
pulling and parsing an incoming packet.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


