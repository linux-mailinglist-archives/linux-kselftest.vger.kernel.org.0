Return-Path: <linux-kselftest+bounces-20938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B509B4765
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 11:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AB91F23E35
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225A3208966;
	Tue, 29 Oct 2024 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="R5FfwxaI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5AA2076D3
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198904; cv=none; b=KQxmzWP0uMwMXXiNWVBHYNKjGlP2yOYYhNFkimIrj60QH84oG6HVxYNYB1GI6+z/sx9/Q5nGyAZptdj+V2vxUzWvk+v9XVcb1xaKp7fO+GGya7Q6gWm4i/H2vIQehfYVGyWGuLVH6wob6jEhxSKF7ltrdacr1d5kkUw1U5l9YGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198904; c=relaxed/simple;
	bh=5tcu2fG7KrBaMuG4quENwE2rUG2aHWyMgw7oow7J32w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQOV7h6p+u8VJk/QaWJjc8+M4rxFE81D3DoovRtu+cXOke4+gmzm82RQ97Dgk1S92g5Ze5vgH1yPWmqSCXouMuT/DdbeJGiRBqMCNSGI7+vmutz9IztJFWhszEOvZ0Ev9cvgi0kIvGs/FIfXaXH9WxtJ65ZtQk873YMdSriUNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=R5FfwxaI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so5627237e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730198896; x=1730803696; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYOEZ7N/JNRw4kkW5nU68RzhrXcuF8cInBO89qjz/Cg=;
        b=R5FfwxaIMFrNSBbi0FQETZ1YrvOgBoXZ6Iqk/iqIAzaOuN87IXCHwCg6VM8gRMGhhw
         YPMJNu1yYGEUUNYnFlsTFvQIoFNrmT5aLHs+cnhfpC6vu0I9EkmjhBmvOo3h+Fa3tU64
         jTw8HoiQAFx3/o+oLPC3NRb2KM1/T3TCajOBahFzfO8f833m8G+GB/fyTal2qo3Rz89A
         BVXGm6z7ZmauzT4WkWng5pFG4sdSeyEvvWMhcEAgzfYA/rpHBfVjRKVisGrj7/AAlvGF
         Wz5gizz0Q2l+RvKKM2PEaLDKE0FbgGEc2yUd3SoNuDtUaO/fPv50eqbwV3vBRUSY0YP+
         GBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730198896; x=1730803696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYOEZ7N/JNRw4kkW5nU68RzhrXcuF8cInBO89qjz/Cg=;
        b=wcmlj5Tqoqb7l8yWwy5aGILKOMDVcWUoXKVAhavMuaz1tFjk7ECKxSUNVlJRUr3pI+
         fvdzSd+WM+XPNsoRSAYvXw1vCQraWOtBKGzlILYdmlxJF9nNlV7jeWmYz1+pJLNwj/6A
         runvC3vIv9jiY4/gj0M9YOYXcgrM8gWvDxDKKRto1SVUsDDA2Cu0enGmQxW1ArxQiund
         mIgqSllBrRUfikQtjYj3PDgxAqwAJy0CQ3NXowxtOnY/X6zkAEIRixsfuc1Rv2UtajDA
         8rImqvkNSnWllrwb06fVyi3oF5JzQKXpmTFjoFpo48Lu5EoCvpNWaKEbmdvIII0+y1XP
         CPjA==
X-Forwarded-Encrypted: i=1; AJvYcCVQvbhTG3yWf9Q8ZqIBQy9T4Noiw3lxouHkObf1BHN64eTUuy5WQwAzMyVly+XK+DRHnoOW2C7vz8m8Qff+hsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBAtU/xxjvfuSR5WOxd4he4w4v7hgCKrXIEjnNVWy+IOjnqq+
	V9oCfm8D6plbqVrL5iJjXfuVwUrETO5ohLt/jjfhMq2tDuBigABRlpAGy68Lcac=
