Return-Path: <linux-kselftest+bounces-26966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39254A3BF07
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 13:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4E6189A552
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 12:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC091F4636;
	Wed, 19 Feb 2025 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWFXqjxw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37F01E834B;
	Wed, 19 Feb 2025 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969529; cv=none; b=aFQv1sLCuBmFDrMhSVoob5I5ZtyNXTX3Ab+VTSHt0JUGgnMMxuOwECfLDqkMUQBQV7tyHHjPsvDTX2/mEa9l+SZ0HTAYSGUfYcZF/BpNNJQzxIokdZShyZBoiq5v22M5Hr07NtzymqNVsjxKKDgKPBT+Hv1PLMzmd9qTm2T+r2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969529; c=relaxed/simple;
	bh=WnqzfYihIgH7CnlxbfGoXmbwDyB/yLwFF1VQRuUd9SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEDRwJffGduQaL2Ncpu6JE0c4f0iXp2VT5xm1xip3LRal+/UPG5Hij6xG6i414yjw0iT/jw73bC90DXsGoLX0gzSPRhcMm4HmAG9IIZylmp6cTzak3N4xDC5Sq0W2J2RnYayVg7TjMsQO3CmAWsVTeK+Ar6vCX+/YWHutDkAR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWFXqjxw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22101839807so92273015ad.3;
        Wed, 19 Feb 2025 04:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969526; x=1740574326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsYd7KiB2vQaWNh0ASWhN8pl6PDFq3SaA7EkmHtk6YM=;
        b=HWFXqjxwR+Fx+mMWPLq85kKQMAr98hYpYLF5PyO3X/EEuuMAbxS5OMh0hVT0U1bVsV
         H3MqQGzZ28Cey10+iFPoGo/iPUqLHQ5KIOt0Yw5vG8QZbd6EG/tNfw2Sim0H1Bx2ypWO
         2N0uBy64v8sKzYiIR8V/5KKX2Nmhli1j7Lj+I316Ft5cr6OmJOlwj7Gy+Lgr/iXvIbvT
         pNy0G8fqw38Uz7fqzsmsUS5H92EaQhGHcCxTEQikKASTadQQFRbGhwrzHwABTJkHNqR4
         10CJIrbbdKdKJaA6IlHSk8F52bUWA+o8bV3JDrz+9yrAv+K4T3uHxwvNRqSFtC3OiqfQ
         yIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969526; x=1740574326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsYd7KiB2vQaWNh0ASWhN8pl6PDFq3SaA7EkmHtk6YM=;
        b=LS3a/jvUKwmLPyud9jr8bPcnaGB2nEl3xmbxmRWXXRyLWJXXjwLxPiMM8ae63ds1ua
         ao0itUFBWQedYUllDHUI644nhJt3WXZc/vrQ5F1uoXr2wQOcU0yKZL9KHDp84sPFG535
         ugtpJNHFO660Dp3MCmZk6xZ19RZvJS+aI7U6deoUOCEdzv5II55AuYLJwE1jsPBH9Vl1
         LqVbJPg/a/Zp9PupcdHgz/zB/jzYMcAdN9E/kMuzhGlFjvgDBSdM83ISNWoU/BwMqsfV
         /MNUOWbzwXmhvAocZbmzbAefUSwcZA5Nhz8vcTV9rC81WHa2WRpxPj74T5NWGmEhtRNp
         Z0Lg==
