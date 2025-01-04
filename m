Return-Path: <linux-kselftest+bounces-23907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 571C0A014AB
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 14:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3BA163B90
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 13:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FCA1C5F38;
	Sat,  4 Jan 2025 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6k2ScIG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C291B87F6;
	Sat,  4 Jan 2025 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995522; cv=none; b=e10YFQ+JEm0yeUwz1OwOzr5f3rtenjpptETBB0XcXtPlHJXBINOLW5H4ks6rvKXAqBLgi1S7/05bRNS1L7We0rozGqGoga05xN8rOyYwCZUVKI93gR6CAU7f8ZBgnXG1Stj6hCRigE204NXxO2zZXi7hMqS2VFNIBRKbG4fH03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995522; c=relaxed/simple;
	bh=ExcFFASRL0JOBX+JRaYP5UZ03RNRSWOI8Fw5iiUDoBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvAtoibNmYwYVFUD0aGRUKo7Ng5IiCYRa6H9ps/TrexFyHzO1wTJzarwIPDMBFBKXIh5iBkVp1rF2D3my0Of6CIqkQAKdIdUCU5TPdVD08sp0KBFJrC6HobsOxgG4mw4UbgHGnHYuFnJE9ZNpaXgczk9qsBxNGIbcSxJE6wNwco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6k2ScIG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2162c0f6a39so191017205ad.0;
        Sat, 04 Jan 2025 04:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995515; x=1736600315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGKuR9iwJLKB00bK/9yuK8uQjR1STrnypDr+9jM2ZjQ=;
        b=J6k2ScIGK5q4Zu3Riv+nBf6FDSbwV4qRNST1fys8zrbpDMKYqM09XJkbwi43ioZ+ZE
         s4oL2puw9e7vwqaaeXZprlM/A+5hXtFM/4L5gm9VxkjwApXAj017J9GEMh+88bPiWaPk
         IUnN0t00dzspa+WBc6oDiXCfv3dibpqF6O1wr0/+zRhA/jb9k8KUur+3cbLdZDwU2XE/
         13Rcwd6hd0SPBy46ORrExbxHryJiV2D8SnDBUjmyCxneeC5WcZajqqUeOm91pVVsucdU
         Dkqdt2DFydTuQOAj+P/O0qmHmVrxY3NVPG39G/p03B5Lwry+7bYZwjbeu7rz3FXodcj2
         c+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995515; x=1736600315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGKuR9iwJLKB00bK/9yuK8uQjR1STrnypDr+9jM2ZjQ=;
        b=m9d0e8MZgJEwx1Nwkoz6IhAO6o3Z1bR61PKwB1VAmNWsJULVlC7/uCtYHMmevEa6pc
         xgOAgp+mFPG8TQsTg54bhhS7yrMkjCUz5nPyaI3jrXSqdZGMyD0APa6YDo8Vo78sgJ+D
         QT+pOlDes+bab68smeaEzt6ZjmaE613nRv42f4xqqCtR8sD0xzfCkHPOBLMNMoKwTvn1
         bHSMTJPfA0owCE1uiHdVRRplxPoH1PVIGnvjimwqZq0F/Z+YuwWnjrFsnoRDIPvTKWFF
         5O+oCPKIEa9ndpRbnDTu+P8XF7HVa1wcTPMO623jwkdRZ2AUbsaE+OpzxgYqqR0MkV1c
         3SEw==