X-Google-Smtp-Source: AGHT+IFUD/AvBuf0wW67fAN0tPDcxNvLfXCB+BdSTsCwK1h4XUqI1lzuRXw5QDEUFX8BqyYsrAd0Ng==
X-Received: by 2002:a05:6512:3d1b:b0:539:f9b9:e6d2 with SMTP id 2adb3069b0e04-53b348e73camr4365695e87.35.1730198895639;
        Tue, 29 Oct 2024 03:48:15 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3dcf:a6cb:47af:d9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431934be328sm141124785e9.0.2024.10.29.03.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:48:15 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 29 Oct 2024 11:47:26 +0100
Subject: [PATCH net-next v11 13/23] ovpn: implement multi-peer support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-b4-ovpn-v11-13-de4698c73a25@openvpn.net>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
In-Reply-To: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13278; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=5tcu2fG7KrBaMuG4quENwE2rUG2aHWyMgw7oow7J32w=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnIL1rKp4Y3thhA52bV6oO5CWCc8uIXRKGBvPGG
 tWNVUsw5cOJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZyC9awAKCRALcOU6oDjV
 h6u8B/4ysFs9EHTlhNpmdk8kIjykgGjRh666fP9sXL7k468v6ipWoFsFn7BBxWXfXw0Pi0oQrfe
 CeIZWuO2evERjEzsq0obO9fLkDHHA4dvORxAt2ChQEglsbPVD/UVtCxWCAZhErlIOjcKZdP6g5E
 ffqkfzVuYwrkUWSHXjkemz9l7EGP7g32zke1z/y6b6DpuffGf0brqeWOBK7LU7q6v7GEBp1Gng0
 GKmuciGNWSUJACwRTTpuZuu5dqeSV3iyFcZaARiIvZ1S3rmXli6VhSob3Gu716+hfu4mpu0Eqe4
 h5cGaHBxwNTzN7zL1OpERrKc7Uw5urwPtaeg5jOG3/ByRgQM
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

With this change an ovpn instance will be able to stay connected to
multiple remote endpoints.

This functionality is strictly required when running ovpn on an
OpenVPN server.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c       |  55 +++++++++++++-
 drivers/net/ovpn/ovpnstruct.h |  19 +++++
 drivers/net/ovpn/peer.c       | 166 ++++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/peer.h       |   9 +++
 4 files changed, 243 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 0488e395eb27d3dba1efc8ff39c023e0ac4a38dd..c7453127ab640d7268c1ce919a87cc5419fac9ee 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -30,6 +30,9 @@
 
 static void ovpn_struct_free(struct net_device *net)
 {
+	struct ovpn_struct *ovpn = netdev_priv(net);
+
+	kfree(ovpn->peers);
 }
 
 static int ovpn_net_init(struct net_device *dev)
@@ -133,12 +136,52 @@ static void ovpn_setup(struct net_device *dev)
 	SET_NETDEV_DEVTYPE(dev, &ovpn_type);
 }
 