X-Forwarded-Encrypted: i=1; AJvYcCU7zDAy3gjJxEflw57PqWeo2/DhnkDIIaQkagDgSPzuVQ/q9WvyRk66PljLiZGGILNmqeUgv7Us3JAg@vger.kernel.org, AJvYcCUvVU2eAd8uoaGqZiesgTVXVxcYa4sg5OP/UMeZzFU+mzLIEXX/aExXTIL+2n0pRDTPSoI=@vger.kernel.org, AJvYcCVCNBAUgOJ+3SKhEDKNGEHdpQEJSQWAaslJAuxPKSn/VQ0z6ym+3LMwyzZPNAIvVIo4yyLHNXmmlOrP9w==@vger.kernel.org, AJvYcCVPpq/3SovDndAYomqoSusDs3Tm91TcRyEjzQ8SO0JohvJmXBuwN5Ta32mltGlFE9HRJtp9rIMJjKfW8dba@vger.kernel.org, AJvYcCVwzeWGsbeuOBuCdWhlZ6Gx8SWiAQXAla6dLuq7+BD/nwJDU0S/U5q2JAEXLxaJgltgaC1FWPUBCo7ktP+8hUHM@vger.kernel.org, AJvYcCW5TElMvRi0ZKoje0D/PM2xNWJWchT82FasB2OcTxovpvVyriVS3BeF+id6pxbSCF8WlTKnJ6fqlt4hZA==@vger.kernel.org, AJvYcCWT6T+/1VJ5rrMeeVgEqtX9n8c4zwbXYqQxUNpBb+GJqSMvm1m7ZWimvsXjENAQu2DFC52qg/Zhurbs@vger.kernel.org, AJvYcCWaqom69t2+UD6x+mUi39muDvcbiwpO5vGqPUOHFAJ3sqXVlcborVTjh1cW3bFv4lvVYCD4XdqFyLvpokwgpIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvunrFre3Sdt1RHCV1RAAL8wqt6+ZuXhZQcg9aOovms4HdDMFl
	9aT6CzAN+pcidL6nmK47ZetXqpkRdUy0sH3saolKwACOfpsMnIMvf72u1WbYHjI=
X-Gm-Gg: ASbGnctGEd+AX09VIMaVCTE7LiAhn1TS2wFxK2/3bA04IlE/TEMx9cYqDY1nOfdKMxE
	a3OXVuQLB+yKZcFnsKuBacuV3bGjPY9belxgem8t42At0udpg/1XtLmeTm0EV/ct5kEW2DtmodF
	1Cct3DRtodXvm5e5BW8Gw8vFkzu/EBzxUluwtK/rCqkXCZiI+CyO6lEuRlJql+FsQzynZAUdwAM
	PnKkzyTHr5kzi/JT0Aw+VocQD6nrhlNHdIQnbquYCj7+J9adLQ9Hw+A0LDIbdt+TcKS8gJq1pLA
	FrHxAA==
X-Google-Smtp-Source: AGHT+IEmzyu5IbJEeeDhw+tXRaZzlcx6HaVQuXOtrNDJjpviTChMhHRF4glLxd0ys0/eE/gPyp4KqQ==
X-Received: by 2002:a17:902:db0a:b0:21f:8677:5961 with SMTP id d9443c01a7336-2217119d382mr58688885ad.34.1739969526138;
        Wed, 19 Feb 2025 04:52:06 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:05 -0800 (PST)
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
Subject: [PATCH net-next v10 08/13] net: ipv6: Use link netns in newlink() of rtnl_link_ops
Date: Wed, 19 Feb 2025 20:50:34 +0800
Message-ID: <20250219125039.18024-9-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When link_net is set, use it as link netns instead of dev_net(). This
prepares for rtnetlink core to create device in target netns directly,
in which case the two namespaces may be different.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv6/ip6_gre.c    | 14 ++++++--------
 net/ipv6/ip6_tunnel.c |  9 +++++----
 net/ipv6/ip6_vti.c    |  6 +++---
 net/ipv6/sit.c        |  6 +++---
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index d9e6b1fd9917..d31a4ce3b19f 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1969,7 +1969,7 @@ static bool ip6gre_netlink_encap_parms(struct nlattr *data[],
 	return ret;
 }
 
