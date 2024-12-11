Return-Path: <linux-kselftest+bounces-23207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3499C9ED8A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D85283296
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 21:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A547B1F37DD;
	Wed, 11 Dec 2024 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JmlPduzw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519271F37A5
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952779; cv=none; b=UuY2ypTPh+t5+WIpjbP50syxpieOb1KMH51kTkX05rR3oh6XokLfpmEt/b1HtJ3nA2MzLE+TvEQbAKrRuoqEsaJsb6LSqJtbKgWoEfyWESAHGBqyeI3ZIgGioHkFYng/vIFb0xLOr7eHqB7Ejw7smsqLWTn3pEIplb8nDY0yOT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952779; c=relaxed/simple;
	bh=06enNxu3ikR0DRj9VUPIev+QBajml+LPHV1f41hqW40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GwMtOr8522q/GfF07HWqkvSKxqO7rNSGVzwsUY9M8M7ZRebmFQ8rEuzgxUqF0nm0O3yaF1u7LFMmWxs4zzROpUyek2wG5leMpgQb0UStlDUkAWM5WmE23c5UyOzup4VLEwi7ZBKMeqpClhnQ7+QQu46JSRshrHbPbSNY6igpSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=JmlPduzw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a766b475so68926995e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 13:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952775; x=1734557575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m59lRlZIpZyUqdMdB2+INdiIL1VpBMdOlZss9cr6rME=;
        b=JmlPduzw53ZrqE2gHHJ896cTvE6Km8lf+Inlc5aDsbJWkSBqGscTxQ2Misik29zDcl
         DrdHvHMOilFbxpf4vb4s/42ZN5yHbTW4DdR7Sjo/Fo95ew+9l35H9kS/XoHaO6DyAlw+
         odW4RxXICV4ZSifzXiCg9qTwXOlPLkyV19Nmpnwgm7PMuvgMMPzBct0D5gnPbWYQKEDm
         84dFVo2ggqAskIrVpCt0HGFBDWkj7oKsEth8pPtinZ+t7bJnXeAOv3bX4XVfLv/p7JSx
         14e/dgp4NZ3dwnKcxnl8KfVtdtn7QfQEK1Xji9qycR8phHXZc1EPfuvHLpP0ToeybxRS
         nQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952775; x=1734557575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m59lRlZIpZyUqdMdB2+INdiIL1VpBMdOlZss9cr6rME=;
        b=OZ5A4aRcEa4OrQZabMShkEHAK3sZneVjWXjU8MtV0dKVPnaEiHnd6ocfnPgtUNQL+f
         jM+MP6UOK9GCk5P7izbYAwl8zqHA9uVCK4dj6eTCvtWVFXvj9D+CAQmXvXTuVO2V1Yfg
         7gh16lBkL+1qk8Tu5nMUy/AZZHB6SSamhuK2Q2x5OxwjPFDDYRXtzL96aEIjoVEpH62t
         U5ZOuRqKn1NnOajM00PBm2iXw7lsIBDlfoOYVqnLwpERrDbFOqKZeXXhaNFV3GnTFbXx
         XC8VIPpptJsx2iP91uSdRbvvqkYeHZ5ywIQt7SkVdAxNb2jLM4GkCoi/7wlDtZdSSmmR
         a5eA==
X-Forwarded-Encrypted: i=1; AJvYcCUStKRafuMKT3OdZIvsak/UyxTK9bLn/kApjtPimazdp0aD0AbmQrZX5/o+LLm+zM8piBO0NEAekz7GlqbfISI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/yOZNm8XAs/c1qNu3NhXy4c73Gpnb1wFnFbfZ+gJd6Trpuy5
	GrAVqaSVa/Koccu/tqtWE+W2wr4a+rIqtiSUTG+7j2eqRxBaXYxzUyzXT8kPzM8mVHPDQCoVn7j
	B
