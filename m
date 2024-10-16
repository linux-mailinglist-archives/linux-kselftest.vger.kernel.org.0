Return-Path: <linux-kselftest+bounces-19798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEA099FDDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 03:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17381C24D43
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 01:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E97218BC0E;
	Wed, 16 Oct 2024 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="N+3nUttc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744518B481
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040641; cv=none; b=V9RdKzcS55Yxx9IO778vWr6a/+jENCCsvtnn1l1Mr8Vdpr5ZRrkqhPVnJDav6pJZwM2sq3dWYXpH2IZC1PomJVHWnkSEK2llONUkItzZ/kETYEzvmXjnBUIgwsBgfJ2+f9RBZ279cg20kexl6k5uiBO1ehtz3oJ6ky3V0midkgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040641; c=relaxed/simple;
	bh=YMuwyTMzclpNnNaR/WkRJmXnCptZu+Rq2A1hloxGEmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQR9IB74FwvcMpNizFSOw72um6S3xIq6ocLm5E2Nk4IQIgG+g/fjJlNgBqqvOOIlSm9/LPJubc4TR2YWv3enmdIWXikVHZhjgMp395vjOcsVsIalbSOF1kMObeCPicptk0nqrjm+7/WKJ7zodriA2ivWCHj10f2VVluZd6EDf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=N+3nUttc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d8901cb98so195760f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 18:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729040637; x=1729645437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEkhq4g07rH6eS4QvsCkWBw8nlVl5m3JneNiJjlmb24=;
        b=N+3nUttc3MDhAbRXHLAPBmrlcQ3gpDFoVrgVIpclNjKVqJ3CTQ6/q4MmB+q4m2udrv
         ePNlCCu5z478ntqCIGTOhkB7wl1OU1FPyTm6OIqolHF8CE9xd6ztXViZb/7q+p6zzD2Q
         fZBeu9y9SgTt2B0ugNq25oFQ1ainbWrQLgxwvZoMRpa2GLWSPZW3tu6xAXNYI7myzFTK
         BGzHlYn28tEV/JDr5NsAj+MflO7rwrUPoTl1sB95LVXtaoKt8SWHDkQz6IJFBfXyh0R4
         5csK/D1hPgksjYXflgVvYeXFYSr7wbK20VkrXyKp/DnWiWLgCDTMldQyG1BVIMD3Yi9x
         FxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040637; x=1729645437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEkhq4g07rH6eS4QvsCkWBw8nlVl5m3JneNiJjlmb24=;
        b=bZNb4Df3XnlEgQxRCImw2Eat/yhqM7E5ZFGDF7krIBOIUVIw+Z1i6412szMswRm1Vn
         Ye0Yhb8+RKWRdDHwPm4NN1MXcZoEQ6M9wLhSHcjOukt3KDlMaULKWlGvxyzTZbAZMDI4
         U/EWplBqglU+BGqt4fem4a1WNapnJPveZwx4SvCkgB+bjjB5GUig5nFA7DpeZhmMGLgT
         Mh3AeUoN5Q7WjAPSv6d8JKzqLZ48IXBpPVMRpZCIVDV52N8HLsFJqm7M6Fpn7P/fW2W/
         u/O72aMcqLm6uriMyqQ7KKO8yQ1eQIgFIMwAaIDkeU0yA7Dl6zf9o6eBCNyKLhlK5E0z
         35Mw==
X-Forwarded-Encrypted: i=1; AJvYcCV6+u86fGTD6R+CJvhMMJDsj2Qh/Hi5l/0ncH/CuRTGEHEBTo7bXG/kkzW9ypqduN4xzaDZYnYiEw+D96y1SkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTn5JScVvc8xfHRULro0SOJSZ4iNCWsQkQqBnytd9a0+CTHy6N
	yzaPiNVScP+EQecOwW9eqod7wYODtsuAsRvm2jrbbWPppQB3JF4nDJuj7JX8GMA=
