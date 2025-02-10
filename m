Return-Path: <linux-kselftest+bounces-26166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86183A2EE0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C80188A07B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 13:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6122FE13;
	Mon, 10 Feb 2025 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAuKR8Qi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C222FE0D;
	Mon, 10 Feb 2025 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194275; cv=none; b=N+BAvRVvPfVUIv79wBkHvhpUaIzP8p1M1SDV+I8etdH5vKuq3A6vSRTV7IHgx37Tj1u/LmEY4kCRP8i0DH8egf03waXqropK0VISiFf2jb033TNCEHfbv14c5Q1ogLMBCt3IKpDLbhAjRd4ngYm5SB71eAUsNplUqTfBCcWRzlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194275; c=relaxed/simple;
	bh=aoKU4ituN+1jSNYs7r3BEr8KfB/a6ZxvOfaMjf8sPJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iq9OOJwu92GyyFL7kd+zBq0rOySjY4wldeZ0rZpD+RUwyXDWswvxMLBgoq1+NAzMc0lPM2UHIRoZJlTQUCgLPxvmXdFetaTOVKURxjI9brJfrLJ435Lu5P9JBRTUPeKPEjFYgHiwUfeswCjlm3OztBCQOvVuyvZxBC1E4M5YFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAuKR8Qi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f6d264221so21884925ad.1;
        Mon, 10 Feb 2025 05:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194272; x=1739799072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qor1B34U3phrXDWeQbB/j8tAelAUjHbXmA4D1BB6HEE=;
        b=mAuKR8Qi4pKkK0U5BcYVlwS7nHS+3Ds1GexN+jjzuz6QG9+qECV7GVqmn9XLRLaQps
         sl+oP9X3UUWZofMSBQ2RWSAAIb6t5Tv2JGHtjqX31RvlHjexL8sYsYPAGWQ5B+QhmzzD
         tF2QFLJFdPFvCp1VjkJwNo4qZEKMM/13vYo61IVNErUsnL5ayxdYMDFmHsRtoUAZCcLd
         tte9906SgxCzFu/NjuEqY2RNvtI0LJaajSadXdfjvwSWYLqhvqcqPPRwE9Lib2sqoTlt
         dJHNzNW+Vto0bPS97oKdwfc0EMEvxs+giyQsPHp/h2RGDERrPqIA90JKoSwdFESZhnG9
         V/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194272; x=1739799072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qor1B34U3phrXDWeQbB/j8tAelAUjHbXmA4D1BB6HEE=;
        b=Lf1iArCqzP0r1z/Z6XT0jgxdk2egABXcWLAYSTYGMWaq2AeTXNqgTK1jcFHrs4XFgy
         ThwPFOJJAYJXjNJwLcUAP6/OHCafm2Nen508Q/1AckBickCsgVBfe3qt2fb5mWwyAqIl
         vRofQYorsyET3R0mvbo30EhWGI/fuKE+i7tDmIaT+w8B1ED5R+oRkK9L23Z2ojDeBUTN
         h3OtzQ+jp1cVCuK1ETus180EImPrSYprREutHH3z2RqwywWEGTdICKdr4tncW1/QMWK2
         RtM7+nUsS73kdv2bVaK6VClUaXPCkSSqO3tfWm9Hr6NbyvRDDgOHKZp7FRA1MsPBCbSC
         p+GA==
