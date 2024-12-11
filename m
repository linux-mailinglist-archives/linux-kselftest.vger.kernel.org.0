Return-Path: <linux-kselftest+bounces-23213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04E39ED8AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5D32833F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 21:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E44F1FA8CE;
	Wed, 11 Dec 2024 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="C4ux9Bqv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A655A1F63DE
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952786; cv=none; b=jPGjJQJOWhEZPFE//7W3iq/ph2iCMeSG0QhQpQbZfXBM9yarJyiLhYJw49CTkukLYmOBcR6Og4NHJhW5l0vQoGamc47paOzEIPw0eMwFRtMxX1Ud0BskajLBJpTdj1RG0RmdFOmQxit729F3MUBkDzn4c3Q0Rflu5NB2WXKQxC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952786; c=relaxed/simple;
	bh=0jHvsbubjLbATY6dn/22tsttoEMOMpa5Tid/uaJf0bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hD9lVt0v/XTe57VKGatG6o5ZuxJJKJnZX0YQgUW/xUZBzB3QE39irXZIHBu/o0m7Q2+neUXOc3vaz9ATkIJe8MQwQ0krCQW1Sc+pejMPfqjtGG0qwYJ5PbIudM3QQ/p4rP1iiC6y+Az/1EWyzWyTZZwd67YTXmBtW51EZ/VyXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=C4ux9Bqv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862a921123so4306710f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 13:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952782; x=1734557582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MeMLhesp1PSLhN6c9KRgOTYbComzWurlrW23QNgAQQ=;
        b=C4ux9Bqvtd1aGcPHYA9/u7AvbCTzPj0e1PMnEBT20Oc9NBCI4OmYiX52+HhmHIzcEa
         FFbkCTy29PTMe4jic4OzcbLp0u6Z9wPlGe5w6ljC5R6W11riW3kUm/Kyl+s5gAUalrFl
         TN0UwMN5DhOJTVDpgx/MyMe36a4WnVYsTrgBU3HW874pRt/mMdQVBB93qG7qKkEJdLk3
         zZrjPxjH4mBdRP21tloCFlIiQnwM9Gq/NeTAg52ncpfbQ0VyssTDatrgPWRUwgke4+YC
         Bc7+mzYrXJTpQvkduSciSKHqg4C0o1Ct1vWQcUIofJEp1QPHDfC8p3WkPP4LHBNPmtTM
         W92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952782; x=1734557582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MeMLhesp1PSLhN6c9KRgOTYbComzWurlrW23QNgAQQ=;
        b=SmcA4D5sRPZFSSBoC2+I5SsZ0/0LWHSUULUUT0yD8GPhskncbDjyPCpTedSVJkkiPC
         AJCL6tivHe3S4lOsHNR013Y2jLXU6/khgtDJZwCGlsjqUZO+PHr+ygqysl9rW2PzBPhq
         4l8GLFh/N587t3qYdCqCLjurFH1zgb8V2VDn7ZlfFPXe1aoDWnOAs8q0nDmGhamNTKoV
         YLx3wi20rCbxwGEXN8zr0ZtsEmRsj23DWWWU1vJbN2ehOKKu+sxUODA4/kyq0uPtmUsa
         H9zPRp8934FOWsXG3++OYdHecARZeYNoJLjRAJelXOqzdiRKtYSMQGl8NwQZD2EpPCIl
         p1nw==
X-Forwarded-Encrypted: i=1; AJvYcCVprfN5pcizh0BQJpJkJMwg10BstEZ/ZJfT110DW/plM6Lpugd1z+uTl5exxKj4XflbkzvQ41yGYx2WbNrDElM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mmPUUYk0hMlLZFc5ZhUomyIjyhIDIIdjrHZJ/5xG6N4uON0s
	8UscB6FL9TfYij6tkPBplhol46ISss0Tc9q+3V90JweXiaCZ3j8YI5NZTGhwM0w=