X-Gm-Gg: ASbGncvQLIuDTt4rriiIPyTmE/0Kf8N1w2etJ22BkIv8j3SEUaXeVm3BQhtqbgQUOVP
	mWIlDb+jXIjk3vE2Segk1Ut4mt1d5QRrWccQ9tMtMSSa6jq14gN7ADyy252vrN251ePAsS/ytru
	9t4DQdc2FqAgCHf7C1AL0xHY7AUW9p+oqoIPy5vaeg7jU8MSX1SIFIhKP07LmKP/p3ACRVLXhJy
	H6ufJM+MbcAT66GufDXjms33vtHYdrCxwfEY5O5SVLyavvDu4fmM+m0vY+LVxKr9g==
X-Google-Smtp-Source: AGHT+IEzOJ4JJd2QS2O0F+SUnlU3TT/KpJXHUw7GmlCi6c8VZQQP9tunqlJI6acRPn+cinf/r7h1nw==
X-Received: by 2002:a05:6000:1fa3:b0:385:e16d:51c0 with SMTP id ffacd0b85a97d-3864ce90f7cmr3960498f8f.18.1733952774628;
        Wed, 11 Dec 2024 13:32:54 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:32:53 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 11 Dec 2024 22:15:11 +0100
Subject: [PATCH net-next v15 07/22] ovpn: implement basic TX path (UDP)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-ovpn-v15-7-314e2cad0618@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=17178; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=06enNxu3ikR0DRj9VUPIev+QBajml+LPHV1f41hqW40=;
 b=owGbwMvMwMHIXfDUaoHF1XbG02pJDOlRrKpbpj44wCDJpFD1TXvpixJB2xOTTB14TjSEGMn7h
 YuxRl/qZDRmYWDkYJAVU2SZufpOzo8rQk/uxR/4AzOIlQlkCgMXpwBM5Lg4+/+kw/VNqTWsSne/
 R0xZ9W/m8jwbgcmtxy/ku6y1/z9JT0HBwUrCPnPhrSlpk08kr7+WL2pt4GaRu+1ddVjIzDtlqeG
 fmc9+kPqwYkqizOWY1F0Rb22qJa2uzrnhIOTkmsmyuVb1VWg31wr/N5qvuq9qi15d1snVs+DHzx
 oxr3b/85U7pzzurjHM/+xhb6wjHhTz0OxB6TcTgV1veCw8dJZbO8xmnukt6yqU/NTZseqyem38n
 opT0X05SzQ/xVu1chqunLvtXvh1zVcX2vJPz6yrvqL8uH1T1rb4KAcXo643Eomt7pq7Tvb0Saye
 +FYzL15I+Lj5BGkBy3CzGraHorUHt8SsPmF06bZJRdpfAA==
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Packets sent over the ovpn interface are processed and transmitted to the
connected peer, if any.

Implementation is UDP only. TCP will be added by a later patch.

Note: no crypto/encapsulation exists yet. Packets are just captured and
sent.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/Kconfig     |   1 +
 drivers/net/ovpn/io.c   | 129 +++++++++++++++++++++++++-
 drivers/net/ovpn/peer.c |  35 ++++++++
 drivers/net/ovpn/peer.h |   4 +
 drivers/net/ovpn/skb.h  |  55 ++++++++++++
 drivers/net/ovpn/udp.c  | 234 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/udp.h  |   5 ++
 7 files changed, 462 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d6c1810f042e222143f53563a8d8df4bc9df27ed..f4f985fc003373ddc14dc18f8b3f73295a3ae0a6 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -119,6 +119,7 @@ config OVPN
 	tristate "OpenVPN data channel offload"
 	depends on NET && INET
 	select DST_CACHE
+	select NET_UDP_TUNNEL
 	help
 	  This module enhances the performance of the OpenVPN userspace software
 	  by offloading the data channel processing to kernelspace.
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index ad3813419c33cbdfe7e8ad6f5c8b444a3540a69f..2a3dbc723813a14070159318097755cc7ea3f216 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -9,14 +9,141 @@
 
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <net/gso.h>
 
 #include "io.h"
