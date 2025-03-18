Return-Path: <linux-kselftest+bounces-29321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9C2A66580
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 02:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062967ABF33
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5450F1DE8AE;
	Tue, 18 Mar 2025 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PBdSH8X4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5F41D6DB5
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 01:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262086; cv=none; b=TB0ANtWoGyVL4Ox8ltKnsV2/NdfPaY7CSo3T6oVV5V9a9gVVp97969ftCzZlY62PBZM8lyPin7vID2rVn+JK0kVMZcaLLYTua4DAmulEHwFWwl+r7iI5ZFZ9mbsJC8yGRmDF5/pylfz0RTRG9sBh/0cYQ5hGTgsCH6a24leOfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262086; c=relaxed/simple;
	bh=iB5Qbo870WqlbaCwTJXZDkTFSeANy8yaa5A4feFl5uI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FYsIiBL2n9v9oe9aq0wpWBuV5wphAxzr57sG/DPXmMfTUrBTCZLGdIFdf72DOMYiZLRnfJKBByeer0dNe6hF0rHGQPRlhFtTXLijZtlIR0QIPnTRdOx2EvBlQdUzuwncLJdEg388I+2zcYXESBR4X4nfy9JhlUev3Whj7gdiReQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PBdSH8X4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so31033895e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 18:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262081; x=1742866881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EX27ynroTle2hMLi/lQB2ni1edTfOYhzu1lG1eRku3I=;
        b=PBdSH8X4r3Bx1IJJkJ4iwiSpvBvFLLyQtZfc3sjqhhVM6IJ8U+dja/tR8T1pB6xzkS
         xoUCCYJea72HLTfUm4dHisidGG5D9teC3POr8T4hp28V4RYMhJEGtxUU8vMJ1NIMxTmS
         PFRwfweUWFUJtkyxnKE8FZinWtD//fwHXtZJDpEE4AbL96zZa+V6GznGAxS3alfGC84h
         HwHoEgr67oaw2zYAFA6GcbvomiTNpWInEP/MmOyrZetWgljOf9wTPyHC66la/Ui5esH7
         66AAp+LxFKQlvM0sfhEZcikm49b21v5vYwD/ivwNwpnCEn4hGLgCSZi8rvhlOrAAJfXO
         GAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262081; x=1742866881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EX27ynroTle2hMLi/lQB2ni1edTfOYhzu1lG1eRku3I=;
        b=i4vw6Ov5pRDWs1FlS3a9zTyJj9DC0rdFZJoNUn3Fz/m6Mi6mIOS1VkbuBGl0oRf4+m
         76fPxe/upF2PIXIHBstwM7aIg0GdWvATTVayynZMrrA2J7N+sFu4naTOobvsi5KW4qns
         ellDqXGy5syWAWkPMAYfIQY+Wrn6p/1oYwLkN8nvFn3sKehGqBgCZjGB3ftj3EvwgObU
         rUMXBk9ed9V0vPiAZTPYqySHu2OrCYxCHM4Enrd6EDw5OeemDvAeWVJ3QcbmEi3LNuY3
         7iNj4XJdQtP3cfX7Vcjxh4xBC52M0N5CauYlZVvEdNBOdUpZHSM451HKUq2/oXGMSM2v
         +l7w==
X-Forwarded-Encrypted: i=1; AJvYcCV/NuQwVNUNUjaBgqcRv4g9nWYVk9CsrM94j3Z8ED+iyRqteeBjHLN/e8iW9mJ/jpIgerEwBb7RhILbHk2C220=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeff1y9KfB72OJ8gEQ9rB6pLzHJjXQ/NTqTQpBzNkxh7X4z9NR
	hzA/Ak5deg2IG4AnMxKfCKx/nykqyjcIbhpfZlDyfbpo5c1w0twDZQIRbcHSElK7HgvlBQBMtrH
	vD9/o4kxvyw4lhUBsYqUA6mdtEKj1z8XitVl28tR+74F1ktXPkt+IIrnWC0k=