X-Gm-Gg: ASbGncsCtTirLxylOwufg6gTRrJTvu7CfQj3CBPlKG2k6M8j3UMpDDa7vDrOTg6ipE+
	yBgJUDfovcUhqtdnu/VLQNBMMbb7afur6cbii9DyFsh9X9qd95vrSZ/jFruay7KoGlB8jjLgxL1
	ATflcbHograakRzH2GuuTF0yQXneAGyQ0EaaIn2Iehw1IiekvChHg1vdSPMsov3VxG5ucDMho04
	y09kDPLtVQ+PHTnCB3Sdag5WG4ES5G5W6faLdLJyNAQX/1EAF99o2VJ6iupjXG4hA==
X-Google-Smtp-Source: AGHT+IHIVx7stO4Mn5CKY9Cgc6lVtIh/yL7yI7C5V5v2kT5uqcOo4aAVUs6UWnsykxSm0RV/BvIDrA==
X-Received: by 2002:a05:6000:68f:b0:386:416b:9c69 with SMTP id ffacd0b85a97d-3878769151bmr816078f8f.16.1733952782059;
        Wed, 11 Dec 2024 13:33:02 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:33:01 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 11 Dec 2024 22:15:17 +0100
Subject: [PATCH net-next v15 13/22] ovpn: implement peer lookup logic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-ovpn-v15-13-314e2cad0618@openvpn.net>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
In-Reply-To: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11635; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=0jHvsbubjLbATY6dn/22tsttoEMOMpa5Tid/uaJf0bU=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnWgUmUklGAR39gTIq+e4NUrbtCe0MLNPdt4VCV
 ExGZw0qiViJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1oFJgAKCRALcOU6oDjV
 h9ZwB/9p34QExM03MQO+7s8kOJibR6WTRyRgZ6seqmBoCo4ALgK0Zf3LlHmxG+Ffx2B4xBEJbib
 l0zMnwJuuoFZqK9Qa+NwrEkDG2Yd/0kiSlozzBYanqfOIJBlFhcEInYe+xn19pUuNZ8LuB+Nhgs
 77/KtXBy2D2Ax2txnUNJo5fL7dFccRF23MfVzR7ybUXpKkB4eH6JTCnHoy0VDNxlHnTjrxaiWx7
 sFeC1LVVOyuWaCeJN2VCVIjkP1y+fgxHSPi2J9PM4l4LllgmecYEHfEiqnD7En/tytyeLbSznEg
 lOmrU/bWjgsVJKyl39BNlFTtrJrYhX/6oI1IT1CFhiERc3kU
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

In a multi-peer scenario there are a number of situations when a
specific peer needs to be looked up.

We may want to lookup a peer by:
1. its ID
2. its VPN destination IP
3. its transport IP/port couple

For each of the above, there is a specific routing table referencing all
peers for fast look up.

Case 2. is a bit special in the sense that an outgoing packet may not be
sent to the peer VPN IP directly, but rather to a network behind it. For
this reason we first perform a nexthop lookup in the system routing
table and then we use the retrieved nexthop as peer search key.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 301 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 291 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 9f213ccacfaf8170b9c23730498f156360774d7e..f1763fb3d044aa87fde7f877cf3e83ea1e19ae11 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -10,6 +10,7 @@
 #include <linux/skbuff.h>
 #include <linux/list.h>
 #include <linux/hashtable.h>
+#include <net/ip6_route.h>
 
 #include "ovpnstruct.h"
 #include "bind.h"
@@ -136,6 +137,121 @@ static int ovpn_peer_skb_to_sockaddr(struct sk_buff *skb,
 	return -1;
 }
 
