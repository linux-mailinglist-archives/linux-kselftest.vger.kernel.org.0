Return-Path: <linux-kselftest+bounces-20641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499A29AFDE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE7D1F23C73
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87EC202648;
	Fri, 25 Oct 2024 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GYbK3KWC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF111F80BD
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847717; cv=none; b=qZfA4um51m4VVWmVP9nv6XjDr1hMpb5gE1Gvni8Hkc0C0VLhR1bNquITTIjbfAY6coVR69mLrCDzVKmaUCzEoNKRNVFbtZp02r7rZsHueSVw9dYkXC0ToQ2p4z++A4vvkWwI2d3GlwJmAtVJAYc9g0pz5AAfhGNmiBMuJ7mG3Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847717; c=relaxed/simple;
	bh=5tcu2fG7KrBaMuG4quENwE2rUG2aHWyMgw7oow7J32w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AaaqhKi37jNuZ3MPoxQekm3TtC2NEp6hg22d749yHTlGl/rCwtBQAEmspj0ZZSng/K6e+iAP+w9mIl3kUrRyGRsnnDIuhlp8YPUWSlDT6IeZdAc2xl+C2u3cQBJ4Trf6lNCtX9DnCLayE3f7rOaesVeR5WDvVlhkGMiG5aKFLKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GYbK3KWC; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso28207901fa.1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 02:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729847710; x=1730452510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYOEZ7N/JNRw4kkW5nU68RzhrXcuF8cInBO89qjz/Cg=;
        b=GYbK3KWCK7y32LwZrhaIu0eQIoLj/XAruSzmRjkw/h/coWP+m3AS4sOaUV/sczRHPW
         25uHbjpg/vaa6ordCojhFAD4GHcVeUYWXZjiBVtjSdkhBEOlOWl7L2EjAeS4b13FyCib
         GnA4xILLi6Vk/KCuJJBcsqHpaoF8+i5GH1oli/ZBj2/wRXSM+9Cn5RJLJLmMI3gpfNqy
         pkALHiG2fochcOa3m+LW2oMlZBf0D9rDUPRaNv5jnrBbQNnzBjWMo0IVg3tWYbutXMQM
         vmeg/MsDsamL6G2hqiQ5WXH3jjN0zXRfIcx4YI+lf5+Qe5O0DRf1GCvt1LHrBe/oe1vN
         JCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847710; x=1730452510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYOEZ7N/JNRw4kkW5nU68RzhrXcuF8cInBO89qjz/Cg=;
        b=IuihRY4S3rJtFg8C433FNt+1n993Frmi85RqsYQ8t2q+thMtFjRdPQUP2u+arzxrtQ
         Ua4XKnE1xcouKFEbEU1lX/FBAZ8gCarDz3YjwQ98r9nN8OVUKXRHWH91jf4c0l2EAUSP
         kcmojIAvTVa/nIZFl9WK2YtlVisU+9vHxmqhb13ajT5WLS6o2sfxCibRavUxdjhST6Mf
         3rz0JmfOQRW0vLoyafisatv89CI8Xgmo4l0IdIErdugV0Rwb1jUJi+nI7X/8hZya/I78
         /JzZyYhSo7i39Sak74dTiJKgYPW8k57LtJXLpPx72g/+PFMV7+bCjvjDXQRm3WmFV0h/
         27EA==
X-Forwarded-Encrypted: i=1; AJvYcCUAZx0kMZ7lpytG/9QFiVFcaxO87nqy28pfRx1sPXWC3x4xVZorcmiS+yC5dk+5vREFDKnktBqcjRpHo1wRfwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTg+TAK5ixMFfXmOZBGnrlYrK8QMrIc6UlgVIDfYHCb/pOQc3
	mKsjoFD86+pbvdOQSMyxB3KkgX5i6Wo7cTjWeSwqMVtN5ZL6YnH0WWZqx5pb9Mo=
X-Google-Smtp-Source: AGHT+IE42WqJJX1UAeMQq9nBvtuvsI3WP024LI4wJ8wFJJSzhIvxmDL6W2JWorgLdpjJ/CCzrBSsDg==
X-Received: by 2002:a2e:be85:0:b0:2fa:d4ef:f234 with SMTP id 38308e7fff4ca-2fc9d2e4e0cmr75961951fa.1.1729847709848;
        Fri, 25 Oct 2024 02:15:09 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:676b:7d84:55a4:bea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm41981485e9.13.2024.10.25.02.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:15:09 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 25 Oct 2024 11:14:12 +0200
Subject: [PATCH net-next v10 13/23] ovpn: implement multi-peer support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-ovpn-v10-13-b87530777be7@openvpn.net>
References: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
In-Reply-To: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
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
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnG2Gasgy/xDIAm9X4NTgEqE+ZNwPgc9JKcRyYm
 zLOt1CsT9SJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZxthmgAKCRALcOU6oDjV
 h4E4B/9noO6K71JG5GKKkFMhqFceQGM/rmiOrQAtsm+Cp4GwUeIR8X7SmaKjdfNff+S5gHyQSr4
 dT8rtwJcVp9d1m9df1usEu9bNzX4FUr6EZ63UiHO8i9sJrb+I4n1W2JIE9x4EUQZGPUCbP5UymE
 KsC/htuPRr5zJW6T6zuG+yHTcfX/uhVQEM5I8uHCwdwXsM9mVNFTLhkcT7mB0ckzEauVicuH7Ls
 eC0CZIpkFmQmHF5vfIFUDOIrbc6+bE2gkR+5aKxORSE8MVmdh2ArPRx8Rl74sLx3IKqdHaZqj8g
 qaAa842oGXnP0o1hY/sQPH9TOahWV6i36u1DCBRW3O7dqLA3
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


