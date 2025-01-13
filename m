Return-Path: <linux-kselftest+bounces-24374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1A6A0B9FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0217A26BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB0322CA1D;
	Mon, 13 Jan 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAze0crh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5030B22C9FC;
	Mon, 13 Jan 2025 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779129; cv=none; b=cNSBwrY2EWiUJRaVUhDY+G5FAhrTzvDu6w4u7liCuk44O3ZDws2rXxdYVkvi3tbPuh2ntEgOXqmkG7J6y6XsernJI09zDX75ywaz6Bkv0UYX+PvcjV3V2rzdBSak4k0UX3IUjU6EK1fpq2TeejWxLGl5FKsphRHMlEwJRBDAdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779129; c=relaxed/simple;
	bh=3ZFVoGehuDwl/mWPg6mYnMbYtzRE432EuJk5jze9RMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YR5xzFB0AnW5DDqFx+hOLHX67ZjAoziTLBXVtSHS2/Sp+vF03uOQihqeUxrQHY+p3tWdTRghkbvYgPp6PTM8Qq5T1EK1alCqcBIWbC8c26ceJJbnGxzyEN/4Ybh3g1YuM2GlaMxwDrEo31R9sllu8MwqCT9+drbSn0cGrJYnnhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAze0crh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21628b3fe7dso73483805ad.3;
        Mon, 13 Jan 2025 06:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779127; x=1737383927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0itpuEZRuaRQ33kirP60JpiMAPNyz5teegcwQ5xuJQ=;
        b=kAze0crhPHvwQAVQFM8UNrhQ0ibbf1uXbP64MVxUHrah/2OHgSsiMw9kXhYZJmYMP1
         UZYDO0lG9DMzbgkZ2e/H/y0n/F0rolVDQFLyOJVKmGjtHeWidoScBr9TEZrVmRr+L7/e
         rx+7I5m6inLXU84tDT4nvJ8JC68BxNZfJAm+Mnf0H7Ip1v7N/oFjjgQOSiQ1cR4pZRsI
         C6Ixd/Qeyip3S5Iu2Joidpo/it/nDmEsea6MEuR3OQMrVDehp5TVQyTyVQqVZBpD/5aL
         vdmbLUr4Y4VQ5mXjwU9Cr5gG26BG1p5Rc1FpLXpYjs5NKkJemmemgT1HYThU/XpC2aL7
         k2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779127; x=1737383927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0itpuEZRuaRQ33kirP60JpiMAPNyz5teegcwQ5xuJQ=;
        b=C4t2TN+DPVcf/J2kX6ZFprOZ6O5uELqYPlog1gubdgSlsZO+S1JGwl/mdnPbsVt28S
         vFTR8GVEj2hQVPIGiLzZXNQMf2FX4GG6dlvPBhI3YVspz4ftgQ9VX9WDrRMt+rlNDZNB
         PSMHfK1oQvZrNch+uISIOkwljDA+UcD5xDAfA7jChvGTu6NyODqmozGCDmHK/PXgP/jA
         FhESTYtcZ8/PkkeIJkuaGoMBn9F7rgwi9IMVEP6YVUuazTqnLm9FlbdZthbWeO2O8v87
         7XiA5/buQ//CnQRwTip9BeSpWFoi+gngRwQRqgK+KQuuLhnnicJg20grf/nMzVg5q73N
         GnLg==