X-Forwarded-Encrypted: i=1; AJvYcCUgSrGQjY450yMOLvHos356U0YnnRH/y2iXa+2IkrJFSVZmjZl89l9voJujNL++BjUXxJdSOzGekgO6@vger.kernel.org, AJvYcCVfs2LsaZq4wMcss7rLuVUKPM7AWNLih2FxQFETbQjqUFziUEXZn4WsRIomK4JT555nZAbhfMVnCWMVjmDm@vger.kernel.org, AJvYcCVj/bQjEyE1fAy8TfiKFAaHqkRTytdmuCZ3/YlUSapknihr77JncVJ2u2IG61TJvWOzt3WV+kagMkUZOnwROhZt@vger.kernel.org, AJvYcCW5QkcVsGljv+Tg2z+HAAI5+p+bKUynca0yi4sJkBbOBP3YlOFB5xLNjattaabeoVR7NYICl76s1uzGNg==@vger.kernel.org, AJvYcCWgQMTJVq+aA76LISyDT0Xz9GnEQpAG+inlOsM6kHtkyyYXEyyBz9zS4Jj+fLm3FfA/9vSd/ubVS6qW@vger.kernel.org, AJvYcCWqYBgCsRG28rMs72al3BbZDQyAuyKlTVWbkjoWYNOuaUOJcAOaXtxrFtny6ZNjMPLv2e4=@vger.kernel.org, AJvYcCXTNRgmSmUcvbLaFh+wFPs37RHrdGyGn9SLn27MFfBMRjVlv0KIRB4+ZiQepwOVyuNdfjRHyXH8l5gMVI97XZQ=@vger.kernel.org, AJvYcCXd4ToD3h6peHqmES1R6GI+9wh1wpYErXbx71okNiV4bmatJo/7PxGeTE9CGh0TJIEreQuLGijgMS9dOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8lIaNz7s6L3bvrIO/Cv21APyBHC4vTR/4Pp9ObD8gk0y2BFy4
	UGm/nQDvmuBOqreAiI4O4QkBN/f6udmTAYND+iUIQiPxFWJYDXmE/J7JVSUTG88=
X-Gm-Gg: ASbGncvnV9AlRmE0zHqw4ZFp0gpaAiP2LxorIHsQ5kt/yvVRabkewBFGCWQ3OvKK2Kx
	7Bb6HBQOKk8IJp9sW+MKYdWxwk7Qflc7oXcYgJcUA48WAjFMxXSTarktmRrbFkO7IrRVp9dkPk/
	OWNS55aVYq693TQYVHqxtUd5Qh2/JJRftLp3w+wP6YNFOlzpHrkqVuBoHBczttxbPFuTFfT89cM
	p5MXmY7SdxrJvSu43n4lxn7LdCOSGKwebOTDcVXFi74GOc=
X-Google-Smtp-Source: AGHT+IGjBqn10MmdRu4jxYpKUCQXpYCqN1FLgpb8zvJWMn+lBROruosGrc2xG5POheEXQ3wHAgMJ2g==
X-Received: by 2002:a05:6a21:648c:b0:1e2:2e4:6893 with SMTP id adf61e73a8af0-1e5e1e2979bmr85664871637.9.1735995515041;
        Sat, 04 Jan 2025 04:58:35 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:34 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
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
Subject: [PATCH net-next v7 06/11] net: ipv6: Use link netns in newlink() of rtnl_link_ops
Date: Sat,  4 Jan 2025 20:57:27 +0800
Message-ID: <20250104125732.17335-7-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
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

Set correct netns in priv before registering device, and avoid
overwriting it in ndo_init() path.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv6/ip6_gre.c    | 22 ++++++++++++----------
 net/ipv6/ip6_tunnel.c | 13 ++++++++-----
 net/ipv6/ip6_vti.c    | 10 ++++++----
 net/ipv6/sit.c        | 11 +++++++----
 4 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 3efd51f0d7d2..1d47c229068d 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