+/**
+ * ovpn_nexthop_from_skb4 - retrieve IPv4 nexthop for outgoing skb
+ * @skb: the outgoing packet
+ *
+ * Return: the IPv4 of the nexthop
+ */
+static __be32 ovpn_nexthop_from_skb4(struct sk_buff *skb)
+{
+	const struct rtable *rt = skb_rtable(skb);
+
+	if (rt && rt->rt_uses_gateway)
+		return rt->rt_gw4;
+
+	return ip_hdr(skb)->daddr;
+}
+
+/**
+ * ovpn_nexthop_from_skb6 - retrieve IPv6 nexthop for outgoing skb
+ * @skb: the outgoing packet
+ *
+ * Return: the IPv6 of the nexthop
+ */
+static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
+{
+	const struct rt6_info *rt = skb_rt6_info(skb);
+
+	if (!rt || !(rt->rt6i_flags & RTF_GATEWAY))
+		return ipv6_hdr(skb)->daddr;
+
+	return rt->rt6i_gateway;
+}
+
+/* variable name __tbl2 needs to be different from __tbl1
+ * in the macro below to avoid confusing clang
+ */
+#define ovpn_get_hash_slot(_tbl, _key, _key_len) ({	\
+	typeof(_tbl) *__tbl2 = &(_tbl);			\
+	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl2);	\
+})
+
+#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
+	typeof(_tbl) *__tbl1 = &(_tbl);				\
+	&(*__tbl1)[ovpn_get_hash_slot(*__tbl1, _key, _key_len)];\
+})
+
+/**
+ * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
+ * @ovpn: the openvpn instance to search
+ * @addr: VPN IPv4 to use as search key
+ *
+ * Refcounter is not increased for the returned peer.
+ *
+ * Return: the peer if found or NULL otherwise
+ */
+static struct ovpn_peer *ovpn_peer_get_by_vpn_addr4(struct ovpn_priv *ovpn,
+						    __be32 addr)
+{
+	struct hlist_nulls_head *nhead;
+	struct hlist_nulls_node *ntmp;
+	struct ovpn_peer *tmp;
+	unsigned int slot;
+
+begin:
+	slot = ovpn_get_hash_slot(ovpn->peers->by_vpn_addr, &addr,
+				  sizeof(addr));
+	nhead = &ovpn->peers->by_vpn_addr[slot];
+
+	hlist_nulls_for_each_entry_rcu(tmp, ntmp, nhead, hash_entry_addr4)
+		if (addr == tmp->vpn_addrs.ipv4.s_addr)
+			return tmp;
+
+	/* item may have moved during lookup - check nulls and restart
+	 * if that's the case
+	 */
+	if (get_nulls_value(ntmp) != slot)
+		goto begin;
+
+	return NULL;
+}
+
+/**
+ * ovpn_peer_get_by_vpn_addr6 - retrieve peer by its VPN IPv6 address
+ * @ovpn: the openvpn instance to search
+ * @addr: VPN IPv6 to use as search key
+ *
+ * Refcounter is not increased for the returned peer.
+ *
+ * Return: the peer if found or NULL otherwise
+ */
+static struct ovpn_peer *ovpn_peer_get_by_vpn_addr6(struct ovpn_priv *ovpn,
+						    struct in6_addr *addr)
+{
+	struct hlist_nulls_head *nhead;
+	struct hlist_nulls_node *ntmp;
+	struct ovpn_peer *tmp;
+	unsigned int slot;
+
+begin:
+	slot = ovpn_get_hash_slot(ovpn->peers->by_vpn_addr, addr,
+				  sizeof(*addr));
+	nhead = &ovpn->peers->by_vpn_addr[slot];
+
+	hlist_nulls_for_each_entry_rcu(tmp, ntmp, nhead, hash_entry_addr6)
+		if (ipv6_addr_equal(addr, &tmp->vpn_addrs.ipv6))
+			return tmp;
+
+	/* item may have moved during lookup - check nulls and restart
+	 * if that's the case
+	 */
+	if (get_nulls_value(ntmp) != slot)
+		goto begin;
+
+	return NULL;
+}
+
 /**
  * ovpn_peer_transp_match - check if sockaddr and peer binding match
  * @peer: the peer to get the binding from
@@ -213,14 +329,43 @@ ovpn_peer_get_by_transp_addr_p2p(struct ovpn_priv *ovpn,
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 					       struct sk_buff *skb)
 {
-	struct ovpn_peer *peer = NULL;
+	struct ovpn_peer *tmp, *peer = NULL;
 	struct sockaddr_storage ss = { 0 };
+	struct hlist_nulls_head *nhead;
+	struct hlist_nulls_node *ntmp;
+	unsigned int slot;
+	ssize_t sa_len;
 
-	if (unlikely(!ovpn_peer_skb_to_sockaddr(skb, &ss)))
+	sa_len = ovpn_peer_skb_to_sockaddr(skb, &ss);
+	if (unlikely(sa_len < 0))
 		return NULL;
 
 	if (ovpn->mode == OVPN_MODE_P2P)
-		peer = ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
+		return ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
+
+	rcu_read_lock();
+begin:
+	slot = ovpn_get_hash_slot(ovpn->peers->by_transp_addr, &ss, sa_len);
+	nhead = &ovpn->peers->by_transp_addr[slot];
+
+	hlist_nulls_for_each_entry_rcu(tmp, ntmp, nhead,
+				       hash_entry_transp_addr) {
+		if (!ovpn_peer_transp_match(tmp, &ss))
+			continue;
+
+		if (!ovpn_peer_hold(tmp))
+			continue;
+
+		peer = tmp;
+		break;
+	}
+
+	/* item may have moved during lookup - check nulls and restart
+	 * if that's the case
+	 */
+	if (!peer && get_nulls_value(ntmp) != slot)
+		goto begin;
+	rcu_read_unlock();
 
 	return peer;
 }