+#include "ovpnstruct.h"
+#include "peer.h"
+#include "udp.h"
+#include "skb.h"
+#include "socket.h"
+
+static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
+{
+	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
+
+	if (unlikely(ret < 0))
+		goto err;
+
+	skb_mark_not_on_list(skb);
+
+	switch (peer->sock->sock->sk->sk_protocol) {
+	case IPPROTO_UDP:
+		ovpn_udp_send_skb(peer, skb);
+		break;
+	default:
+		/* no transport configured yet */
+		goto err;
+	}
+	/* skb passed down the stack - don't free it */
+	skb = NULL;
+err:
+	if (unlikely(skb))
+		dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
+	ovpn_peer_put(peer);
+	kfree_skb(skb);
+}
+
+static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	ovpn_skb_cb(skb)->peer = peer;
+
+	/* take a reference to the peer because the crypto code may run async.
+	 * ovpn_encrypt_post() will release it upon completion
+	 */
+	if (unlikely(!ovpn_peer_hold(peer))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return false;
+	}
+
+	ovpn_encrypt_post(skb, 0);
+	return true;
+}
+
+/* send skb to connected peer, if any */
+static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
+		      struct ovpn_peer *peer)
+{
+	struct sk_buff *curr, *next;
+
+	/* this might be a GSO-segmented skb list: process each skb
+	 * independently
+	 */
+	skb_list_walk_safe(skb, curr, next) {
+		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
+			dev_core_stats_tx_dropped_inc(ovpn->dev);
+			kfree_skb(curr);
+		}
+	}
+
+	ovpn_peer_put(peer);
+}
 
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+	struct sk_buff *segments, *curr, *next;
+	struct sk_buff_head skb_list;
+	struct ovpn_peer *peer;
+	__be16 proto;
+	int ret;
+
+	/* reset netfilter state */
+	nf_reset_ct(skb);
+
+	/* verify IP header size in network packet */
+	proto = ovpn_ip_check_protocol(skb);
+	if (unlikely(!proto || skb->protocol != proto))
+		goto drop;
+
+	if (skb_is_gso(skb)) {
+		segments = skb_gso_segment(skb, 0);
+		if (IS_ERR(segments)) {
+			ret = PTR_ERR(segments);
+			net_err_ratelimited("%s: cannot segment payload packet: %d\n",
+					    netdev_name(dev), ret);
+			goto drop;
+		}
+
+		consume_skb(skb);
+		skb = segments;
+	}
+
+	/* from this moment on, "skb" might be a list */
+
+	__skb_queue_head_init(&skb_list);
+	skb_list_walk_safe(skb, curr, next) {
+		skb_mark_not_on_list(curr);
+
+		curr = skb_share_check(curr, GFP_ATOMIC);
+		if (unlikely(!curr)) {
+			net_err_ratelimited("%s: skb_share_check failed for payload packet\n",
+					    netdev_name(dev));
+			dev_core_stats_tx_dropped_inc(ovpn->dev);
+			continue;
+		}
+
+		__skb_queue_tail(&skb_list, curr);
+	}
+	skb_list.prev->next = NULL;
+
+	/* retrieve peer serving the destination IP of this packet */
+	peer = ovpn_peer_get_by_dst(ovpn, skb);
+	if (unlikely(!peer)) {
+		net_dbg_ratelimited("%s: no peer to send data to\n",
+				    netdev_name(ovpn->dev));
+		goto drop;
+	}
+
+	ovpn_send(ovpn, skb_list.next, peer);
+
+	return NETDEV_TX_OK;
+
+drop:
+	dev_core_stats_tx_dropped_inc(ovpn->dev);
 	skb_tx_error(skb);
