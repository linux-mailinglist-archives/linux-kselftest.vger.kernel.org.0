Return-Path: <linux-kselftest+bounces-23504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0FC9F66DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 14:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A030D16F02F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471A01FA8C2;
	Wed, 18 Dec 2024 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k58c8fR5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D11B0406;
	Wed, 18 Dec 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527418; cv=none; b=MWUUegZReS3AjxLyePMfvt6w430E3mduBsXs/J2aL01HqV5NiRxmQax/TxaunPtJXcz/Y3U/abL01wMWUNHb04I94Av5fHtMrqdvt3MQpXB8BhaDn/CwjGs6uV6tzn7+1rORSnMcd5Emq6WMCg3TgpLKZKhqZAkvVrsxFvWzMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527418; c=relaxed/simple;
	bh=ExcFFASRL0JOBX+JRaYP5UZ03RNRSWOI8Fw5iiUDoBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qolKQu96xaqxI7CxPSh2Hfnhosj63/a/ogqlmJDgqsW81QynVgPLNkdmhmkQ47B8XyclYVgRfN6zHOBgSkWqfPiUxa7RbqK9ZzEfz3GTeIMoJwwS1dTP/EZqI1q5x8+p07+WZ8HAEZntZT8Wkm6KJDAU6HwNdh2WyduF1D2S5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k58c8fR5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-728f1525565so7669855b3a.1;
        Wed, 18 Dec 2024 05:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527415; x=1735132215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGKuR9iwJLKB00bK/9yuK8uQjR1STrnypDr+9jM2ZjQ=;
        b=k58c8fR5Keswx3idccyEnvIDUTHA7CZHJvsT5wzJYta5LpxyyAd5apTc4JQwP3q3ql
         3n6bubBCzjEJXO3hcvYnkET0VXOQOw6ce0ZyyptQnKlitRF8T22KeC3FS3OPf+gnuhFc
         G6Q+EkGgGAOU+pYs+l8XPiIyRT3JBQnaTY9FiO1Cxjrtx7TFrC0DSpYV8SLoJusN/p+6
         Wb8Pv66zm4NsTuJe+J3jIrRHZ0WOHftefdDONQ7xX3yNbMM6su9jtYzbgfuENVOjLsfY
         Not+dxdU0sZ5RLkr7sXhVygrTaATCKwNOcY+qq2/TfpyTCOBcbfq/BaVWTAqo/XNaiTb
         J3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527415; x=1735132215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGKuR9iwJLKB00bK/9yuK8uQjR1STrnypDr+9jM2ZjQ=;
        b=Qdem2b3z0fkGr21DHFYKLPwavw9OmASnX9CMwHpV4vni4gHpJBeX/aDA4fI49QDZ7+
         ZaD2lwyaiG3m+2SKZURzckgpRO8uoPDjT3WcyGgZRxxPQwW/XSkNe6FThOaxKcA/3MMB
         r6A3JYQA++ylZ9uEQfWoGU/E8TFiKENysI1bj5fSQ3WCxOYmguLajjEV+qxWcN7ROVbT
         QHAwNmSr+O4+QHuMyLBHj7pom9ei+yVX29emOB+UP/rvm7aKXMf7JlnregYaDs8ZX8Q5
         zLe5g8Vr5D7iuJZpv6/effztUiA2awmzPXS1eRVDZ9P41n5UK2a/e18DC7OvIqt0Z8GH
         ZaWw==
X-Forwarded-Encrypted: i=1; AJvYcCUBuQSS/7bOaIkfdmZsPyazGRywEliljUxHTElvD0ZvfsnSuQFtuZsfdeaX+tT+c1omlOHaNqZL7pKj312dxijq@vger.kernel.org, AJvYcCV1KgMdfERDNebFWwpKRtN1l4S+UUwLA7BA8RIUjqBCOoNEM/uB9Cs8mT6OpD3eae23EtM=@vger.kernel.org, AJvYcCVGTaqnWPDMkZDQBa2CynBu/C2ovHSnqXxrl4jH8G3poV6kWPe0ojKMs5vL8s8ORJYgWl61yUS5Eq1w@vger.kernel.org, AJvYcCVV2YuMMhr/43NSRME6qk8ZzZ67amg8ZaJke73MUx3feq76Awtc7XQKgrzRik1hEumLQozCddAcmXmpDw==@vger.kernel.org, AJvYcCW8kygT/FwiLFkgOaFB5leU1OGQWqwB1SeW5lvAmBaXidta1xOdfFcimcSkEQ0IC3lQFFE9hQVMpDg3JA==@vger.kernel.org, AJvYcCWiOP9UN3t+pnRk0nixpltWtxkhPiFpELxxb62wDuvXgOPV9MHJH58Op24CwpTteknHfkJTNYMcdRe+aPpa@vger.kernel.org, AJvYcCXED5Cg+ZeksM/BIoKsx8pp+0ZU0BIbyxFts84ogf+QVTBfls6iVnYkn/woXnJ/vb8d8YqIbPvyr9zRubmUrBU=@vger.kernel.org, AJvYcCXIMQG/VMF3tLt/yUe1zTgA3kY/TdifEaPUEmFB1DsBY6JOz39Zl83CyJeHFTLjf74S2fv2tuWmlszL@vger.kernel.org
X-Gm-Message-State: AOJu0YyKrtw2zQASRKDYZLQuUhY7JC7+U8cQZ3O37c4sZMmhzu5ELi2F
	B0e40FS+BASmcK7vUkb9KnLNErpYog9PobUb+WM4dmGZG2SiqcrSv+6Ex9H9wR0=
X-Gm-Gg: ASbGncsLkiB9504GqVskjz5RoVyDxAeMsPUCugi/gjArGMnxyckYHq4ikyJLSfDN8NK
	IGQ30LK2Np0646bniRlXhaZqEP4KVdb0cT8uPsRFdrKBH2qssgImQkoff/WNejIhMnlH+pDCivR
	MV8BI5nuCXMhDtPthCb/zuK+VLmr5GMYaoOhNKw/k6oRoVekmIsETsQJOK6odNR2sFqggpd3wZv
	GLZU0zjhjY1Jq+UHr1aXSj2f6kP4HlrnlziLppgOJxQ4oQ=
X-Google-Smtp-Source: AGHT+IGQHpjG9Zvq9f/GAFOY7LWqEtsiV3DpqBRQY31QGrPpt7r1KVlmyyAbS3TmBXSPxo4Izh1/lg==
X-Received: by 2002:a05:6a20:7288:b0:1e2:5c9:65e0 with SMTP id adf61e73a8af0-1e5b48891d8mr4000269637.32.1734527413950;
        Wed, 18 Dec 2024 05:10:13 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:13 -0800 (PST)
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
Subject: [PATCH net-next v6 06/11] net: ipv6: Use link netns in newlink() of rtnl_link_ops
Date: Wed, 18 Dec 2024 21:09:04 +0800
Message-ID: <20241218130909.2173-7-shaw.leon@gmail.com>
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


