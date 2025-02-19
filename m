Return-Path: <linux-kselftest+bounces-26965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63389A3BEFD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 13:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB261887E0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8121F4193;
	Wed, 19 Feb 2025 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBdqcVna"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A08A1E8348;
	Wed, 19 Feb 2025 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969519; cv=none; b=o5eh1WEH+2lLZbB84uEWBSe9wAmsmxHNMLnew3VjtoIVMnlJtjusXggjQjBx1W0hGtZj398bPUSTkXVtigMRqxZf9kVYZ+CBH3XgN7FUrd7QPFZ9ZOgbVSdOpUwsXTYdO1JXKyz+OaMMU8ydcYeTcFZtFrac/3L2k+xHLxSmbJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969519; c=relaxed/simple;
	bh=VA66gTa0Qj/pMCkEuKNn0qYWFCRGp3U7y68sKrY8e1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHdin1WUg6O/6b7gSmsbkX7J+CuFHfghnn0VzAShbko7ZckKQZkMwUV9ud1ffJ89UIktfRMhdQVZoP2OKEg3GX1wsBr9iQY3qTfTdkJAcOcMvtu0uZldSCGZGu42VkKyPjYZdmd78EnwmRZllWhvwyrQ54eNjNZkvRgCk+Sp2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBdqcVna; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-221206dbd7eso61495045ad.2;
        Wed, 19 Feb 2025 04:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969517; x=1740574317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6bozwwxLUJNxVW5ZYXuCA298+o6a+m5Om77EOnyIyg=;
        b=hBdqcVnap1SvFAmPRCLl21kqRyfCUvsmatnwVX49ev8h/bvNRCRg2tE3+BzxQetcdr
         S/6lVTYbG+lAJqWAS+9tpj8rsqPc1D70Mxng++jmtwFkxe4YlbQaUTbXv7pPg95pTqze
         prLivo4vTVi8uZ1W7WMo/eeIg2Hncmo34VQFCpq5Bu+x1W2tlqNut2D4QFF0JREVslQ7
         taHuklrS0Wv4MpOcKiShh0a33AGyIKHnTXNy/aTcwdRwfYiwUoDKDBRnpT69knRPg+2v
         MpGap4nLWmEsZhFYDF+NfjC91Cr/zHnCmdBbfYsbzSg2xdqDiCxRSmIwqe5+rvajHmQa
         sOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969517; x=1740574317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6bozwwxLUJNxVW5ZYXuCA298+o6a+m5Om77EOnyIyg=;
        b=hszK9pggXwYEzDu8FLNR3cYSJ4uZ/NJehBYrslBfJFL7z2kgnh8o9IJiRKEaq6xNbo
         XSNSUtsEUOr56KIW9O5GhQaAHAl02C2CPx/FROmNTSrS+s/U+GrK1A7pnN0JL9gq3X+O
         3i0jVeu9kgp33LZxy+IevIYgCvnoKopaQyNHp6rxvYyFPwfSHltHVzG1liWMZ5OKL7iZ
         a9G4f9IGzJQzEU300ATuXAO9TGUfQRUjs1foTlQu04vuo0QpvyYc3mRijQjr1jmAdgSL
         pBdGW+Wi1lqcD5a+G4SsY5ERAX0pBDVc5ytaL4vCbr8JnnSsImzA0sSkcj6l4i/Djarf
         OFSg==
X-Forwarded-Encrypted: i=1; AJvYcCUxiaeBpc5+bco1sv+IdPY1rAo1M5GRyCRp5mMnjk5hjcBMNeylgr9wpY8kPLwklRnQ70tOmtL5iGdO@vger.kernel.org, AJvYcCVXHnZrqMmedRb+FEgR3GcZDbi0piMxUNDawNBNJieaIRH2pq/Ceb2aFODn7KkhFjGMi3glYPA3KaEJEB9J3A0=@vger.kernel.org, AJvYcCVaKihNMGgeC+WnyZsYC5B0uMvDizm49m7HwZuaVA+UbQAaVPDjCy2gqV2iZow9JshxFNnrLnjFx5BTsN3eFHll@vger.kernel.org, AJvYcCVehEhy3uaJqFNSa7/eZo69aK6MHGT5ghs/1ZiXuQ6kupaa22aR7ZRWCHNSogo9hJmhyETbjyyQ0zsnXg==@vger.kernel.org, AJvYcCW2fplYC9r6KugTvv67GyQjO53GuEBMbaN9k+/o29PUx72cs1BXgxvC40EyxttXqRmC6nQ75MNB5or7@vger.kernel.org, AJvYcCWKoq2B24nfcCbrIY1LfLgSf21wqNl3A4emyVSjcDZ2773ZmP/MtZITNFJFZTe9HFaPWQM=@vger.kernel.org, AJvYcCWkoNb3X69N2ZYk+4SqLd8mPMyGG6UVSTJxxwGr96GwhfT7NX9QM9Ra7heebtZWsEFVfAOBAha5gSoBRQ==@vger.kernel.org, AJvYcCXGJYmrHwWZGKUUaZ0CFRREIwWnQDZM8w7/i3Ngot2vBw3knstlR4ArwnHUtDwPyIc+Wlb7Jbok1NTo2Azd@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUdPlKCOSIOofU6wNKoUXyh+gW8aGrciEChlwslCVxB6NgVjv
	U/S2ffTKwF6HSdBObTbXzqLKD8ILUWiDtw7izO4L83kgVFkFBRGGeeZxcksJCw8=