@@ -255,10 +400,27 @@ static struct ovpn_peer *ovpn_peer_get_by_id_p2p(struct ovpn_priv *ovpn,
  */
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id)
 {
-	struct ovpn_peer *peer = NULL;
+	struct ovpn_peer *tmp, *peer = NULL;
+	struct hlist_head *head;
 
 	if (ovpn->mode == OVPN_MODE_P2P)
-		peer = ovpn_peer_get_by_id_p2p(ovpn, peer_id);
+		return ovpn_peer_get_by_id_p2p(ovpn, peer_id);
+
+	head = ovpn_get_hash_head(ovpn->peers->by_id, &peer_id,
+				  sizeof(peer_id));
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp, head, hash_entry_id) {
+		if (tmp->id != peer_id)
+			continue;
+
+		if (!ovpn_peer_hold(tmp))
+			continue;
+
+		peer = tmp;
+		break;
+	}
+	rcu_read_unlock();
 
 	return peer;
 }
@@ -280,6 +442,8 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 				       struct sk_buff *skb)
 {
 	struct ovpn_peer *peer = NULL;
+	struct in6_addr addr6;
+	__be32 addr4;
 
 	/* in P2P mode, no matter the destination, packets are always sent to
 	 * the single peer listening on the other side
@@ -290,11 +454,109 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 		if (unlikely(peer && !ovpn_peer_hold(peer)))
 			peer = NULL;
 		rcu_read_unlock();
+		return peer;
 	}
 
+	rcu_read_lock();
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		addr4 = ovpn_nexthop_from_skb4(skb);
+		peer = ovpn_peer_get_by_vpn_addr4(ovpn, addr4);
+		break;
+	case htons(ETH_P_IPV6):
+		addr6 = ovpn_nexthop_from_skb6(skb);
+		peer = ovpn_peer_get_by_vpn_addr6(ovpn, &addr6);
+		break;
+	}
+
+	if (unlikely(peer && !ovpn_peer_hold(peer)))
+		peer = NULL;
+	rcu_read_unlock();
+
 	return peer;
 }
 
+/**
+ * ovpn_nexthop_from_rt4 - look up the IPv4 nexthop for the given destination
+ * @ovpn: the private data representing the current VPN session
+ * @dest: the destination to be looked up
+ *
+ * Looks up in the IPv4 system routing table the IP of the nexthop to be used
+ * to reach the destination passed as argument. If no nexthop can be found, the
+ * destination itself is returned as it probably has to be used as nexthop.
+ *
+ * Return: the IP of the next hop if found or dest itself otherwise
+ */
+static __be32 ovpn_nexthop_from_rt4(struct ovpn_priv *ovpn, __be32 dest)
+{
+	struct rtable *rt;
+	struct flowi4 fl = {
+		.daddr = dest
+	};
+
+	rt = ip_route_output_flow(dev_net(ovpn->dev), &fl, NULL);
+	if (IS_ERR(rt)) {
+		net_dbg_ratelimited("%s: no route to host %pI4\n",
+				    netdev_name(ovpn->dev), &dest);
+		/* if we end up here this packet is probably going to be
+		 * thrown away later
+		 */
+		return dest;
+	}
+
+	if (!rt->rt_uses_gateway)
+		goto out;
+
+	dest = rt->rt_gw4;
+out:
+	ip_rt_put(rt);
+	return dest;
+}
+
+/**
+ * ovpn_nexthop_from_rt6 - look up the IPv6 nexthop for the given destination
+ * @ovpn: the private data representing the current VPN session
+ * @dest: the destination to be looked up
+ *
+ * Looks up in the IPv6 system routing table the IP of the nexthop to be used
+ * to reach the destination passed as argument. If no nexthop can be found, the
+ * destination itself is returned as it probably has to be used as nexthop.
+ *
+ * Return: the IP of the next hop if found or dest itself otherwise
+ */
+static struct in6_addr ovpn_nexthop_from_rt6(struct ovpn_priv *ovpn,
+					     struct in6_addr dest)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	struct dst_entry *entry;
+	struct rt6_info *rt;
+	struct flowi6 fl = {
+		.daddr = dest,
+	};
+
+	entry = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &fl,
+						NULL);
+	if (IS_ERR(entry)) {
+		net_dbg_ratelimited("%s: no route to host %pI6c\n",
+				    netdev_name(ovpn->dev), &dest);
+		/* if we end up here this packet is probably going to be
+		 * thrown away later
+		 */
+		return dest;
+	}
+
+	rt = dst_rt6_info(entry);
+
+	if (!(rt->rt6i_flags & RTF_GATEWAY))
+		goto out;
+
+	dest = rt->rt6i_gateway;
+out:
+	dst_release((struct dst_entry *)rt);
+#endif
+	return dest;
+}
+
 /**
  * ovpn_peer_check_by_src - check that skb source is routed via peer
  * @ovpn: the openvpn instance to search
@@ -307,21 +569,40 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer)
 {
 	bool match = false;
+	struct in6_addr addr6;
+	__be32 addr4;
 
 	if (ovpn->mode == OVPN_MODE_P2P) {
 		/* in P2P mode, no matter the destination, packets are always
 		 * sent to the single peer listening on the other side
 		 */