-	kfree_skb(skb);
+	kfree_skb_list(skb);
 	return NET_XMIT_DROP;
 }
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 427276dd910f4658dd0bfb272b13631976df622d..d89c82aae2c7646f8c40cdde5bfe364c8b46c659 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -16,6 +16,7 @@
 #include "main.h"
 #include "netlink.h"
 #include "peer.h"
+#include "socket.h"
 
 /**
  * ovpn_peer_new - allocate and initialize a new peer object
@@ -253,6 +254,38 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id)
 	return peer;
 }
 
+/**
+ * ovpn_peer_get_by_dst - Lookup peer to send skb to
+ * @ovpn: the private data representing the current VPN session
+ * @skb: the skb to extract the destination address from
+ *
+ * This function takes a tunnel packet and looks up the peer to send it to
+ * after encapsulation. The skb is expected to be the in-tunnel packet, without
+ * any OpenVPN related header.
+ *
+ * Assume that the IP header is accessible in the skb data.
+ *
+ * Return: the peer if found or NULL otherwise.
+ */
+struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
+				       struct sk_buff *skb)
+{
+	struct ovpn_peer *peer = NULL;
+
+	/* in P2P mode, no matter the destination, packets are always sent to
+	 * the single peer listening on the other side
+	 */
+	if (ovpn->mode == OVPN_MODE_P2P) {
+		rcu_read_lock();
+		peer = rcu_dereference(ovpn->peer);
+		if (unlikely(peer && !ovpn_peer_hold(peer)))
+			peer = NULL;
+		rcu_read_unlock();
+	}
+
+	return peer;
+}
+
 /**
  * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
  * @ovpn: the instance to add the peer to
@@ -318,6 +351,8 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	if (peer->sock)
+		ovpn_socket_put(peer->sock);
 
 	/* reference from ovpn->peer or hashtable dropped */
 	ovpn_peer_put(peer);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index c3458732b2cfcd439644423ec8cd77595f9ed5f3..24de7a69e371a521bed48a8ef3116350ea3e9560 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -19,6 +19,7 @@
  * @vpn_addrs: IP addresses assigned over the tunnel
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
+ * @sock: the socket being used to talk to this peer
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
@@ -34,6 +35,7 @@ struct ovpn_peer {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
 	} vpn_addrs;
+	struct ovpn_socket *sock;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
 	enum ovpn_del_peer_reason delete_reason;
@@ -74,5 +76,7 @@ void ovpn_peer_release_p2p(struct ovpn_priv *ovpn,
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 					       struct sk_buff *skb);
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
+struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
+				       struct sk_buff *skb);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
new file mode 100644
index 0000000000000000000000000000000000000000..af7b1f5b0ee6033ce980978667c3ee99a90e1d1b
--- /dev/null
+++ b/drivers/net/ovpn/skb.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_SKB_H_
+#define _NET_OVPN_SKB_H_
+
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/skbuff.h>
+#include <linux/socket.h>
+#include <linux/types.h>
+
+struct ovpn_cb {
+	struct ovpn_peer *peer;
+};
+
+static inline struct ovpn_cb *ovpn_skb_cb(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct ovpn_cb) > sizeof(skb->cb));
+	return (struct ovpn_cb *)skb->cb;
+}
+
+/* Return IP protocol version from skb header.
+ * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
+ */
+static inline __be16 ovpn_ip_check_protocol(struct sk_buff *skb)
+{
+	__be16 proto = 0;
+
+	/* skb could be non-linear,
+	 * make sure IP header is in non-fragmented part
+	 */
+	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+		return 0;
+
+	if (ip_hdr(skb)->version == 4) {
+		proto = htons(ETH_P_IP);
+	} else if (ip_hdr(skb)->version == 6) {
+		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
+			return 0;
+		proto = htons(ETH_P_IPV6);
+	}
+
+	return proto;
+}
+
+#endif /* _NET_OVPN_SKB_H_ */
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index c00e07f148d72ff737e732028fd73f82a507fb57..c0e7aa289ad3345fcd91e7c890f70961300c356f 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -7,15 +7,249 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/inetdevice.h>
+#include <linux/skbuff.h>
 #include <linux/socket.h>
 #include <linux/udp.h>
