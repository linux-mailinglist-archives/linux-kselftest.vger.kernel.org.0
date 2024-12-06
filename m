Return-Path: <linux-kselftest+bounces-22946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB2C9E7AC1
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 22:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E861888208
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 21:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0145B2236E4;
	Fri,  6 Dec 2024 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="e1SlfQJl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F51A214810
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519942; cv=none; b=je7NISdnrHUrmkY8cL8tfuZyLaWcZPR9f2rYPHXTTDgYXaysaZ1m6pRvjD5Ib+nJW45LpdlnaZxFHt17v9u/BLf2HQXkd1JtwP3xOkOp6Doyq2K/N9iOHd5csxcwgvVzvOOQrOMDL0BzCe1b0E3FWRQ3O+9ExXuNMLGjXvvnUUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519942; c=relaxed/simple;
	bh=neS/+0qWJqF8Z7Wgo3VzoX3OM8bNHfa0Vevx+f0f3Ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MX8Z1zaICoi8VW9DsfBgwX2hLmb7IK2+Vy9HGWxtXSvTTV8Vep57Wp55C4kkfbdN0pyle+JEQx2IttRL5z53XEndbTSj2Ol0qw0uDjRqlYmpIT6L2ZWCPzcoEXL8AOvjuIQjHbNbLjhYCORgDprI+mB3FD1EWd+Kpcf/+STtd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=e1SlfQJl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so2034086f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 13:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733519937; x=1734124737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGTX6bsSUfHp3feyAtZvFNRrvKLiQ67eLp8Tyq9Lxvg=;
        b=e1SlfQJlH0GkUmKTNHhMBZO5bcMfqYTRiQ+vG2meibB71R0+aHMCRO39EDmh1ebZx+
         /owT3mLYLkvKXPWLEadpIndA3CSORnSNXQt0kXLnpN9LwQDJbFCz/fv29E8a5X7ws7Bd
         pH/6SRM/XWGVgXMyMRIhgdazYZBPW8Zt4NZULCirAcQFrVMNaiuAkBbjiqoSXV8fXsrC
         ZNzSiT9tDVyNKmJgO549Xfj4yStsjuW+O/oJm4KjYd5lIBnCMSo55KSKflsSAWOB5hnQ
         gPsNdzGS96pOQWZDsNO+28YMX/c8RX+N8SLNoh9t+HXYDzIPRG6oTN245868N82Ph8Gs
         sbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519937; x=1734124737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGTX6bsSUfHp3feyAtZvFNRrvKLiQ67eLp8Tyq9Lxvg=;
        b=IVwAL/2jVdOjMHXIgxwc1dxsrSgZH71IvSWvKilqFmOhBwM7oSziIBDMWNTxgxXoVX
         7fP3eLFHYNs2qKPsGeV9tWgOjEaQ3hUdXWojoXncI/dBs/YxX03gK0ld2tAGm7EuO24K
         rwGK3e9LzUoaLnVeUABfJjDUSMXPqgepLRitL7V5yWfylqzj6zvty5+lZtgR5FhB+md2
         2SAsvCXLoTb+DRduCWHnKie/S+vsK/8A6KXS5GzzY89d5hK+qtoEXfX1FHURdStB9nJf
         nC2+4ELVNvH6o3dPFEyL1LeNbvqKbtL+aijNWdBYzhB1rw9PqlHPgKZ2PWaxAM2Cr+rj
         xpqg==
X-Forwarded-Encrypted: i=1; AJvYcCXt5NLur9Ybn8q5ZiD0MpYrh4qMUnVdU/vF51b7N2huDKH8d6QmtK2EAXOTSdMGsuZRDfxNks1aOSZ3AHySqQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGqfCQ/JAsY2UNxpjRdswUpTbD71LO3DchHbDLswb3oTXDn8t/
	444OaqgvlZ7xa85fVEsg1Z/Zv41lloZNih8AEKhq6REiXxIje9FUkkxbagLr9+c=
X-Gm-Gg: ASbGncucsZISw3AALOEtAVTuB1JS/zVRvRsrq/tkpxjl43KbCDUvgxPrd0F5I7PQaYb
	YnkWu4dxhU8D104Oj+RB9O5xxC4z4wCShN1dFTwo0/E8174wHtdigVIbNiYb7WAqqpol4+XznRd
	+qYBjQvAJtssJfm6LAcwT7fnhJVX1TxJY92iX6VfxDA/kHk9fBNrqfJoFEs25u1p6mbNOaT6cLw
	tEReVGVC+eZ+e1+ClNtfKSElOYsw+0Aio7B0diugLforCLn+uelxyv3t74gVQ==
X-Google-Smtp-Source: AGHT+IFICAekuySvdk8wQfh+QmqxSDhiP1atIUevz4yUTAey5l6yWD8Ys0dku4sIz4tJe/cf4xGh0A==
X-Received: by 2002:a05:6000:1846:b0:37d:4647:154e with SMTP id ffacd0b85a97d-3862b333747mr3556778f8f.9.1733519937099;
        Fri, 06 Dec 2024 13:18:57 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3cee:9adf:5d38:601e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46839sm5441302f8f.52.2024.12.06.13.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:18:56 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 06 Dec 2024 22:18:38 +0100
Subject: [PATCH net-next v13 13/22] ovpn: implement peer lookup logic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-b4-ovpn-v13-13-67fb4be666e2@openvpn.net>
References: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
In-Reply-To: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11634; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=neS/+0qWJqF8Z7Wgo3VzoX3OM8bNHfa0Vevx+f0f3Ls=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnU2pXYv0A5lvOceAAHwmyENSidCIE1746zs3mG
 y6O+or1Vi2JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1NqVwAKCRALcOU6oDjV
 h/jyB/9dvaYQtsd/1iY/L+O5XmqqU9u6JrmCvXoNgBwz3HuutyuOjN0t9jVki0CS4gnKueV/S+/
 BIgZrQU/HVAeAeaZCIF224jJxYIRMhiG81DryyKlEAMUOEYrojAOS90G2BOnUYtI69hzN/BRmTM
 Ieyma7Xi1H1wiZ30E6zIGfk7KXsY7JcePa6MF+ci+GYWzJhr+E9IoL9zZYR2uY4mVHu/NYNlF7O
 L81Esqlyuovlj8CydC/FNFo49JeNIzEu35+CistI5wKfsSdRCDnvVw4CuLQd5GRIhTk5hYpTyVd
 dxUapOzN7/5cj3HW79KG9ykUC0gTRRWWSbHZMxDNR+KV8y7U
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
index 9f213ccacfaf8170b9c23730498f156360774d7e..5e78c984ef302ae17ef8481bb10ac382e5d11e31 100644
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
+	size_t sa_len;
 
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


