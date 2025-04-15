Return-Path: <linux-kselftest+bounces-30853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B58A89C0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C707188CE2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E200729C33A;
	Tue, 15 Apr 2025 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Uag6v6Xd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B669D29A3C2
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715872; cv=none; b=GqG6OaO65v73BMug+0AGGejZX4aiQdLcTBXVqV/DX8No9bNUsJrtokQ7O663AhJmnWFY0MjwUXBFxNzZ4anddRv68mr5cX9BlXjnxFPDmRyu7bNttcauaUZBReGlPm8w+8+IhDcPcgiq8J8HiNzrWLHSB2StD4oLC4zKjPz1wxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715872; c=relaxed/simple;
	bh=Qz1wwbBezNZv1FnAKam5tfxVwWdQfiQrT7NGpNzQOdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OR4ciQenXh5u3PWahNoE3dD1vxF9qhV1gc0WF1w1jQKS8smIiyC2MTPPE5K3cPUMCungoJhiZRqYIULdvNdZsJLEMQ6ZjvD+sDBPB3cEgQmEgDfk1mP3clU24T+ouZazbfrjuSQdEcFOsNqKdZB+eEyefNddwrJEOvFpbjo9VXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Uag6v6Xd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c1ee0fd43so5229609f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715867; x=1745320667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwUZuVAaNoiHUHlyIfXYJQLeFNxbSXbeyVs9czXZA+0=;
        b=Uag6v6XdeI0+rX2icfhH1MFbikgd7VXeF5OW7Rumxh4D50PEG2FGPrGN5CeNBehJB/
         uwpS3PrAKFS313x+40uYU16pN3jYQBhA12UehXzlOjQLl1dU2TAqd0OizHUIwtzDw5//
         u8bOCf9VJp2XH2nUdAil+2MIj5WtfTKv8XXnOTq07f1TwA3RJ0z7B8LMyz1qjJKOFn1J
         ZLoZkFQTzXZFRax/EMcURgrugPqp0yiELN+KFHFTNRgemOubhPL3x30sWFs0g9ZexPSh
         DwGSdlpn3vOr4NljU/MdRugl6HCOTXvcAdIyrTDGqvVXciHGv+BYVi8+BE4yEAvjvrsp
         /Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715867; x=1745320667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwUZuVAaNoiHUHlyIfXYJQLeFNxbSXbeyVs9czXZA+0=;
        b=aA6zsO7/LmAEkkjQPMQG/slPoZiit3R5DNckg0+X0hvwCvjlJA2Miw/T2UzB9eFa5L
         ZHGKRij0nzVBxlDjdg+FWa3w0CsikE/3X8vd1gZR++f7UybrEzqBR23e1ToX1pJ1zs9/
         /MVveFJfpW+vn3ZvR+IRD/vvrKbpG/bdSSvdKVbkfEwPbLDVb7sTQXEvb4E7ls9r+Inq
         icvmqR6Ky5XV2TWRb7+Y8QCXTrvrSu2WWbXrkGmhq90oQAcxxWgkhgfS4Hh14tFEhq+K
         yBuMekJZLOKIP83GzUqwlRAhqsy7hnINLbNmBQy2b0i4kyulXkpVGsf+E3RexHzjZqzN
         wd+A==
X-Forwarded-Encrypted: i=1; AJvYcCU23pcYclIoOCuZ+baTcqHctblcdlkRcXf3peKWMpLola1xzD8P1IGzNialECfvXUcW6F4p2pxZuiU/yNRGLbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/aQLlisEvBlFbVOoMJYcCfr/CTcHkbIxjIX/OJNzwiYsu+s/
	zxm0dUgmYCjmIzbhu3LcI0M+iXgdpYEdRyKMAzM8VsAmLsx9d+J4Cl1E09kpSH0BApp/Kz12MN9
	K2s1887KDfNXLCiA0JqfnjEd42m5OQVK5C3hY/UTp5pujaXK8+889tdglHTA=
X-Gm-Gg: ASbGncuXJDuF1LSBcVfJcI3v1cRc0eItnkqQ26b9oR+1i059o8VR4LIAxlYrwhxXxsG
	szb/869tihXIuUVli4j3ruEEiC7v+XdfEVdaL3ONURxOyw7mIlimYiVROhioXB/LdBGgBV6yri+
	nWAEyzERqDdzUKsG/V2v0EPEAwAZrohaB95fx+11T/HTjPUXAFFgQG9fr0VvwRZJbCFJ9wZi/SW
	clz6j2dHyHbIJ4DgqWsF7t8SnsJPIZr/cIJ8/bvyWPKQb9lXuXhujF/Y0ECKGXOzjtbf01LHHAS
	tpNQeuh3rofZ1ie8DDrI2ua3DTYz9oIcpe95xA==
X-Google-Smtp-Source: AGHT+IEZwOuJRYqQv+4pwcnYZIYkfSBMrFpZbDIdxKyZPJuf/MqnrOaOI32eFRsWXN50vGz7AfrlGQ==
X-Received: by 2002:a5d:64a9:0:b0:39e:dd1e:f325 with SMTP id ffacd0b85a97d-39edd1ef401mr1778010f8f.31.1744715866934;
        Tue, 15 Apr 2025 04:17:46 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:46 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:32 +0200
Subject: [PATCH net-next v26 15/23] ovpn: implement peer lookup logic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-15-577f6097b964@openvpn.net>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
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
 h=from:subject:message-id; bh=Qz1wwbBezNZv1FnAKam5tfxVwWdQfiQrT7NGpNzQOdE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn/kBCQs8bWPMKI9fCg27dtdt0ocYT4mU0ON6aw
 oZ0ikJ/ZNqJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/5AQgAKCRALcOU6oDjV
 h3NdCACo1r32h9fePzE7jpJepg7G8lUj9pm2hmJFhZadPNsHwBT0t9bzZJMoivmu9zYac5Anx/f
 javGfoVxU1iZcZqvSCRBzTwROLPl9vGefbfUjquTAYFJp5MewZ2b60YwTs+fHZjuapKs1NVQjz/
 +uuN6Trt/YtouaNAHhujTR1Zmd911zirAszOjJf/W+HOGENFkzJ39wueB+7hBqOF7t0U0bPkSdl
 XtyvT8klF343tOrfoGsGr7dwF4fzixKgE7yFtXgGyT8+bkw1JBt3ak1G8ZvEw9Gu4Z2rMD4gyyv
 s66ZVLRnNSgHGQAeIMLDISBrM74XFrKSAsU5EDyk6+PB2xFg
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
2.49.0