X-Gm-Gg: ASbGncs5jWVP4LxHk2kptM8svHcaijb4wjVBMPlqWoMasU4vOWheXz+SgesjaKZJDx2
	KeWb4ddSy0KYMRkYvTE7aE6vNQ3kzt3FICrngKmBE3W+goTggHG5O8xh1XqLVxkdRsBFNusEYS6
	t1CaT5C1bpvkYRXn3+6pMsnor/Z3pd1GvCCi4oOQJz0b9p0AinKMbEX42ovayW/DL+3mVWJpnKf
	6oWzJRq4WwALTgVJWD4S9bdnInpHJjDPyF6VXU+01sS0YmtA6t6ikVYP1B15JVkpnCUW34U3Mm/
	E9wUKA==
X-Google-Smtp-Source: AGHT+IGKxW3/SlkXIFQ/R+7OZM2jJGBrIehyvby3inig7425vAO11UDlInuUnZBsT6heGdokKuXecQ==
X-Received: by 2002:a17:903:2305:b0:220:fce7:d3b8 with SMTP id d9443c01a7336-221709654admr66486875ad.12.1739969517203;
        Wed, 19 Feb 2025 04:51:57 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:56 -0800 (PST)
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
Subject: [PATCH net-next v10 07/13] net: ipv6: Init tunnel link-netns before registering dev
Date: Wed, 19 Feb 2025 20:50:33 +0800
Message-ID: <20250219125039.18024-8-shaw.leon@gmail.com>
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

Currently some IPv6 tunnel drivers set tnl->net to dev_net(dev) in
ndo_init(), which is called in register_netdevice(). However, it lacks
the context of link-netns when we enable cross-net tunnels at device
registration time.

Let's move the init of tunnel link-netns before register_netdevice().

ip6_gre has already initialized netns, so just remove the redundant
assignment.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv6/ip6_gre.c    | 2 --
 net/ipv6/ip6_tunnel.c | 3 ++-
 net/ipv6/ip6_vti.c    | 3 ++-
 net/ipv6/sit.c        | 8 +++++---
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 863852abe8ea..d9e6b1fd9917 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1498,7 +1498,6 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
@@ -1882,7 +1881,6 @@ static int ip6erspan_tap_init(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 54b843d20870..111a8777c2f7 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1878,7 +1878,6 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	int t_hlen;
 
 	t->dev = dev;
-	t->net = dev_net(dev);
 
 	ret = dst_cache_init(&t->dst_cache, GFP_KERNEL);
 	if (ret)
@@ -1940,6 +1939,7 @@ static int __net_init ip6_fb_tnl_dev_init(struct net_device *dev)
 	struct net *net = dev_net(dev);
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 
+	t->net = net;
 	t->parms.proto = IPPROTO_IPV6;
 
 	rcu_assign_pointer(ip6n->tnls_wc[0], t);
@@ -2015,6 +2015,7 @@ static int ip6_tnl_newlink(struct net_device *dev,
 	int err;
 
 	nt = netdev_priv(dev);
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip6_tnl_encap_setup(nt, &ipencap);
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 993f85aeb882..16e0d74f99dd 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -925,7 +925,6 @@ static inline int vti6_dev_init_gen(struct net_device *dev)
 	struct ip6_tnl *t = netdev_priv(dev);
 
 	t->dev = dev;
-	t->net = dev_net(dev);
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
 	netdev_lockdep_set_classes(dev);
 	return 0;
@@ -958,6 +957,7 @@ static int __net_init vti6_fb_tnl_dev_init(struct net_device *dev)
 	struct net *net = dev_net(dev);
 	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
 
+	t->net = net;
 	t->parms.proto = IPPROTO_IPV6;
 
 	rcu_assign_pointer(ip6n->tnls_wc[0], t);
@@ -1009,6 +1009,7 @@ static int vti6_newlink(struct net_device *dev,
 	vti6_netlink_parms(data, &nt->parms);
 
 	nt->parms.proto = IPPROTO_IPV6;
+	nt->net = net;
 
 	if (vti6_locate(net, &nt->parms, 0))
 		return -EEXIST;
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index e2bd52cabdee..20453671ac50 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -269,6 +269,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 
 	nt = netdev_priv(dev);
 
+	nt->net = net;
 	nt->parms = *parms;
 	if (ipip6_tunnel_create(dev) < 0)
 		goto failed_free;
@@ -1449,7 +1450,6 @@ static int ipip6_tunnel_init(struct net_device *dev)
 	int err;
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ipip6_tunnel_bind_dev(dev);
@@ -1565,6 +1565,7 @@ static int ipip6_newlink(struct net_device *dev,
 	int err;
 
 	nt = netdev_priv(dev);
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip_tunnel_encap_setup(nt, &ipencap);
@@ -1860,6 +1861,9 @@ static int __net_init sit_init_net(struct net *net)
 	 */
 	sitn->fb_tunnel_dev->netns_local = true;
 
+	t = netdev_priv(sitn->fb_tunnel_dev);
+	t->net = net;
+
 	err = register_netdev(sitn->fb_tunnel_dev);
 	if (err)
 		goto err_reg_dev;
@@ -1867,8 +1871,6 @@ static int __net_init sit_init_net(struct net *net)
 	ipip6_tunnel_clone_6rd(sitn->fb_tunnel_dev, sitn);
 	ipip6_fb_tunnel_init(sitn->fb_tunnel_dev);
 
-	t = netdev_priv(sitn->fb_tunnel_dev);
-
 	strcpy(t->parms.name, sitn->fb_tunnel_dev->name);
 	return 0;
 
-- 
2.48.1


