Return-Path: <linux-kselftest+bounces-23506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CCE9F66F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 14:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBEA1896A01
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BEF1FBEB7;
	Wed, 18 Dec 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX1ApjrK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22D1B423E;
	Wed, 18 Dec 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527435; cv=none; b=BNrR6XklckZbORhb3atFXeZh4W6PLCkP0mGTWxi2ek31+Ld9vZHECmrteo6vnAXNznRE/nlwvLbUpoOtT5cS+WuqipgmF9kwsMssxGHNthrW7oJSVOGaaM+Sbil8Z781yJtiSxAlQA57G+h6J7O7UQ1I/AkgP6tqWSs2+sP8iVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527435; c=relaxed/simple;
	bh=7cGPxfnNq5yiQ2uUz1I87Ai/9MiFtraEfBlwrKXtY4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwC33EgUitcz/3JOUrsHrzmQQyo0BLusPAPtAAKwpQypbRdWzipggm9JKKVfA0URqFezINQluwd9jBMV0WSvYbKhRKlCY6/85psb+l4icZnE/oVp6sRwDLnm1295N8LsiqMhQ+q+nMZdMYEtAl7D9oISqeF2y/rKLDyIbPlC+bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX1ApjrK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163dc5155fso56034765ad.0;
        Wed, 18 Dec 2024 05:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527430; x=1735132230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKRdbuSYL7hnJpCbxB6/aqEJFoCo8iX729XZZAsUkqw=;
        b=WX1ApjrKSCPOyATiok7JMfwd5sYsJpFj/0OUjClOIR8JMZTBPvIcPZJhpBScv7l7pK
         wLLduNYRX3HXCDf3+4KF5G4yhNNPq+W6SGrImvV8RzDdOQ8G2Ef6gBRchlnDPWv0efNM
         hieuO9XaSZy95nkWZNd+neqyOjwjYRs6gdSp4y0ozyzRODG+eWfvfZebUrXZkvzXT1Ch
         PZ8qPUw2AB4l6BFGbDW7nRXFPAD/Mj3Uk30NB+xNi9qAT9D2RWyLmSGdjAIdDo9kXVZ0
         5M+59L4GEwY8+Y4HqC/G3w+hLAk3Hc5kqBpSxy+LcZ/pxHNN6cKwfWEEGoOAGv46DfOP
         D/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527430; x=1735132230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKRdbuSYL7hnJpCbxB6/aqEJFoCo8iX729XZZAsUkqw=;
        b=QUdNhIz0YCJE4cMBcZvU6kvBePgBe2R6bGc2KdVRQTazpSEWz/DmylXqRQZVVUW5JQ
         w5VVq/dTYKCkT525sy1JbwWC/dlQFN8+31x+g1qWr9UOyFxS0uhK0FSvO+HMhnr0i/xE
         5L13yBkkrHWgTGb9yY3JZjUrzdtmpgWsPqaakbvw4UUfISpon6++qpnxAdlW5OCCagcG
         TWDVj31ifMyuvkJRZKBpXSWYhd2yjgzjY4x/oXWfztoXwnH196ymGdpEtOcmbGyveRWj
         9pyKHiu7JwRU7yxFvJpdT7Vw84W84m383G8NOVfFaLv4EKkj37P6bwwemszzFEVg6iXQ
         5Qeg==
