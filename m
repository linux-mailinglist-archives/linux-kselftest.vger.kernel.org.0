Return-Path: <linux-kselftest+bounces-22978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCE39E8DF1
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0C32819BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3C4217655;
	Mon,  9 Dec 2024 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NFXsIWad"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161221639D
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734392; cv=none; b=pHAkoaGg9nVWRQstvFLXHEVBZYrFUi/9qhx30ROG9Sbs+insRcsM1ei0UphxONcVgTeVkFXasRoSoIaK21KnbGLriKxIo5b/clWDGI/ybEp1WwNZUq/t60kyb/H1OdAYjk02couLXN2Vz2n+ty6tLmPrM5i3V6tZNxWGpJgHZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734392; c=relaxed/simple;
	bh=06enNxu3ikR0DRj9VUPIev+QBajml+LPHV1f41hqW40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0zYIXrh/AeWVWUtLdVDIXWTdGWdlOSompspVjhFCoTQGM0lVzmFP0d5GynkP5193h8JN7Z0A2fyFWmNR8Pnrnck1xHZqsX0qs3bn0UbhluAgO+/6ZM0P+qBPEilXP4m7uiVFuAMpNwARPuPrpQaAVwEGKOybFVURpcoo54qP2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NFXsIWad; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434fe0a8cceso1594695e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 00:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734387; x=1734339187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m59lRlZIpZyUqdMdB2+INdiIL1VpBMdOlZss9cr6rME=;
        b=NFXsIWadxTAWVhCAuFQSU0aU48RJ9IM8OA/sc/rOFSKkO3d51pWGqPdCEzZxN/kDUj
         Vim3qw1XP9IbMc2BpO1oGkc7zCv+ESwBtwbb+T66/nCp3qJv089F3e61Rr2cWQ+w8Jl0
         C/DH5DBBFqLkiG4iEIsyhJ52c6+3TB9/2pEKxrP5OQYGj02pIcMkPQQP8lv2e7znf5ec
         LZ9L1SrKiSlsGorhZGndSWmvvhrCr/9TUfjR+VP76fOCqpYJMvSR6h1DtqA4JdHKGYRM
         BfIBe5BQBl70tPHkL1kgVUydnb30Pq7lSwMMqWp5lYQcg3vqluO61hHnpUYIS9bf5CkK
         qUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734387; x=1734339187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m59lRlZIpZyUqdMdB2+INdiIL1VpBMdOlZss9cr6rME=;
        b=Zp/2Nf2goA4Pudt7iRFSywaZILTmxNA9l8+MvFyJPcW0nJSdPXDPjC/f1jE1RePNIF
         kKqTr0+gMD+upJgvw7aPs2aqy1xDE2jVXRpSDz94eDL3mSKMNK/tyeFQqXEhUHLL80Qn
         HBaCZ/XzYIJUyBuRu41ao6ZDg3AnyZv8D69v9xJkQZwOeQMmEeREH0XhIXlLQo/Au9bs
         XrzYVFg8utTsUFFxg5V7OUG9AFtDcq7bxvZaeiULFvWqMJGrxJsQwC3+oiyjmWxnZvVL
         j+oqb7qG9GK1+5ys0ZcWylc2AlPu0NTdqJyTtSPuVJFDQ1eGIF0LIp9s1NAKYGnRIo8/
         kBQg==
X-Forwarded-Encrypted: i=1; AJvYcCW988jhRDvxZotvn+sTy/82+O1XfqAauT1IlhtK9B3JTxpqDF5YjgCXj4SmDlFrdCPdxLQgMK2M5RZSDZlO/eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmnAX8qDi0/JMiCyJqBjGHNBBFnp37RBJyvu4yeXqxvqeamLj
	9ey7zfxyi+PwRC1Hs13c05fYnx+nUcyivHn/mwUJ+4Vv9DUIb6wDMWI5HJ7K5LnMaCxDR/gecSx
	j
X-Gm-Gg: ASbGncttAvhSB8RiBxCYhFtNOWvMX6nO5vCyMDCyBPCKmfrFlLD7nicaUkP8AC0kgUp
	w59m9P84ZPu5qoRgDBFnL673kBnaaixg14+o3WNiuDl1l6LS/hFiWbQF5G4OWvWZ20pVurXTXnz
	DjCGin9Vib3yWy0LbBocOPy72ir2KHqPNpmNBrMoh3K6NTiF05EiS5pBkZpYUVnwDxirKwyJOey
	qpqTnzuoxVHqdUTuX42JcLESGfBexCxF/1Hf7flD8TfPUSgwDqllv8/FT5K
X-Google-Smtp-Source: AGHT+IHKX/VQVyCjZ2Z2fbfjInyTCzbZFPD+53zNcO93Evysyntgyu+xlgPM8zuNLGyNXQKFJjrDAw==
X-Received: by 2002:a05:600c:a0b:b0:434:a75b:5f59 with SMTP id 5b1f17b1804b1-434ddea3247mr106514865e9.3.1733734387318;
        Mon, 09 Dec 2024 00:53:07 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:53:06 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:16 +0100
Subject: [PATCH net-next v14 07/22] ovpn: implement basic TX path (UDP)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-7-ea243cf16417@openvpn.net>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17178; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=06enNxu3ikR0DRj9VUPIev+QBajml+LPHV1f41hqW40=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrASKtlSs1PbqHGVXlC03G4i1dKhE80Ayiqfq
 nrE9fId//eJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awEgAKCRALcOU6oDjV
 hyozB/9XDYj8TkSa/ylVpVicwffefENpcdA1Vp66tJvWnWrUNEQbOktcFBjXB1TOmjYCwFWkJwn
 ak8Gcn7NeQYmj4/stqjTbLEIZs66JiLyGQKst/w/6mUIk82P67vlpJKrOCq7VjDzB5IWzy5Qtsv
 l3hhFkwaiW1hVuIjdsK0mQiF8sTlsmDOaVo0EExVHFeFVxCvPc9LMX7GnaSmunIhsr7vyc3lRFS
 ODGUpc/5y2PZOutzEbsy9d24nKjYgyPR3nMFSeFvy22fq4KQ49ek46v0Pleo0KCIR4EQywIV3bA
 ETZgAroNqjsMDUEVMWOEHELY9C3bER1iz0lHalKqaOPH14xq
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