X-Gm-Gg: ASbGnculcDKFy1BOXeVzNXylhDf1OOgCpHmr+pBMx4I0+tfFmf3vciyYtlUEzKWKFfB
	o7+Db6wCzQeKya3CZ8EO1YtIO4AmiCC2YtIklRRH9d9TCJnycbrS2J8ZGWA2KnQSUf1BuYGuWEM
	Af/9k475YB0lLdLY5Q3DwXGye0w8lmK5MZdFCqTqBXa1lb/7eVwh1EUVLtpp4lNLE7LWA1QyqfV
	X7dteWlTXj6u5ialumwpZd5wl7CDnfjcbBdKmN0nIwwJ0hSw+CAlejqghzATVSKgtaFGsVW9L/q
	jWCwv0bn/EXks8wWSTPMHEsWFamo/iEzoGUeg66bzQ==
X-Google-Smtp-Source: AGHT+IG6UN66Yg4RLgS3mKX2KYWiyqq0UfcLDvTiKFzJ67BRfqupQp7HG2zgzK3ILEAgZeARFaL5rQ==
X-Received: by 2002:a05:600c:1991:b0:43d:db5:7b21 with SMTP id 5b1f17b1804b1-43d3ba10cc5mr2757415e9.28.1742262080681;
        Mon, 17 Mar 2025 18:41:20 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:20 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:50 +0100
Subject: [PATCH net-next v24 15/23] ovpn: implement peer lookup logic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-15-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
In-Reply-To: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11637; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=iB5Qbo870WqlbaCwTJXZDkTFSeANy8yaa5A4feFl5uI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn2M8qy8p0GsGbpugkT1SAMv94rVXZup6mCBUa6
 MrBR3wtgFGJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9jPKgAKCRALcOU6oDjV
 h/9nCACLcdU4z44DHtcLELhUfGLdHp3Ygnisd8qD+eYmMRQbcKfDLHSnS6zBmIXnesGyRn7oPBx
 YCBo08IIfwQCr5nv19vAqCrPq9p3PVJ2VlFfDbzqnt3+6j9xK6ZsrmGmpcrtFM3yzdHIxBHLKPa
 oC27QzFS2NA3GRQ6K2UxsZxgxxr6Yt23mF6T9+sYQG09gHYEgrYuhMNls3G2vUWLBIAhMOJVsIr
 3LGU2IeoCbXXPZlqDem/HpJrS1/Ynxwx6LvVkFF77RnMdtcos5Xxao//Fj9ThnjIplHWH7lNIW5
 5/jocZA3O4QYfSUoXrK3IKX4yQ1DbF04qhSqZBMhRsqIdnj6
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
index bed2e591c000c4efecdcd92db484e590f97f9f7f..2d6cecc28c5d1f7d5516f7f89bc0ba274c72d5e1 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -10,6 +10,7 @@
 #include <linux/skbuff.h>
 #include <linux/list.h>
 #include <linux/hashtable.h>
+#include <net/ip6_route.h>
 
 #include "ovpnpriv.h"
 #include "bind.h"
@@ -150,6 +151,121 @@ static int ovpn_peer_skb_to_sockaddr(struct sk_buff *skb,
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
+	slot = ovpn_get_hash_slot(ovpn->peers->by_vpn_addr4, &addr,
+				  sizeof(addr));
+	nhead = &ovpn->peers->by_vpn_addr4[slot];
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
+	slot = ovpn_get_hash_slot(ovpn->peers->by_vpn_addr6, addr,
+				  sizeof(*addr));
+	nhead = &ovpn->peers->by_vpn_addr6[slot];
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
@@ -227,14 +343,43 @@ ovpn_peer_get_by_transp_addr_p2p(struct ovpn_priv *ovpn,
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
@@ -269,10 +414,27 @@ static struct ovpn_peer *ovpn_peer_get_by_id_p2p(struct ovpn_priv *ovpn,
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
@@ -330,6 +492,8 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 				       struct sk_buff *skb)
 {
 	struct ovpn_peer *peer = NULL;
+	struct in6_addr addr6;
+	__be32 addr4;
 
 	/* in P2P mode, no matter the destination, packets are always sent to
 	 * the single peer listening on the other side
@@ -340,11 +504,109 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
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
@@ -357,21 +619,40 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
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
2.48.1