X-Forwarded-Encrypted: i=1; AJvYcCUCiiOLAO/FS02ytrsuch3SXkBqSliI7Lo75Lr44lDP7oLBYzrxNfccEQkV6n1WKjdRQEhBIuJPIy52ZA==@vger.kernel.org, AJvYcCUL60OTZgoiXQ0SYSgKGlj4Nrq5OqzGCHcbsan1ULfkx+/irqu28AUw6g5BVVf6GFn/jENLRlpfgfI4KmIrdt8=@vger.kernel.org, AJvYcCURT8a9zzWxt9a03WxqJKKzen539BwJGgKWW9anSjvaXRvRlk+hYUfABx7SRsu8XfPpkdCKe9RQQYWJwmuY@vger.kernel.org, AJvYcCUZPVnH2946ieuZX5/IVeaoQDvRtGD3HP6aG8K4ojrxmWKTv7shvohEuOmq5BNilWkrwMOlgvFvoXPl@vger.kernel.org, AJvYcCVWXgPL/7opb/T2oz4UdzubVeOHhSI+pquZHOZIgG8j8hQzpJo4RlcrKhf1lL58jnExkJI=@vger.kernel.org, AJvYcCWHsI2laDEuhxsbgEC8/X73TLWsY5EXbKtv3sWOGc6fA+IO7ogy76wffl4QUJqyCq3uYfa4DP81Vvc+z/s1fgwx@vger.kernel.org, AJvYcCWV4rA8ZPYq+nsj9syLVBtitCDEHUnRolnPpWUPmtp9ZTwW14pQ+XjCf3P/a+8jjnNTsF8QYpoIdBKx@vger.kernel.org, AJvYcCXNBFMo+azk8yJgWyV+41/Kl5CC85VG57GRH5LltK9zRkNW0cJONgM7M2dLd6+JfCroGq2N48u0Y8M61Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxojYaXwnRTGZlp6/dtdj1XeSqRO7670wKI3urNFTEwyynuEIt8
	udkBzu/JWeIjfuGFAzG54XTiyH9ofTt683c0xki7bo+1CKNfJHIYDCEtOyOvovg=
X-Gm-Gg: ASbGncvJyLqavOxyZdtfwZSEn4e47Y5leUIQuA7eSUkg95gzUoe3qWZJY0veXUHA3zy
	KYOkT+ZKEm3zfNsi24r2QsxYZ1ER6IYtag16ux++kA5d43k4l7u3xTJwN7s5/ZyhRfoPa1+Rx/M
	FkCGI4Cnv2VJDN1T5aTHdOUiF6NokcAUGIy4GKvE60IDUBLBJEvEVrK/HF+NKtnW7XaW+IUPYbM
	JwqlJs9cd46LHdS3uWo2Ef1RoL0Spq2w1vnZ24/Eh3MEEk=
X-Google-Smtp-Source: AGHT+IF46BIJsHmY25FQQjjhe3rRKluIF8yEXaDZgFjxpJ6wghwfrMVhniqYlndXdS242mt6yFdpoQ==
X-Received: by 2002:a17:903:230d:b0:215:cbbf:8926 with SMTP id d9443c01a7336-21a83fb0da4mr356224215ad.35.1736779127243;
        Mon, 13 Jan 2025 06:38:47 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:46 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
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
Subject: [PATCH net-next v8 08/11] rtnetlink: Remove "net" from newlink params
Date: Mon, 13 Jan 2025 22:37:16 +0800
Message-ID: <20250113143719.7948-9-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113143719.7948-1-shaw.leon@gmail.com>
References: <20250113143719.7948-1-shaw.leon@gmail.com>
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
index 00c086ca0c11..dd51240431b8 100644
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
@@ -80,7 +79,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  *	@data: IFLA_INFO_DATA attributes
  */
 struct rtnl_newlink_params {
-	struct net *net;
 	struct net *src_net;
 	struct net *link_net;
 	struct net *peer_net;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7ff5e96f6ba7..cce5bcd1f257 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3767,7 +3767,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	char ifname[IFNAMSIZ];
 	int err;
 	struct rtnl_newlink_params params = {
-		.net = net,
 		.src_net = net,
 		.link_net = link_net,
 		.peer_net = peer_net,
@@ -3794,11 +3793,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 	dev->ifindex = ifm->ifi_index;
 
-	if (link_net)
-		params.net = link_net;
-	if (peer_net)
-		params.net = peer_net;
-
 	if (ops->newlink)
 		err = ops->newlink(dev, &params, extack);
 	else
-- 
2.47.1