X-Forwarded-Encrypted: i=1; AJvYcCVqXAEuVOziiA3Bv/gmJN2FOVKWhQVCjP9MBwATLdhiJviX/kSKn9WXLsJoCXjQkV0U9M7cpsg3aIfTb/ZuXys=@vger.kernel.org, AJvYcCVrnxo5t1XMlKhq1c2IgKRjSrSSq+/W0D7KKopgMLQVf2fvBp1a4iozQZ1k8hp75Q19n2TkRVdZeUTC3sbT@vger.kernel.org, AJvYcCVz3vL3Skm5koZI+Yx1l5Dz/nDEKNNJLS2T/hy7SQ879lh5jJTLID70xTqEsmkQ/hLp/zY=@vger.kernel.org, AJvYcCWC5MixxVnhidX6bRuNjBq/12KuZ0shdhsy55Qegdo2wajXzVBPe3h+QoEgfo/d1g7HZ57wh+cKGsaDT4H6izqw@vger.kernel.org, AJvYcCWN1x/j/pOpFzKoqFzbBqU2lDN3ct8YJLlUIgqPp7t7G/zLVkPqYpNKZdYQNTAw3B7ESoJFgapm2b8yWA==@vger.kernel.org, AJvYcCWR3h3F6dzSDHcTY+G5zBC2ggbprbCW1yUNxtn9sJhPXd64chscE2YvbfKM24afDZhRRmorDEYuwuaI@vger.kernel.org, AJvYcCWS94QJ7971n1r6Q2PAoFpHy2Vpev/sGBq6iQRPIJ/WIhzGFUe/TZFIRQrviHjnubn2fyKMzboYm8r1EQ==@vger.kernel.org, AJvYcCWk8xzHm3WPkk76cf3PkBGHH7wsRj6l+JRFdJP2sl70ZaWtEUA5Ron01+UPsQO8QXoHBnpsC4QRjsRC@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnNNEVJ74hLe2KiWzPNNEaQoaO6UxS37xPNQgZcQvHGIdI5d/
	egOKlWjay72C1DdsGy5G4S7S+I6zXuRhgpEF9iPGwcKqWaX1mX6/PbnKFXF/97g=
X-Gm-Gg: ASbGnctvaj52ZhXE7UbXL6U/zI/MLZ8Ab5c+2rApYwifZsciSTy1sffU6kWXGeGZrNZ
	wnA3B7ELUp7s8vIzY52P0GdLSdL7x9WsgYennElGZ9cfioI++unBIfFxZJbtSobt/dr5yuCSx33
	xt92mt1MZrKC82etC6kBW3ovdypIE494gcRmyK9Et8Ij4UD0l3m+dbA5AacAV3Mbf2Opp028Ahh
	HMr7tUOtpbspIT99hfS0cWT0VJMGycOaB8M7HOobIk12Fz5O/wDbp0rE9KRW3GfYUJ18hSmzz6D
	5c2G+w==
X-Google-Smtp-Source: AGHT+IFCFfI6vwnuduAlE62ZWjGMFvRKTwncJUJKPQ14C3FGCNohEq5KLKAyTOyXoZyqMzbv5RHKHA==
X-Received: by 2002:a17:903:1a06:b0:216:6769:9eca with SMTP id d9443c01a7336-21f4e73acf5mr177842015ad.37.1739194272042;
        Mon, 10 Feb 2025 05:31:12 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:11 -0800 (PST)
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
Subject: [PATCH net-next v9 06/11] net: ipv6: Use link netns in newlink() of rtnl_link_ops
Date: Mon, 10 Feb 2025 21:29:57 +0800
Message-ID: <20250210133002.883422-7-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133002.883422-1-shaw.leon@gmail.com>
References: <20250210133002.883422-1-shaw.leon@gmail.com>
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
 net/ipv6/ip6_gre.c    | 20 ++++++++++----------
 net/ipv6/ip6_tunnel.c | 13 ++++++++-----
 net/ipv6/ip6_vti.c    | 10 ++++++----
 net/ipv6/sit.c        | 11 +++++++----
 4 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 863852abe8ea..108600dc716f 100644
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
@@ -2009,11 +2011,10 @@ static int ip6gre_newlink(struct net_device *dev,
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
 
@@ -2028,7 +2029,7 @@ static int ip6gre_newlink(struct net_device *dev,
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6gre_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6gre_tunnel_link_md(ign, nt);
@@ -2248,11 +2249,10 @@ static int ip6erspan_newlink(struct net_device *dev,
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
 
@@ -2268,7 +2268,7 @@ static int ip6erspan_newlink(struct net_device *dev,
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6erspan_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6erspan_tunnel_link_md(ign, nt);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 54b843d20870..2438dc627e02 100644
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
@@ -2008,13 +2008,16 @@ static int ip6_tnl_newlink(struct net_device *dev,
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
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip6_tnl_encap_setup(nt, &ipencap);
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 993f85aeb882..4aa1e7821951 100644
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
@@ -1002,13 +1002,15 @@ static int vti6_newlink(struct net_device *dev,
 			struct netlink_ext_ack *extack)
 {
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
index e2bd52cabdee..e870271ed04a 100644
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
@@ -1556,15 +1557,17 @@ static int ipip6_newlink(struct net_device *dev,
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
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip_tunnel_encap_setup(nt, &ipencap);
-- 
2.48.1