X-Google-Smtp-Source: AGHT+IHxxd3uRD1CMOwjI1wFdLJBPOmy367kPhdMjELOXvHRZmhhQy5Z39M+WfVTnmxeHVWFtY0MQQ==
X-Received: by 2002:a5d:4ec8:0:b0:37d:325e:dd59 with SMTP id ffacd0b85a97d-37d5529d987mr11814279f8f.26.1729040636794;
        Tue, 15 Oct 2024 18:03:56 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:4c1a:a7c8:72f5:4282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm2886765f8f.25.2024.10.15.18.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 18:03:56 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 16 Oct 2024 03:03:08 +0200
Subject: [PATCH net-next v9 08/23] ovpn: implement basic TX path (UDP)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-b4-ovpn-v9-8-aabe9d225ad5@openvpn.net>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
In-Reply-To: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16921; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=YMuwyTMzclpNnNaR/WkRJmXnCptZu+Rq2A1hloxGEmY=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnDxDve/y0jL3koGQbg4pJ5HRav7bl0/9DdhDuO
 xKEt9UUfiaJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZw8Q7wAKCRALcOU6oDjV
 h/xECACsMxHihAVKWE2/92IKrn9axr7+vvONH/mJ3OgPzmskAhUYhq3u934EOTDo3ngj1PL+QrS
 FmWQCJJxQCMxz39NuV5OUcCbB3z3FbnWEeDck5991fcZuspyboOkqdCyT2XYH8gzi+AReh3pRnt
 P4BhynVSmyukCQQEOYgtgQ21k/8zzqYITWFQmmJCdrh0+0r/MN+RvaJ9Q3l6YdwnhwvD3FqngGB
 74KZsvMSjvx1+7kSFwDpkeT8+SW+36nLGLm0E8ND/8XAiIyDIaSuJ5kbKN045cZVZG09B17gG+d
 QWpgkp+2Ww7ZmHQ2xSwcKrDj3oY+42N9CLjE+8BNTCqfCtYA
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Packets sent over the ovpn interface are processed and transmitted to the
connected peer, if any.

Implementation is UDP only. TCP will be added by a later patch.

Note: no crypto/encapsulation exists yet. packets are just captured and
sent.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   | 138 +++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.c |  37 +++++++-
 drivers/net/ovpn/peer.h |   4 +
 drivers/net/ovpn/skb.h  |  51 +++++++++++
 drivers/net/ovpn/udp.c  | 232 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/udp.h  |   8 ++
 6 files changed, 468 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index ad3813419c33cbdfe7e8ad6f5c8b444a3540a69f..77ba4d33ae0bd2f52e8bd1c06a182d24285297b4 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -9,14 +9,150 @@
 
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
+		ovpn_udp_send_skb(peer->ovpn, peer, skb);
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
+static void ovpn_send(struct ovpn_struct *ovpn, struct sk_buff *skb,
+		      struct ovpn_peer *peer)
+{
+	struct sk_buff *curr, *next;
+
+	if (likely(!peer))
+		/* retrieve peer serving the destination IP of this packet */
+		peer = ovpn_peer_get_by_dst(ovpn, skb);
+	if (unlikely(!peer)) {
+		net_dbg_ratelimited("%s: no peer to send data to\n",
+				    ovpn->dev->name);
+		dev_core_stats_tx_dropped_inc(ovpn->dev);
+		goto drop;
+	}
+
+	/* this might be a GSO-segmented skb list: process each skb
+	 * independently
+	 */
+	skb_list_walk_safe(skb, curr, next)
+		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
+			dev_core_stats_tx_dropped_inc(ovpn->dev);
+			kfree_skb(curr);
+		}
+
+	/* skb passed over, no need to free */
+	skb = NULL;
+drop:
+	if (likely(peer))
+		ovpn_peer_put(peer);
+	kfree_skb_list(skb);
+}
 
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct ovpn_struct *ovpn = netdev_priv(dev);
+	struct sk_buff *segments, *curr, *next;
+	struct sk_buff_head skb_list;
+	__be16 proto;
+	int ret;
+
+	/* reset netfilter state */
+	nf_reset_ct(skb);
+
+	/* verify IP header size in network packet */
+	proto = ovpn_ip_check_protocol(skb);
+	if (unlikely(!proto || skb->protocol != proto)) {
+		net_err_ratelimited("%s: dropping malformed payload packet\n",
+				    dev->name);
+		dev_core_stats_tx_dropped_inc(ovpn->dev);
+		goto drop;
+	}
+
+	if (skb_is_gso(skb)) {
+		segments = skb_gso_segment(skb, 0);
+		if (IS_ERR(segments)) {
+			ret = PTR_ERR(segments);
+			net_err_ratelimited("%s: cannot segment packet: %d\n",
+					    dev->name, ret);
+			dev_core_stats_tx_dropped_inc(ovpn->dev);
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
+			net_err_ratelimited("%s: skb_share_check failed\n",
+					    dev->name);
+			dev_core_stats_tx_dropped_inc(ovpn->dev);
+			continue;
+		}
+
+		__skb_queue_tail(&skb_list, curr);
+	}
+	skb_list.prev->next = NULL;
+
+	ovpn_send(ovpn, skb_list.next, NULL);
+
+	return NETDEV_TX_OK;
+
+drop:
 	skb_tx_error(skb);
