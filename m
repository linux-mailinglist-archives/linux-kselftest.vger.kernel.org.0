Return-Path: <linux-kselftest+bounces-30846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6672FA89BF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11163BC228
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32542973B1;
	Tue, 15 Apr 2025 11:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dRfQVBA+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D48C296D14
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715861; cv=none; b=GPN3zFYRtTOIwiBr7pWFzgoYyRPoJbH0aGwNgp12/VRpwFF+MMxNVG6J9wJ/lG9R6cyVZym/OqbZxLRjgpwYAQ83lZ0cNXQOL0TvLDHBakB517aYyTAksKLuAke/3PuDRVqRI8RKEFYFzvYhFn8WsTw7JBcEQtro/Ad26v0epYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715861; c=relaxed/simple;
	bh=jlCLaGVNxLm1Jsk4tkiNegdEQkq21daqEz9fo+9VcI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jhadJw2dendPkIMIuspBgqhSupAbb4DZyKpQKtlUIxWj2solB7g3SvKXNZajepvhW8aKNbLNEiCF3ZfK5ygOEgFEuDI1aLAJQXlfZx5FqhfhRRFW1+uwW2TpYr7ZLnM+YlyG3X80F75uRH7f34twVA+QEEi0Egrn/bt4snLNC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dRfQVBA+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso52000315e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715857; x=1745320657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcZ4k/k95znNdp6YriGx1xBYvWaYpJ8GxQw+hTFVv8Q=;
        b=dRfQVBA+fHcufZBZZ9VAXMgwHouj4C4gyi1W2/ZZORZjnEzooUSvAa0Ctvs/i2HRwE
         gbHvAPvP3UMrMhzz4vwwtcztlS9T3FGVPDl8deL0vMnCkAX7qUaHYBSegVunfBjiFaU0
         DSl1VUKOntApRwwYSYARWNwlWqxkPzOdWM1ljg7W2/53ewedUpSkB1GH18i5BafLdz44
         wHzKugYHIqdTUYjkX264tKbwWzveTnA0bF8LtfDe/Hb/t4BbNGXSFQP3e4zzAIIda5Nv
         +Suh2mydHGoLaf84lEEMo2xF2GS/T31ormfZXLe340xxla6hiLJp6dyBoZE6oNIM8LW8
         1GPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715857; x=1745320657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcZ4k/k95znNdp6YriGx1xBYvWaYpJ8GxQw+hTFVv8Q=;
        b=d4z2DDdRv7tVGRhGI2oDa40ICpKyIh/9+sfValhIDjBGO7TUaPVEDJ7v7MuHNkvaOm
         09A6kt4HPdqUKxH1wYs5aMvUxs2KtCIQSy9ztDFfTwBfpSM2yZGncSrZCjmGjI8P+1Ud
         TCAN181Z5BVn8SD1bnlwWTgjQjp/b9oaJZ5TxmcPDFFC20DR/3hjNm6RyMexs4n6+iVA
         X6mTh93xComEF/l1dwT6DNPvylysjcKFsgosiSUS2j8YLbgoN5ByhSRVUwMBFIW7Wtyv
         PIMLmWJTI7a8YN2ZBdLw+6yQ8tHmX3GpB9lAI1U/wwEoeqfSWWeEy/Rmp+4W5AG8slNm
         s7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9l2UkzPmeeSObkddKoXs+CIMQaaQYFk0MkoiFtchyZ/Dkh2yDQyEyEHhi8E5s9q55/eY60xM6jhyaVgVP9V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE0C+AsM53+v4tDbb7UgTfc+53eaPaZ+eWLffk6t9kZGYNpygJ
	xNh0aUpVORoVSDGA7TjU8RB+sIsiABL9DD1Tx1qKvJ45BkKY41nQeoVEiSt3unCqRobVKSyUCVG
	hI3fWyZFevU62Y4jp745RPAhV+dt6Hovu/fEGYJ20LqO/JIkpkBmZd8ddVUI=
X-Gm-Gg: ASbGnctc5oPwoPzISI8RVLuL8QaJGQSz8hwOv4+4IbbThE38/no+uhx6LYChtuXUgsG
	EFU7zXya1hFptWrQkiw4wiX7BW7TQTsEDw5aYbve9Lm84NWIL+8sYDUQ1odsOmoE4DNuCr9f696
	5Bnb3pYnQAHHklhJCn7laTfk1T3wmwcdWVi5cRTDMtlY3rXpDKJ3zfvql95GikuI/LhhrhGEbZW
	c7cHUoU1jmhCG/BPo8Im9j8xDo0g69T7pXq1NED6So7O+FJzcfkyoYzfnSEcPtUEbLfIiLv8HNz
	Z5FqB5+OL/GDR0CC8sGniFBZY4CobpRr4dZmOg==
X-Google-Smtp-Source: AGHT+IH7Jcw4JCqhPlH3V3HgIBweSBREGujZ9Lk37c2/ZCR87skvltP2Lq6qU5G5KMlbFkbDm9t/MA==
X-Received: by 2002:a05:600c:458b:b0:43c:fc0c:7f33 with SMTP id 5b1f17b1804b1-43f3a925f6amr143384645e9.2.1744715853430;
        Tue, 15 Apr 2025 04:17:33 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:32 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:24 +0200