-static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
+static int ip6gre_newlink_common(struct net *link_net, struct net_device *dev,
 				 struct nlattr *tb[], struct nlattr *data[],
 				 struct netlink_ext_ack *extack)
 {
@@ -1990,7 +1990,7 @@ static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
 		eth_hw_addr_random(dev);
 
 	nt->dev = dev;
-	nt->net = dev_net(dev);
+	nt->net = link_net;
 
 	err = register_netdevice(dev);
 	if (err)
@@ -2007,11 +2007,10 @@ static int ip6gre_newlink(struct net_device *dev,
 			  struct rtnl_newlink_params *params,
 			  struct netlink_ext_ack *extack)
 {
+	struct net *net = params->link_net ? : dev_net(dev);
 	struct ip6_tnl *nt = netdev_priv(dev);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
-	struct net *net = dev_net(dev);
 	struct ip6gre_net *ign;
 	int err;
 
@@ -2026,7 +2025,7 @@ static int ip6gre_newlink(struct net_device *dev,
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6gre_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6gre_tunnel_link_md(ign, nt);
@@ -2246,11 +2245,10 @@ static int ip6erspan_newlink(struct net_device *dev,
 			     struct rtnl_newlink_params *params,
 			     struct netlink_ext_ack *extack)
 {
+	struct net *net = params->link_net ? : dev_net(dev);
 	struct ip6_tnl *nt = netdev_priv(dev);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
-	struct net *net = dev_net(dev);
 	struct ip6gre_net *ign;
 	int err;
 
@@ -2266,7 +2264,7 @@ static int ip6erspan_newlink(struct net_device *dev,
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6erspan_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6erspan_tunnel_link_md(ign, nt);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 111a8777c2f7..89d206731af0 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -253,8 +253,7 @@ static void ip6_dev_free(struct net_device *dev)
 static int ip6_tnl_create2(struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
-	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
+	struct ip6_tnl_net *ip6n = net_generic(t->net, ip6_tnl_net_id);
 	int err;
 
 	dev->rtnl_link_ops = &ip6_link_ops;
@@ -2008,12 +2007,14 @@ static int ip6_tnl_newlink(struct net_device *dev,
 {
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
-	struct net *net = dev_net(dev);
-	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
+	struct ip6_tnl_net *ip6n;
 	struct ip6_tnl *nt, *t;
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
+	ip6n = net_generic(net, ip6_tnl_net_id);
 	nt = netdev_priv(dev);
 	nt->net = net;
 
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 16e0d74f99dd..83c055996fbb 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -177,8 +177,7 @@ vti6_tnl_unlink(struct vti6_net *ip6n, struct ip6_tnl *t)
 static int vti6_tnl_create2(struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
-	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
+	struct vti6_net *ip6n = net_generic(t->net, vti6_net_id);
 	int err;
 
 	dev->rtnl_link_ops = &vti6_link_ops;
@@ -1002,9 +1001,10 @@ static int vti6_newlink(struct net_device *dev,
 			struct netlink_ext_ack *extack)
 {
 	struct nlattr **data = params->data;
-	struct net *net = dev_net(dev);
 	struct ip6_tnl *nt;
+	struct net *net;
 
+	net = params->link_net ? : dev_net(dev);
 	nt = netdev_priv(dev);
 	vti6_netlink_parms(data, &nt->parms);
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 20453671ac50..f7b59bc957d3 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -201,8 +201,7 @@ static void ipip6_tunnel_clone_6rd(struct net_device *dev, struct sit_net *sitn)
 static int ipip6_tunnel_create(struct net_device *dev)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
-	struct sit_net *sitn = net_generic(net, sit_net_id);
+	struct sit_net *sitn = net_generic(t->net, sit_net_id);
 	int err;
 
 	__dev_addr_set(dev, &t->parms.iph.saddr, 4);
@@ -1556,14 +1555,15 @@ static int ipip6_newlink(struct net_device *dev,
 {
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
-	struct net *net = dev_net(dev);
 	struct ip_tunnel *nt;
 	struct ip_tunnel_encap ipencap;
 #ifdef CONFIG_IPV6_SIT_6RD
 	struct ip_tunnel_6rd ip6rd;
 #endif
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
 	nt = netdev_priv(dev);
 	nt->net = net;
 
-- 
2.48.1