-	kfree_skb(skb);
+	kfree_skb_list(skb);
 	return NET_XMIT_DROP;
 }
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index d9788a0cc99b5839c466c35d1b2266cc6b95fb72..aff3e9e99b7d2dd2fa68484d9a396d43f75a6d0b 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -16,6 +16,7 @@
 #include "main.h"
 #include "netlink.h"
 #include "peer.h"
+#include "socket.h"
 
 /**
  * ovpn_peer_new - allocate and initialize a new peer object
@@ -64,8 +65,10 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
  */
 static void ovpn_peer_release(struct ovpn_peer *peer)
 {
-	ovpn_bind_reset(peer, NULL);
+	if (peer->sock)
+		ovpn_socket_put(peer->sock);
 
+	ovpn_bind_reset(peer, NULL);
 	dst_cache_destroy(&peer->dst_cache);
 	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
 	kfree_rcu(peer, rcu);
@@ -243,6 +246,38 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
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
+struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
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
index 6e0c6b14559de886d0677117f5a7ae029214e1f8..51955aa39f1aa85ce541e289c60e9635cadb9c48 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -19,6 +19,7 @@
  * @vpn_addrs: IP addresses assigned over the tunnel
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
+ * @sock: the socket being used to talk to this peer
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
  * @halt: true if ovpn_peer_mark_delete was called
@@ -35,6 +36,7 @@ struct ovpn_peer {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
 	} vpn_addrs;
+	struct ovpn_socket *sock;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
 	bool halt;
@@ -75,5 +77,7 @@ void ovpn_peer_release_p2p(struct ovpn_struct *ovpn);
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
 					       struct sk_buff *skb);
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id);
+struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
+				       struct sk_buff *skb);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
new file mode 100644
index 0000000000000000000000000000000000000000..e070fe6f448c0b7a9631394ebef4554f6348ef44
--- /dev/null
+++ b/drivers/net/ovpn/skb.h
@@ -0,0 +1,51 @@
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
+	if (ip_hdr(skb)->version == 4)
+		proto = htons(ETH_P_IP);
+	else if (ip_hdr(skb)->version == 6)
+		proto = htons(ETH_P_IPV6);
+
+	return proto;
+}
+
+#endif /* _NET_OVPN_SKB_H_ */
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index c10474d252e19a0626d17a6f5dd328a5e5811551..d26d7566e9c8dfe91fa77f49c34fb179a9fb2239 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -7,14 +7,246 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/inetdevice.h>
 #include <linux/socket.h>
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
+ * @ovpn: the openvpn instance
+ * @bind: the binding related to the destination peer
+ * @cache: dst cache
+ * @sk: the socket to send the packet over
+ * @skb: the packet to send
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_udp4_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
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
+		bind->local.ipv4.s_addr = 0;
+		dst_cache_reset(cache);
+	}
+
+	rt = ip_route_output_flow(sock_net(sk), &fl, sk);
+	if (IS_ERR(rt) && PTR_ERR(rt) == -EINVAL) {
+		fl.saddr = 0;
+		bind->local.ipv4.s_addr = 0;
+		dst_cache_reset(cache);
+
+		rt = ip_route_output_flow(sock_net(sk), &fl, sk);
+	}
+
+	if (IS_ERR(rt)) {
+		ret = PTR_ERR(rt);
+		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
+				    ovpn->dev->name, &bind->remote.in4, ret);
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
+ * @ovpn: the openvpn instance
+ * @bind: the binding related to the destination peer
+ * @cache: dst cache
+ * @sk: the socket to send the packet over
+ * @skb: the packet to send
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_udp6_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
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
+		bind->local.ipv6 = in6addr_any;
+		dst_cache_reset(cache);
+	}
+
+	dst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
+	if (IS_ERR(dst)) {
+		ret = PTR_ERR(dst);
+		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
+				    ovpn->dev->name, &bind->remote.in6, ret);
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
+ * @ovpn: the openvpn instance
+ * @bind: the binding related to the destination peer
+ * @cache: dst cache
+ * @sk: the socket to send the packet over
+ * @skb: the packet to send
+ *
+ * rcu_read_lock should be held on entry.
+ * On return, the skb is consumed.
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_udp_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
+			   struct dst_cache *cache, struct sock *sk,
+			   struct sk_buff *skb)
+{
+	int ret;
+
+	/* set sk to null if skb is already orphaned */
+	if (!skb->destructor)
+		skb->sk = NULL;
+
+	/* always permit openvpn-created packets to be (outside) fragmented */
+	skb->ignore_df = 1;
+
+	switch (bind->remote.in4.sin_family) {
+	case AF_INET:
+		ret = ovpn_udp4_output(ovpn, bind, cache, sk, skb);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		ret = ovpn_udp6_output(ovpn, bind, cache, sk, skb);
+		break;
+#endif
+	default:
+		ret = -EAFNOSUPPORT;
+		break;
+	}
+
+	return ret;
+}
+
+/**
+ * ovpn_udp_send_skb - prepare skb and send it over via UDP
+ * @ovpn: the openvpn instance
+ * @peer: the destination peer
+ * @skb: the packet to send
+ */
+void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
+		       struct sk_buff *skb)
+{
+	struct ovpn_bind *bind;
+	unsigned int pkt_len;
+	struct socket *sock;
+	int ret = -1;
+
+	skb->dev = ovpn->dev;
+	/* no checksum performed at this layer */
+	skb->ip_summed = CHECKSUM_NONE;
+
+	/* get socket info */
+	sock = peer->sock->sock;
+	if (unlikely(!sock)) {
+		net_warn_ratelimited("%s: no sock for remote peer\n", __func__);
+		goto out;
+	}
+
+	rcu_read_lock();
+	/* get binding */
+	bind = rcu_dereference(peer->bind);
+	if (unlikely(!bind)) {
+		net_warn_ratelimited("%s: no bind for remote peer\n", __func__);
+		goto out_unlock;
+	}
+
+	/* crypto layer -> transport (UDP) */
+	pkt_len = skb->len;
+	ret = ovpn_udp_output(ovpn, bind, &peer->dst_cache, sock->sk, skb);
+
+out_unlock:
+	rcu_read_unlock();
+out:
+	if (unlikely(ret < 0)) {
+		dev_core_stats_tx_dropped_inc(ovpn->dev);
+		kfree_skb(skb);
+		return;
+	}
+
+	dev_sw_netstats_tx_add(ovpn->dev, 1, pkt_len);
+}
+
 /**
  * ovpn_udp_socket_attach - set udp-tunnel CBs on socket and link it to ovpn
  * @sock: socket to configure
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index f2507f8f2c71ea9d5e5ac5446801e2d56f86700f..e60f8cd2b4ac8f910aabcf8ed546af59d6ca4be4 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -9,9 +9,17 @@
 #ifndef _NET_OVPN_UDP_H_
 #define _NET_OVPN_UDP_H_
 
+#include <linux/skbuff.h>
+#include <net/sock.h>
+
+struct ovpn_peer;
 struct ovpn_struct;
+struct sk_buff;
 struct socket;
 
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn);
 
+void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
+		       struct sk_buff *skb);
+
 #endif /* _NET_OVPN_UDP_H_ */

-- 
2.45.2