Subject: [PATCH net-next v26 07/23] ovpn: implement basic TX path (UDP)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-7-577f6097b964@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16589; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=jlCLaGVNxLm1Jsk4tkiNegdEQkq21daqEz9fo+9VcI4=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn/kBBiasEA7+354YE5uX8/UktWsLwl6Dp8oVeo
 VQa6de9NJmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/5AQQAKCRALcOU6oDjV
 h1gyB/0TpTJRD9FzFK7ngLfY7bfQ2TTz75xoy1PR+zjJWt2tqKjXv6foDzH/yRutjcbWOQ6qBvc
 rYFtyDw6o4942IhP+7IMwzd+RVhCDhN2GN2hjTJWPMZ9YFKz5L1X6D5gH1c9ey6CVDmwAFPtrVQ
 +lKt8xkE5bsiG3lH/UNkBIdqhbIV0fwY0n0vzb3YrEW/fcCQEh/5r4XuPxnjNOJw/HNgtTLT4Ic
 Aw84YaFuzaFSBvmRfyeS+hXMsP3cv08diKK9vfgYjAVo2FwAisNKpWlBv9JQqyQe+UOv24bCjW+
 YSJz9a4BjmnI56PP0JDsYoO3G3ulyrG0aVzfcbCTcgxfRSqv
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
 drivers/net/ovpn/io.c   | 137 +++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.c |  32 +++++++
 drivers/net/ovpn/peer.h |   2 +
 drivers/net/ovpn/skb.h  |  55 ++++++++++++
 drivers/net/ovpn/udp.c  | 233 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/udp.h  |   6 ++
 7 files changed, 464 insertions(+), 2 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 2806fcc22a2dbd9b2985b09dd6ef65dd1dc4ebc1..305f04dd97234c4aa43da78217448b914cc7ede0 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -120,6 +120,7 @@ config OVPN
 	depends on NET && INET
 	depends on IPV6 || !IPV6
 	select DST_CACHE
+	select NET_UDP_TUNNEL
 	help
 	  This module enhances the performance of the OpenVPN userspace software
 	  by offloading the data channel processing to kernelspace.
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 4b71c38165d7adbb1a2d1a64d27a13b7f76cfbfe..93b128827b6d683a57297391816bff3391ef5bec 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -9,14 +9,149 @@
 
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <net/gso.h>
 
 #include "io.h"
+#include "ovpnpriv.h"
+#include "peer.h"
+#include "udp.h"
+#include "skb.h"
+#include "socket.h"
+
+static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
+{
+	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
+	struct ovpn_socket *sock;
+
+	if (unlikely(ret < 0))
+		goto err;
+
+	skb_mark_not_on_list(skb);
+
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	if (unlikely(!sock))
+		goto err_unlock;
+
+	switch (sock->sock->sk->sk_protocol) {
+	case IPPROTO_UDP:
+		ovpn_udp_send_skb(peer, sock->sock, skb);
+		break;
+	default:
+		/* no transport configured yet */
+		goto err_unlock;
+	}
+	/* skb passed down the stack - don't free it */
+	skb = NULL;
+err_unlock:
+	rcu_read_unlock();
+err:
+	if (unlikely(skb))
+		dev_dstats_tx_dropped(peer->ovpn->dev);
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
+			dev_dstats_tx_dropped(ovpn->dev);
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
+			dev_dstats_tx_dropped(ovpn->dev);
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
+	dev_dstats_tx_dropped(ovpn->dev);
 	skb_tx_error(skb);
-	kfree_skb(skb);
+	kfree_skb_list(skb);
 	return NET_XMIT_DROP;
 }
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 0bb6c15171848acbc055829a3d2aefd26c5b810a..10eabd62ae7237162a36a333b41c748901a7d888 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -294,6 +294,38 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	llist_add(&peer->release_entry, release_list);
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
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 29c9065cedccb156ec6ca6d9b692372e8fc89a2d..fef04311c1593db4ccfa3c417487b3d4faaae9d7 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -80,5 +80,7 @@ void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 					       struct sk_buff *skb);
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
+struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
+				       struct sk_buff *skb);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
new file mode 100644
index 0000000000000000000000000000000000000000..9db7a9adebdb4cc493f162f89fb2e9c6301fa213
--- /dev/null
+++ b/drivers/net/ovpn/skb.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
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
index 91970e66a4340370a96c1fc42321f94574302143..28307ef7b2672cf1ad1240c1d17ffdcb9e64b5a5 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -7,15 +7,246 @@
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
 
 #include "ovpnpriv.h"
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
+ * @sock: the RCU protected peer socket
+ * @skb: the packet to send
+ */
+void ovpn_udp_send_skb(struct ovpn_peer *peer, struct socket *sock,
+		       struct sk_buff *skb)
+{
+	int ret = -1;
+
+	skb->dev = peer->ovpn->dev;
+	/* no checksum performed at this layer */
+	skb->ip_summed = CHECKSUM_NONE;
+
+	/* get socket info */
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
  * @ovpn_sock: socket to configure
@@ -31,7 +262,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
 {
 	struct socket *sock = ovpn_sock->sock;
 	struct ovpn_socket *old_data;
-	int ret = 0;
+	int ret;
 
 	/* make sure no pre-existing encapsulation handler exists */
 	rcu_read_lock();
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index 1c8fb6fe402dc1cfdc10fddc9cf5b74d7d6887ce..9994eb6e04283247d8ffc729966345810f84b22b 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -9,6 +9,9 @@
 #ifndef _NET_OVPN_UDP_H_
 #define _NET_OVPN_UDP_H_
 
+#include <net/sock.h>
+
+struct ovpn_peer;
 struct ovpn_priv;
 struct socket;
 
@@ -16,4 +19,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
 			   struct ovpn_priv *ovpn);
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock);
 
+void ovpn_udp_send_skb(struct ovpn_peer *peer, struct socket *sock,
+		       struct sk_buff *skb);
+
 #endif /* _NET_OVPN_UDP_H_ */

-- 
2.49.0