+static int ovpn_mp_alloc(struct ovpn_struct *ovpn)
+{
+	struct in_device *dev_v4;
+	int i;
+
+	if (ovpn->mode != OVPN_MODE_MP)
+		return 0;
+
+	dev_v4 = __in_dev_get_rtnl(ovpn->dev);
+	if (dev_v4) {
+		/* disable redirects as Linux gets confused by ovpn
+		 * handling same-LAN routing.
+		 * This happens because a multipeer interface is used as
+		 * relay point between hosts in the same subnet, while
+		 * in a classic LAN this would not be needed because the
+		 * two hosts would be able to talk directly.
+		 */
+		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
+		IPV4_DEVCONF_ALL(dev_net(ovpn->dev), SEND_REDIRECTS) = false;
+	}
+
+	/* the peer container is fairly large, therefore we allocate it only in
+	 * MP mode
+	 */
+	ovpn->peers = kzalloc(sizeof(*ovpn->peers), GFP_KERNEL);
+	if (!ovpn->peers)
+		return -ENOMEM;
+
+	spin_lock_init(&ovpn->peers->lock);
+
+	for (i = 0; i < ARRAY_SIZE(ovpn->peers->by_id); i++) {
+		INIT_HLIST_HEAD(&ovpn->peers->by_id[i]);
+		INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_vpn_addr[i], i);
+		INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_transp_addr[i], i);
+	}
+
+	return 0;
+}
+
 static int ovpn_newlink(struct net *src_net, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
 	struct ovpn_struct *ovpn = netdev_priv(dev);
 	enum ovpn_mode mode = OVPN_MODE_P2P;
+	int err;
 
 	if (data && data[IFLA_OVPN_MODE]) {
 		mode = nla_get_u8(data[IFLA_OVPN_MODE]);
@@ -149,6 +192,10 @@ static int ovpn_newlink(struct net *src_net, struct net_device *dev,
 	ovpn->mode = mode;
 	spin_lock_init(&ovpn->lock);
 
+	err = ovpn_mp_alloc(ovpn);
+	if (err < 0)
+		return err;
+
 	/* turn carrier explicitly off after registration, this way state is
 	 * clearly defined
 	 */
@@ -197,8 +244,14 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 		netif_carrier_off(dev);
 		ovpn->registered = false;
 
-		if (ovpn->mode == OVPN_MODE_P2P)
+		switch (ovpn->mode) {
+		case OVPN_MODE_P2P:
 			ovpn_peer_release_p2p(ovpn);
+			break;
+		case OVPN_MODE_MP:
+			ovpn_peers_free(ovpn);
+			break;
+		}
 		break;
 	case NETDEV_POST_INIT:
 	case NETDEV_GOING_DOWN:
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index 4a48fc048890ab1cda78bc104fe3034b4a49d226..12ed5e22c2108c9f143d1984048eb40c887cac63 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -15,6 +15,23 @@
 #include <uapi/linux/if_link.h>
 #include <uapi/linux/ovpn.h>
 
+/**
+ * struct ovpn_peer_collection - container of peers for MultiPeer mode
+ * @by_id: table of peers index by ID
+ * @by_vpn_addr: table of peers indexed by VPN IP address (items can be
+ *		 rehashed on the fly due to peer IP change)
+ * @by_transp_addr: table of peers indexed by transport address (items can be
+ *		    rehashed on the fly due to peer IP change)
+ * @lock: protects writes to peer tables
+ */
+struct ovpn_peer_collection {
+	DECLARE_HASHTABLE(by_id, 12);
+	struct hlist_nulls_head by_vpn_addr[1 << 12];
+	struct hlist_nulls_head by_transp_addr[1 << 12];
+
+	spinlock_t lock; /* protects writes to peer tables */
+};
+
 /**
  * struct ovpn_struct - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
@@ -22,6 +39,7 @@
  * @registered: whether dev is still registered with netdev or not
  * @mode: device operation mode (i.e. p2p, mp, ..)
  * @lock: protect this object
+ * @peers: data structures holding multi-peer references
  * @peer: in P2P mode, this is the only remote peer
  * @dev_list: entry for the module wide device list
  * @gro_cells: pointer to the Generic Receive Offload cell
@@ -32,6 +50,7 @@ struct ovpn_struct {
 	bool registered;
 	enum ovpn_mode mode;
 	spinlock_t lock; /* protect writing to the ovpn_struct object */
+	struct ovpn_peer_collection *peers;
 	struct ovpn_peer __rcu *peer;
 	struct list_head dev_list;
 	struct gro_cells gro_cells;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 5025bfb759d6a5f31e3f2ec094fe561fbdb9f451..73ef509faab9701192a45ffe78a46dbbbeab01c2 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -9,6 +9,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/list.h>
+#include <linux/hashtable.h>
 
 #include "ovpnstruct.h"
 #include "bind.h"
@@ -64,17 +65,16 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	return peer;
 }
 
-/**
- * ovpn_peer_release - release peer private members
- * @peer: the peer to release
- */
 static void ovpn_peer_release(struct ovpn_peer *peer)
 {
 	if (peer->sock)
 		ovpn_socket_put(peer->sock);
 
 	ovpn_crypto_state_release(&peer->crypto);
+	spin_lock_bh(&peer->lock);
 	ovpn_bind_reset(peer, NULL);
+	spin_unlock_bh(&peer->lock);
+
 	dst_cache_destroy(&peer->dst_cache);
 	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
 	kfree_rcu(peer, rcu);
@@ -309,6 +309,89 @@ bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 	return match;
 }
 
+#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
+	typeof(_tbl) *__tbl = &(_tbl);				\
+	(&(*__tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl)]); }) \
+
+/**
+ * ovpn_peer_add_mp - add peer to related tables in a MP instance
+ * @ovpn: the instance to add the peer to
+ * @peer: the peer to add
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
+{
+	struct sockaddr_storage sa = { 0 };
+	struct hlist_nulls_head *nhead;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa4;
+	struct ovpn_bind *bind;
+	struct ovpn_peer *tmp;
+	size_t salen;
+	int ret = 0;
+
+	spin_lock_bh(&ovpn->peers->lock);
+	/* do not add duplicates */
+	tmp = ovpn_peer_get_by_id(ovpn, peer->id);
+	if (tmp) {
+		ovpn_peer_put(tmp);
+		ret = -EEXIST;
+		goto out;
+	}
+
+	bind = rcu_dereference_protected(peer->bind, true);
+	/* peers connected via TCP have bind == NULL */
+	if (bind) {
+		switch (bind->remote.in4.sin_family) {
+		case AF_INET:
+			sa4 = (struct sockaddr_in *)&sa;
+
+			sa4->sin_family = AF_INET;
+			sa4->sin_addr.s_addr = bind->remote.in4.sin_addr.s_addr;
+			sa4->sin_port = bind->remote.in4.sin_port;
+			salen = sizeof(*sa4);
+			break;
+		case AF_INET6:
+			sa6 = (struct sockaddr_in6 *)&sa;
+
+			sa6->sin6_family = AF_INET6;
+			sa6->sin6_addr = bind->remote.in6.sin6_addr;
+			sa6->sin6_port = bind->remote.in6.sin6_port;
+			salen = sizeof(*sa6);
+			break;
+		default:
+			ret = -EPROTONOSUPPORT;
+			goto out;
+		}
+
+		nhead = ovpn_get_hash_head(ovpn->peers->by_transp_addr, &sa,
+					   salen);
+		hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
+	}
+
+	hlist_add_head_rcu(&peer->hash_entry_id,
+			   ovpn_get_hash_head(ovpn->peers->by_id, &peer->id,
+					      sizeof(peer->id)));
+
+	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
+		nhead = ovpn_get_hash_head(ovpn->peers->by_vpn_addr,
+					   &peer->vpn_addrs.ipv4,
+					   sizeof(peer->vpn_addrs.ipv4));
+		hlist_nulls_add_head_rcu(&peer->hash_entry_addr4, nhead);
+	}
+
+	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
+		nhead = ovpn_get_hash_head(ovpn->peers->by_vpn_addr,
+					   &peer->vpn_addrs.ipv6,
+					   sizeof(peer->vpn_addrs.ipv6));
+		hlist_nulls_add_head_rcu(&peer->hash_entry_addr6, nhead);
+	}
+out:
+	spin_unlock_bh(&ovpn->peers->lock);
+	return ret;
+}
+
 /**
  * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
  * @ovpn: the instance to add the peer to
@@ -349,6 +432,8 @@ static int ovpn_peer_add_p2p(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 {
 	switch (ovpn->mode) {
+	case OVPN_MODE_MP:
+		return ovpn_peer_add_mp(ovpn, peer);
 	case OVPN_MODE_P2P:
 		return ovpn_peer_add_p2p(ovpn, peer);
 	default:
@@ -356,6 +441,51 @@ int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 	}
 }
 
+/**
+ * ovpn_peer_unhash - remove peer reference from all hashtables
+ * @peer: the peer to remove
+ * @reason: the delete reason to attach to the peer
+ */
+static void ovpn_peer_unhash(struct ovpn_peer *peer,
+			     enum ovpn_del_peer_reason reason)
+	__must_hold(&ovpn->peers->lock)
+{
+	hlist_del_init_rcu(&peer->hash_entry_id);
+
+	hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
+	hlist_nulls_del_init_rcu(&peer->hash_entry_addr6);
+	hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+
+	ovpn_peer_put(peer);
+	peer->delete_reason = reason;
+}
+
+/**
+ * ovpn_peer_del_mp - delete peer from related tables in a MP instance
+ * @peer: the peer to delete
+ * @reason: reason why the peer was deleted (sent to userspace)
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_del_mp(struct ovpn_peer *peer,
+			    enum ovpn_del_peer_reason reason)
+	__must_hold(&peer->ovpn->peers->lock)
+{
+	struct ovpn_peer *tmp;
+	int ret = -ENOENT;
+
+	tmp = ovpn_peer_get_by_id(peer->ovpn, peer->id);
+	if (tmp == peer) {
+		ovpn_peer_unhash(peer, reason);
+		ret = 0;
+	}
+
+	if (tmp)
+		ovpn_peer_put(tmp);
+
+	return ret;
+}
+
 /**
  * ovpn_peer_del_p2p - delete peer from related tables in a P2P instance
  * @peer: the peer to delete
@@ -411,10 +541,36 @@ void ovpn_peer_release_p2p(struct ovpn_struct *ovpn)
  */
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 {
+	int ret;
+
 	switch (peer->ovpn->mode) {
+	case OVPN_MODE_MP:
+		spin_lock_bh(&peer->ovpn->peers->lock);
+		ret = ovpn_peer_del_mp(peer, reason);
+		spin_unlock_bh(&peer->ovpn->peers->lock);
+		return ret;
 	case OVPN_MODE_P2P:
-		return ovpn_peer_del_p2p(peer, reason);
+		spin_lock_bh(&peer->ovpn->lock);
+		ret = ovpn_peer_del_p2p(peer, reason);
+		spin_unlock_bh(&peer->ovpn->lock);
+		return ret;
 	default:
 		return -EOPNOTSUPP;
 	}
 }