+#include <net/addrconf.h>
+#include <net/dst_cache.h>
+#include <net/route.h>
+#include <net/ipv6_stubs.h>
 #include <net/udp.h>
+#include <net/udp_tunnel.h>
 
 #include "ovpnstruct.h"
 #include "main.h"
+#include "bind.h"
+#include "io.h"
+#include "peer.h"
 #include "socket.h"
 #include "udp.h"
 
+/**
+ * ovpn_udp4_output - send IPv4 packet over udp socket
+ * @peer: the destination peer
+ * @bind: the binding related to the destination peer
+ * @cache: dst cache
+ * @sk: the socket to send the packet over
+ * @skb: the packet to send
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
+			    struct dst_cache *cache, struct sock *sk,
+			    struct sk_buff *skb)
+{
+	struct rtable *rt;
+	struct flowi4 fl = {
+		.saddr = bind->local.ipv4.s_addr,
+		.daddr = bind->remote.in4.sin_addr.s_addr,
+		.fl4_sport = inet_sk(sk)->inet_sport,
+		.fl4_dport = bind->remote.in4.sin_port,
+		.flowi4_proto = sk->sk_protocol,
+		.flowi4_mark = sk->sk_mark,
+	};
+	int ret;
+
+	local_bh_disable();
+	rt = dst_cache_get_ip4(cache, &fl.saddr);
+	if (rt)
+		goto transmit;
+
+	if (unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0, fl.saddr,
+					RT_SCOPE_HOST))) {
+		/* we may end up here when the cached address is not usable
+		 * anymore. In this case we reset address/cache and perform a
+		 * new look up
+		 */
+		fl.saddr = 0;
+		spin_lock_bh(&peer->lock);
+		bind->local.ipv4.s_addr = 0;
+		spin_unlock_bh(&peer->lock);
+		dst_cache_reset(cache);
+	}
+
+	rt = ip_route_output_flow(sock_net(sk), &fl, sk);
+	if (IS_ERR(rt) && PTR_ERR(rt) == -EINVAL) {
+		fl.saddr = 0;
+		spin_lock_bh(&peer->lock);
+		bind->local.ipv4.s_addr = 0;
+		spin_unlock_bh(&peer->lock);
+		dst_cache_reset(cache);
+
+		rt = ip_route_output_flow(sock_net(sk), &fl, sk);
+	}
+
+	if (IS_ERR(rt)) {
+		ret = PTR_ERR(rt);
+		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
+				    netdev_name(peer->ovpn->dev),
+				    &bind->remote.in4,
+				    ret);
+		goto err;
+	}
+	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+
+transmit:
+	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
+			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
+			    fl.fl4_dport, false, sk->sk_no_check_tx);
+	ret = 0;
+err:
+	local_bh_enable();
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+/**
+ * ovpn_udp6_output - send IPv6 packet over udp socket
+ * @peer: the destination peer
+ * @bind: the binding related to the destination peer
+ * @cache: dst cache
+ * @sk: the socket to send the packet over
+ * @skb: the packet to send
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
+			    struct dst_cache *cache, struct sock *sk,
+			    struct sk_buff *skb)
+{
+	struct dst_entry *dst;
+	int ret;
+
+	struct flowi6 fl = {
+		.saddr = bind->local.ipv6,
+		.daddr = bind->remote.in6.sin6_addr,
+		.fl6_sport = inet_sk(sk)->inet_sport,
+		.fl6_dport = bind->remote.in6.sin6_port,
+		.flowi6_proto = sk->sk_protocol,
+		.flowi6_mark = sk->sk_mark,
+		.flowi6_oif = bind->remote.in6.sin6_scope_id,
+	};
+
+	local_bh_disable();
+	dst = dst_cache_get_ip6(cache, &fl.saddr);
+	if (dst)
+		goto transmit;
+
+	if (unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
+		/* we may end up here when the cached address is not usable
+		 * anymore. In this case we reset address/cache and perform a
+		 * new look up
+		 */
+		fl.saddr = in6addr_any;
+		spin_lock_bh(&peer->lock);
+		bind->local.ipv6 = in6addr_any;
+		spin_unlock_bh(&peer->lock);
+		dst_cache_reset(cache);
+	}
+
+	dst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
+	if (IS_ERR(dst)) {
+		ret = PTR_ERR(dst);
+		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
+				    netdev_name(peer->ovpn->dev),
+				    &bind->remote.in6, ret);
+		goto err;
+	}
+	dst_cache_set_ip6(cache, dst, &fl.saddr);
+
+transmit:
+	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
+			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
+			     fl.fl6_dport, udp_get_no_check6_tx(sk));
+	ret = 0;
+err:
+	local_bh_enable();
+	return ret;
+}
+#endif
+
+/**
+ * ovpn_udp_output - transmit skb using udp-tunnel
+ * @peer: the destination peer
+ * @cache: dst cache
+ * @sk: the socket to send the packet over
+ * @skb: the packet to send
+ *
+ * rcu_read_lock should be held on entry.
+ * On return, the skb is consumed.
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
+			   struct sock *sk, struct sk_buff *skb)
+{
+	struct ovpn_bind *bind;
+	int ret;
+
+	/* set sk to null if skb is already orphaned */
+	if (!skb->destructor)
+		skb->sk = NULL;
+
+	/* always permit openvpn-created packets to be (outside) fragmented */
+	skb->ignore_df = 1;
+
+	rcu_read_lock();
+	bind = rcu_dereference(peer->bind);
+	if (unlikely(!bind)) {
+		net_warn_ratelimited("%s: no bind for remote peer %u\n",
+				     netdev_name(peer->ovpn->dev), peer->id);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	switch (bind->remote.in4.sin_family) {
+	case AF_INET:
+		ret = ovpn_udp4_output(peer, bind, cache, sk, skb);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		ret = ovpn_udp6_output(peer, bind, cache, sk, skb);
+		break;
+#endif
+	default:
+		ret = -EAFNOSUPPORT;
+		break;
+	}
+
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+/**
+ * ovpn_udp_send_skb - prepare skb and send it over via UDP
+ * @peer: the destination peer
+ * @skb: the packet to send
+ */
+void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	struct socket *sock;
+	int ret = -1;
+
+	skb->dev = peer->ovpn->dev;
+	/* no checksum performed at this layer */
+	skb->ip_summed = CHECKSUM_NONE;
+
+	/* get socket info */
+	sock = peer->sock->sock;
+	if (unlikely(!sock)) {
+		net_warn_ratelimited("%s: no sock for remote peer %u\n",
+				     netdev_name(peer->ovpn->dev), peer->id);
+		goto out;
+	}
+
+	/* crypto layer -> transport (UDP) */
+	ret = ovpn_udp_output(peer, &peer->dst_cache, sock->sk, skb);
+out:
+	if (unlikely(ret < 0)) {
+		kfree_skb(skb);
+		return;
+	}
+}
+
 /**
  * ovpn_udp_socket_attach - set udp-tunnel CBs on socket and link it to ovpn
  * @sock: socket to configure
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index 3c48a06f15eed624aec0a2a7b871f0e7f3004137..44ebeb82325dc4d172da7e29fb36f21a5609ea8d 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -9,9 +9,14 @@
 #ifndef _NET_OVPN_UDP_H_
 #define _NET_OVPN_UDP_H_
 
+#include <net/sock.h>
+
+struct ovpn_peer;
 struct ovpn_priv;
 struct socket;
 
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn);
 
+void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb);
+
 #endif /* _NET_OVPN_UDP_H_ */

-- 
2.45.2