-		match = (peer == rcu_access_pointer(ovpn->peer));
+		return peer == rcu_access_pointer(ovpn->peer);
+	}
+
+	/* This function performs a reverse path check, therefore we now
+	 * lookup the nexthop we would use if we wanted to route a packet
+	 * to the source IP. If the nexthop matches the sender we know the
+	 * latter is valid and we allow the packet to come in
+	 */
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		addr4 = ovpn_nexthop_from_rt4(ovpn, ip_hdr(skb)->saddr);
+		rcu_read_lock();
+		match = (peer == ovpn_peer_get_by_vpn_addr4(ovpn, addr4));
+		rcu_read_unlock();
+		break;
+	case htons(ETH_P_IPV6):
+		addr6 = ovpn_nexthop_from_rt6(ovpn, ipv6_hdr(skb)->saddr);
+		rcu_read_lock();
+		match = (peer == ovpn_peer_get_by_vpn_addr6(ovpn, &addr6));
+		rcu_read_unlock();
+		break;
 	}
 
 	return match;
 }
 
-#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
-	typeof(_tbl) *__tbl = &(_tbl);				\
-	(&(*__tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl)]); }) \
-
 /**
  * ovpn_peer_add_mp - add peer to related tables in a MP instance
  * @ovpn: the instance to add the peer to

-- 
2.45.2