@@ -1882,7 +1883,8 @@ static int ip6erspan_tap_init(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
@@ -1971,7 +1973,7 @@ static bool ip6gre_netlink_encap_parms(struct nlattr *data[],
 	return ret;
 }
 
-static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
+static int ip6gre_newlink_common(struct net *link_net, struct net_device *dev,
 				 struct nlattr *tb[], struct nlattr *data[],
 				 struct netlink_ext_ack *extack)
 {
@@ -1992,7 +1994,7 @@ static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
 		eth_hw_addr_random(dev);
 
 	nt->dev = dev;
-	nt->net = dev_net(dev);
+	nt->net = link_net;
 
 	err = register_netdevice(dev);
 	if (err)
@@ -2010,13 +2012,13 @@ static int ip6gre_newlink(struct rtnl_newlink_params *params)
 	struct netlink_ext_ack *extack = params->extack;
 	struct net_device *dev = params->dev;
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
-	struct net *net = dev_net(dev);
 	struct ip6gre_net *ign;
 	struct ip6_tnl *nt;
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
 	nt = netdev_priv(dev);
 	ip6gre_netlink_parms(data, &nt->parms);
 	ign = net_generic(net, ip6gre_net_id);
@@ -2029,7 +2031,7 @@ static int ip6gre_newlink(struct rtnl_newlink_params *params)
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6gre_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6gre_tunnel_link_md(ign, nt);
@@ -2250,13 +2252,13 @@ static int ip6erspan_newlink(struct rtnl_newlink_params *params)
 	struct netlink_ext_ack *extack = params->extack;
 	struct net_device *dev = params->dev;
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
-	struct net *net = dev_net(dev);
 	struct ip6gre_net *ign;
 	struct ip6_tnl *nt;
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
 	nt = netdev_priv(dev);
 	ip6gre_netlink_parms(data, &nt->parms);
 	ip6erspan_set_version(data, &nt->parms);
@@ -2270,7 +2272,7 @@ static int ip6erspan_newlink(struct rtnl_newlink_params *params)
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6erspan_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6erspan_tunnel_link_md(ign, nt);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index f4bdbabc3246..cb09cc878dee 100644
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
@@ -1878,7 +1877,8 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	int t_hlen;
 
 	t->dev = dev;
-	t->net = dev_net(dev);
+	if (!t->net)
+		t->net = dev_net(dev);
 
 	ret = dst_cache_init(&t->dst_cache, GFP_KERNEL);
 	if (ret)
@@ -2007,13 +2007,16 @@ static int ip6_tnl_newlink(struct rtnl_newlink_params *params)
 	struct net_device *dev = params->dev;
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
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip6_tnl_encap_setup(nt, &ipencap);
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 79e601e629d2..a3108a7464c7 100644
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
@@ -925,7 +924,8 @@ static inline int vti6_dev_init_gen(struct net_device *dev)
 	struct ip6_tnl *t = netdev_priv(dev);
 
 	t->dev = dev;
-	t->net = dev_net(dev);
+	if (!t->net)
+		t->net = dev_net(dev);
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
 	netdev_lockdep_set_classes(dev);
 	return 0;
@@ -1001,13 +1001,15 @@ static int vti6_newlink(struct rtnl_newlink_params *params)
 {
 	struct net_device *dev = params->dev;
 	struct nlattr **data = params->data;
-	struct net *net = dev_net(dev);
 	struct ip6_tnl *nt;
+	struct net *net;
 
+	net = params->link_net ? : dev_net(dev);
 	nt = netdev_priv(dev);
 	vti6_netlink_parms(data, &nt->parms);
 
 	nt->parms.proto = IPPROTO_IPV6;
+	nt->net = net;
 
 	if (vti6_locate(net, &nt->parms, 0))
 		return -EEXIST;
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 4dd1309d1eb3..8888fc51fa0b 100644
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
@@ -270,6 +269,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 	nt = netdev_priv(dev);
 
 	nt->parms = *parms;
+	nt->net = net;
 	if (ipip6_tunnel_create(dev) < 0)
 		goto failed_free;
 
@@ -1449,7 +1449,8 @@ static int ipip6_tunnel_init(struct net_device *dev)
 	int err;
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ipip6_tunnel_bind_dev(dev);
@@ -1555,15 +1556,17 @@ static int ipip6_newlink(struct rtnl_newlink_params *params)
 	struct net_device *dev = params->dev;
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
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip_tunnel_encap_setup(nt, &ipencap);
-- 
2.47.1