X-Forwarded-Encrypted: i=1; AJvYcCUBaEfNqWUc69kmJLnJS27KTF4fo5Y9VnQ7JI518lHYMwM2K29o+DmSDm4OcG+PAGvCVzbuwddyrA3z0Q==@vger.kernel.org, AJvYcCUyx21jtEv9ZC1AD+oMwoGMKgQqwyU4/YvWf7oECT3+rM/NBjHkGWYZnYXYHT0dFzB6JstHePD3yvlaIq5A@vger.kernel.org, AJvYcCV5ht67sbEermWtg8HmOLO2n22oOCjaUh4yqdZ7ihNLo+8glFuDhQWEeTb9EisvCjppRmYzx0n7A6cm3S90CWvs@vger.kernel.org, AJvYcCVGhSBbY6VFHKr3RKRYRBgjguxvdX1tqoqEnYjEIQHFBlNnAKl+89V3mXz5iJ/l8x1xr2kBWl+N2WpUWg==@vger.kernel.org, AJvYcCVbfUcyybS5XllNVoikl7UhDna2DXxPChWRL4e0uyGuDgO5wtMZEs9v15jSzvLjdZ9zl4g=@vger.kernel.org, AJvYcCVjw6rYHFDKFZCjaLhGVVdUHzPP036BBG81fdCMBX5QR1nSVqJUcvjwyAlse5RdZGKVUry57vv90Zxnneo1D6M=@vger.kernel.org, AJvYcCW2ZDYjqDUSbdcdfLX+NimCjv5myDrnRGFqUHPodrve9tUbkkosO3p+gqKkPYIpIAPl5xWs04DibLWe@vger.kernel.org, AJvYcCW9wzg1rh+IJTbKI5pCzxydVfVvATlWm5uEkJCJCaeD/fuH2LDlIsopA+iV05BHyyl9q0n9D/xhdkUW@vger.kernel.org
X-Gm-Message-State: AOJu0YwHzsbdYxSdCub6boH1unYBDF1W12Kkhz9N5mNlrYQuf65j2mfG
	QbaUEADgUzcXAfgKHn9b5bd7iDvYnrKOcI4YcRdm0PcMB67f1Q9NfTgbJlNrd1k=
X-Gm-Gg: ASbGncu42Ns/FvOnS526P2yskrRj0iBwy6Z5fTDocJhAyd0dTLdZHAYbeehU2Kl/blg
	4o1443KPF2Xyzu0miRvjiSyBNaY7mwheRPUvZn+Op6xWTyydHy4RQzsPzoO9nBDsqx5cLZn3TV5
	RPVkCUn56TgU80VICUmLh7gxf5O8ixb8JFBsoMlLzqiQTUrBVWlLSyJue4HbgFwulmRg9X8n1E4
	ODHXk4I1klHunOlwzDfJyzF/jOOTqAm1FrK2+6/0kEyj0U=
X-Google-Smtp-Source: AGHT+IG5uNon7/+5tavnAU1+6ODsDyulZAAiwNo5sldF4FHk8kNssZ4/V0oQpI2qOsRTRp3qJQ4m2Q==
X-Received: by 2002:a17:902:db01:b0:216:5867:976a with SMTP id d9443c01a7336-218d725b7aamr38087595ad.45.1734527430302;
        Wed, 18 Dec 2024 05:10:30 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:29 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 08/11] rtnetlink: Remove "net" from newlink params
Date: Wed, 18 Dec 2024 21:09:06 +0800
Message-ID: <20241218130909.2173-9-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218130909.2173-1-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that devices have been converted to use the specific netns instead
of ambiguous "net", let's remove it from newlink parameters.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/rtnetlink.h | 2 --
 net/core/rtnetlink.c    | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index ed970b4568d1..04fc0e91af42 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -72,7 +72,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 /**
  *	struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()
  *
- *	@net: Netns of interest
  *	@src_net: Source netns of rtnetlink socket
  *	@link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
  *	@peer_net: Peer netns
@@ -82,7 +81,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  *	@extack: Netlink extended ACK
  */
 struct rtnl_newlink_params {
-	struct net *net;
 	struct net *src_net;
 	struct net *link_net;
 	struct net *peer_net;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f7c176a2f1a0..e33ef8a0a6d6 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3758,7 +3758,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	char ifname[IFNAMSIZ];
 	int err;
 	struct rtnl_newlink_params params = {
-		.net = net,
 		.src_net = net,
 		.link_net = link_net,
 		.peer_net = peer_net,
@@ -3787,11 +3786,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	dev->ifindex = ifm->ifi_index;
 	params.dev = dev;
 
-	if (link_net)
-		params.net = link_net;
-	if (peer_net)
-		params.net = peer_net;
-
 	if (ops->newlink)
 		err = ops->newlink(&params);
 	else
-- 
2.47.1