+
+/**
+ * ovpn_peers_free - free all peers in the instance
+ * @ovpn: the instance whose peers should be released
+ */
+void ovpn_peers_free(struct ovpn_struct *ovpn)
+{
+	struct hlist_node *tmp;
+	struct ovpn_peer *peer;
+	int bkt;
+
+	spin_lock_bh(&ovpn->peers->lock);
+	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id)
+		ovpn_peer_unhash(peer, OVPN_DEL_PEER_REASON_TEARDOWN);
+	spin_unlock_bh(&ovpn->peers->lock);
+}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 2b7fa9510e362ef3646157bb0d361bab19ddaa99..942b90c84a0fb9e6fbb96f6df7f7842a9f738caf 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -23,6 +23,10 @@
  * @vpn_addrs: IP addresses assigned over the tunnel
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
+ * @hash_entry_id: entry in the peer ID hashtable
+ * @hash_entry_addr4: entry in the peer IPv4 hashtable
+ * @hash_entry_addr6: entry in the peer IPv6 hashtable
+ * @hash_entry_transp_addr: entry in the peer transport address hashtable
  * @sock: the socket being used to talk to this peer
  * @tcp: keeps track of TCP specific state
  * @tcp.strp: stream parser context (TCP only)
@@ -55,6 +59,10 @@ struct ovpn_peer {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
 	} vpn_addrs;
+	struct hlist_node hash_entry_id;
+	struct hlist_nulls_node hash_entry_addr4;
+	struct hlist_nulls_node hash_entry_addr6;
+	struct hlist_nulls_node hash_entry_transp_addr;
 	struct ovpn_socket *sock;
 
 	/* state of the TCP reading. Needed to keep track of how much of a
@@ -119,6 +127,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id);
 int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer);
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
 void ovpn_peer_release_p2p(struct ovpn_struct *ovpn);
+void ovpn_peers_free(struct ovpn_struct *ovpn);
 
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
 					       struct sk_buff *skb);

-- 
2.45.2


